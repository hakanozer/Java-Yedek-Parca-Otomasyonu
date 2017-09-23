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

 Date: 09/23/2017 09:21:42 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `sepet`
-- ----------------------------
BEGIN;
INSERT INTO `sepet` VALUES ('224', '2017-09-21T13:37:35.959', '4', '5', '1', '450.00', '0', '2017-09-21 13:43:36'), ('225', '2017-09-21T13:37:35.959', '4', '5', '1', '450.00', '0', '2017-09-21 13:43:36'), ('226', '2017-09-21T13:37:35.959', '4', '5', '1', '450.00', '0', '2017-09-21 13:43:36'), ('227', '2017-09-21T13:37:35.959', '4', '5', '1', '450.00', '0', '2017-09-21 13:43:36'), ('228', '2017-09-21T13:37:35.959', '2', '3', '1', '70.00', '0', '2017-09-21 13:43:38'), ('231', '2017-09-21T13:37:35.959', '2', '3', '1', '70.00', '0', '2017-09-21 13:43:42'), ('233', '2017-09-21T13:53:24.016', '4', '5', '1', '450.00', '0', '2017-09-21 13:53:25'), ('238', '2017-09-23T09:18:39.832', '1', '2', '1', '65.00', '1', '2017-09-23 09:18:52'), ('239', '2017-09-23T09:18:39.832', '1', '2', '10', '650.00', '1', '2017-09-23 09:18:52');
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `siparis`
-- ----------------------------
BEGIN;
INSERT INTO `siparis` VALUES ('7', '2017-06-24T02:47:04.130', '13.09', '1', '2', '2017-06-24 03:10:02'), ('8', '2017-06-24T19:59:35.732', '140.00', '1', '2', '2017-06-24 19:59:36'), ('9', '2017-06-24T19:59:35.732', '140.00', '2', '2', '2017-06-24 20:05:41'), ('10', '2017-06-25T11:45:17.489', '2500.00', '1', '2', '2017-06-25 11:45:26'), ('11', '2017-06-25T11:52:29.054', '75.00', '1', '2', '2017-06-25 11:52:32'), ('62', '2017-09-17T10:54:41.044', '140.00', '2', '2', '2017-09-17 10:54:45'), ('63', '2017-09-23T09:18:39.832', '715.00', '1', '2', '2017-09-23 09:18:51');
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
  `sadet` int(4) DEFAULT '0' COMMENT 'stok sayısı',
  `sfiyat` decimal(6,2) DEFAULT NULL COMMENT 'Ürünün if',
  `starih` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- ----------------------------
--  Records of `stok`
-- ----------------------------
BEGIN;
INSERT INTO `stok` VALUES ('1', '1', '1', '1', '1', '41', '75.00', '2017-09-23 07:38:37'), ('2', '1', '3', '1', '2', '59', '70.00', '2017-09-21 13:43:42'), ('3', '2', '4', '2', '3', '40', '400.00', '2017-09-21 13:53:24'), ('4', '2', '5', '2', '4', '67', '450.00', '2017-09-21 15:36:59'), ('5', '3', '6', '3', '5', '55', '500.00', '2017-09-21 10:39:35'), ('6', '3', '7', '3', '6', '43', '550.00', '2017-09-21 13:31:59'), ('7', '1', '2', '1', '1', '79', '65.00', '2017-09-23 09:18:45');
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
--  Procedure structure for `proSepetDuzenle`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSepetDuzenle`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proSepetDuzenle`(IN urunid int(11), IN referanskodu varchar(255))
BEGIN

SET @uid = urunid;
SET @refkodu = referanskodu;

SELECT COUNT(adet) as adet, SUM(fiyat) as fiyat from sepet WHERE refkodu = @refkodu and uid = @uid GROUP BY uid = @uid;

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
	SELECT SUM(adet) as adet, SUM(fiyat) as fiyat, ubaslik, seid, sid, refkodu, u.uid, s.pid  FROM sepet as s LEFT JOIN urunler as u ON s.uid = u.uid LEFT JOIN stok as st ON s.pid = st.pid  WHERE s.refkodu=@referansNo GROUP BY s.pid ORDER BY adet DESC;
	

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
--  Procedure structure for `proSepetUrunDus`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proSepetUrunDus`;
delimiter ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `proSepetUrunDus`(IN uid int(11), IN pid int(11))
BEGIN
	SET @urunId = uid;
	SET @partiId = pid;
	delete from sepet where sepet.uid = @urunId and sepet.pid = @partiId;
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

	update stok as st set st.sadet=st.sadet+@gelenAdet where st.sid=@stokid; 

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
