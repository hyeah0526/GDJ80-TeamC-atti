-- MariaDB dump 10.19-11.3.2-MariaDB, for osx10.19 (arm64)
--
-- Host: localhost    Database: atti
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clinic`
--

DROP TABLE IF EXISTS `clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinic` (
  `clinic_no` int NOT NULL AUTO_INCREMENT,
  `regi_no` int NOT NULL,
  `clinic_content` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `clinic_cost` int NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`clinic_no`),
  KEY `FK_clinic_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_clinic_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic`
--

LOCK TABLES `clinic` WRITE;
/*!40000 ALTER TABLE `clinic` DISABLE KEYS */;
INSERT INTO `clinic` VALUES
(1,2,'배변기능 이상으로 정밀 검사 필요. X-ray 및 혈액 검사 진행 후 재검진',5000,'2024-05-09 17:12:19','2024-05-09 17:12:19'),
(2,3,'다리 관절  이상으로 정밀 검사 필요. X-ray 촬영 후 재검진 / 관절에 염증이 심해 수술 필요',5000,'2024-05-09 17:14:59','2024-05-09 17:22:08'),
(3,4,'노화로 인한 시력 감퇴',5000,'2024-05-09 17:14:59','2024-05-09 17:14:59'),
(4,5,'소화기능 이상으로 정밀 검사 필요. X-ray 및 혈액 검사 진행 후 재검진',5000,'2024-05-09 17:14:59','2024-05-09 17:14:59'),
(5,10,'소화 기능 이상으로 정밀 검사 필요. 소변검사 진행',5000,'2024-05-14 10:47:00','2024-05-14 10:47:00'),
(6,11,'다리 관절  이상으로 정밀 검사 필요. X-ray 촬영 후 재검진 / 관절에 염증이 심해 수술 필요',5000,'2024-05-14 10:47:00','2024-05-14 10:47:00'),
(7,12,'다리 관절 이상으로 수술 필요.',5000,'2024-05-14 10:47:00','2024-05-14 10:47:00'),
(8,13,'빈혈 증상 의심으로 혈액 검사 필요',5000,'2024-05-14 10:47:00','2024-05-14 10:47:00'),
(9,14,'입원 후 경과 확인',5000,'2024-05-14 10:47:00','2024-05-14 10:47:00'),
(10,15,'발작 증상으로 종합검사 필요',5000,'2024-05-14 10:47:00','2024-05-14 10:47:00'),
(11,16,'노화로 인한 시력 감퇴',5000,'2024-05-09 17:14:59','2024-05-09 17:14:59'),
(12,17,'다리 관절  이상으로 수술 필요',5000,'2024-05-09 17:14:59','2024-05-09 17:14:59'),
(13,18,'영양제 처방',5000,'2024-05-09 17:14:59','2024-05-09 17:14:59'),
(14,19,'발톱 갈아줌',5000,'2024-05-09 17:14:59','2024-05-09 17:14:59'),
(15,20,'전체 검사 및 중성화수술 진행',5000,'2024-05-09 17:14:59','2024-05-09 17:14:59'),
(16,21,'수술 후 검사로 경과 확인',5000,'2024-05-11 17:14:59','2024-05-11 17:14:59'),
(17,22,'저번 진료 후 개선되지 않아 수술 필요',5000,'2024-05-11 17:14:59','2024-05-11 17:14:59'),
(18,23,'중성화 수술로 입원 후 재진료',5000,'2024-05-11 16:59:37','2024-05-11 16:59:37'),
(19,24,'시력 재확인',5000,'2024-05-11 16:59:37','2024-05-11 16:59:37'),
(20,25,'부리 이상으로 수술 필요. 수술 전 검사 필요.',5000,'2024-05-11 16:59:37','2024-05-11 16:59:37'),
(21,26,'노화로 인한 시력 감퇴',5000,'2024-04-02 16:59:37','2024-04-02 16:59:37'),
(22,27,'다리 관절  이상으로 수술 필요',5000,'2024-04-08 16:59:37','2024-04-08 16:59:37'),
(23,28,'영양제 처방',5000,'2024-04-08 16:59:37','2024-04-08 16:59:37'),
(24,29,'발톱 갈아줌',5000,'2024-04-06 16:59:37','2024-04-06 16:59:37'),
(25,30,'전체 검사 및 중성화수술 진행',5000,'2024-04-05 16:59:37','2024-04-05 16:59:37');
/*!40000 ALTER TABLE `clinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_no` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `customer_tel` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `customer_address` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`customer_no`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES
(3,'김인수','01011111111','경기도','2024-05-09 16:12:25','2024-05-09 16:12:25'),
(4,'김지훈','01022222222','강원도','2024-05-09 16:13:29','2024-05-09 16:13:29'),
(5,'박혜아','01033333333','충청도','2024-05-09 16:13:29','2024-05-09 16:13:29'),
(6,'한은혜','01044444444','전라도','2024-05-09 16:13:29','2024-05-09 16:13:29'),
(7,'김일','01011111112','경기도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(8,'김이','01022222223','강원도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(9,'박삼','01033333334','충청도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(10,'한사','01044444445','전라도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(11,'김오','01011111116','경기도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(12,'김육','01022222227','강원도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(13,'박칠','01033333338','충청도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(14,'한팔','01044444449','전라도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(15,'김구','01011111121','경기도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(16,'김십','01022222232','강원도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(17,'박십일','01033333323','충청도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(18,'한십이','01044444424','전라도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(19,'김십삼','01011111125','경기도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(20,'김십사','01022222226','강원도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(21,'박십오','01033333327','충청도','2024-05-14 10:08:08','2024-05-14 10:08:08'),
(22,'한십육','01044444428','전라도','2024-05-14 10:08:08','2024-05-14 10:08:08');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `emp_no` int NOT NULL,
  `emp_major` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `emp_grade` enum('의사','간호사','관리자','퇴사자') COLLATE utf8mb4_bin NOT NULL,
  `emp_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `emp_birth` date NOT NULL,
  `emp_gender` enum('M','F') COLLATE utf8mb4_bin NOT NULL,
  `emp_tel` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `hire_date` date NOT NULL,
  `emp_pw` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`emp_no`) USING BTREE,
  KEY `FK_empoyee_major` (`emp_major`),
  CONSTRAINT `FK_empoyee_major` FOREIGN KEY (`emp_major`) REFERENCES `major` (`emp_major`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES
(1100802,'포유류','관리자','박지유','1987-04-23','M','01055555555','2010-08-02','*00A51F3F48415C7D4E8908980D443C29C69B60C9'),
(2020226,'파충류','의사','최애영','1979-11-15','F','01066666666','2002-02-26','*A4B6157319038724E3560894F7F932C8886EBFCF'),
(2020227,'조류','의사','박인수','1985-05-14','M','01033333333','2020-02-22','*A4B6157319038724E3560894F7F932C8886EBFCF'),
(3181112,'파충류','간호사','강수영','1991-08-08','F','01088888888','2018-11-12','*A4B6157319038724E3560894F7F932C8886EBFCF'),
(3200513,'포유류','간호사','강국길','1996-12-03','M','01077777777','2020-05-13','*A4B6157319038724E3560894F7F932C8886EBFCF');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examination`
--

DROP TABLE IF EXISTS `examination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examination` (
  `examination_no` int NOT NULL AUTO_INCREMENT,
  `regi_no` int NOT NULL,
  `examination_kind` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `examination_content` text COLLATE utf8mb4_bin NOT NULL,
  `examination_date` datetime NOT NULL,
  PRIMARY KEY (`examination_no`),
  KEY `FK_examination_examination_kind` (`examination_kind`),
  KEY `FK_examination_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_examination_examination_kind` FOREIGN KEY (`examination_kind`) REFERENCES `examination_kind` (`examination_kind`),
  CONSTRAINT `FK_examination_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examination`
--

LOCK TABLES `examination` WRITE;
/*!40000 ALTER TABLE `examination` DISABLE KEYS */;
INSERT INTO `examination` VALUES
(4,10,'소변검사','소변 검사','2024-05-14 07:47:00'),
(5,11,'x-ray','다리 관절 x-ray 촬영','2024-05-14 08:47:00'),
(6,15,'소변검사','소변 검사','2024-05-14 12:47:00'),
(7,15,'혈액검사','혈액 검사','2024-05-14 12:47:00'),
(8,15,'x-ray','종합 x-ray 촬영','2024-05-14 12:47:00'),
(9,16,'혈액검사','혈액 검사','2024-05-14 12:47:00'),
(10,20,'혈액검사','혈액 검사','2024-05-09 14:59:37'),
(11,20,'x-ray','종합 x-ray 촬영','2024-05-09 17:14:59'),
(12,21,'혈액검사','혈액 검사','2024-05-09 14:59:37'),
(13,25,'혈액검사','혈액 검사','2024-05-11 14:59:37'),
(14,26,'혈액검사','혈액 검사','2024-04-02 15:59:37'),
(15,30,'혈액검사','혈액 검사','2024-04-05 16:59:37');
/*!40000 ALTER TABLE `examination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examination_kind`
--

DROP TABLE IF EXISTS `examination_kind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examination_kind` (
  `examination_kind` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `examination_cost` int NOT NULL,
  PRIMARY KEY (`examination_kind`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examination_kind`
--

LOCK TABLES `examination_kind` WRITE;
/*!40000 ALTER TABLE `examination_kind` DISABLE KEYS */;
INSERT INTO `examination_kind` VALUES
('x-ray',30000),
('소변검사',15000),
('혈액검사',80000);
/*!40000 ALTER TABLE `examination_kind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examination_photo`
--

DROP TABLE IF EXISTS `examination_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examination_photo` (
  `photo_no` int NOT NULL AUTO_INCREMENT,
  `examination_no` int NOT NULL,
  `registration_no` int NOT NULL,
  `photo_name` text COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`photo_no`),
  KEY `FK_examination_photo_examination` (`examination_no`),
  KEY `FK_examination_photo_registration` (`registration_no`),
  CONSTRAINT `FK_examination_photo_examination` FOREIGN KEY (`examination_no`) REFERENCES `examination` (`examination_no`),
  CONSTRAINT `FK_examination_photo_registration` FOREIGN KEY (`registration_no`) REFERENCES `registration` (`regi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examination_photo`
--

LOCK TABLES `examination_photo` WRITE;
/*!40000 ALTER TABLE `examination_photo` DISABLE KEYS */;
INSERT INTO `examination_photo` VALUES
(1,5,11,'testphotoname1.jpg'),
(2,8,15,'testphotoname2.jpg'),
(3,11,20,'testphotoname3.jpg');
/*!40000 ALTER TABLE `examination_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_room`
--

DROP TABLE IF EXISTS `hospital_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital_room` (
  `room_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `state` enum('ON','OFF') COLLATE utf8mb4_bin NOT NULL DEFAULT 'OFF',
  `cost` int NOT NULL,
  `update_date` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`room_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_room`
--

LOCK TABLES `hospital_room` WRITE;
/*!40000 ALTER TABLE `hospital_room` DISABLE KEYS */;
INSERT INTO `hospital_room` VALUES
('A01','OFF',75000,'2024-05-10 10:12:07'),
('A02','ON',75000,'2024-05-10 09:59:44'),
('A03','OFF',75000,'2024-05-10 09:59:44'),
('A04','OFF',75000,'2024-05-10 09:59:44'),
('A05','OFF',75000,'2024-05-10 09:59:44'),
('A06','OFF',75000,'2024-05-10 09:59:44'),
('A07','OFF',75000,'2024-05-10 09:59:44'),
('A08','OFF',75000,'2024-05-10 09:59:44'),
('A09','OFF',75000,'2024-05-10 09:59:44'),
('A10','OFF',75000,'2024-05-10 09:59:44'),
('B01','OFF',150000,'2024-05-10 09:59:44'),
('B02','OFF',150000,'2024-05-10 09:59:44'),
('B03','OFF',150000,'2024-05-10 09:59:44'),
('B04','OFF',150000,'2024-05-10 09:59:44'),
('B05','OFF',150000,'2024-05-10 09:59:44'),
('B06','OFF',150000,'2024-05-10 09:59:44'),
('B07','OFF',150000,'2024-05-10 09:59:44'),
('B08','OFF',150000,'2024-05-10 09:59:44'),
('B09','OFF',150000,'2024-05-10 09:59:44'),
('B10','OFF',150000,'2024-05-10 09:59:44'),
('C01','OFF',75000,'2024-05-10 09:59:44'),
('C02','OFF',75000,'2024-05-10 09:59:44'),
('C03','ON',75000,'2024-05-10 09:59:44'),
('C04','OFF',75000,'2024-05-10 09:59:44'),
('C05','OFF',75000,'2024-05-10 09:59:44'),
('C06','OFF',75000,'2024-05-10 09:59:44'),
('C07','OFF',75000,'2024-05-10 09:59:44'),
('C08','OFF',75000,'2024-05-10 09:59:44'),
('C09','OFF',75000,'2024-05-10 09:59:44'),
('C10','OFF',75000,'2024-05-10 09:59:44');
/*!40000 ALTER TABLE `hospital_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitalization`
--

DROP TABLE IF EXISTS `hospitalization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospitalization` (
  `hospitalization_no` int NOT NULL AUTO_INCREMENT,
  `room_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `regi_no` int NOT NULL,
  `hospitalization_content` text COLLATE utf8mb4_bin NOT NULL,
  `create_date` datetime NOT NULL,
  `discharge_date` datetime NOT NULL,
  PRIMARY KEY (`hospitalization_no`),
  KEY `FK_hospitalization_list_hospital_room` (`room_name`),
  KEY `FK_hospitalization_list_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_hospitalization_list_hospital_room` FOREIGN KEY (`room_name`) REFERENCES `hospital_room` (`room_name`),
  CONSTRAINT `FK_hospitalization_list_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitalization`
--

LOCK TABLES `hospitalization` WRITE;
/*!40000 ALTER TABLE `hospitalization` DISABLE KEYS */;
INSERT INTO `hospitalization` VALUES
(1,'A01',3,'관절 염증 수술 환자 입원중','2024-05-10 10:11:16','2024-05-13 10:11:16'),
(2,'A02',11,'다리 관절 이상으로 입원중','2024-05-14 10:47:00','2024-05-16 00:00:00'),
(3,'C03',12,'다리 골절 수술로 입원','2024-05-14 10:47:00','2024-05-16 00:00:00'),
(4,'B04',14,'눈 이물질 수시 확인 필요','2024-05-14 10:47:00','2024-05-16 00:00:00'),
(5,'A05',15,'종양 제거 후 입원','2024-05-14 10:47:00','2024-05-16 00:00:00'),
(6,'A02',16,'영양제','2024-05-09 17:14:59','2024-05-11 17:14:59'),
(7,'A03',17,'다리 수술로 입원','2024-05-09 17:14:59','2024-05-09 17:14:59'),
(8,'A04',20,'중성화수술로 입원','2024-05-09 17:29:35','2024-05-09 17:29:35'),
(9,'A03',21,'다리 재검사 후 입원','2024-05-11 17:14:59','2024-05-13 17:14:59'),
(10,'B01',22,'내과 수술 후 입원','2024-05-11 17:14:59','2024-05-11 17:14:59'),
(11,'C05',25,'부리 접합 수술 후 입원','2024-05-11 17:14:59','2024-05-11 17:14:59'),
(12,'A02',26,'영양제','2024-04-02 17:14:59','2024-04-04 17:14:59'),
(13,'A03',27,'다리 수술로 입원','2024-04-08 17:14:59','2024-04-10 17:14:59'),
(14,'A04',30,'중성화수술로 입원','2024-04-05 17:29:35','2024-04-07 17:29:35');
/*!40000 ALTER TABLE `hospitalization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `major` (
  `emp_major` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`emp_major`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES
('조류'),
('파충류'),
('포유류');
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine` (
  `medicine_no` int NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `medicine_cost` int NOT NULL,
  PRIMARY KEY (`medicine_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine`
--

LOCK TABLES `medicine` WRITE;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
INSERT INTO `medicine` VALUES
(1,'cefovecin',40000),
(2,'oxytocin',60000),
(3,'tricaines',50000);
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_history`
--

DROP TABLE IF EXISTS `password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_history` (
  `history_no` int NOT NULL AUTO_INCREMENT,
  `emp_no` int NOT NULL,
  `previous_pw` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`history_no`),
  KEY `FK_password_history_empoyee` (`emp_no`) USING BTREE,
  CONSTRAINT `FK_password_history_empoyee` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_history`
--

LOCK TABLES `password_history` WRITE;
/*!40000 ALTER TABLE `password_history` DISABLE KEYS */;
INSERT INTO `password_history` VALUES
(7,1100802,'*A4B6157319038724E3560894F7F932C8886EBFCF','2024-05-12 19:56:49');
/*!40000 ALTER TABLE `password_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `payment_no` int NOT NULL AUTO_INCREMENT,
  `regi_no` int NOT NULL,
  `payment_state` enum('미납','완납') COLLATE utf8mb4_bin NOT NULL DEFAULT '미납',
  `payment_category` enum('수술','처방','진료','검사','입원') COLLATE utf8mb4_bin NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`payment_no`),
  KEY `FK_payment_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_payment_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES
(1,2,'미납','진료','2024-05-09 16:59:37'),
(2,3,'미납','진료','2024-05-09 16:59:37'),
(3,5,'미납','진료','2024-05-09 16:59:37'),
(4,3,'미납','수술','2024-05-09 17:29:35'),
(5,3,'미납','처방','2024-05-09 17:37:18'),
(6,3,'미납','처방','2024-05-09 17:38:08'),
(7,2,'미납','검사','2024-05-10 09:48:06'),
(8,3,'미납','검사','2024-05-10 09:48:06'),
(9,4,'미납','검사','2024-05-10 09:48:06'),
(10,3,'미납','입원','2024-05-10 10:11:16'),
(11,10,'미납','진료','2024-05-14 10:47:00'),
(12,10,'미납','검사','2024-05-14 10:47:00'),
(13,11,'미납','진료','2024-05-14 10:47:00'),
(14,11,'미납','검사','2024-05-14 10:47:00'),
(15,11,'미납','입원','2024-05-14 10:47:00'),
(16,12,'미납','진료','2024-05-14 10:47:00'),
(17,12,'미납','수술','2024-05-14 10:47:00'),
(18,12,'미납','입원','2024-05-14 10:47:00'),
(19,13,'미납','진료','2024-05-14 10:47:00'),
(20,13,'미납','처방','2024-05-14 10:47:00'),
(21,14,'미납','진료','2024-05-14 10:47:00'),
(22,14,'미납','입원','2024-05-14 10:47:00'),
(23,15,'미납','진료','2024-05-14 10:47:00'),
(24,15,'미납','검사','2024-05-14 10:47:00'),
(25,15,'미납','입원','2024-05-14 10:47:00'),
(26,15,'미납','수술','2024-05-14 10:47:00'),
(27,15,'미납','처방','2024-05-14 10:47:00'),
(28,16,'완납','진료','2024-05-09 17:14:59'),
(29,16,'완납','검사','2024-05-09 17:14:59'),
(30,16,'완납','입원','2024-05-09 17:14:59'),
(31,17,'완납','진료','2024-05-09 17:14:59'),
(32,17,'완납','수술','2024-05-09 17:14:59'),
(33,17,'완납','입원','2024-05-09 17:14:59'),
(34,18,'완납','진료','2024-05-09 17:14:59'),
(35,18,'완납','처방','2024-05-09 17:14:59'),
(36,20,'완납','진료','2024-05-09 17:14:59'),
(37,20,'완납','검사','2024-05-09 17:14:59'),
(38,20,'완납','수술','2024-05-09 17:14:59'),
(39,20,'완납','입원','2024-05-09 17:14:59'),
(40,20,'완납','처방','2024-05-09 17:14:59'),
(41,21,'완납','진료','2024-05-11 17:14:59'),
(42,21,'완납','검사','2024-05-11 17:14:59'),
(43,21,'완납','입원','2024-05-11 17:14:59'),
(44,22,'완납','진료','2024-05-11 17:14:59'),
(45,22,'완납','수술','2024-05-11 17:14:59'),
(46,22,'완납','입원','2024-05-11 17:14:59'),
(47,23,'완납','진료','2024-05-11 16:59:37'),
(48,23,'완납','처방','2024-05-11 16:59:37'),
(49,24,'완납','진료','2024-05-11 16:59:37'),
(50,25,'완납','진료','2024-05-11 17:14:59'),
(51,25,'완납','검사','2024-05-11 17:14:59'),
(52,25,'완납','수술','2024-05-11 17:14:59'),
(53,25,'완납','입원','2024-05-11 17:14:59'),
(54,25,'완납','처방','2024-05-11 17:14:59'),
(55,26,'완납','진료','2024-04-02 17:14:59'),
(56,26,'완납','검사','2024-04-02 17:14:59'),
(57,26,'완납','입원','2024-04-02 17:14:59'),
(58,27,'완납','진료','2024-04-08 17:14:59'),
(59,27,'완납','수술','2024-04-08 17:14:59'),
(60,27,'완납','입원','2024-04-08 17:14:59'),
(61,28,'완납','진료','2024-04-08 17:14:59'),
(62,28,'완납','처방','2024-04-08 17:14:59'),
(63,30,'완납','진료','2024-04-05 17:14:59'),
(64,30,'완납','검사','2024-04-05 17:14:59'),
(65,30,'완납','수술','2024-04-05 17:14:59'),
(66,30,'완납','입원','2024-04-05 17:14:59'),
(67,30,'완납','처방','2024-04-05 17:14:59'),
(68,19,'완납','진료','2024-05-09 17:14:59'),
(69,29,'완납','진료','2024-04-06 17:14:59');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pet` (
  `pet_no` int NOT NULL AUTO_INCREMENT,
  `customer_no` int NOT NULL,
  `emp_major` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `pet_kind` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `pet_name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `pet_birth` date NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`pet_no`),
  KEY `FK_pet_customer` (`customer_no`),
  CONSTRAINT `FK_pet_customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet`
--

LOCK TABLES `pet` WRITE;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` VALUES
(1,3,'파충류','도마뱀','왕눈이','2024-05-08','2024-05-09 16:26:55','2024-05-09 16:26:55'),
(2,5,'포유류','강아지','까망이','2023-02-01','2024-05-09 16:29:27','2024-05-09 16:29:27'),
(3,6,'포유류','강아지','달이','2023-04-01','2024-05-09 16:29:27','2024-05-09 16:29:27'),
(4,4,'포유류','원숭이','개구쟁이','2024-05-01','2024-05-09 16:29:38','2024-05-09 16:29:38'),
(5,7,'파충류','도마뱀','하나','2024-05-08','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(6,8,'포유류','강아지','두울','2023-02-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(7,9,'조류','앵무새','세엣','2023-04-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(8,10,'포유류','원숭이','네엣','2024-05-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(9,11,'파충류','도마뱀','다섯','2024-05-08','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(10,12,'포유류','강아지','여섯','2023-02-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(11,13,'포유류','강아지','일곱','2023-04-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(12,14,'포유류','원숭이','여덟','2024-05-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(13,15,'파충류','도마뱀','아홉','2024-05-08','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(14,16,'조류','비둘기','열열','2023-02-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(15,17,'포유류','강아지','열하나','2023-04-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(16,18,'포유류','원숭이','열두울','2024-05-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(17,19,'파충류','도마뱀','열세엣','2024-05-08','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(18,20,'포유류','강아지','열네엣','2023-02-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(19,21,'포유류','강아지','열다섯','2023-04-01','2024-05-14 10:16:54','2024-05-14 10:16:54'),
(20,22,'포유류','원숭이','열여섯','2024-05-01','2024-05-14 10:16:54','2024-05-14 10:16:54');
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescription` (
  `prescription_no` int NOT NULL AUTO_INCREMENT,
  `regi_no` int NOT NULL,
  `medicine_no` int NOT NULL,
  `prescription_content` text COLLATE utf8mb4_bin NOT NULL,
  `prescription_date` datetime NOT NULL,
  PRIMARY KEY (`prescription_no`) USING BTREE,
  KEY `FK_prescription_medicine` (`medicine_no`),
  KEY `FK_prescription_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_prescription_medicine` FOREIGN KEY (`medicine_no`) REFERENCES `medicine` (`medicine_no`),
  CONSTRAINT `FK_prescription_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
INSERT INTO `prescription` VALUES
(3,13,1,'철분영양제','2024-05-14 10:47:00'),
(4,15,1,'영양제','2024-05-14 12:47:00'),
(5,15,2,'수술 후 소염제 ','2024-05-14 12:47:00'),
(6,15,3,'진통제','2024-05-14 12:47:00'),
(7,18,1,'영양제','2024-05-09 12:59:37'),
(8,20,3,'진통제','2024-05-09 14:59:37'),
(9,23,3,'진통제','2024-05-11 12:59:37'),
(10,25,1,'영양제','2024-05-11 14:59:37'),
(11,25,3,'진통제','2024-05-11 14:59:37'),
(12,28,1,'영양제','2024-04-08 16:59:37'),
(13,30,3,'진통제','2024-04-05 16:59:37');
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration` (
  `regi_no` int NOT NULL AUTO_INCREMENT,
  `emp_no` int NOT NULL,
  `pet_no` int NOT NULL,
  `regi_content` text COLLATE utf8mb4_bin NOT NULL,
  `create_date` datetime NOT NULL,
  `regi_date` datetime NOT NULL,
  `regi_state` enum('예약','대기','취소','진행','완료') COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`regi_no`) USING BTREE,
  KEY `FK__pet` (`pet_no`),
  KEY `FK_registration_empoyee` (`emp_no`),
  CONSTRAINT `FK__pet` FOREIGN KEY (`pet_no`) REFERENCES `pet` (`pet_no`),
  CONSTRAINT `FK_registration_empoyee` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES
(2,1100802,1,'배변기능 이상','2024-05-09 16:59:37','2024-05-14 13:47:00','대기'),
(3,2020226,2,'다리 관절  이상','2024-05-09 16:59:37','2024-05-14 14:47:00','대기'),
(4,3200513,3,'시력  이상','2024-05-09 16:59:37','2024-05-24 10:00:00','예약'),
(5,3181112,4,'소화 기능  이상','2024-05-09 16:59:37','2024-05-14 15:47:00','대기'),
(6,1100802,5,'배변기능 이상','2024-05-14 10:47:00','2024-05-14 16:47:00','대기'),
(7,2020226,6,'다리 관절  이상','2024-05-14 10:47:00','2024-05-25 10:10:10','예약'),
(8,3200513,7,'시력  이상','2024-05-14 10:47:00','2024-05-20 11:11:11','예약'),
(9,3181112,8,'소화 기능  이상','2024-05-14 10:47:00','2024-05-26 09:00:00','예약'),
(10,2020226,5,'소화 기능 이상','2024-05-14 10:47:00','2024-05-14 07:47:00','진행'),
(11,1100802,6,'다리 관절  이상','2024-05-14 10:47:00','2024-05-14 08:47:00','진행'),
(12,2020227,7,'다리 관절 골절','2024-05-14 10:47:00','2024-05-14 09:47:00','진행'),
(13,1100802,8,'비틀비틀 걸어요','2024-05-14 10:47:00','2024-05-14 10:47:00','진행'),
(14,2020226,9,'눈에 이물질이 들어갔어요','2024-05-14 10:47:00','2024-05-14 11:47:00','진행'),
(15,1100802,10,'발작증상','2024-05-14 10:47:00','2024-05-14 12:47:00','진행'),
(16,1100802,11,'시력  이상','2024-05-09 16:59:37','2024-05-09 10:59:37','완료'),
(17,1100802,12,'다리 관절  이상','2024-05-09 16:59:37','2024-05-09 11:59:37','완료'),
(18,2020226,13,'토했어요','2024-05-09 16:59:37','2024-05-09 12:59:37','완료'),
(19,2020227,14,'발톱 자르러 왔어요','2024-05-09 16:59:37','2024-05-09 13:59:37','완료'),
(20,1100802,15,'중성화수술','2024-05-09 16:59:37','2024-05-09 14:59:37','완료'),
(21,1100802,12,'수술 후 경과','2024-05-11 16:59:37','2024-05-11 10:59:37','완료'),
(22,2020226,13,'계속 토해요(재진료)','2024-05-11 16:59:37','2024-05-11 11:59:37','완료'),
(23,1100802,15,'중성화 수술 후 재진료','2024-05-11 16:59:37','2024-05-11 12:59:37','완료'),
(24,1100802,11,'퇴원 후 경과 확인','2024-05-11 16:59:37','2024-05-11 13:59:37','완료'),
(25,2020227,14,'부리에 금갔어요','2024-05-11 16:59:37','2024-05-11 14:59:37','완료'),
(26,1100802,11,'시력  이상','2024-04-02 16:59:37','2024-04-02 15:59:37','완료'),
(27,1100802,12,'다리 관절  이상','2024-04-08 16:59:37','2024-04-08 12:59:37','완료'),
(28,2020226,13,'토했어요','2024-04-08 16:59:37','2024-04-08 16:59:37','완료'),
(29,2020227,14,'발톱 자르러 왔어요','2024-04-06 16:59:37','2024-04-06 16:59:37','완료'),
(30,1100802,15,'중성화수술','2024-04-05 16:59:37','2024-04-05 16:59:37','완료');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgery`
--

DROP TABLE IF EXISTS `surgery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surgery` (
  `surgery_no` int NOT NULL AUTO_INCREMENT,
  `regi_no` int NOT NULL,
  `surgery_kind` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `surgery_content` text COLLATE utf8mb4_bin NOT NULL,
  `surgery_date` datetime NOT NULL,
  PRIMARY KEY (`surgery_no`) USING BTREE,
  KEY `FK_surgery_surgery_kind` (`surgery_kind`),
  KEY `FK_surgery_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_surgery_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`),
  CONSTRAINT `FK_surgery_surgery_kind` FOREIGN KEY (`surgery_kind`) REFERENCES `surgery_kind` (`surgery_kind`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgery`
--

LOCK TABLES `surgery` WRITE;
/*!40000 ALTER TABLE `surgery` DISABLE KEYS */;
INSERT INTO `surgery` VALUES
(2,12,'외과','골절로 인한 수술 진행 ','2024-05-14 09:47:00'),
(3,15,'외과','종양 발견 발견으로 수술 진행','2024-05-14 12:47:00'),
(4,17,'외과','골절로 인한 수술 진행 ','2024-05-09 11:59:37'),
(5,20,'외과','중성화수술','2024-05-09 14:59:37'),
(6,22,'내과','소화기관 수술','2024-05-11 11:59:37'),
(7,25,'외과','부리 접합 수술','2024-05-11 14:59:37'),
(8,27,'외과','골절로 인한 수술 진행 ','2024-04-08 12:59:37'),
(9,30,'외과','중성화수술','2024-04-05 16:59:37');
/*!40000 ALTER TABLE `surgery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgery_kind`
--

DROP TABLE IF EXISTS `surgery_kind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surgery_kind` (
  `surgery_kind` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `surgery_cost` int NOT NULL,
  PRIMARY KEY (`surgery_kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgery_kind`
--

LOCK TABLES `surgery_kind` WRITE;
/*!40000 ALTER TABLE `surgery_kind` DISABLE KEYS */;
INSERT INTO `surgery_kind` VALUES
('내과',300000),
('안과',200000),
('외과',400000);
/*!40000 ALTER TABLE `surgery_kind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'atti'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-14 14:54:00
