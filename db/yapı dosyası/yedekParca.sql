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

 Date: 07/14/2017 11:29:06 AM
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
