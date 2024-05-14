-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.24-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- atti 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `atti` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `atti`;

-- 테이블 atti.clinic 구조 내보내기
CREATE TABLE IF NOT EXISTS `clinic` (
  `clinic_no` int(11) NOT NULL AUTO_INCREMENT,
  `regi_no` int(11) NOT NULL,
  `clinic_content` varchar(500) NOT NULL,
  `clinic_cost` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`clinic_no`),
  KEY `FK_clinic_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_clinic_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.clinic:~4 rows (대략적) 내보내기
INSERT INTO `clinic` (`clinic_no`, `regi_no`, `clinic_content`, `clinic_cost`, `create_date`, `update_date`) VALUES
	(1, 2, '배변기능 이상으로 정밀 검사 필요. X-ray 및 혈액 검사 진행 후 재검진', 5000, '2024-05-09 17:12:19', '2024-05-09 17:12:19'),
	(2, 3, '다리 관절  이상으로 정밀 검사 필요. X-ray 촬영 후 재검진 / 관절에 염증이 심해 수술 필요', 5000, '2024-05-09 17:14:59', '2024-05-09 17:22:08'),
	(3, 4, '노화로 인한 시력 감퇴', 5000, '2024-05-09 17:14:59', '2024-05-09 17:14:59'),
	(4, 5, '소화기능 이상으로 정밀 검사 필요. X-ray 및 혈액 검사 진행 후 재검진', 5000, '2024-05-09 17:14:59', '2024-05-09 17:14:59');

-- 테이블 atti.customer 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(20) NOT NULL,
  `customer_tel` varchar(50) NOT NULL,
  `customer_address` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`customer_no`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.customer:~20 rows (대략적) 내보내기
INSERT INTO `customer` (`customer_no`, `customer_name`, `customer_tel`, `customer_address`, `create_date`, `update_date`) VALUES
	(3, '김인수', '01011111111', '경기도', '2024-05-09 16:12:25', '2024-05-09 16:12:25'),
	(4, '김지훈', '01022222222', '강원도', '2024-05-09 16:13:29', '2024-05-09 16:13:29'),
	(5, '박혜아', '01033333333', '충청도', '2024-05-09 16:13:29', '2024-05-09 16:13:29'),
	(6, '한은혜', '01044444444', '전라도', '2024-05-09 16:13:29', '2024-05-09 16:13:29'),
	(7, '김일', '01011111112', '경기도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(8, '김이', '01022222223', '강원도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(9, '박삼', '01033333334', '충청도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(10, '한사', '01044444445', '전라도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(11, '김오', '01011111116', '경기도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(12, '김육', '01022222227', '강원도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(13, '박칠', '01033333338', '충청도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(14, '한팔', '01044444449', '전라도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(15, '김구', '01011111121', '경기도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(16, '김십', '01022222232', '강원도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(17, '박십일', '01033333323', '충청도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(18, '한십이', '01044444424', '전라도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(19, '김십삼', '01011111125', '경기도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(20, '김십사', '01022222226', '강원도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(21, '박십오', '01033333327', '충청도', '2024-05-14 10:08:08', '2024-05-14 10:08:08'),
	(22, '한십육', '01044444428', '전라도', '2024-05-14 10:08:08', '2024-05-14 10:08:08');

-- 테이블 atti.employee 구조 내보내기
CREATE TABLE IF NOT EXISTS `employee` (
  `emp_no` int(11) NOT NULL,
  `emp_major` varchar(50) NOT NULL,
  `emp_grade` enum('의사','간호사','관리자','퇴사자') NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_birth` date NOT NULL,
  `emp_gender` enum('M','F') NOT NULL,
  `emp_tel` varchar(50) NOT NULL,
  `hire_date` date NOT NULL,
  `emp_pw` varchar(50) NOT NULL,
  PRIMARY KEY (`emp_no`) USING BTREE,
  KEY `FK_empoyee_major` (`emp_major`),
  CONSTRAINT `FK_empoyee_major` FOREIGN KEY (`emp_major`) REFERENCES `major` (`emp_major`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.employee:~4 rows (대략적) 내보내기
INSERT INTO `employee` (`emp_no`, `emp_major`, `emp_grade`, `emp_name`, `emp_birth`, `emp_gender`, `emp_tel`, `hire_date`, `emp_pw`) VALUES
	(1100802, '포유류', '관리자', '박지유', '1987-04-23', 'M', '01055555555', '2010-08-02', '*00A51F3F48415C7D4E8908980D443C29C69B60C9'),
	(2020226, '파충류', '의사', '최애영', '1979-11-15', 'F', '01066666666', '2002-02-26', '*A4B6157319038724E3560894F7F932C8886EBFCF'),
	(3181112, '파충류', '간호사', '강수영', '1991-08-08', 'F', '01088888888', '2018-11-12', '*A4B6157319038724E3560894F7F932C8886EBFCF'),
	(3200513, '포유류', '간호사', '강국길', '1996-12-03', 'M', '01077777777', '2020-05-13', '*A4B6157319038724E3560894F7F932C8886EBFCF');

-- 테이블 atti.examination 구조 내보내기
CREATE TABLE IF NOT EXISTS `examination` (
  `examination_no` int(11) NOT NULL AUTO_INCREMENT,
  `regi_no` int(11) NOT NULL,
  `examination_kind` varchar(50) NOT NULL,
  `examination_content` text NOT NULL,
  `examination_date` datetime NOT NULL,
  PRIMARY KEY (`examination_no`),
  KEY `FK_examination_examination_kind` (`examination_kind`),
  KEY `FK_examination_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_examination_examination_kind` FOREIGN KEY (`examination_kind`) REFERENCES `examination_kind` (`examination_kind`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_examination_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.examination:~3 rows (대략적) 내보내기
INSERT INTO `examination` (`examination_no`, `regi_no`, `examination_kind`, `examination_content`, `examination_date`) VALUES
	(1, 2, 'x-ray', ' 소화기간 x-ray 촬영', '2024-05-10 09:48:06'),
	(2, 3, 'x-ray', '다리 관절 x-ray 촬영', '2024-05-10 09:48:06'),
	(3, 5, 'x-ray', '소화기간 x-ray 촬영', '2024-05-10 09:48:06');

-- 테이블 atti.examination_kind 구조 내보내기
CREATE TABLE IF NOT EXISTS `examination_kind` (
  `examination_kind` varchar(50) NOT NULL,
  `examination_cost` int(11) NOT NULL,
  PRIMARY KEY (`examination_kind`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.examination_kind:~3 rows (대략적) 내보내기
INSERT INTO `examination_kind` (`examination_kind`, `examination_cost`) VALUES
	('x-ray', 30000),
	('소변검사', 15000),
	('혈액검사', 80000);

-- 테이블 atti.examination_photo 구조 내보내기
CREATE TABLE IF NOT EXISTS `examination_photo` (
  `photo_no` int(11) NOT NULL AUTO_INCREMENT,
  `examination_no` int(11) NOT NULL,
  `registration_no` int(11) NOT NULL,
  `photo_name` text NOT NULL,
  PRIMARY KEY (`photo_no`),
  KEY `FK_examination_photo_examination` (`examination_no`),
  KEY `FK_examination_photo_registration` (`registration_no`),
  CONSTRAINT `FK_examination_photo_examination` FOREIGN KEY (`examination_no`) REFERENCES `examination` (`examination_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_examination_photo_registration` FOREIGN KEY (`registration_no`) REFERENCES `registration` (`regi_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.examination_photo:~0 rows (대략적) 내보내기

-- 테이블 atti.hospitalization 구조 내보내기
CREATE TABLE IF NOT EXISTS `hospitalization` (
  `hospitalization_no` int(11) NOT NULL AUTO_INCREMENT,
  `room_name` varchar(50) NOT NULL,
  `regi_no` int(11) NOT NULL,
  `hospitalization_content` text NOT NULL,
  `create_date` datetime NOT NULL,
  `discharge_date` datetime NOT NULL,
  PRIMARY KEY (`hospitalization_no`),
  KEY `FK_hospitalization_list_hospital_room` (`room_name`),
  KEY `FK_hospitalization_list_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_hospitalization_list_hospital_room` FOREIGN KEY (`room_name`) REFERENCES `hospital_room` (`room_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_hospitalization_list_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.hospitalization:~1 rows (대략적) 내보내기
INSERT INTO `hospitalization` (`hospitalization_no`, `room_name`, `regi_no`, `hospitalization_content`, `create_date`, `discharge_date`) VALUES
	(1, 'A01', 3, '관절 염증 수술 환자 입원중', '2024-05-10 10:11:16', '2024-05-13 10:11:16');

-- 테이블 atti.hospital_room 구조 내보내기
CREATE TABLE IF NOT EXISTS `hospital_room` (
  `room_name` varchar(50) NOT NULL,
  `state` enum('ON','OFF') NOT NULL DEFAULT 'OFF',
  `cost` int(11) NOT NULL,
  `update_date` varchar(50) NOT NULL,
  PRIMARY KEY (`room_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.hospital_room:~30 rows (대략적) 내보내기
INSERT INTO `hospital_room` (`room_name`, `state`, `cost`, `update_date`) VALUES
	('A01', 'ON', 75000, '2024-05-10 10:12:07'),
	('A02', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A03', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A04', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A05', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A06', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A07', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A08', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A09', 'OFF', 75000, '2024-05-10 09:59:44'),
	('A10', 'OFF', 75000, '2024-05-10 09:59:44'),
	('B01', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B02', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B03', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B04', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B05', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B06', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B07', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B08', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B09', 'OFF', 150000, '2024-05-10 09:59:44'),
	('B10', 'OFF', 150000, '2024-05-10 09:59:44'),
	('C01', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C02', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C03', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C04', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C05', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C06', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C07', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C08', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C09', 'OFF', 75000, '2024-05-10 09:59:44'),
	('C10', 'OFF', 75000, '2024-05-10 09:59:44');

-- 테이블 atti.major 구조 내보내기
CREATE TABLE IF NOT EXISTS `major` (
  `emp_major` varchar(50) NOT NULL,
  PRIMARY KEY (`emp_major`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.major:~3 rows (대략적) 내보내기
INSERT INTO `major` (`emp_major`) VALUES
	('조류'),
	('파충류'),
	('포유류');

-- 테이블 atti.medicine 구조 내보내기
CREATE TABLE IF NOT EXISTS `medicine` (
  `medicine_no` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(50) NOT NULL,
  `medicine_cost` int(11) NOT NULL,
  PRIMARY KEY (`medicine_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.medicine:~3 rows (대략적) 내보내기
INSERT INTO `medicine` (`medicine_no`, `medicine_name`, `medicine_cost`) VALUES
	(1, 'cefovecin', 40000),
	(2, 'oxytocin', 60000),
	(3, 'tricaines', 50000);

-- 테이블 atti.password_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `password_history` (
  `history_no` int(11) NOT NULL AUTO_INCREMENT,
  `emp_no` int(11) NOT NULL,
  `previous_pw` varchar(50) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`history_no`),
  KEY `FK_password_history_empoyee` (`emp_no`) USING BTREE,
  CONSTRAINT `FK_password_history_empoyee` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.password_history:~1 rows (대략적) 내보내기
INSERT INTO `password_history` (`history_no`, `emp_no`, `previous_pw`, `update_date`) VALUES
	(7, 1100802, '*A4B6157319038724E3560894F7F932C8886EBFCF', '2024-05-12 19:56:49');

-- 테이블 atti.payment 구조 내보내기
CREATE TABLE IF NOT EXISTS `payment` (
  `payment_no` int(11) NOT NULL AUTO_INCREMENT,
  `regi_no` int(11) NOT NULL,
  `payment_state` enum('미납','완납') NOT NULL DEFAULT '미납',
  `payment_category` enum('수술','처방','진료','검사','입원') NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`payment_no`),
  KEY `FK_payment_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_payment_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.payment:~10 rows (대략적) 내보내기
INSERT INTO `payment` (`payment_no`, `regi_no`, `payment_state`, `payment_category`, `create_date`) VALUES
	(1, 2, '미납', '진료', '2024-05-09 16:59:37'),
	(2, 3, '미납', '진료', '2024-05-09 16:59:37'),
	(3, 5, '미납', '진료', '2024-05-09 16:59:37'),
	(4, 3, '미납', '수술', '2024-05-09 17:29:35'),
	(5, 3, '미납', '처방', '2024-05-09 17:37:18'),
	(6, 3, '미납', '처방', '2024-05-09 17:38:08'),
	(7, 2, '미납', '검사', '2024-05-10 09:48:06'),
	(8, 3, '미납', '검사', '2024-05-10 09:48:06'),
	(9, 4, '미납', '검사', '2024-05-10 09:48:06'),
	(10, 3, '미납', '입원', '2024-05-10 10:11:16');

-- 테이블 atti.pet 구조 내보내기
CREATE TABLE IF NOT EXISTS `pet` (
  `pet_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` int(11) NOT NULL,
  `emp_major` varchar(50) NOT NULL,
  `pet_kind` varchar(50) NOT NULL,
  `pet_name` varchar(50) NOT NULL,
  `pet_birth` date NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`pet_no`),
  KEY `FK_pet_customer` (`customer_no`),
  CONSTRAINT `FK_pet_customer` FOREIGN KEY (`customer_no`) REFERENCES `customer` (`customer_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.pet:~20 rows (대략적) 내보내기
INSERT INTO `pet` (`pet_no`, `customer_no`, `emp_major`, `pet_kind`, `pet_name`, `pet_birth`, `create_date`, `update_date`) VALUES
	(1, 3, '파충류', '도마뱀', '왕눈이', '2024-05-08', '2024-05-09 16:26:55', '2024-05-09 16:26:55'),
	(2, 5, '포유류', '강아지', '까망이', '2023-02-01', '2024-05-09 16:29:27', '2024-05-09 16:29:27'),
	(3, 6, '포유류', '강아지', '달이', '2023-04-01', '2024-05-09 16:29:27', '2024-05-09 16:29:27'),
	(4, 4, '포유류', '원숭이', '개구쟁이', '2024-05-01', '2024-05-09 16:29:38', '2024-05-09 16:29:38'),
	(5, 7, '파충류', '도마뱀', '하나', '2024-05-08', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(6, 8, '포유류', '강아지', '두울', '2023-02-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(7, 9, '포유류', '강아지', '세엣', '2023-04-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(8, 10, '포유류', '원숭이', '네엣', '2024-05-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(9, 11, '파충류', '도마뱀', '다섯', '2024-05-08', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(10, 12, '포유류', '강아지', '여섯', '2023-02-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(11, 13, '포유류', '강아지', '일곱', '2023-04-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(12, 14, '포유류', '원숭이', '여덟', '2024-05-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(13, 15, '파충류', '도마뱀', '아홉', '2024-05-08', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(14, 16, '포유류', '강아지', '열열', '2023-02-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(15, 17, '포유류', '강아지', '열하나', '2023-04-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(16, 18, '포유류', '원숭이', '열두울', '2024-05-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(17, 19, '파충류', '도마뱀', '열세엣', '2024-05-08', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(18, 20, '포유류', '강아지', '열네엣', '2023-02-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(19, 21, '포유류', '강아지', '열다섯', '2023-04-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54'),
	(20, 22, '포유류', '원숭이', '열여섯', '2024-05-01', '2024-05-14 10:16:54', '2024-05-14 10:16:54');

-- 테이블 atti.prescription 구조 내보내기
CREATE TABLE IF NOT EXISTS `prescription` (
  `prescription_no` int(11) NOT NULL AUTO_INCREMENT,
  `regi_no` int(11) NOT NULL,
  `medicine_no` int(11) NOT NULL,
  `prescription_content` text NOT NULL,
  `prescription_date` datetime NOT NULL,
  PRIMARY KEY (`prescription_no`) USING BTREE,
  KEY `FK_prescription_medicine` (`medicine_no`),
  KEY `FK_prescription_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_prescription_medicine` FOREIGN KEY (`medicine_no`) REFERENCES `medicine` (`medicine_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_prescription_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.prescription:~2 rows (대략적) 내보내기
INSERT INTO `prescription` (`prescription_no`, `regi_no`, `medicine_no`, `prescription_content`, `prescription_date`) VALUES
	(1, 3, 2, '수술 후 관절 염증 제거제', '2024-05-09 17:37:18'),
	(2, 3, 3, '진통제', '2024-05-09 17:38:08');

-- 테이블 atti.registration 구조 내보내기
CREATE TABLE IF NOT EXISTS `registration` (
  `regi_no` int(11) NOT NULL AUTO_INCREMENT,
  `emp_no` int(11) NOT NULL,
  `pet_no` int(11) NOT NULL,
  `regi_content` text NOT NULL,
  `create_date` datetime NOT NULL,
  `regi_date` datetime NOT NULL,
  `regi_state` enum('예약','대기','취소','진행','완료') NOT NULL,
  PRIMARY KEY (`regi_no`) USING BTREE,
  KEY `FK__pet` (`pet_no`),
  KEY `FK_registration_empoyee` (`emp_no`),
  CONSTRAINT `FK__pet` FOREIGN KEY (`pet_no`) REFERENCES `pet` (`pet_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_registration_empoyee` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.registration:~20 rows (대략적) 내보내기
INSERT INTO `registration` (`regi_no`, `emp_no`, `pet_no`, `regi_content`, `create_date`, `regi_date`, `regi_state`) VALUES
	(2, 1100802, 1, '배변기능 이상', '2024-05-09 16:59:37', '2024-05-09 16:59:37', '대기'),
	(3, 2020226, 2, '다리 관절  이상', '2024-05-09 16:59:37', '2024-05-09 16:59:37', '대기'),
	(4, 3200513, 3, '시력  이상', '2024-05-09 16:59:37', '2024-06-24 00:00:00', '예약'),
	(5, 3181112, 4, '소화 기능  이상', '2024-05-09 16:59:37', '2024-05-09 16:59:37', '대기'),
	(6, 1100802, 5, '배변기능 이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '대기'),
	(7, 2020226, 6, '다리 관절  이상', '2024-05-14 10:47:00', '2024-06-25 10:10:10', '예약'),
	(8, 3200513, 7, '시력  이상', '2024-05-14 10:47:00', '2024-06-20 11:11:11', '예약'),
	(9, 3181112, 8, '소화 기능  이상', '2024-05-14 10:47:00', '2024-06-26 09:00:00', '예약'),
	(10, 1100802, 9, '배변기능 이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '진행'),
	(11, 2020226, 10, '다리 관절  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '진행'),
	(12, 3200513, 11, '시력  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '진행'),
	(13, 3181112, 12, '소화 기능  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '진행'),
	(14, 1100802, 13, '배변기능 이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '진행'),
	(15, 2020226, 14, '다리 관절  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '완료'),
	(16, 3200513, 15, '시력  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '완료'),
	(17, 3181112, 16, '소화 기능  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '완료'),
	(18, 1100802, 17, '배변기능 이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '완료'),
	(19, 2020226, 18, '다리 관절  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '완료'),
	(20, 3200513, 19, '시력  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '완료'),
	(21, 3181112, 20, '소화 기능  이상', '2024-05-14 10:47:00', '2024-05-14 10:47:00', '완료');

-- 테이블 atti.surgery 구조 내보내기
CREATE TABLE IF NOT EXISTS `surgery` (
  `surgery_no` int(11) NOT NULL AUTO_INCREMENT,
  `regi_no` int(11) NOT NULL,
  `surgery_kind` varchar(50) NOT NULL,
  `surgery_content` text NOT NULL,
  `surgery_date` datetime NOT NULL,
  PRIMARY KEY (`surgery_no`) USING BTREE,
  KEY `FK_surgery_surgery_kind` (`surgery_kind`),
  KEY `FK_surgery_registration` (`regi_no`) USING BTREE,
  CONSTRAINT `FK_surgery_registration` FOREIGN KEY (`regi_no`) REFERENCES `registration` (`regi_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_surgery_surgery_kind` FOREIGN KEY (`surgery_kind`) REFERENCES `surgery_kind` (`surgery_kind`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.surgery:~0 rows (대략적) 내보내기
INSERT INTO `surgery` (`surgery_no`, `regi_no`, `surgery_kind`, `surgery_content`, `surgery_date`) VALUES
	(1, 3, '내과', '관절 염증 수술 진행 후 염증 제거 완료', '2024-05-09 17:29:35');

-- 테이블 atti.surgery_kind 구조 내보내기
CREATE TABLE IF NOT EXISTS `surgery_kind` (
  `surgery_kind` varchar(50) NOT NULL,
  `surgery_cost` int(11) NOT NULL,
  PRIMARY KEY (`surgery_kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 테이블 데이터 atti.surgery_kind:~3 rows (대략적) 내보내기
INSERT INTO `surgery_kind` (`surgery_kind`, `surgery_cost`) VALUES
	('내과', 300000),
	('안과', 200000),
	('외과', 400000);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
