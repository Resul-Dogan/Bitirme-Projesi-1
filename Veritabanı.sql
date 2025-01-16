CREATE DATABASE EgitimSistem;
USE EgitimSistem;
CREATE TABLE Ogrenci (
    ogrenci_id INT IDENTITY(1,1) PRIMARY KEY,
    ad_soyad NVARCHAR(100) NOT NULL,
    eposta NVARCHAR(100) UNIQUE NOT NULL,
    sifre NVARCHAR(255) NOT NULL,
    ogrenci_numarasi NVARCHAR(50) NOT NULL,
    bolum NVARCHAR(100),
    olusturulma_tarihi DATETIME DEFAULT GETDATE()
);
CREATE TABLE Personel (
    ogretmen_id INT IDENTITY(1,1) PRIMARY KEY,
    ad_soyad NVARCHAR(100) NOT NULL,
    eposta NVARCHAR(100) UNIQUE NOT NULL,
    sifre NVARCHAR(255) NOT NULL,
    departman NVARCHAR(100),
    uzmanlik_alani NVARCHAR(100),
    olusturulma_tarihi DATETIME DEFAULT GETDATE()
);
CREATE TABLE Dersler (
    ders_id INT IDENTITY(1,1) PRIMARY KEY,
    baslik NVARCHAR(150) NOT NULL,
    aciklama NVARCHAR(MAX),
    ogretmen_id INT NOT NULL,
    olusturulma_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ogretmen_id) REFERENCES Personel(ogretmen_id)
);
CREATE TABLE DersKayit (
    kayit_id INT IDENTITY(1,1) PRIMARY KEY,
    ders_id INT NOT NULL,
    ogrenci_id INT NOT NULL,
    kayit_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ders_id) REFERENCES Dersler(ders_id),
    FOREIGN KEY (ogrenci_id) REFERENCES Ogrenci(ogrenci_id)
);
CREATE TABLE Icerik (
    icerik_id INT IDENTITY(1,1) PRIMARY KEY,
    ders_id INT NOT NULL,
    tur NVARCHAR(10) CHECK (tur IN ('pdf', 'video', 'metin')) NOT NULL,
    dosya_yolu NVARCHAR(255),
    baslik NVARCHAR(150),
    olusturulma_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ders_id) REFERENCES Dersler(ders_id)
);
CREATE TABLE Odevler (
    odev_id INT IDENTITY(1,1) PRIMARY KEY,
    ders_id INT NOT NULL,
    baslik NVARCHAR(150) NOT NULL,
    aciklama NVARCHAR(MAX),
    son_teslim_tarihi DATETIME,
    olusturulma_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ders_id) REFERENCES Dersler(ders_id)
);
CREATE TABLE OdevTeslim (
    teslim_id INT IDENTITY(1,1) PRIMARY KEY,
    odev_id INT NOT NULL,
    ogrenci_id INT NOT NULL,
    dosya_yolu NVARCHAR(255),
    teslim_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (odev_id) REFERENCES Odevler(odev_id),
    FOREIGN KEY (ogrenci_id) REFERENCES Ogrenci(ogrenci_id)
);
CREATE TABLE Mesajlar (
    mesaj_id INT IDENTITY(1,1) PRIMARY KEY,
    gonderen_rol NVARCHAR(10) CHECK (gonderen_rol IN ('ogrenci', 'ogretmen')) NOT NULL,
    gonderen_id INT NOT NULL,
    alici_rol NVARCHAR(10) CHECK (alici_rol IN ('ogrenci', 'ogretmen')) NOT NULL,
    alici_id INT NOT NULL,
    icerik NVARCHAR(MAX) NOT NULL,
    gonderilme_tarihi DATETIME DEFAULT GETDATE()
);
CREATE TABLE Notlar (
    not_id INT IDENTITY(1,1) PRIMARY KEY,
    ogrenci_id INT NOT NULL,
    ders_id INT NOT NULL,
    odev_id INT,
    not_degeri FLOAT NOT NULL,
    geri_bildirim NVARCHAR(MAX),
    not_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ogrenci_id) REFERENCES Ogrenci(ogrenci_id),
    FOREIGN KEY (ders_id) REFERENCES Dersler(ders_id),
    FOREIGN KEY (odev_id) REFERENCES Odevler(odev_id)
);
CREATE TABLE Duyurular (
    duyuru_id INT IDENTITY(1,1) PRIMARY KEY,
    ders_id INT,
    baslik NVARCHAR(150) NOT NULL,
    icerik NVARCHAR(MAX) NOT NULL,
    yayinlanma_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ders_id) REFERENCES Dersler(ders_id)
);
CREATE TABLE Sinavlar (
    sinav_id INT IDENTITY(1,1) PRIMARY KEY,
    ders_id INT NOT NULL,
    baslik NVARCHAR(150) NOT NULL,
    aciklama NVARCHAR(MAX),
    tarih DATETIME NOT NULL,
    sure INT NOT NULL, -- dakika olarak
    olusturma_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ders_id) REFERENCES Dersler(ders_id)
);
CREATE TABLE SinavSonuclari (
    sonuc_id INT IDENTITY(1,1) PRIMARY KEY,
    sinav_id INT NOT NULL,
    ogrenci_id INT NOT NULL,
    puan DECIMAL(5,2) NOT NULL,
    teslim_tarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sinav_id) REFERENCES Sinavlar(sinav_id),
    FOREIGN KEY (ogrenci_id) REFERENCES Ogrenci(ogrenci_id)
);
