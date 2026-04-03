USE BusTicketSystemDB;
GO
-- ============================================================
CREATE VIEW vw_BiletDetaylari AS
SELECT
    t.TicketID,
    u.FirstName + ' ' + u.LastName                          AS Yolcu,
    u.Email                                                  AS Email,
    dep_city.CityName + ' / ' + dep_term.TerminalName       AS Kalkis,
    arr_city.CityName + ' / ' + arr_term.TerminalName       AS Varis,
    tr.DepartureTime                                         AS KalkisZamani,
    tr.ArrivalTime                                           AS VarisZamani,
    b.PlateNumber                                            AS OtobusPlaka,
    b.BusType                                                AS OtobusTipi,
    t.SeatNumber                                             AS KoltukNo,
    tr.TicketPrice                                           AS BiletFiyati,
    t.PurchaseDate                                           AS SatinAlmaTarihi,
    t.Status                                                 AS BiletDurumu
FROM Tickets t
INNER JOIN Users     u         ON t.UserID              = u.UserID
INNER JOIN Trips     tr        ON t.TripID              = tr.TripID
INNER JOIN Buses     b         ON tr.BusID              = b.BusID
INNER JOIN Terminals dep_term  ON tr.DepartureTerminalID = dep_term.TerminalID
INNER JOIN Cities    dep_city  ON dep_term.CityID        = dep_city.CityID
INNER JOIN Terminals arr_term  ON tr.ArrivalTerminalID   = arr_term.TerminalID
INNER JOIN Cities    arr_city  ON arr_term.CityID        = arr_city.CityID;
GO
PRINT 'vw_BiletDetaylari view oluþturuldu.';

-- ============================================================

CREATE PROCEDURE sp_SeferAra
    @KalkisSehir NVARCHAR(50),
    @VarisSehir  NVARCHAR(50),
    @SeferTarihi DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        tr.TripID,
        dep_city.CityName   AS Kalkis,
        arr_city.CityName   AS Varis,
        tr.DepartureTime    AS KalkisSaati,
        tr.ArrivalTime      AS VarisSaati,
        b.BusType           AS OtobusTipi,
        b.Capacity          AS ToplamKoltuk,
        b.Capacity - COUNT(tk.TicketID) AS BosKoltuk,
        tr.TicketPrice      AS Fiyat
    FROM Trips tr
    INNER JOIN Terminals dep_term ON tr.DepartureTerminalID = dep_term.TerminalID
    INNER JOIN Cities    dep_city ON dep_term.CityID        = dep_city.CityID
    INNER JOIN Terminals arr_term ON tr.ArrivalTerminalID   = arr_term.TerminalID
    INNER JOIN Cities    arr_city ON arr_term.CityID        = arr_city.CityID
    INNER JOIN Buses     b        ON tr.BusID               = b.BusID
    LEFT  JOIN Tickets   tk       ON tr.TripID              = tk.TripID
                                  AND tk.Status = 'Active'
    WHERE dep_city.CityName = @KalkisSehir
      AND arr_city.CityName = @VarisSehir
      AND CAST(tr.DepartureTime AS DATE) = @SeferTarihi
    GROUP BY
        tr.TripID, dep_city.CityName, arr_city.CityName,
        tr.DepartureTime, tr.ArrivalTime,
        b.BusType, b.Capacity, tr.TicketPrice;
END;
GO
PRINT 'sp_SeferAra prosedürü oluþturuldu.';

-- ============================================================
CREATE PROCEDURE sp_BiletSatinal
    @TripID    INT,
    @UserID    INT,
    @SeatNumber INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Kontrol 1: Koltuk dolu mu?
        IF EXISTS (
            SELECT 1 FROM Tickets
            WHERE TripID = @TripID AND SeatNumber = @SeatNumber AND Status = 'Active'
        )
        BEGIN
            RAISERROR('HATA: Bu koltuk zaten satýlmýþ durumda!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

     
        DECLARE @Capacity INT;
        SELECT @Capacity = b.Capacity
        FROM Trips tr
        INNER JOIN Buses b ON tr.BusID = b.BusID
        WHERE tr.TripID = @TripID;

        IF @Capacity IS NULL
        BEGIN
            RAISERROR('HATA: Belirtilen sefer bulunamadý!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @SeatNumber > @Capacity
        BEGIN
            RAISERROR('HATA: Koltuk numarasý otobüs kapasitesini (%d) aþýyor!', 16, 1, @Capacity);
            ROLLBACK TRANSACTION;
            RETURN;
        END

     
        INSERT INTO Tickets (TripID, UserID, SeatNumber)
        VALUES (@TripID, @UserID, @SeatNumber);

        COMMIT TRANSACTION;
        PRINT 'Bilet baþarýyla satýn alýndý! Koltuk No: ' + CAST(@SeatNumber AS VARCHAR);

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END;
GO
PRINT 'sp_BiletSatinal prosedürü oluþturuldu.';

-- ============================================================
CREATE PROCEDURE sp_BiletIptal
    @TicketID INT,
    @UserID   INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

      
        IF NOT EXISTS (
            SELECT 1 FROM Tickets
            WHERE TicketID = @TicketID AND UserID = @UserID AND Status = 'Active'
        )
        BEGIN
            RAISERROR('HATA: Ýptal edilecek aktif bilet bulunamadý!', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE Tickets
        SET Status = 'Cancelled'
        WHERE TicketID = @TicketID;

        COMMIT TRANSACTION;
        PRINT 'Bilet baþarýyla iptal edildi!';

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END;
GO
PRINT '>>> Tüm VIEW ve Stored Procedure''ler oluþturuldu!';
