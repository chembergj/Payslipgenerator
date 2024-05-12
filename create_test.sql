-- --------------------------------------------------------
-- Vært:                         127.0.0.1
-- Server-version:               11.2.2-MariaDB - mariadb.org binary distribution
-- ServerOS:                     Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for tabel studio_test.earningperiods
DROP TABLE IF EXISTS `earningperiods`;
CREATE TABLE IF NOT EXISTS `earningperiods` (
  `Id` uuid NOT NULL,
  `FromDate` date NOT NULL,
  `ToDate` date NOT NULL,
  `TRM` float NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.earningperiods: ~2 rows (tilnærmelsesvis)
INSERT INTO `earningperiods` (`Id`, `FromDate`, `ToDate`, `TRM`) VALUES
	('dac91a67-0c3b-43fd-8b0c-5e689a56133a', '2024-03-11', '2024-03-18', 3780),
	('2dc79111-a093-493f-bd23-ab8a1003a95e', '2024-03-01', '2024-03-10', 3780);

-- Dumping structure for tabel studio_test.modelaccounts
DROP TABLE IF EXISTS `modelaccounts`;
CREATE TABLE IF NOT EXISTS `modelaccounts` (
  `Id` uuid NOT NULL,
  `Username` varchar(300) NOT NULL DEFAULT '',
  `Website` varchar(50) NOT NULL DEFAULT '',
  `ModelsId` uuid NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelaccount_models` (`ModelsId`),
  CONSTRAINT `FK_modelaccount_models` FOREIGN KEY (`ModelsId`) REFERENCES `models` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.modelaccounts: ~3 rows (tilnærmelsesvis)
INSERT INTO `modelaccounts` (`Id`, `Username`, `Website`, `ModelsId`) VALUES
	('f1de3a58-9230-47f4-adcb-0a79474c85f0', 'miss_trial', 'Chaturbate', 'e9fd1f24-d976-454e-b1ea-84683cc384f5'),
	('ea284bc1-1834-4302-98c5-719b3a18eca4', 'lana_doll', 'Chaturbate', '324d8dda-b380-422c-9d05-09677718d0c6'),
	('be785262-d526-41c9-8ae0-bea4370e8217', 'miss_trial', 'Stripchat', 'e9fd1f24-d976-454e-b1ea-84683cc384f5');

-- Dumping structure for tabel studio_test.modelearningperiods
DROP TABLE IF EXISTS `modelearningperiods`;
CREATE TABLE IF NOT EXISTS `modelearningperiods` (
  `Id` uuid NOT NULL,
  `earningperiodId` uuid NOT NULL,
  `Percentage` float NOT NULL DEFAULT 0,
  `modelId` uuid NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelearning_earningperiods` (`earningperiodId`),
  KEY `FK_modelearning_modelaccounts` (`modelId`) USING BTREE,
  CONSTRAINT `FK_modelearning_earningperiods` FOREIGN KEY (`earningperiodId`) REFERENCES `earningperiods` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_modelearningperiods_models` FOREIGN KEY (`modelId`) REFERENCES `models` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.modelearningperiods: ~3 rows (tilnærmelsesvis)
INSERT INTO `modelearningperiods` (`Id`, `earningperiodId`, `Percentage`, `modelId`) VALUES
	('d9eeca3f-81d6-49d3-98cd-25d026cca33b', '2dc79111-a093-493f-bd23-ab8a1003a95e', 65, 'e9fd1f24-d976-454e-b1ea-84683cc384f5'),
	('ac0225e3-f56b-498a-90e9-d75b7b90dbb2', '2dc79111-a093-493f-bd23-ab8a1003a95e', 80, '324d8dda-b380-422c-9d05-09677718d0c6'),
	('ff3c1e65-1463-4be4-baeb-eeffee2accb5', 'dac91a67-0c3b-43fd-8b0c-5e689a56133a', 65, 'e9fd1f24-d976-454e-b1ea-84683cc384f5');

-- Dumping structure for tabel studio_test.modelearnings
DROP TABLE IF EXISTS `modelearnings`;
CREATE TABLE IF NOT EXISTS `modelearnings` (
  `Id` uuid NOT NULL,
  `modelearningperiodsId` uuid NOT NULL,
  `modelaccountsId` uuid NOT NULL,
  `date` date NOT NULL,
  `noOfUnits` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelearnings_modelearningperiods` (`modelearningperiodsId`),
  KEY `FK_modelearnings_modelaccounts` (`modelaccountsId`),
  CONSTRAINT `FK_modelearnings_modelaccounts` FOREIGN KEY (`modelaccountsId`) REFERENCES `modelaccounts` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_modelearnings_modelearningperiods` FOREIGN KEY (`modelearningperiodsId`) REFERENCES `modelearningperiods` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.modelearnings: ~6 rows (tilnærmelsesvis)
INSERT INTO `modelearnings` (`Id`, `modelearningperiodsId`, `modelaccountsId`, `date`, `noOfUnits`) VALUES
	('bbc57fc6-64d0-4b54-8d76-6f94586fdbff', 'ff3c1e65-1463-4be4-baeb-eeffee2accb5', 'f1de3a58-9230-47f4-adcb-0a79474c85f0', '2024-03-11', 461),
	('9239d1b2-1408-4796-9090-9d2ce0842632', 'ff3c1e65-1463-4be4-baeb-eeffee2accb5', 'be785262-d526-41c9-8ae0-bea4370e8217', '2024-03-11', 10),
	('66784a34-047a-4755-8a71-ac8accea652b', 'ff3c1e65-1463-4be4-baeb-eeffee2accb5', 'f1de3a58-9230-47f4-adcb-0a79474c85f0', '2024-03-12', 45),
	('54245614-7acf-4490-8b3f-b38b8e1246bc', 'ac0225e3-f56b-498a-90e9-d75b7b90dbb2', 'ea284bc1-1834-4302-98c5-719b3a18eca4', '2024-03-08', 162),
	('45ef4628-033f-4e61-b75d-d4df9dffebd7', 'd9eeca3f-81d6-49d3-98cd-25d026cca33b', 'f1de3a58-9230-47f4-adcb-0a79474c85f0', '2024-03-08', 19),
	('826f021a-ea20-453f-b35b-d8f703206ff5', 'd9eeca3f-81d6-49d3-98cd-25d026cca33b', 'f1de3a58-9230-47f4-adcb-0a79474c85f0', '2024-03-07', 25);

-- Dumping structure for tabel studio_test.models
DROP TABLE IF EXISTS `models`;
CREATE TABLE IF NOT EXISTS `models` (
  `Id` uuid NOT NULL,
  `Name` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.models: ~2 rows (tilnærmelsesvis)
INSERT INTO `models` (`Id`, `Name`) VALUES
	('324d8dda-b380-422c-9d05-09677718d0c6', 'Mariana Baquero'),
	('e9fd1f24-d976-454e-b1ea-84683cc384f5', 'Angie Natalia Perez Leon');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
