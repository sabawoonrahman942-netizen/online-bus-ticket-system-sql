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


| Tablo | Açıklama | Kayıt Türü |
|---|---|---|
| `Cities` | Şehir bilgileri | Referans |
| `Terminals` | Terminaller / Otogarlar | Referans |
| `Buses` | Otobüs bilgileri (plaka, kapasite, tip) | Referans |
| `Users` | Kayıtlı kullanıcılar / müşteriler | İşlemsel |
| `Trips` | Seferler (güzergah, saat, fiyat) | İşlemsel |
| `Tickets` | Satılan biletler (koltuk no, durum) | İşlemsel |

---

## ⭐ Öne Çıkan Özellikler

### 🔐 Veri Güvenliği & Bütünlüğü
- ✅ **`BEGIN TRANSACTION` + `TRY-CATCH` + `ROLLBACK`** — Herhangi bir hata durumunda işlem tamamen geri alınır
- ✅ **Composite UNIQUE Constraint** (`TripID + SeatNumber`) — Aynı koltuğun iki kez satılması veritabanı seviyesinde engellenir
- ✅ **CHECK Constraint** — Varış saati kalkış saatinden önce olamaz
- ✅ **CHECK Constraint** — Kalkış ve varış aynı terminal olamaz
- ✅ **`RAISERROR`** — Kullanıcıya anlamlı hata mesajları döndürülür

### ⚙️ İş Mantığı (Stored Procedures)
| Prosedür | Açıklama |
|---|---|
| `sp_SeferAra` | Şehir + tarih filtresiyle sefer arar, **boş koltuk sayısını** hesaplar |
| `sp_BiletSatinal` | Koltuk kontrolü + kapasite kontrolü + güvenli `INSERT` |
| `sp_BiletIptal` | Kullanıcı doğrulama + Status güncelleme (`Active` → `Cancelled`) |

### 📊 Raporlama & Sorgulama
- ✅ **`vw_BiletDetaylari` VIEW** — 7 tablo JOIN'i tek sorguda birleştiren sanal tablo
- ✅ **GROUP BY + SUM** — Sefer bazlı toplam gelir raporu
- ✅ **GROUP BY + HAVING** — Doluluk oranı %50 üzerindeki seferler
- ✅ **TOP + ORDER BY** — En çok bilet alan kullanıcılar

### 🌍 Türkçe Destek
- ✅ **`Turkish_CI_AS` Collation** — ş, ç, ğ, ü, ö, ı karakterleri desteklenir
- ✅ **`NVARCHAR`** veri tipi — Tüm metin alanlarda Unicode desteği

---

## 📁 Dosya Yapısı
📦 online-bus-ticket-system-sql

┣ 📜 1_DDL_Veritabani.sql          → Veritabanı oluşturma (Turkish_CI_AS)

┣ 📜 2_DDL_Tablolar.sql            → 6 tablo + tüm kısıt tanımları

┣ 📜 3_DML_OrnekVeriler.sql        → Örnek veri (5 şehir, 3 otobüs, 5 kullanıcı...)

┣ 📜 4_T-SQL_View_Prosedurler.sql  → 1 VIEW + 3 Stored Procedure

┣ 📜 5_Test_Sorgulari.sql          → 9 test sorgusu (başarılı + hata senaryoları)


---

## ⚙️ Kurulum

> ⚠️ **Gereksinimler:** Microsoft SQL Server 2025 Express + SSMS

1. Repo'yu klonla:


2. SSMS'i aç ve dosyaları **sırayla** çalıştır `(F5)`:

 1_DDL_Veritabani.sql

2_DDL_Tablolar.sql

3_DML_OrnekVeriler.sql

4_T-SQL_View_Prosedurler.sql

5_Test_Sorgulari.sql

---

## 🧪 Örnek Kullanım
-- 1. İstanbul → Ankara seferlerini ara (boş koltuk sayısıyla birlikte)

EXEC sp_SeferAra

@KalkisSehir = 'İstanbul',

@VarisSehir  = 'Ankara',

@SeferTarihi = '2026-05-10';

-- 2. Güvenli bilet satın al

EXEC sp_BiletSatinal @TripID = 1, @UserID = 1, @SeatNumber = 7;

-- 3. Hata senaryosu: Dolu koltuğa bilet alma (HATA VERİR)

EXEC sp_BiletSatinal @TripID = 1, @UserID = 2, @SeatNumber = 7;

-- >> HATA: Bu koltuk zaten satılmış durumda!

-- 4. Tüm bilet detaylarını görüntüle

SELECT * FROM vw_BiletDetaylari;

-- 5. Bilet iptal et

EXEC sp_BiletIptal @TicketID = 1, @UserID = 1;


---

## 📊 Örnek Çıktı — `vw_BiletDetaylari`

| TicketID | Yolcu | Kalkış | Varış | Koltuk | Fiyat | Durum |
|---|---|---|---|---|---|---|
| 1 | Ahmet Yılmaz | İstanbul / Esenler | Ankara / AŞTİ | 5 | 500.00 ₺ | Active |
| 2 | Ayşe Demir | İstanbul / Esenler | Ankara / AŞTİ | 10 | 500.00 ₺ | Active |

---

## 👤 Geliştirici

<div align="center">

**Rahman**  
[@sabawoonrahman942-netizen](https://github.com/sabawoonrahman942-netizen)

⭐ Bu projeyi beğendiyseniz **star** vermeyi unutmayın!

</div>




