/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50505
 Source Host           : localhost
 Source Database       : yedekParca

 Target Server Type    : MySQL
 Target Server Version : 50505
 File Encoding         : utf-8

 Date: 07/14/2017 11:29:35 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `admin`
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
--  Records of `admin`
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES ('1', 'Ali', 'Bilmem', 'ali', '86318e52f5ed4801abe1d13d509443de', '1', '2017-06-17 10:16:09'), ('2', 'Veli', 'Bilsin', 'veli', '4799d7258653f1c1ad6f6b6718fb9af5', '0', '2017-06-17 10:16:18');
COMMIT;

-- ----------------------------
--  Table structure for `kategori`
-- ----------------------------
DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori` (
  `kid` int(11) NOT NULL AUTO_INCREMENT,
  `kadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `ktarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `kategori`
-- ----------------------------
BEGIN;
INSERT INTO `kategori` VALUES ('1', 'Far', '2017-06-21 10:12:50'), ('2', 'Lastik', '2017-06-21 10:12:54'), ('3', 'Jant', '2017-06-21 10:12:57'), ('4', 'Direksiyon', '2017-06-21 10:13:04'), ('5', 'Debriyaj', '2017-06-21 10:13:09'), ('6', 'Balata', '2017-06-21 10:13:12');
COMMIT;

-- ----------------------------
--  Table structure for `musteri`
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `musteri`
-- ----------------------------
BEGIN;
INSERT INTO `musteri` VALUES ('1', 'Suat', 'CEZİK', '2147483647', 'suatcezik@gmail.com', 'İstanbul', '2017-06-21 10:45:26', null), ('2', 'Yusuf', 'Mucur', '2147483647', 'ymuccur@gmail.com', 'Kadıköy', '2017-06-21 10:51:54', null);
COMMIT;

-- ----------------------------
--  Table structure for `ozellik`
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
--  Table structure for `ozelllikkategori`
-- ----------------------------
DROP TABLE IF EXISTS `ozelllikkategori`;
CREATE TABLE `ozelllikkategori` (
  `okid` int(11) NOT NULL AUTO_INCREMENT,
  `katid` int(11) NOT NULL,
  `kadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `aid` int(11) DEFAULT NULL,
  PRIMARY KEY (`okid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Table structure for `parti`
-- ----------------------------
DROP TABLE IF EXISTS `parti`;
CREATE TABLE `parti` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `kid` int(11) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `parti`
-- ----------------------------
BEGIN;
INSERT INTO `parti` VALUES ('1', '1', '1', '1'), ('2', '7', '1', '1'), ('3', '2', '2', '1'), ('4', '3', '3', '2'), ('5', '4', '4', '2'), ('6', '5', '5', '3'), ('7', '6', '6', '3');
COMMIT;

-- ----------------------------
--  Table structure for `profil`
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
--  Table structure for `raf`
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
--  Table structure for `sepet`
-- ----------------------------
DROP TABLE IF EXISTS `sepet`;
CREATE TABLE `sepet` (
  `seid` int(11) NOT NULL AUTO_INCREMENT,
  `refkodu` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `adet` int(3) DEFAULT NULL,
  `fiyat` decimal(6,2) DEFAULT NULL,
  `satildimi` int(2) DEFAULT '0' COMMENT 'satıs gerceklesirse 1, iptal olursa 0',
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`seid`)
) ENGINE=InnoDB AUTO_INCREMENT=565 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `sepet`
-- ----------------------------
BEGIN;
INSERT INTO `sepet` VALUES ('487', '2017-07-01T17:25:52.985', '6', '7', '1', '550.00', '1', '2017-07-01 17:26:28'), ('488', '2017-07-01T17:25:52.985', '6', '7', '1', '550.00', '1', '2017-07-01 17:26:28'), ('489', '2017-07-01T17:25:52.985', '6', '7', '1', '550.00', '1', '2017-07-01 17:26:28'), ('490', '2017-07-01T17:26:59.943', '6', '7', '1', '550.00', '0', '2017-07-01 17:26:59'), ('492', '2017-07-01T17:29:13.425', '1', '2', '1', '65.00', '1', '2017-07-01 17:37:54'), ('505', '2017-07-05T17:48:31.398', '1', '2', '1', '65.00', '1', '2017-07-05 17:48:43'), ('506', '2017-07-05T17:48:31.398', '2', '3', '1', '70.00', '1', '2017-07-05 17:48:43'), ('510', '2017-07-05T18:09:33.781', '2', '3', '1', '70.00', '1', '2017-07-05 18:11:59'), ('511', '2017-07-05T18:09:33.781', '2', '3', '1', '70.00', '1', '2017-07-05 18:11:59'), ('512', '2017-07-05T18:09:33.781', '2', '3', '1', '70.00', '1', '2017-07-05 18:11:59'), ('513', '2017-07-05T18:09:33.781', '2', '3', '1', '70.00', '1', '2017-07-05 18:11:59'), ('514', '2017-07-05T18:09:33.781', '2', '3', '1', '70.00', '1', '2017-07-05 18:11:59'), ('516', '2017-07-05T18:22:33.402', '1', '1', '1', '75.00', '1', '2017-07-05 18:22:36'), ('517', '2017-07-05T18:22:46.194', '1', '1', '1', '75.00', '1', '2017-07-05 18:22:49'), ('518', '2017-07-05T18:31:42.431', '2', '3', '1', '70.00', '1', '2017-07-05 18:31:45'), ('519', '2017-07-05T18:31:53.572', '2', '3', '1', '70.00', '1', '2017-07-05 18:31:55'), ('520', '2017-07-05T18:33:00.910', '5', '6', '1', '500.00', '1', '2017-07-05 18:33:03'), ('521', '2017-07-08T09:46:30.188', '4', '5', '1', '450.00', '0', '2017-07-08 09:46:30'), ('522', '2017-07-08T09:46:30.188', '4', '5', '1', '450.00', '0', '2017-07-08 09:46:30'), ('523', '2017-07-08T09:47:05.931', '2', '3', '1', '70.00', '0', '2017-07-08 09:47:05'), ('524', '2017-07-08T09:47:05.931', '1', '1', '1', '75.00', '0', '2017-07-08 09:47:07'), ('525', '2017-07-08T09:47:18.282', '4', '5', '1', '450.00', '0', '2017-07-08 09:47:18'), ('528', '2017-07-08T09:47:18.282', '4', '5', '1', '450.00', '0', '2017-07-08 09:47:28'), ('529', '2017-07-09T01:49:19.708', '1', '1', '1', '75.00', '1', '2017-07-09 01:49:21'), ('530', '2017-07-09T01:49:33.992', '1', '1', '1', '75.00', '1', '2017-07-09 01:49:37'), ('531', '2017-07-09T01:49:48.420', '1', '1', '1', '75.00', '0', '2017-07-09 01:49:48'), ('532', '2017-07-12T14:36:57.347', '1', '1', '1', '75.00', '0', '2017-07-12 14:36:57'), ('533', '2017-07-12T14:36:57.347', '1', '1', '1', '75.00', '0', '2017-07-12 14:36:57'), ('534', '2017-07-12T14:41:38.964', '1', '1', '1', '75.00', '0', '2017-07-12 14:41:38'), ('535', '2017-07-12T14:41:38.964', '1', '1', '1', '75.00', '0', '2017-07-12 14:41:39'), ('536', '2017-07-12T14:42:04.206', '1', '1', '1', '75.00', '0', '2017-07-12 14:42:04'), ('537', '2017-07-12T14:42:04.206', '1', '1', '1', '75.00', '0', '2017-07-12 14:42:04'), ('538', '2017-07-12T14:42:23.486', '1', '1', '1', '75.00', '0', '2017-07-12 14:42:23'), ('539', '2017-07-12T14:42:23.486', '1', '1', '1', '75.00', '0', '2017-07-12 14:42:23'), ('542', '2017-07-12T14:47:20.296', '3', '4', '1', '400.00', '0', '2017-07-12 14:48:08'), ('543', '2017-07-12T14:47:20.296', '4', '5', '1', '450.00', '0', '2017-07-12 14:48:10'), ('544', '2017-07-12T15:10:18.549', '1', '1', '1', '75.00', '0', '2017-07-12 15:10:18'), ('545', '2017-07-12T15:10:18.549', '1', '2', '1', '65.00', '0', '2017-07-12 15:10:22'), ('546', '2017-07-12T15:19:35.865', '1', '1', '1', '75.00', '0', '2017-07-12 15:19:35'), ('547', '2017-07-12T15:19:35.865', '1', '2', '1', '65.00', '0', '2017-07-12 15:19:37'), ('548', '2017-07-12T15:20:45.612', '1', '1', '1', '75.00', '0', '2017-07-12 15:20:45'), ('549', '2017-07-12T15:20:45.612', '1', '2', '1', '65.00', '0', '2017-07-12 15:20:46'), ('550', '2017-07-12T15:25:26.588', '1', '1', '1', '75.00', '0', '2017-07-12 15:25:26'), ('551', '2017-07-12T15:25:26.588', '1', '2', '1', '65.00', '0', '2017-07-12 15:25:29'), ('552', '2017-07-12T15:25:37.103', '1', '1', '1', '75.00', '0', '2017-07-12 15:25:37'), ('553', '2017-07-12T15:25:37.103', '1', '2', '1', '65.00', '0', '2017-07-12 15:25:38'), ('554', '2017-07-12T15:25:37.103', '2', '3', '1', '70.00', '0', '2017-07-12 15:25:40'), ('555', '2017-07-13T18:35:01.699', '1', '1', '1', '75.00', '1', '2017-07-13 18:35:22'), ('556', '2017-07-13T18:35:01.699', '1', '2', '5', '325.00', '1', '2017-07-13 18:35:22'), ('557', '2017-07-13T18:35:29.753', '1', '2', '1', '65.00', '0', '2017-07-13 18:35:29'), ('558', '2017-07-13T18:36:31.453', '1', '1', '1', '75.00', '0', '2017-07-13 18:36:31'), ('559', '2017-07-13T18:36:31.453', '1', '1', '1', '75.00', '0', '2017-07-13 18:36:34'), ('560', '2017-07-14T10:39:23.473', '1', '2', '1', '65.00', '1', '2017-07-14 10:39:33'), ('561', '2017-07-14T10:39:23.473', '1', '1', '1', '75.00', '1', '2017-07-14 10:39:33'), ('562', '2017-07-14T10:54:54.072', '5', '6', '1', '500.00', '1', '2017-07-14 10:54:57'), ('563', '2017-07-14T10:55:02.431', '6', '7', '1', '550.00', '1', '2017-07-14 10:55:12'), ('564', '2017-07-14T10:55:35.228', '2', '3', '1', '70.00', '1', '2017-07-14 10:55:39');
COMMIT;

-- ----------------------------
--  Table structure for `siparis`
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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `siparis`
-- ----------------------------
BEGIN;
INSERT INTO `siparis` VALUES ('7', '2017-06-24T02:47:04.130', '13.09', '1', '2', '2017-06-24 03:10:02'), ('8', '2017-06-24T19:59:35.732', '140.00', '1', '2', '2017-06-24 19:59:36'), ('9', '2017-06-24T19:59:35.732', '140.00', '2', '2', '2017-06-24 20:05:41'), ('10', '2017-06-25T11:45:17.489', '2500.00', '1', '2', '2017-06-25 11:45:26'), ('11', '2017-06-25T11:52:29.054', '75.00', '1', '2', '2017-06-25 11:52:32'), ('12', '2017-06-25T11:52:52.585', '400.00', '1', '2', '2017-06-25 11:52:56'), ('13', '2017-06-25T11:54:08.248', '550.00', '1', '2', '2017-06-25 11:54:08'), ('14', '2017-06-25T12:00:21.237', '400.00', '1', '2', '2017-06-25 12:00:22'), ('15', '2017-06-25T12:02:29.029', '65.00', '1', '2', '2017-06-25 12:02:34'), ('16', '2017-06-25T12:03:15.002', '65.00', '1', '2', '2017-06-25 12:03:16'), ('17', '2017-06-25T12:03:55.582', '70.00', '1', '2', '2017-06-25 12:03:56'), ('18', '2017-06-25T12:05:51.434', '450.00', '1', '2', '2017-06-25 12:06:01'), ('19', '2017-06-25T12:07:17.327', '1800.00', '1', '2', '2017-06-25 12:07:18'), ('20', '2017-06-25T12:08:26.332', '70.00', '1', '2', '2017-06-25 12:08:27'), ('21', '2017-06-25T12:59:55.457', '500.00', '1', '2', '2017-06-25 12:59:56'), ('22', '2017-06-25T13:05:29.451', '550.00', '1', '2', '2017-06-25 13:05:30'), ('23', '2017-06-25T13:24:25.199', '450.00', '1', '2', '2017-06-25 13:24:26'), ('24', '2017-06-25T14:16:51.632', '450.00', '1', '2', '2017-06-25 14:16:52'), ('25', '2017-06-25T14:23:05.566', '3850.00', '2', '2', '2017-06-25 14:23:07'), ('26', '2017-06-25T14:24:42.153', '3200.00', '1', '2', '2017-06-25 14:24:43'), ('27', '2017-06-25T19:22:54.547', '3430.00', '1', '2', '2017-06-25 19:22:55'), ('28', '2017-06-29T11:28:04.371', '275.00', '1', '2', '2017-06-29 11:28:45'), ('29', '2017-06-29T12:15:57.099', '1350.00', '1', '2', '2017-06-29 12:15:58'), ('30', '2017-06-29T12:16:55.591', '140.00', '1', '2', '2017-06-29 12:16:56'), ('31', '2017-06-29T12:16:55.591', '140.00', '1', '2', '2017-06-29 12:16:59'), ('32', '2017-06-29T12:19:02.809', '900.00', '1', '2', '2017-06-29 12:19:03'), ('33', '2017-06-29T12:19:29.433', '1000.00', '1', '2', '2017-06-29 12:19:30'), ('36', '2017-06-29T12:23:42.741', '75.00', '1', '2', '2017-06-29 12:23:44'), ('37', '2017-06-29T12:23:52.481', '65.00', '1', '2', '2017-06-29 12:23:53'), ('38', '2017-06-29T12:23:59.736', '70.00', '1', '2', '2017-06-29 12:24:01'), ('39', '2017-06-29T12:25:55.799', '900.00', '1', '2', '2017-06-29 12:26:27'), ('40', '2017-06-29T12:27:10.604', '2250.00', '2', '2', '2017-06-29 12:27:14'), ('41', '2017-06-29T12:28:17.883', '450.00', '2', '2', '2017-06-29 12:28:24'), ('42', '2017-06-29T12:28:27.008', '450.00', '2', '2', '2017-06-29 12:28:30'), ('43', '2017-06-30T09:37:27.897', '1200.00', '1', '2', '2017-06-30 09:37:29'), ('44', '2017-06-30T09:38:15.862', '2000.00', '1', '2', '2017-06-30 09:38:17'), ('45', '2017-07-01T10:53:04.829', '9270.00', '1', '2', '2017-07-01 10:53:21'), ('46', '2017-07-01T17:25:52.985', '1650.00', '1', '2', '2017-07-01 17:26:27'), ('47', '2017-07-01T17:29:13.425', '65.00', '1', '2', '2017-07-01 17:37:52'), ('48', '2017-07-05T17:48:31.398', '135.00', '1', '2', '2017-07-05 17:48:42'), ('49', '2017-07-05T18:09:33.781', '350.00', '2', '2', '2017-07-05 18:11:58'), ('50', '2017-07-05T18:22:33.402', '75.00', '1', '2', '2017-07-05 18:22:35'), ('51', '2017-07-05T18:22:46.194', '75.00', '1', '2', '2017-07-05 18:22:48'), ('52', '2017-07-05T18:31:42.431', '70.00', '1', '2', '2017-07-05 18:31:44'), ('53', '2017-07-05T18:31:53.572', '70.00', '1', '2', '2017-07-05 18:31:54'), ('54', '2017-07-05T18:33:00.910', '500.00', '1', '2', '2017-07-05 18:33:02'), ('55', '2017-07-09T01:49:19.708', '75.00', '1', '2', '2017-07-09 01:49:20'), ('56', '2017-07-09T01:49:33.992', '75.00', '1', '2', '2017-07-09 01:49:35'), ('57', '2017-07-13T18:35:01.699', '400.00', '1', '2', '2017-07-13 18:35:20'), ('58', '2017-07-14T10:39:23.473', '140.00', '1', '2', '2017-07-14 10:39:32'), ('59', '2017-07-14T10:54:54.072', '500.00', '1', '2', '2017-07-14 10:54:55'), ('60', '2017-07-14T10:55:02.431', '550.00', '2', '2', '2017-07-14 10:55:11'), ('61', '2017-07-14T10:55:35.228', '70.00', '2', '2', '2017-07-14 10:55:37');
COMMIT;

-- ----------------------------
--  Table structure for `stok`
-- ----------------------------
DROP TABLE IF EXISTS `stok`;
CREATE TABLE `stok` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL COMMENT 'parti id',
  `kid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL COMMENT 'kategori id si',
  `sadet` int(4) DEFAULT NULL COMMENT 'stok sayısı',
  `sfiyat` decimal(6,2) DEFAULT NULL COMMENT 'Ürünün if',
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `stok`
-- ----------------------------
BEGIN;
INSERT INTO `stok` VALUES ('1', '1', '1', '1', '1', '78', '75.00', '2017-07-14 10:39:25'), ('2', '1', '3', '1', '2', '59', '70.00', '2017-07-14 10:55:35'), ('3', '2', '4', '2', '3', '80', '400.00', '2017-07-12 14:48:08'), ('4', '2', '5', '2', '4', '61', '450.00', '2017-07-12 14:48:10'), ('5', '3', '6', '3', '5', '60', '500.00', '2017-07-14 10:54:54'), ('6', '3', '7', '3', '6', '35', '550.00', '2017-07-14 10:55:02'), ('7', '1', '2', '1', '1', '51', '65.00', '2017-07-14 10:39:23');
COMMIT;

-- ----------------------------
--  Table structure for `urunler`
-- ----------------------------
DROP TABLE IF EXISTS `urunler`;
CREATE TABLE `urunler` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `kid` int(11) NOT NULL,
  `aid` int(11) DEFAULT NULL,
  `ozellikler` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL COMMENT 'özellikler tablosu içerisindeki id ler',
  `ubaslik` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `udetay` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `utarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `urunler`
-- ----------------------------
BEGIN;
INSERT INTO `urunler` VALUES ('1', '1', '2', null, 'Kısa Far', null, '2017-06-21 11:10:28'), ('2', '1', '2', null, 'Uzun Far', null, '2017-06-21 11:10:26'), ('3', '2', '2', null, 'Kış Lastiği', null, '2017-06-21 11:21:59'), ('4', '2', '2', null, 'Yaz Lastiği', null, '2017-06-21 11:22:10'), ('5', '3', '2', null, '14', null, '2017-06-22 08:44:22'), ('6', '3', '2', null, '17', null, '2017-06-22 08:44:26');
COMMIT;

-- ----------------------------
--  Procedure structure for `proKategoriGetir`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proKategoriGetir`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proKategoriGetir`()
BEGIN
	SELECT *FROM kategori;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proMusteriGetir`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proMusteriGetir`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proMusteriGetir`()
BEGIN
	SELECT *FROM musteri;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSatildimi`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSatildimi`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proSatildimi`(IN rno varchar(255))
BEGIN
	SET @gelenReferansNo = rno;

	update `yedekParca`.`sepet` set `satildimi`='1' where refkodu = @gelenReferansNo;

END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSepetEkle`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSepetEkle`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proSepetEkle`(IN uid int(11), IN uadet int(11), IN rno varchar(255), IN ufiyat double(6,2), IN pid int(11))
BEGIN
	SET @urunId = uid;
	SET @urunAdet = uadet;
	SET @refNo = rno;
	SET @urunFiyat = ufiyat;
	SET @parti = pid;
	INSERT INTO sepet VALUES(null, @refNo, @urunId, @parti, @urunAdet, @urunFiyat, 0, now() );
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSepetGetir`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSepetGetir`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proSepetGetir`(IN rno varchar(255))
BEGIN
	SET @referansNo = rno;
	SELECT *FROM sepet as s LEFT JOIN urunler as u ON s.uid = u.uid LEFT JOIN stok as st ON s.pid = st.pid  WHERE s.refkodu=@referansNo;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSepetStokGetir`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSepetStokGetir`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proSepetStokGetir`(IN seid int(11))
BEGIN
	SET @sepetid = seid;
	SELECT * FROM sepet as s LEFT JOIN stok as st ON s.uid = st.uid AND s.pid = st.pid WHERE s.seid = @sepetid;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSepetToplamFiyatGetir`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSepetToplamFiyatGetir`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proSepetToplamFiyatGetir`(IN rno varchar(255))
BEGIN
	SET @referansKodu = rno;
	Select SUM(fiyat) FROM sepet WHERE refkodu = @referansKodu;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSepetUrunSilme`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSepetUrunSilme`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proSepetUrunSilme`(IN sid int(11))
BEGIN
	SET @gelenSepetId = sid;
	DELETE FROM sepet WHERE seid = @gelenSepetId;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSiparisOlustur`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSiparisOlustur`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proSiparisOlustur`(IN rno varchar(255), IN fiyat decimal(6,2), IN muid int(11), IN aid int(11))
BEGIN
	SET @referansKodu = rno;
	SET @fiyat = fiyat;
	SET @musteriId = muid;
	SET @adminId = aid;
	INSERT INTO siparis VALUES(null, @referansKodu, @fiyat, @musteriId, @adminId, now());
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proSonSiparisler`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSonSiparisler`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proSonSiparisler`()
BEGIN
	select * from `yedekParca`.`siparis` as s LEFT JOIN musteri as m ON s.mid = m.mid  LEFT JOIN admin as a ON s.aid = a.aid ORDER BY s.satarih DESC limit 0,10;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proStokDus`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proStokDus`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proStokDus`(IN sid int(11), IN adet int(11))
BEGIN

	SET @stokid = sid;
	SET @gelenAdet = adet;
	update stok as st set st.sadet=st.sadet-adet where st.sid=@stokid; 

END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proStokEkle`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proStokEkle`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proStokEkle`(IN sid int(11), IN adet int(11))
BEGIN

	SET @stokid = sid;
	SET @gelenAdet = adet;
	update stok as st set st.sadet=st.sadet+adet where st.sid=@stokid; 

END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proStokFiyatGetir`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proStokFiyatGetir`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proStokFiyatGetir`(IN sid int(11))
BEGIN
	SET @gelenKategoriId = sid;
	SELECT *FROM stok as s INNER JOIN urunler as u ON s.uid = u.uid WHERE s.sid = @gelenKategoriId;
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proUrunAra`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proUrunAra`;
delimiter ;;
CREATE DEFINER=`byczk`@`localhost` PROCEDURE `proUrunAra`(IN kid int(11), IN uadi varchar(255))
BEGIN
	SET @gelenKategoriId = kid;
	SET @gelenData = uadi;
	SELECT *FROM stok as s INNER JOIN urunler as u ON s.uid = u.uid WHERE s.kid =@gelenKategoriId and u.ubaslik LIKE CONCAT('%',@gelenData,'%');
END
 ;;
delimiter ;

-- ----------------------------
--  Procedure structure for `proUrunGetir`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proUrunGetir`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proUrunGetir`(IN kid int(11))
BEGIN
	SET @gelenKategoriId = kid;
	SELECT *FROM stok as s INNER JOIN urunler as u ON s.uid = u.uid LEFT JOIN parti as p ON p.pid = s.pid WHERE s.kid =@gelenKategoriId;
END
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
