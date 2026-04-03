
USE master;
GO

 EXISTS (SELECT name FROM sys.databases WHERE name = 'BusTicketSystemDB')
BEGIN
    ALTER DATABASE BusTicketSystemDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BusTicketSystemDB;
END
GO


CREATE DATABASE BusTicketSystemDB
COLLATE Turkish_CI_AS; 
GO


USE BusTicketSystemDB;
GO

PRINT 'BusTicketSystemDB başarıyla oluşturuldu!';
GO
