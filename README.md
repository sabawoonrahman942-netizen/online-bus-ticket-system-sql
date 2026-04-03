# 🚌 Online Otobüs Bilet Sistemi — SQL Server Veritabanı Projesi

> T-SQL ile geliştirilmiş, tam işlevsel bir otobüs bileti rezervasyon veritabanı projesi.

---

## 🛠️ Kullanılan Teknolojiler

| Teknoloji | Detay |
|---|---|
| **Veritabanı** | Microsoft SQL Server 2025 Express Edition |
| **Sürüm** | 17.0.1000.7 (X64) — RTM, Oct 21 2025 |
| **İşletim Sistemi** | Windows 10 Home x64 (Build 26200) |
| **SQL Dili** | T-SQL (Transact-SQL) |
| **Yönetim Aracı** | SSMS (SQL Server Management Studio) |

---

## 📋 Proje Hakkında

Bu proje, bir **online otobüs bileti satış sisteminin** veritabanı katmanını modellemektedir.  
Kullanıcılar sisteme kayıt olabilir, sefer arayabilir, koltuk seçip bilet satın alabilir veya mevcut biletlerini iptal edebilir.

---

## 🗃️ Veritabanı Tabloları

| Tablo | Açıklama |
|---|---|
| `Cities` | Şehir bilgileri |
| `Terminals` | Terminaller / Otogarlar (bir şehrin birden fazla terminali olabilir) |
| `Buses` | Otobüs bilgileri (plaka, kapasite, tip: 2+1 / 2+2) |
| `Users` | Kayıtlı kullanıcılar / müşteriler |
| `Trips` | Seferler (güzergah, kalkış-varış saati, bilet fiyatı) |
| `Tickets` | Satılan biletler (koltuk no, durum: Active / Cancelled) |

---

## ⭐ Öne Çıkan Özellikler

- ✅ **Transaction + TRY-CATCH** ile güvenli bilet satın alma işlemi  
- ✅ **Composite UNIQUE Constraint** — Aynı koltuğun iki kez satılması engellenir  
- ✅ **CHECK Constraint** — Varış saati kalkış saatinden önce olamaz; kalkış ve varış aynı terminal olamaz  
- ✅ **Stored Procedures** — `sp_SeferAra`, `sp_BiletSatinal`, `sp_BiletIptal`  
- ✅ **VIEW** — Tüm JOIN'leri tek sorguda birleştiren `vw_BiletDetaylari`  
- ✅ **Raporlama Sorguları** — GROUP BY, HAVING, TOP, ORDER BY ile gelir ve doluluk raporları  
- ✅ **Turkish_CI_AS Collation** — Türkçe karakter desteği (ş, ç, ğ, ü, ö, ı)  

---



