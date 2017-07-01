/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50505
 Source Host           : localhost
 Source Database       : yedekparca

 Target Server Type    : MySQL
 Target Server Version : 50505
 File Encoding         : utf-8

 Date: 07/01/2017 11:50:03 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `aadi` varchar(255) DEFAULT NULL,
  `asoyadi` varchar(255) DEFAULT NULL,
  `akuladi` varchar(255) DEFAULT NULL,
  `asifre` varchar(32) DEFAULT NULL,
  `seviye` varchar(255) DEFAULT NULL,
  `atarih` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `admin`
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES ('5', 'Hasan', 'CELEBI', 'hsbcelebi', 'e10adc3949ba59abbe56e057f20f883e', '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `kategori`
-- ----------------------------
DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori` (
  `kid` int(11) NOT NULL AUTO_INCREMENT,
  `kadi` varchar(255) DEFAULT NULL,
  `ktarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `musteri`
-- ----------------------------
DROP TABLE IF EXISTS `musteri`;
CREATE TABLE `musteri` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `madi` varchar(255) DEFAULT NULL,
  `msoyadi` varchar(255) DEFAULT NULL,
  `mtelefon` int(10) DEFAULT NULL,
  `mmail` varchar(255) DEFAULT NULL,
  `madres` varchar(255) DEFAULT NULL,
  `mtarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `aid` int(11) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ozellik`
-- ----------------------------
DROP TABLE IF EXISTS `ozellik`;
CREATE TABLE `ozellik` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `kid` int(11) DEFAULT NULL,
  `oadi` varchar(255) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL COMMENT 'özelliği ekleyen admin id si',
  `otarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`oid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ozellikkategori`
-- ----------------------------
DROP TABLE IF EXISTS `ozellikkategori`;
CREATE TABLE `ozellikkategori` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `kadi` varchar(255) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `profil`
-- ----------------------------
DROP TABLE IF EXISTS `profil`;
CREATE TABLE `profil` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `aadi` varchar(255) DEFAULT NULL,
  `asoyadi` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `tc` bigint(11) DEFAULT NULL,
  `telefon` bigint(10) DEFAULT NULL,
  `adres` varchar(255) DEFAULT NULL,
  `cinsiyet` enum('bay','bayan') DEFAULT NULL,
  `yas` int(11) DEFAULT NULL,
  `tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `raf`
-- ----------------------------
DROP TABLE IF EXISTS `raf`;
CREATE TABLE `raf` (
  `rid` int(11) NOT NULL,
  `radi` varchar(255) DEFAULT NULL,
  `tanim` varchar(255) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `rtarih` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sepet`
-- ----------------------------
DROP TABLE IF EXISTS `sepet`;
CREATE TABLE `sepet` (
  `seid` int(11) NOT NULL AUTO_INCREMENT,
  `refkodu` varchar(255) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `adet` int(3) DEFAULT NULL,
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`seid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `siparis`
-- ----------------------------
DROP TABLE IF EXISTS `siparis`;
CREATE TABLE `siparis` (
  `said` int(11) NOT NULL,
  `srefkodu` varchar(255) DEFAULT NULL,
  `toplamfiyat` decimal(8,2) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `satarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`said`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `stok`
-- ----------------------------
DROP TABLE IF EXISTS `stok`;
CREATE TABLE `stok` (
  `sid` int(11) NOT NULL,
  `rid` int(11) DEFAULT NULL,
  `kid` int(11) DEFAULT NULL,
  `sadet` int(4) DEFAULT NULL,
  `sfiyat` decimal(6,2) DEFAULT NULL,
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `urunler`
-- ----------------------------
DROP TABLE IF EXISTS `urunler`;
CREATE TABLE `urunler` (
  `uid` int(11) NOT NULL,
  `kid` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  `ozellikler` varchar(255) DEFAULT NULL COMMENT 'ozellikler tablosu içindeki id ler',
  `ubaslik` varchar(255) DEFAULT NULL,
  `udetay` varchar(255) DEFAULT NULL,
  `utarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
