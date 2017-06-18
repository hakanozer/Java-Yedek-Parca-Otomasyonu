-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 18 Haz 2017, 11:54:12
-- Sunucu sürümü: 10.1.21-MariaDB
-- PHP Sürümü: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `yedekparca`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin`
--

CREATE TABLE `admin` (
  `aid` int(11) NOT NULL,
  `aadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `asoyadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `akuladi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `asifre` varchar(32) COLLATE utf8_turkish_ci DEFAULT NULL,
  `seviye` int(1) DEFAULT NULL COMMENT 'seviye = 1 Süper admin \r\nseviye = 0 admin',
  `atarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `admin`
--

INSERT INTO `admin` (`aid`, `aadi`, `asoyadi`, `akuladi`, `asifre`, `seviye`, `atarih`) VALUES
(1, 'Ali', 'Bilmem', 'ali', '86318e52f5ed4801abe1d13d509443de', 1, '2017-06-17 07:16:09'),
(2, 'Veli', 'Bilsin', 'veli', '4799d7258653f1c1ad6f6b6718fb9af5', 0, '2017-06-17 07:16:18');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kategori`
--

CREATE TABLE `kategori` (
  `kid` int(11) NOT NULL,
  `kadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `ktarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `musteri`
--

CREATE TABLE `musteri` (
  `mid` int(11) NOT NULL,
  `madi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `msoyadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `mtelefon` int(10) DEFAULT NULL,
  `mmail` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `madres` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `mtarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `aid` int(11) DEFAULT NULL COMMENT 'ekleyen admin id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ozellik`
--

CREATE TABLE `ozellik` (
  `oid` int(11) NOT NULL,
  `okid` int(11) DEFAULT NULL,
  `oadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `aid` int(11) DEFAULT NULL COMMENT 'özelliği ekleyen admin id ''si',
  `otarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ozelllikkategori`
--

CREATE TABLE `ozelllikkategori` (
  `okid` int(11) NOT NULL,
  `katid` int(11) NOT NULL,
  `kadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `aid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `profil`
--

CREATE TABLE `profil` (
  `pid` int(11) NOT NULL,
  `aid` int(11) DEFAULT NULL,
  `tc` int(11) DEFAULT NULL,
  `telefon` int(10) DEFAULT NULL,
  `adres` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `cinsiyet` enum('bay','bayan') COLLATE utf8_turkish_ci DEFAULT NULL,
  `yas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `raf`
--

CREATE TABLE `raf` (
  `rid` int(11) NOT NULL,
  `radi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `tanım` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL COMMENT 'adres gibi kullanılabilir.',
  `aid` int(11) DEFAULT NULL,
  `rtarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sepet`
--

CREATE TABLE `sepet` (
  `seid` int(11) NOT NULL,
  `refkodu` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `adet` int(3) DEFAULT NULL,
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `siparis`
--

CREATE TABLE `siparis` (
  `said` int(11) NOT NULL,
  `srefkodu` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `toplamfiyat` decimal(8,2) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL COMMENT 'müşteri id',
  `aid` int(11) DEFAULT NULL,
  `satarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `stok`
--

CREATE TABLE `stok` (
  `sid` int(11) NOT NULL,
  `rid` int(11) DEFAULT NULL,
  `kid` int(11) DEFAULT NULL COMMENT 'kategori id si',
  `sadet` int(4) DEFAULT NULL COMMENT 'stok sayısı',
  `sfiyat` decimal(6,2) DEFAULT NULL COMMENT 'Ürünün if',
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `urunler`
--

CREATE TABLE `urunler` (
  `uid` int(11) NOT NULL,
  `kid` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `ozellikler` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL COMMENT 'özellikler tablosu içerisindeki id ler',
  `ubaslik` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `udetay` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `utarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `kulBensersiz` (`akuladi`);

--
-- Tablo için indeksler `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`kid`);

--
-- Tablo için indeksler `musteri`
--
ALTER TABLE `musteri`
  ADD PRIMARY KEY (`mid`);

--
-- Tablo için indeksler `ozellik`
--
ALTER TABLE `ozellik`
  ADD PRIMARY KEY (`oid`);

--
-- Tablo için indeksler `ozelllikkategori`
--
ALTER TABLE `ozelllikkategori`
  ADD PRIMARY KEY (`okid`);

--
-- Tablo için indeksler `profil`
--
ALTER TABLE `profil`
  ADD PRIMARY KEY (`pid`);

--
-- Tablo için indeksler `raf`
--
ALTER TABLE `raf`
  ADD PRIMARY KEY (`rid`);

--
-- Tablo için indeksler `sepet`
--
ALTER TABLE `sepet`
  ADD PRIMARY KEY (`seid`);

--
-- Tablo için indeksler `siparis`
--
ALTER TABLE `siparis`
  ADD PRIMARY KEY (`said`);

--
-- Tablo için indeksler `stok`
--
ALTER TABLE `stok`
  ADD PRIMARY KEY (`sid`);

--
-- Tablo için indeksler `urunler`
--
ALTER TABLE `urunler`
  ADD PRIMARY KEY (`uid`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admin`
--
ALTER TABLE `admin`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Tablo için AUTO_INCREMENT değeri `kategori`
--
ALTER TABLE `kategori`
  MODIFY `kid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `musteri`
--
ALTER TABLE `musteri`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `ozellik`
--
ALTER TABLE `ozellik`
  MODIFY `oid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `ozelllikkategori`
--
ALTER TABLE `ozelllikkategori`
  MODIFY `okid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `profil`
--
ALTER TABLE `profil`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `raf`
--
ALTER TABLE `raf`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `sepet`
--
ALTER TABLE `sepet`
  MODIFY `seid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `siparis`
--
ALTER TABLE `siparis`
  MODIFY `said` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `stok`
--
ALTER TABLE `stok`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT;
--
-- Tablo için AUTO_INCREMENT değeri `urunler`
--
ALTER TABLE `urunler`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
