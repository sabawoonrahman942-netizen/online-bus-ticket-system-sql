USE BusTicketSystemDB;
GO

-- =====================================================

SELECT * FROM vw_BiletDetaylari;

-- =====================================================

EXEC sp_SeferAra
    @KalkisSehir = 'İstanbul',
    @VarisSehir  = 'Ankara',
    @SeferTarihi = '2026-05-10';

-- =====================================================

EXEC sp_BiletSatinal @TripID = 1, @UserID = 4, @SeatNumber = 22;

-- =====================================================

EXEC sp_BiletSatinal @TripID = 1, @UserID = 3, @SeatNumber = 5; 

-- =====================================================

EXEC sp_BiletSatinal @TripID = 1, @UserID = 3, @SeatNumber = 99; 
-- =====================================================
-- TEST 6: Bilet iptali
-- =====================================================
EXEC sp_BiletIptal @TicketID = 1, @UserID = 1;

-- =====================================================

SELECT
    tr.TripID,
    dep_city.CityName + ' → ' + arr_city.CityName  AS Guzergah,
    COUNT(t.TicketID)                               AS SatilanBilet,
    b.Capacity - COUNT(t.TicketID)                  AS BosKoltuk,
    SUM(tr.TicketPrice)                             AS ToplamGelir
FROM Trips tr
INNER JOIN Buses     b        ON tr.BusID              = b.BusID
INNER JOIN Terminals dep_term ON tr.DepartureTerminalID = dep_term.TerminalID
INNER JOIN Cities    dep_city ON dep_term.CityID        = dep_city.CityID
INNER JOIN Terminals arr_term ON tr.ArrivalTerminalID   = arr_term.TerminalID
INNER JOIN Cities    arr_city ON arr_term.CityID        = arr_city.CityID
LEFT  JOIN Tickets   t        ON tr.TripID             = t.TripID
                              AND t.Status = 'Active'
GROUP BY tr.TripID, dep_city.CityName, arr_city.CityName, b.Capacity;

-- =====================================================

SELECT TOP 3
    u.FirstName + ' ' + u.LastName AS Kullanici,
    COUNT(t.TicketID)              AS BiletSayisi
FROM Users u
INNER JOIN Tickets t ON u.UserID = t.UserID
WHERE t.Status = 'Active'
GROUP BY u.UserID, u.FirstName, u.LastName
ORDER BY BiletSayisi DESC;

-- =====================================================

SELECT
    tr.TripID,
    dep_city.CityName + ' → ' + arr_city.CityName  AS Guzergah,
    COUNT(t.TicketID) * 100 / b.Capacity            AS DolulukOrani
FROM Trips tr
INNER JOIN Buses     b        ON tr.BusID              = b.BusID
INNER JOIN Terminals dep_term ON tr.DepartureTerminalID = dep_term.TerminalID
INNER JOIN Cities    dep_city ON dep_term.CityID        = dep_city.CityID
INNER JOIN Terminals arr_term ON tr.ArrivalTerminalID   = arr_term.TerminalID
INNER JOIN Cities    arr_city ON arr_term.CityID        = arr_city.CityID
LEFT  JOIN Tickets   t        ON tr.TripID             = t.TripID
                              AND t.Status = 'Active'
GROUP BY tr.TripID, dep_city.CityName, arr_city.CityName, b.Capacity
HAVING COUNT(t.TicketID) * 100 / b.Capacity > 50;
