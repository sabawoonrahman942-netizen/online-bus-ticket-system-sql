-- ============================================================
-- Online Otobüs Bilet Sistemi
-- Adým 1: Veritabaný Oluþturma
-- ============================================================

USE master;
GO

-- Eðer veritabaný zaten varsa önce sil (geliþtirme ortamý için)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'BusTicketSystemDB')
BEGIN
    ALTER DATABASE BusTicketSystemDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BusTicketSystemDB;
END
GO

-- Veritabanýný oluþtur
CREATE DATABASE BusTicketSystemDB
COLLATE Turkish_CI_AS;  -- Türkçe karakter desteði için
GO

-- Veritabanýný aktif olarak seç
USE BusTicketSystemDB;
GO

PRINT 'BusTicketSystemDB baþarýyla oluþturuldu!';
GO