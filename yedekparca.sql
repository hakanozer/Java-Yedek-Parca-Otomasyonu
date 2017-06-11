/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 100121
Source Host           : localhost:3306
Source Database       : yedekparca

Target Server Type    : MYSQL
Target Server Version : 100121
File Encoding         : 65001

Date: 2017-06-11 14:23:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `aadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `asoyadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `akuladi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `asifre` varchar(32) COLLATE utf8_turkish_ci DEFAULT NULL,
  `seviye` int(1) DEFAULT NULL COMMENT 'seviye = 1 Süper admin \r\nseviye = 0 admin',
  `atarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`),
  UNIQUE KEY `kulBensersiz` (`akuladi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'Ali', 'Bilmem', 'ali', '827ccb0eea8a706c4c34a16891f84e7b', '1', '2017-06-11 13:47:47');
INSERT INTO `admin` VALUES ('2', 'Veli', 'Bilsin', 'veli', '01cfcd4f6b8770febfb40cb906715822', '0', '2017-06-11 14:15:12');

-- ----------------------------
-- Table structure for kategori
-- ----------------------------
DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori` (
  `kid` int(11) NOT NULL AUTO_INCREMENT,
  `kadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `ktarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of kategori
-- ----------------------------

-- ----------------------------
-- Table structure for musteri
-- ----------------------------
DROP TABLE IF EXISTS `musteri`;
CREATE TABLE `musteri` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `madi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `msoyadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `mtelefon` int(10) DEFAULT NULL,
  `mmail` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `madres` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `mtarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `aid` int(11) DEFAULT NULL COMMENT 'ekleyen admin id',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of musteri
-- ----------------------------

-- ----------------------------
-- Table structure for ozellik
-- ----------------------------
DROP TABLE IF EXISTS `ozellik`;
CREATE TABLE `ozellik` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `okid` int(11) DEFAULT NULL,
  `oadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `aid` int(11) DEFAULT NULL COMMENT 'özelliği ekleyen admin id ''si',
  `otarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of ozellik
-- ----------------------------

-- ----------------------------
-- Table structure for ozelllikkategori
-- ----------------------------
DROP TABLE IF EXISTS `ozelllikkategori`;
CREATE TABLE `ozelllikkategori` (
  `okid` int(11) NOT NULL AUTO_INCREMENT,
  `kadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  PRIMARY KEY (`okid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of ozelllikkategori
-- ----------------------------

-- ----------------------------
-- Table structure for profil
-- ----------------------------
DROP TABLE IF EXISTS `profil`;
CREATE TABLE `profil` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT NULL,
  `tc` int(11) DEFAULT NULL,
  `telefon` int(10) DEFAULT NULL,
  `adres` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `cinsiyet` enum('bay','bayan') COLLATE utf8_turkish_ci DEFAULT NULL,
  `yas` int(11) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of profil
-- ----------------------------

-- ----------------------------
-- Table structure for raf
-- ----------------------------
DROP TABLE IF EXISTS `raf`;
CREATE TABLE `raf` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `radi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `tanım` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL COMMENT 'adres gibi kullanılabilir.',
  `aid` int(11) DEFAULT NULL,
  `rtarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of raf
-- ----------------------------

-- ----------------------------
-- Table structure for sepet
-- ----------------------------
DROP TABLE IF EXISTS `sepet`;
CREATE TABLE `sepet` (
  `seid` int(11) NOT NULL AUTO_INCREMENT,
  `refkodu` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `adet` int(3) DEFAULT NULL,
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of sepet
-- ----------------------------

-- ----------------------------
-- Table structure for siparis
-- ----------------------------
DROP TABLE IF EXISTS `siparis`;
CREATE TABLE `siparis` (
  `said` int(11) NOT NULL AUTO_INCREMENT,
  `srefkodu` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `toplamfiyat` decimal(8,2) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL COMMENT 'müşteri id',
  `aid` int(11) DEFAULT NULL,
  `satarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`said`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of siparis
-- ----------------------------

-- ----------------------------
-- Table structure for stok
-- ----------------------------
DROP TABLE IF EXISTS `stok`;
CREATE TABLE `stok` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `kid` int(11) DEFAULT NULL COMMENT 'kategori id si',
  `sadet` int(4) DEFAULT NULL COMMENT 'stok sayısı',
  `sfiyat` decimal(6,2) DEFAULT NULL COMMENT 'Ürünün if',
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of stok
-- ----------------------------

-- ----------------------------
-- Table structure for urunler
-- ----------------------------
DROP TABLE IF EXISTS `urunler`;
CREATE TABLE `urunler` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `kid` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `ozellikler` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL COMMENT 'özellikler tablosu içerisindeki id ler',
  `ubaslik` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `udetay` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `utarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
-- Records of urunler
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;
