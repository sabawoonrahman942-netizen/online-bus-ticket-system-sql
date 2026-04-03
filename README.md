# 🚌 Online Otobüs Bilet Sistemi — SQL Server

T-SQL ile geliştirilmiş, tam işlevsel bir otobüs bileti rezervasyon veritabanı projesi.

## Teknolojiler
- Microsoft SQL Server 2019+
- T-SQL (Transact-SQL)
- SSMS (SQL Server Management Studio)

## Veritabanı Şeması
[ER Diagram görseli buraya]

## Öne Çıkan Özellikler
- Transaction + TRY-CATCH ile güvenli bilet satışı
- Aynı koltuğun iki kez satılmasını engelleyen Composite UNIQUE Constraint
- Çoklu JOIN kullanan detaylı VIEW
- Parametreli Stored Procedures (Sefer Arama, Bilet Satış, Bilet İptal)

## Kurulum
Dosyaları SSMS'te sırayla çalıştırın:
1_DDL_Veritabani.sql
2_DDL_Tablolar.sql
3_DML_OrnekVeriler.sql
4_T-SQL_View_Prosedurler.sql
5_Test_Sorgulari.sql
