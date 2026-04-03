USE BusTicketSystemDB;
GO

-- Cities
INSERT INTO Cities (CityName) VALUES
('Ýstanbul'), ('Ankara'), ('Ýzmir'), ('Antalya'), ('Bursa');
GO

-- Terminals
INSERT INTO Terminals (CityID, TerminalName) VALUES
(1, 'Esenler Otogarý'),
(1, 'Alibeyköy Cep Otogarý'),
(2, 'AÞTÝ'),
(3, 'ÝZOTAÞ Otogarý'),
(4, 'Antalya Otogarý'),
(5, 'Bursa Otogarý');
GO

-- Buses
INSERT INTO Buses (PlateNumber, Capacity, BusType) VALUES
('34 ABC 123', 40, '2+1'),
('06 DEF 456', 44, '2+2'),
('35 GHI 789', 40, '2+1');
GO

-- Users
INSERT INTO Users (FirstName, LastName, Email, PasswordHash, PhoneNumber) VALUES
('Ahmet',   'Yýlmaz', 'ahmet@email.com',  'hash_ahmet_001',  '05551234567'),
('Ayþe',    'Demir',  'ayse@email.com',   'hash_ayse_002',   '05329876543'),
('Mehmet',  'Kaya',   'mehmet@email.com', 'hash_mehmet_003', '05441112233'),
('Fatma',   'Çelik',  'fatma@email.com',  'hash_fatma_004',  '05064445566'),
('Ali',     'Þahin',  'ali@email.com',    'hash_ali_005',    NULL);
GO
-- ============================================================
INSERT INTO Trips (BusID, DepartureTerminalID, ArrivalTerminalID, DepartureTime, ArrivalTime, TicketPrice) VALUES
(1, 1, 3, '2026-05-10 09:00:00', '2026-05-10 15:00:00', 500.00),
(2, 3, 4, '2026-05-11 08:00:00', '2026-05-11 16:00:00', 650.00),
(3, 1, 5, '2026-05-12 22:00:00', '2026-05-13 06:00:00', 750.00);
GO


INSERT INTO Tickets (TripID, UserID, SeatNumber) VALUES
(1, 1, 5), 
(1, 2, 10),  
(1, 3, 15),  
(2, 4, 1),   
(2, 5, 20),  
(3, 1, 3);  
GO

PRINT '>>> Tüm örnek veriler baþarýyla eklendi!';
