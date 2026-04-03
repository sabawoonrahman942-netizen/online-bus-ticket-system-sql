USE BusTicketSystemDB;
GO

-- ============================================================
-- TABLO 1: Cities (Þehirler)
-- Hiçbir foreign key içermez, en baðýmsýz tablodur.
-- ============================================================
CREATE TABLE Cities (
    CityID   INT            IDENTITY(1,1) PRIMARY KEY,
    CityName NVARCHAR(50)   NOT NULL
);
GO
PRINT 'Cities tablosu oluþturuldu.';

-- ============================================================
-- TABLO 2: Terminals (Terminaller / Otogarlar)
-- Bir þehrin birden fazla terminali olabilir (1:N ile Cities'e baðlý)
-- ============================================================
CREATE TABLE Terminals (
    TerminalID   INT            IDENTITY(1,1) PRIMARY KEY,
    CityID       INT            NOT NULL,
    TerminalName NVARCHAR(100)  NOT NULL,

    CONSTRAINT FK_Terminals_Cities
        FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);
GO
PRINT 'Terminals tablosu oluþturuldu.';

-- ============================================================
-- TABLO 3: Buses (Otobüsler)
-- Hiçbir foreign key içermez.
-- ============================================================
CREATE TABLE Buses (
    BusID       INT          IDENTITY(1,1) PRIMARY KEY,
    PlateNumber VARCHAR(20)  NOT NULL UNIQUE,
    Capacity    INT          NOT NULL CHECK (Capacity > 0),
    BusType     VARCHAR(10)  NOT NULL CHECK (BusType IN ('2+1', '2+2'))
);
GO
PRINT 'Buses tablosu oluþturuldu.';

-- ============================================================
-- TABLO 4: Users (Kullanýcýlar / Müþteriler)
-- Hiçbir foreign key içermez.
-- ============================================================
CREATE TABLE Users (
    UserID       INT            IDENTITY(1,1) PRIMARY KEY,
    FirstName    NVARCHAR(50)   NOT NULL,
    LastName     NVARCHAR(50)   NOT NULL,
    Email        NVARCHAR(100)  NOT NULL UNIQUE,
    PasswordHash NVARCHAR(256)  NOT NULL,
    PhoneNumber  VARCHAR(15)    NULL,
    CreatedAt    DATETIME       NOT NULL DEFAULT GETDATE()
);
GO
PRINT 'Users tablosu oluþturuldu.';

-- ============================================================
-- TABLO 5: Trips (Seferler)
-- Buses ve Terminals tablolarýna baðýmlýdýr.
-- ============================================================
CREATE TABLE Trips (
    TripID              INT            IDENTITY(1,1) PRIMARY KEY,
    BusID               INT            NOT NULL,
    DepartureTerminalID INT            NOT NULL,
    ArrivalTerminalID   INT            NOT NULL,
    DepartureTime       DATETIME       NOT NULL,
    ArrivalTime         DATETIME       NOT NULL,
    TicketPrice         DECIMAL(10,2)  NOT NULL CHECK (TicketPrice > 0),

    -- Foreign Key Kýsýtlamalarý
    CONSTRAINT FK_Trips_Buses
        FOREIGN KEY (BusID) REFERENCES Buses(BusID),
    CONSTRAINT FK_Trips_DepartureTerminal
        FOREIGN KEY (DepartureTerminalID) REFERENCES Terminals(TerminalID),
    CONSTRAINT FK_Trips_ArrivalTerminal
        FOREIGN KEY (ArrivalTerminalID) REFERENCES Terminals(TerminalID),

    -- Ýþ Kurallarý (Business Rules)
    CONSTRAINT CHK_DifferentTerminals
        CHECK (DepartureTerminalID <> ArrivalTerminalID),
    CONSTRAINT CHK_ValidTripDates
        CHECK (ArrivalTime > DepartureTime)
);
GO
PRINT 'Trips tablosu oluþturuldu.';

-- ============================================================
-- TABLO 6: Tickets (Biletler)
-- Trips ve Users tablolarýna baðýmlýdýr. En son oluþturulur.
-- ============================================================
CREATE TABLE Tickets (
    TicketID     INT          IDENTITY(1,1) PRIMARY KEY,
    TripID       INT          NOT NULL,
    UserID       INT          NOT NULL,
    SeatNumber   INT          NOT NULL CHECK (SeatNumber > 0),
    PurchaseDate DATETIME     NOT NULL DEFAULT GETDATE(),
    Status       VARCHAR(20)  NOT NULL DEFAULT 'Active'
                              CHECK (Status IN ('Active', 'Cancelled')),

    -- Foreign Key Kýsýtlamalarý
    CONSTRAINT FK_Tickets_Trips
        FOREIGN KEY (TripID) REFERENCES Trips(TripID),
    CONSTRAINT FK_Tickets_Users
        FOREIGN KEY (UserID) REFERENCES Users(UserID),

    -- Kompozit Unique Kýsýt: Ayný seferde ayný koltuk iki kez satýlamaz!
    CONSTRAINT UQ_Trip_Seat
        UNIQUE (TripID, SeatNumber)
);
GO
PRINT 'Tickets tablosu oluþturuldu.';
PRINT '>>> Tüm tablolar baþarýyla oluþturuldu!';