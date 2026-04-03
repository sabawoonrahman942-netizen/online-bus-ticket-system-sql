<div align="center">

# 🚌 Online Otobüs Bilet Sistemi
### SQL Server 2025 | T-SQL | Stored Procedures | Transaction

![SQL Server](https://img.shields.io/badge/SQL%20Server-2025%20Express-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-Transact--SQL-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Windows](https://img.shields.io/badge/Windows%2010-x64-0078D4?style=for-the-badge&logo=windows&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

> T-SQL ile geliştirilmiş, **production-ready** mimariyle tasarlanmış tam işlevsel bir otobüs bileti rezervasyon veritabanı projesi.

</div>

---

## 🛠️ Kullanılan Teknolojiler

| Teknoloji | Detay |
|:---:|:---|
| ![SQL Server](https://img.shields.io/badge/-SQL%20Server-CC2927?logo=microsoftsqlserver&logoColor=white) | Microsoft SQL Server **2025 Express Edition** |
| **Sürüm** | `17.0.1000.7 (X64)` — RTM, Oct 21 2025 |
| **İşletim Sistemi** | Windows 10 Home x64 (Build 26200) |
| **SQL Dili** | T-SQL (Transact-SQL) |
| **Yönetim Aracı** | SSMS (SQL Server Management Studio) |

---

## 📋 Proje Hakkında

Bu proje, bir **online otobüs bileti satış sisteminin** veritabanı katmanını modellemektedir.  
Kullanıcılar sisteme kayıt olabilir, sefer arayabilir, koltuk seçip bilet satın alabilir veya mevcut biletlerini iptal edebilir.

Proje; **veri bütünlüğü**, **hata yönetimi** ve **performans** odaklı geliştirilmiştir:
- Hatalı işlemler `TRY-CATCH` bloğuyla yakalanır ve `ROLLBACK` ile geri alınır
- `CHECK`, `UNIQUE` ve `FOREIGN KEY` kısıtlamalarıyla veri tutarlılığı güvence altına alınır
- `Turkish_CI_AS` collation ile tam Türkçe karakter desteği sağlanır

---

## 🗃️ Veritabanı Mimarisi




