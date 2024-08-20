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


-- Dumping database structure for studio
CREATE DATABASE IF NOT EXISTS `studio` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `studio`;

-- Dumping structure for tabel studio.earningperiods
CREATE TABLE IF NOT EXISTS `earningperiods` (
  `Id` uuid NOT NULL,
  `FromDate` date NOT NULL,
  `ToDate` date NOT NULL,
  `TRM` float NOT NULL,
  `TRMDate` date NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio.earningperiods: ~15 rows (tilnærmelsesvis)
DELETE FROM `earningperiods`;
INSERT INTO `earningperiods` (`Id`, `FromDate`, `ToDate`, `TRM`, `TRMDate`) VALUES
	('107185f1-d35c-4686-8d5f-0bda5a30e69d', '2024-06-17', '2024-06-23', 3933, '2024-06-27'),
	('ee326114-8060-4b41-8679-2021745b4f78', '2024-05-13', '2024-05-19', 3486, '2024-05-21'),
	('5062d5f5-e1c0-4671-9fa6-284329acb237', '2024-04-22', '2024-04-28', 3475, '2024-04-28'),
	('f6479a82-bc77-49ac-886d-2f60944cbb10', '2024-08-05', '2024-08-11', 3724, '2024-08-13'),
	('957113a3-ab45-46ba-bc6b-38e1ce294c61', '2024-05-20', '2024-05-26', 3539, '2024-05-27'),
	('99ec6cd1-6f54-4027-b855-4cf38b999ab1', '2024-06-10', '2024-06-16', 3812, '2024-06-17'),
	('464f057d-af15-4b2c-9f8f-515927dca330', '2024-07-08', '2024-07-14', 3605, '2024-07-15'),
	('b501a3a0-d454-4fbb-a19d-53cc44f851db', '2024-06-24', '2024-06-30', 3809, '2024-07-01'),
	('180ab816-9a06-4cf0-8ee5-62009220c4b0', '2024-08-12', '2024-08-18', 3682, '2024-08-20'),
	('1f9e548d-3ec3-41d5-9977-76d2cb6305d4', '2024-05-27', '2024-06-02', 3521, '2024-06-03'),
	('1d49be9d-0e72-45e3-8eaf-7f67ea15d795', '2024-04-08', '2024-04-14', 3525, '2024-04-15'),
	('5307cfa6-5d84-4a34-9d13-8451d1a030d2', '2024-07-29', '2024-08-04', 3845, '2024-08-06'),
	('479ace4d-2c0d-42ab-931f-a102b9223639', '2024-05-06', '2024-05-12', 3749, '2024-05-14'),
	('8b8b5c89-f87e-4dea-88d1-c48fbaf5e1dd', '2024-07-22', '2024-07-28', 3675, '2024-07-29'),
	('468d0a6a-0f2b-4e84-8a28-e453d84341e0', '2024-07-15', '2024-07-21', 3701, '2024-07-22'),
	('24fe00d4-c669-407f-bf0b-ec402a9680f2', '2024-04-15', '2024-04-21', 3475, '2024-04-22'),
	('51196c72-c7b9-470a-90e3-f2db77e770d2', '2024-06-03', '2024-06-09', 3744, '2024-06-11'),
	('53533a12-b43e-4140-b419-f617b97089d4', '2024-07-01', '2024-07-07', 3754, '2024-07-08');

-- Dumping structure for tabel studio.modelaccounts
CREATE TABLE IF NOT EXISTS `modelaccounts` (
  `Id` uuid NOT NULL,
  `Username` varchar(300) NOT NULL DEFAULT '',
  `Website` varchar(50) NOT NULL DEFAULT '',
  `ModelsId` uuid NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelaccount_models` (`ModelsId`),
  CONSTRAINT `FK_modelaccount_models` FOREIGN KEY (`ModelsId`) REFERENCES `models` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio.modelaccounts: ~28 rows (tilnærmelsesvis)
DELETE FROM `modelaccounts`;
INSERT INTO `modelaccounts` (`Id`, `Username`, `Website`, `ModelsId`) VALUES
	('c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 'johans_stiv', 'CB', '5d169101-96cc-44ea-8eed-88ea847900e7'),
	('43a36f95-a918-4015-b3a2-0b270e09c6f6', 'madam_grace', 'C4', '53ca84ed-9d5a-4d75-a47f-57b4d3cd3682'),
	('169b396c-f1c6-4128-b579-19404e5aee01', 'missbeloved', 'CS', '2acd9deb-9f41-47f5-87b9-02fe8d261ecc'),
	('b78900dc-7c53-4b00-b87c-1c9e55c43a55', 'santi_fabulous', 'CB', '20023412-5689-467c-bfd4-245b63970215'),
	('3d2fbc27-6af9-4271-b761-211a30801e73', 'miss_beloved', 'CB', '2acd9deb-9f41-47f5-87b9-02fe8d261ecc'),
	('4269ab2b-0297-4d45-8bc9-23d389f57708', 'ares_johnsonn', 'CB', '13da5ea4-74c6-49b1-bca9-a528bc5d69f7'),
	('762fa940-fce9-4f0b-8b3e-348de5e15e73', 'santi_fabulous', 'OF', '20023412-5689-467c-bfd4-245b63970215'),
	('207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 'Dani_Brown_08', 'SC', 'c36aab53-bc0a-4872-a445-a0f269f21a0d'),
	('d205d61a-1c70-48a6-95e7-58a887380315', 'gretta_n_dannie@hotmail.com', 'LJ', 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a'),
	('9d9eba98-4941-4081-985c-67d236d917c7', 'Goddess_Angel_', 'SC', '2a128185-ce47-42f7-a4cb-dc7f34dc9192'),
	('aab3877d-1af4-45e1-aed8-6a744d9cc6df', 'ares_johnson', 'SC', '13da5ea4-74c6-49b1-bca9-a528bc5d69f7'),
	('f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 'Danii_Brown_', 'CB', 'c36aab53-bc0a-4872-a445-a0f269f21a0d'),
	('917851c1-61a1-47f0-86c2-716d43fac8b1', 'dakapsy_420', 'CB', '8673d76c-9e9a-408c-847c-6af03c1b075c'),
	('7958f135-22b1-4816-b724-7900307e2373', 'gretta_n_dannie', 'CB', 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a'),
	('a6dd490b-7fbf-4dd5-9e01-7f6bf5fbec03', 'miss_rouese', 'CB', 'fa5be2dc-f5c8-408a-93ec-d7a0318b99cd'),
	('da22ca04-cd6e-4f78-b754-a94698ef4bba', 'justin_morrisss', 'CB', '87db29cd-1822-4317-8cf5-775ac3d28b9c'),
	('b7555714-28d6-4cd7-9136-b29f0dca1554', 'madam_grace_', 'C4', '53ca84ed-9d5a-4d75-a47f-57b4d3cd3682'),
	('fa92ee06-d548-4a63-aa74-b8d421393d23', 'yourmoderador', 'CB', '2a128185-ce47-42f7-a4cb-dc7f34dc9192'),
	('f0d11e31-cbdb-4121-9130-c067b0563475', 'dakapsy', 'SC', '8673d76c-9e9a-408c-847c-6af03c1b075c'),
	('d336919f-534a-4e07-aa05-c9377b71f5c9', 'kalivanvoinescu', 'C4', '0ffdf296-2191-461c-950f-03025604b43a'),
	('8b35ba94-1cbe-42ea-87c3-ca82dd03817b', 'miaa_scott', 'SC', '3a1a9f59-006e-47a5-9178-af73e6f787c7'),
	('d6295885-3006-4017-b1a6-cff23c4156cf', 'santi_fabulous', 'SC', '20023412-5689-467c-bfd4-245b63970215'),
	('bde158e6-6c2f-492a-ab14-d4f0332025bb', 'MxBTKs209@studiobantokens.co', 'LJ', '2a128185-ce47-42f7-a4cb-dc7f34dc9192'),
	('eb4f9dca-1446-49a7-91d5-dda7c15ba502', 'gretta_n_dannie', 'SC', 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a'),
	('b495c526-e886-4a33-ba84-e5a2f160e254', 'johans_stiv', 'SC', '5d169101-96cc-44ea-8eed-88ea847900e7'),
	('15846b1f-4889-4257-b8fc-e6939d110456', 'miaa_scott_', 'CB', '3a1a9f59-006e-47a5-9178-af73e6f787c7'),
	('762a0e9e-b005-4cfb-8c9a-f8664055f03b', 'kalivan_voinescu', 'CB', '0ffdf296-2191-461c-950f-03025604b43a'),
	('4f962a53-9850-42a9-9a2b-fa8cffbaef38', 'kalivan_voinescu', 'SC', '0ffdf296-2191-461c-950f-03025604b43a');

-- Dumping structure for tabel studio.modelearningperiods
CREATE TABLE IF NOT EXISTS `modelearningperiods` (
  `Id` uuid NOT NULL,
  `earningperiodId` uuid NOT NULL,
  `Percentage` float NOT NULL DEFAULT 0,
  `modelId` uuid NOT NULL,
  `SpecialTRM` float DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelearning_earningperiods` (`earningperiodId`),
  KEY `FK_modelearning_modelaccounts` (`modelId`) USING BTREE,
  CONSTRAINT `FK_modelearning_earningperiods` FOREIGN KEY (`earningperiodId`) REFERENCES `earningperiods` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_modelearningperiods_models` FOREIGN KEY (`modelId`) REFERENCES `models` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio.modelearningperiods: ~117 rows (tilnærmelsesvis)
DELETE FROM `modelearningperiods`;
INSERT INTO `modelearningperiods` (`Id`, `earningperiodId`, `Percentage`, `modelId`, `SpecialTRM`) VALUES
	('fb9ad430-0118-4fbc-91ee-00c05edd33db', '180ab816-9a06-4cf0-8ee5-62009220c4b0', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('b85536e9-1632-41bd-ac01-02c1b07a1313', '468d0a6a-0f2b-4e84-8a28-e453d84341e0', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('7db76e35-4bf1-4867-9842-0442f69d4684', '180ab816-9a06-4cf0-8ee5-62009220c4b0', 55, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('cbf48349-73d2-43a6-9543-09c3bd8b0d97', '5307cfa6-5d84-4a34-9d13-8451d1a030d2', 55, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('017216fc-3228-4ec8-9c98-0d6fb47f4717', '8b8b5c89-f87e-4dea-88d1-c48fbaf5e1dd', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('bce1a145-bf97-43e0-be5c-14e83b4ce3e2', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('407c5447-a6c1-4f39-954d-155c2e0a82af', '53533a12-b43e-4140-b419-f617b97089d4', 65, '87db29cd-1822-4317-8cf5-775ac3d28b9c', NULL),
	('f0b74d07-8935-4fe8-a12a-1915e153376a', 'f6479a82-bc77-49ac-886d-2f60944cbb10', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('a73e1336-53b9-4487-bffe-19d2a2a2cc6d', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('ccc5164a-5a70-404a-a26c-1d8ec2d2e6c2', '464f057d-af15-4b2c-9f8f-515927dca330', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('0ebe72f7-41ef-48ab-9ce7-24e023c2253d', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 55, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('f0a589e8-0b4c-48de-81f8-26582e747a38', '5062d5f5-e1c0-4671-9fa6-284329acb237', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('a94190be-f058-4b77-af0b-27c98be819ec', '8b8b5c89-f87e-4dea-88d1-c48fbaf5e1dd', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('6427c1c6-2e28-49b3-9f30-290165022ba1', '479ace4d-2c0d-42ab-931f-a102b9223639', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('849a1091-ff57-434e-b72b-2ae2330d0cc5', 'ee326114-8060-4b41-8679-2021745b4f78', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('482085f3-dc67-4e67-a677-2d36c355b136', '5307cfa6-5d84-4a34-9d13-8451d1a030d2', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('cf089975-5629-4359-9e83-2e9548125b1d', 'f6479a82-bc77-49ac-886d-2f60944cbb10', 55, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('ff87c0d1-2141-4b0f-aba1-2fcce8360ffd', '5062d5f5-e1c0-4671-9fa6-284329acb237', 65, '3a1a9f59-006e-47a5-9178-af73e6f787c7', NULL),
	('ad182af3-76d0-45f1-9fb3-335e3c190e32', '5307cfa6-5d84-4a34-9d13-8451d1a030d2', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('9b4b8e85-52e9-49ff-8d1b-355a66eed66b', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('1f55611d-5c3c-4b66-b321-362a41b4da97', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('98e3cd77-9555-401e-9c52-36ae922586cf', '464f057d-af15-4b2c-9f8f-515927dca330', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('81083afa-e15b-4af3-842c-3737d773dac3', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 55, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('d85c2d4d-a4bc-4ab1-8f07-391a8dec23ae', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('76d2fa03-7ec7-4e82-ac6b-395107f4e27a', '5307cfa6-5d84-4a34-9d13-8451d1a030d2', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('c8a65981-7b2a-4a04-bb61-3a0a44a46475', '53533a12-b43e-4140-b419-f617b97089d4', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('22b68639-6320-4e38-8de2-3a43440fd682', 'f6479a82-bc77-49ac-886d-2f60944cbb10', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('f2bceb71-cd8a-45c0-9ce6-3a46a12ceceb', '5307cfa6-5d84-4a34-9d13-8451d1a030d2', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('126c0463-2e70-4737-855b-3dfadbd2874f', '468d0a6a-0f2b-4e84-8a28-e453d84341e0', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('385f515c-3bf1-449c-8c39-410fd90c9096', '5062d5f5-e1c0-4671-9fa6-284329acb237', 65, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('c60ade8f-c98a-44c5-934e-4262e3c03002', '51196c72-c7b9-470a-90e3-f2db77e770d2', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('c062ccdf-bb7a-4643-8b64-481bc99ae094', '53533a12-b43e-4140-b419-f617b97089d4', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('5a6a8822-49b8-413f-8276-493e49a8f2b4', '464f057d-af15-4b2c-9f8f-515927dca330', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('8ed71007-a27e-4102-861e-4aeac725b4e9', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 65, '87db29cd-1822-4317-8cf5-775ac3d28b9c', NULL),
	('e9ff102c-7bbe-4725-bc82-4b6790a5442a', '51196c72-c7b9-470a-90e3-f2db77e770d2', 57.5, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('4450ef31-d739-447e-beb3-4d13ff74a680', '5062d5f5-e1c0-4671-9fa6-284329acb237', 65, 'fa5be2dc-f5c8-408a-93ec-d7a0318b99cd', NULL),
	('7c9e01ba-11f1-4171-adf5-4e640e9cd4b4', '53533a12-b43e-4140-b419-f617b97089d4', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('bd52bb6d-1489-4d2e-b346-52a40c678dd7', '479ace4d-2c0d-42ab-931f-a102b9223639', 65, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('bc3a3892-8629-476e-b333-54723a30e7d5', '180ab816-9a06-4cf0-8ee5-62009220c4b0', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('98fc3073-0521-4b9d-9b29-5616de0f6f37', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 55, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL),
	('b943bffe-f1c3-42f5-9f87-57c9c526e232', '468d0a6a-0f2b-4e84-8a28-e453d84341e0', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('150f9151-1f92-411f-931e-58b9d5651f89', '51196c72-c7b9-470a-90e3-f2db77e770d2', 57.5, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL),
	('1217b415-a359-480d-90d7-59f22ff0fa99', '464f057d-af15-4b2c-9f8f-515927dca330', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('2188fa3a-b0ba-4643-9cd9-5d5dc76ae837', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 55, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL),
	('61f8b380-59ae-49bf-9368-5eb64a14f23c', '8b8b5c89-f87e-4dea-88d1-c48fbaf5e1dd', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('68c6d686-85f9-4c3a-ab00-63115436e288', 'f6479a82-bc77-49ac-886d-2f60944cbb10', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('032f362c-8b30-4e13-994f-6339e9273ae3', '479ace4d-2c0d-42ab-931f-a102b9223639', 65, 'fa5be2dc-f5c8-408a-93ec-d7a0318b99cd', NULL),
	('c06c0360-ae0b-4df4-8948-68f485f31d16', '468d0a6a-0f2b-4e84-8a28-e453d84341e0', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('ffdfcea1-5e2d-407c-b625-6a1a333625bd', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('8f696e03-4fe9-48f9-9902-6bd00f3590fe', '51196c72-c7b9-470a-90e3-f2db77e770d2', 67.5, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('5e39eea3-81d8-4150-b68b-6c47db476063', '51196c72-c7b9-470a-90e3-f2db77e770d2', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('bf5f9532-972f-44eb-8764-6c4e644366ef', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 65, '87db29cd-1822-4317-8cf5-775ac3d28b9c', NULL),
	('064275a3-16de-49f5-a84e-7413c8496074', '5062d5f5-e1c0-4671-9fa6-284329acb237', 65, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('d5a0e67c-fd9c-4c1c-ae9c-7c545ee5c631', '51196c72-c7b9-470a-90e3-f2db77e770d2', 57.5, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('6bad8221-924a-4773-b373-87ec2a353850', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('a921df62-7eb4-44ec-831a-897b1c9bf996', '479ace4d-2c0d-42ab-931f-a102b9223639', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('3f3f20c6-f3e2-4a7d-b12f-8ceeace31092', '53533a12-b43e-4140-b419-f617b97089d4', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('66537bc5-4fca-4c5e-81e9-8db3db57cf93', '479ace4d-2c0d-42ab-931f-a102b9223639', 65, '3a1a9f59-006e-47a5-9178-af73e6f787c7', NULL),
	('8e971008-609a-490b-b54b-9765d545e89b', '180ab816-9a06-4cf0-8ee5-62009220c4b0', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('7c16ced9-c504-41ff-a8d5-976d573129ff', '479ace4d-2c0d-42ab-931f-a102b9223639', 55, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('aaf40ed6-1fe6-4053-9b86-9dfc3bec23a9', '51196c72-c7b9-470a-90e3-f2db77e770d2', 57.5, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('69440f3b-7eae-4e05-b86b-9f911cba19c8', '8b8b5c89-f87e-4dea-88d1-c48fbaf5e1dd', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('a9186c7c-e125-4d25-8918-9fed2f0134ad', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('d804e4c8-fe7b-48b5-a4af-a462ff008ec7', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('6763f4f6-a7e0-4f14-a304-a64b7003069d', '180ab816-9a06-4cf0-8ee5-62009220c4b0', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('d680800b-2cc7-4109-8255-a8416e4d6323', '5062d5f5-e1c0-4671-9fa6-284329acb237', 55, '53ca84ed-9d5a-4d75-a47f-57b4d3cd3682', NULL),
	('2438c763-0f01-4769-b2b8-ab2e8ffa0911', '464f057d-af15-4b2c-9f8f-515927dca330', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('0306b96a-7b5a-4cc4-b707-ae4a4fda4ad4', '464f057d-af15-4b2c-9f8f-515927dca330', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('3ae3c131-dca9-457a-a163-ae66fee68494', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('40661122-2a4c-4796-82ca-b2c92806083b', '468d0a6a-0f2b-4e84-8a28-e453d84341e0', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('b08f32f0-919c-457f-ba4e-b774ac5773a9', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('1e6b155a-5a35-4191-83bd-baef2237ba2c', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 55, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL),
	('6e201446-c729-42c6-89c8-bf9fee5c831e', 'f6479a82-bc77-49ac-886d-2f60944cbb10', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('c1143633-33e4-44d1-98c8-c0a4fe1a863d', '5062d5f5-e1c0-4671-9fa6-284329acb237', 55, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('5d42c860-a8f4-4626-953a-c0f97de0ad7f', '53533a12-b43e-4140-b419-f617b97089d4', 55, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL),
	('fd877af1-30cb-4604-82aa-c27f7047b98d', '479ace4d-2c0d-42ab-931f-a102b9223639', 65, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('fdd8d6fd-46c4-48ed-8088-c7d2c66b71a0', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('37ed0d9c-c0ec-4cf5-8fb6-cd26132ac8da', '8b8b5c89-f87e-4dea-88d1-c48fbaf5e1dd', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('0cbae480-339c-443a-8fd2-d02236615291', '468d0a6a-0f2b-4e84-8a28-e453d84341e0', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('e177fc5a-a446-4390-8261-d419628333ca', '464f057d-af15-4b2c-9f8f-515927dca330', 55, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL),
	('01a7bb9c-c976-4065-b43d-d64b58175f18', '5062d5f5-e1c0-4671-9fa6-284329acb237', 65, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('31e9d281-39f1-40cb-8a4c-dd819fd60875', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('a21d397a-40db-46bb-9a43-ddc9a5889057', '8b8b5c89-f87e-4dea-88d1-c48fbaf5e1dd', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('d79f4db0-75b7-498b-9a9c-e041eeafa55e', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('b66d8980-f36d-4c90-9640-e0e40c355f87', '99ec6cd1-6f54-4027-b855-4cf38b999ab1', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('b8b6948a-f41e-432d-8ab2-e5140c72271c', '5062d5f5-e1c0-4671-9fa6-284329acb237', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('33e7d345-9fb7-45b2-b82e-e684b650dd71', '53533a12-b43e-4140-b419-f617b97089d4', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('bb3e7339-c84a-472a-be11-e742090afd18', '180ab816-9a06-4cf0-8ee5-62009220c4b0', 100, '20023412-5689-467c-bfd4-245b63970215', 3882),
	('b3ac4b20-a2c5-4763-a307-e82592caedec', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('1e3ad71f-f700-4ae7-83a4-f481fcf07f9c', '5307cfa6-5d84-4a34-9d13-8451d1a030d2', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('0f36a580-9e52-4cc2-8677-f4f668245e69', '53533a12-b43e-4140-b419-f617b97089d4', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('974d5cea-52c4-40c8-b3fa-f65048472cd3', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('e21c0334-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('e21c04f2-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 65, '3a1a9f59-006e-47a5-9178-af73e6f787c7', NULL),
	('e21c0509-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 55, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('e21c051c-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 65, 'fa5be2dc-f5c8-408a-93ec-d7a0318b99cd', NULL),
	('e21c052d-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('e21c053e-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 55, '53ca84ed-9d5a-4d75-a47f-57b4d3cd3682', NULL),
	('e21c054f-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 55, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('e21c0560-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 65, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('e21c0573-17aa-11ef-a189-f889d2572590', 'ee326114-8060-4b41-8679-2021745b4f78', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('d7e0e764-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('d7e0e7d5-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('d7e0e7e5-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 65, '3a1a9f59-006e-47a5-9178-af73e6f787c7', NULL),
	('d7e0e7f3-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 65, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('d7e0e800-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 65, 'fa5be2dc-f5c8-408a-93ec-d7a0318b99cd', NULL),
	('d7e0e810-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 55, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('d7e0e81e-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 55, '53ca84ed-9d5a-4d75-a47f-57b4d3cd3682', NULL),
	('d7e0e82b-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 55, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('d7e0e839-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('d7e0e847-1d2d-11ef-a189-f889d2572590', '957113a3-ab45-46ba-bc6b-38e1ce294c61', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('d7cd72bc-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 55, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL),
	('d7cd73ce-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 65, '2a128185-ce47-42f7-a4cb-dc7f34dc9192', NULL),
	('d7cd73fd-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('d7cd7447-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 60, 'c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', NULL),
	('d7cd7494-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 60, '5d169101-96cc-44ea-8eed-88ea847900e7', NULL),
	('d7cd74e4-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 55, '0ffdf296-2191-461c-950f-03025604b43a', NULL),
	('d7cd750b-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('d7cd7533-22a9-11ef-a189-f889d2572590', '1f9e548d-3ec3-41d5-9977-76d2cb6305d4', 80, '13da5ea4-74c6-49b1-bca9-a528bc5d69f7', NULL),
	('7edc8d95-93c7-44cd-99a8-f9dd3a477188', '51196c72-c7b9-470a-90e3-f2db77e770d2', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('fd56dbc9-e3ee-4c11-bc37-fb1fbee96239', 'f6479a82-bc77-49ac-886d-2f60944cbb10', 80, '8673d76c-9e9a-408c-847c-6af03c1b075c', NULL),
	('2af34564-2b67-4ba5-a4b3-fb92d48c6797', 'b501a3a0-d454-4fbb-a19d-53cc44f851db', 100, '20023412-5689-467c-bfd4-245b63970215', NULL),
	('ee6f3f2c-8efb-4900-b08e-fe393c656433', '107185f1-d35c-4686-8d5f-0bda5a30e69d', 55, 'c36aab53-bc0a-4872-a445-a0f269f21a0d', NULL);

-- Dumping structure for tabel studio.modelearnings
CREATE TABLE IF NOT EXISTS `modelearnings` (
  `Id` uuid NOT NULL DEFAULT uuid(),
  `ModelAccountsId` uuid NOT NULL,
  `noOfUnits` double NOT NULL DEFAULT 0,
  `ModelEarningPeriodId` uuid NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelearnings_modelaccounts` (`ModelAccountsId`),
  KEY `FK_modelearnings_modelearningperiods` (`ModelEarningPeriodId`),
  CONSTRAINT `FK_modelearnings_modelaccounts` FOREIGN KEY (`ModelAccountsId`) REFERENCES `modelaccounts` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_modelearnings_modelearningperiods` FOREIGN KEY (`ModelEarningPeriodId`) REFERENCES `modelearningperiods` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio.modelearnings: ~262 rows (tilnærmelsesvis)
DELETE FROM `modelearnings`;
INSERT INTO `modelearnings` (`Id`, `ModelAccountsId`, `noOfUnits`, `ModelEarningPeriodId`) VALUES
	('4bad4c27-d8f1-46b5-8eb3-00108bc413d4', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 41, 'd7e0e847-1d2d-11ef-a189-f889d2572590'),
	('56517cc1-d39f-4bf2-b5f9-01455bb3bf8e', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 1390, 'd7cd7447-22a9-11ef-a189-f889d2572590'),
	('997957c1-bd92-43fc-b9f9-0189bc32b2f1', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 0, '5d42c860-a8f4-4626-953a-c0f97de0ad7f'),
	('1b9ea167-7826-4a38-a68d-02484663aaca', '4269ab2b-0297-4d45-8bc9-23d389f57708', 2128, '5e39eea3-81d8-4150-b68b-6c47db476063'),
	('9275ebed-e3d0-4a0a-8eac-02b9d170b531', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 0, 'd7cd72bc-22a9-11ef-a189-f889d2572590'),
	('b1768c68-f940-4641-a102-045c0b0eea2c', '9d9eba98-4941-4081-985c-67d236d917c7', 0, '974d5cea-52c4-40c8-b3fa-f65048472cd3'),
	('dc613648-66a2-4b30-bd6f-0472c4dadaea', '917851c1-61a1-47f0-86c2-716d43fac8b1', 0, 'fd56dbc9-e3ee-4c11-bc37-fb1fbee96239'),
	('77a968b7-a2e3-4cb0-9492-048f79ad486d', 'f0d11e31-cbdb-4121-9130-c067b0563475', 502, '1f55611d-5c3c-4b66-b321-362a41b4da97'),
	('d2233eb1-9279-4f68-a642-04cfaa8d91f5', '7958f135-22b1-4816-b724-7900307e2373', 5708, 'd7cd7447-22a9-11ef-a189-f889d2572590'),
	('4a7f56b2-4e42-4033-8d46-04e8b61f10fa', '917851c1-61a1-47f0-86c2-716d43fac8b1', 0, 'f2bceb71-cd8a-45c0-9ce6-3a46a12ceceb'),
	('f022fd31-d64a-4b7f-be06-0738aff21f1d', 'd205d61a-1c70-48a6-95e7-58a887380315', 67, 'ccc5164a-5a70-404a-a26c-1d8ec2d2e6c2'),
	('1a3f7c67-bc68-4e30-8cc9-07bb1ba85f96', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, 'd7cd73fd-22a9-11ef-a189-f889d2572590'),
	('2588f292-6c48-4103-8242-07c498ee88ed', 'f0d11e31-cbdb-4121-9130-c067b0563475', 620, 'd7cd750b-22a9-11ef-a189-f889d2572590'),
	('4a8350b5-5f07-4df2-bea1-0aa6f2fb2d62', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 928, 'ccc5164a-5a70-404a-a26c-1d8ec2d2e6c2'),
	('bfaa3324-9446-4f27-8291-0b3b1c3a9616', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, '1217b415-a359-480d-90d7-59f22ff0fa99'),
	('8ea95ae0-e211-4ab6-987f-0e626e040677', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, '6427c1c6-2e28-49b3-9f30-290165022ba1'),
	('5b2e9917-ca47-4680-8351-0ebbd3c94188', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 1006, '68c6d686-85f9-4c3a-ab00-63115436e288'),
	('a282c4fc-1259-4bbd-8e49-0edb82df6516', '4269ab2b-0297-4d45-8bc9-23d389f57708', 740, '482085f3-dc67-4e67-a677-2d36c355b136'),
	('f01781b7-5781-4802-bd5f-0f14249ba8ab', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, 'bce1a145-bf97-43e0-be5c-14e83b4ce3e2'),
	('9b7319dd-d5d0-43ea-8ce6-1013b0123521', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 40, 'b08f32f0-919c-457f-ba4e-b774ac5773a9'),
	('7fe0372f-f30d-4e44-8c60-101d751ec988', '9d9eba98-4941-4081-985c-67d236d917c7', 1270, '0306b96a-7b5a-4cc4-b707-ae4a4fda4ad4'),
	('5f0fa4cf-5d67-4f00-ad6e-102c571135db', 'a6dd490b-7fbf-4dd5-9e01-7f6bf5fbec03', 0, 'd7e0e800-1d2d-11ef-a189-f889d2572590'),
	('64953855-d99f-4741-88b4-104ed56473a4', 'd6295885-3006-4017-b1a6-cff23c4156cf', 1826, 'bce1a145-bf97-43e0-be5c-14e83b4ce3e2'),
	('a297d6b3-83a0-4f78-9edf-10a887e13c4b', '4269ab2b-0297-4d45-8bc9-23d389f57708', 52, '0cbae480-339c-443a-8fd2-d02236615291'),
	('5ffb6570-f280-4a14-9e8e-16517d021eef', 'b495c526-e886-4a33-ba84-e5a2f160e254', 3008, 'd5a0e67c-fd9c-4c1c-ae9c-7c545ee5c631'),
	('c6201e1a-d37e-4a51-af75-1747c5dabe00', 'd6295885-3006-4017-b1a6-cff23c4156cf', 75, 'e21c0334-17aa-11ef-a189-f889d2572590'),
	('5460a289-8f30-451b-9bdc-1a21f196f83d', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, 'b66d8980-f36d-4c90-9640-e0e40c355f87'),
	('3ce7c453-8a2b-4bc5-aed6-1a5663838605', 'da22ca04-cd6e-4f78-b754-a94698ef4bba', 8, '407c5447-a6c1-4f39-954d-155c2e0a82af'),
	('6bcdc6d5-93c4-4196-9e1d-1cd10920d078', 'a6dd490b-7fbf-4dd5-9e01-7f6bf5fbec03', 24, '032f362c-8b30-4e13-994f-6339e9273ae3'),
	('66a5fa10-8aec-425a-93ba-1cefd5e2fd83', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 0, '5d42c860-a8f4-4626-953a-c0f97de0ad7f'),
	('1489d32f-7422-4677-b6d5-1d1d4783b5ba', '917851c1-61a1-47f0-86c2-716d43fac8b1', 33, 'a94190be-f058-4b77-af0b-27c98be819ec'),
	('55622d24-a151-4a84-bbe0-1e03ec783d83', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 0, '150f9151-1f92-411f-931e-58b9d5651f89'),
	('f94a1fe5-123b-4dc4-ab56-1fcfa9ac1bda', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 2433, 'd5a0e67c-fd9c-4c1c-ae9c-7c545ee5c631'),
	('09ad76d4-d805-464a-be91-203dd2ca3838', '9d9eba98-4941-4081-985c-67d236d917c7', 5, 'cbf48349-73d2-43a6-9543-09c3bd8b0d97'),
	('e04c3272-de27-46f7-b77d-2089a1392b10', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, '37ed0d9c-c0ec-4cf5-8fb6-cd26132ac8da'),
	('d04e555c-0496-4af0-80b8-238624efb360', '7958f135-22b1-4816-b724-7900307e2373', 3342, 'b3ac4b20-a2c5-4763-a307-e82592caedec'),
	('e48b8a9f-d7d1-4750-97f9-23d1fa1338e0', 'd205d61a-1c70-48a6-95e7-58a887380315', 11, '6bad8221-924a-4773-b373-87ec2a353850'),
	('3795e9e9-5fb1-4e45-bffb-24a0b7e6585b', 'f0d11e31-cbdb-4121-9130-c067b0563475', 187, 'a9186c7c-e125-4d25-8918-9fed2f0134ad'),
	('4081f73f-3c2e-4857-be82-24a3a615dac5', '8b35ba94-1cbe-42ea-87c3-ca82dd03817b', 925, '66537bc5-4fca-4c5e-81e9-8db3db57cf93'),
	('ebbe7b4d-0b7a-4a77-883d-2686c9bfcfe0', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 1117, '0306b96a-7b5a-4cc4-b707-ae4a4fda4ad4'),
	('18b8d7d2-5c69-43c6-91f1-277523500843', '43a36f95-a918-4015-b3a2-0b270e09c6f6', 0, 'e21c053e-17aa-11ef-a189-f889d2572590'),
	('1a46d695-d430-4891-a374-27e54c4a3000', '15846b1f-4889-4257-b8fc-e6939d110456', 10, 'e21c04f2-17aa-11ef-a189-f889d2572590'),
	('5e165567-18eb-4c7f-b3ef-28124f5aa838', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 4299, '5a6a8822-49b8-413f-8276-493e49a8f2b4'),
	('b5c19e57-8892-43de-83d7-28cd251a11cc', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 360, '1e3ad71f-f700-4ae7-83a4-f481fcf07f9c'),
	('4c8bcec6-0bd2-43fa-acb1-28eea3425d8a', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, 'b943bffe-f1c3-42f5-9f87-57c9c526e232'),
	('837f349f-314b-420c-8525-292690b92457', 'bde158e6-6c2f-492a-ab14-d4f0332025bb', 6, 'cbf48349-73d2-43a6-9543-09c3bd8b0d97'),
	('ebdf8b9d-66a5-4877-a872-298b789eec2e', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, 'bb3e7339-c84a-472a-be11-e742090afd18'),
	('857cd75b-2a35-4e5b-8d9a-2a73440c9cea', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 1507, 'a73e1336-53b9-4487-bffe-19d2a2a2cc6d'),
	('35c03fb1-1741-4961-99c5-2e7e283e5168', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 8300, 'bb3e7339-c84a-472a-be11-e742090afd18'),
	('30ef5b55-1bda-4286-a87c-316163732e76', '917851c1-61a1-47f0-86c2-716d43fac8b1', 2070, '126c0463-2e70-4737-855b-3dfadbd2874f'),
	('c012f3f6-ceff-4f6c-884f-327ba8b27c8d', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, '76d2fa03-7ec7-4e82-ac6b-395107f4e27a'),
	('a49ec28b-8465-4840-9ebb-32c4f252c61d', 'd205d61a-1c70-48a6-95e7-58a887380315', 80, '69440f3b-7eae-4e05-b86b-9f911cba19c8'),
	('9144c2b7-870a-465c-bfb3-3433a8f8a969', '7958f135-22b1-4816-b724-7900307e2373', 14, 'fdd8d6fd-46c4-48ed-8088-c7d2c66b71a0'),
	('bad57972-fbf8-4132-9f4a-343fa0ea6379', '762a0e9e-b005-4cfb-8c9a-f8664055f03b', 1705, '7c16ced9-c504-41ff-a8d5-976d573129ff'),
	('691760f9-f7ff-4bee-80e3-35351e65be46', '4269ab2b-0297-4d45-8bc9-23d389f57708', 66, 'fb9ad430-0118-4fbc-91ee-00c05edd33db'),
	('57cd4119-476e-4c42-84c7-3573b9109099', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 540, 'bd52bb6d-1489-4d2e-b346-52a40c678dd7'),
	('b2f0dd90-4c80-4e68-8c0c-36cdc4c6cf0b', '4269ab2b-0297-4d45-8bc9-23d389f57708', 248, '61f8b380-59ae-49bf-9368-5eb64a14f23c'),
	('f94851e1-c3a0-4f78-9aae-37615d10f9cb', '7958f135-22b1-4816-b724-7900307e2373', 2589, 'e21c0509-17aa-11ef-a189-f889d2572590'),
	('37135101-14bb-4a14-bb6d-378f960d1e91', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 0, 'cbf48349-73d2-43a6-9543-09c3bd8b0d97'),
	('c32ff60e-e9b3-48a7-8da1-38361c4f7213', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 606, '6e201446-c729-42c6-89c8-bf9fee5c831e'),
	('b43dd61b-62c2-4c7c-ae86-393e6c661d8e', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 86, 'b85536e9-1632-41bd-ac01-02c1b07a1313'),
	('5454ae61-6362-4f04-9d01-39b1609c2ca3', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 0, 'e21c0573-17aa-11ef-a189-f889d2572590'),
	('b8a1e9e7-a70d-4b5b-821e-3a9ed6768116', 'bde158e6-6c2f-492a-ab14-d4f0332025bb', 25, '7db76e35-4bf1-4867-9842-0442f69d4684'),
	('ac91109c-f11d-4881-acce-3ac489ee6472', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 26, 'd7e0e7d5-1d2d-11ef-a189-f889d2572590'),
	('7587e653-3f97-4935-af35-3b23439d2fa8', '4f962a53-9850-42a9-9a2b-fa8cffbaef38', 1218, 'd7cd74e4-22a9-11ef-a189-f889d2572590'),
	('5ebd5197-d75a-4a6a-a2c0-3d469a13867c', '7958f135-22b1-4816-b724-7900307e2373', 1594, '6bad8221-924a-4773-b373-87ec2a353850'),
	('94676593-a7af-45fa-9bce-3ea450a1298d', '4f962a53-9850-42a9-9a2b-fa8cffbaef38', 978, '81083afa-e15b-4af3-842c-3737d773dac3'),
	('92661475-d7c6-4810-ba54-408f391c4b95', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 1517, 'c8a65981-7b2a-4a04-bb61-3a0a44a46475'),
	('ec8a039b-d2db-4ce7-95e9-41bb5508be62', '15846b1f-4889-4257-b8fc-e6939d110456', 343, '66537bc5-4fca-4c5e-81e9-8db3db57cf93'),
	('e2014364-b027-4a02-8827-42030155a5c7', 'f0d11e31-cbdb-4121-9130-c067b0563475', 1303, '33e7d345-9fb7-45b2-b82e-e684b650dd71'),
	('6550eeab-02bf-49f1-9827-45f885ab533e', 'd205d61a-1c70-48a6-95e7-58a887380315', 5, '22b68639-6320-4e38-8de2-3a43440fd682'),
	('cb955815-5738-45d9-8ef6-46a8c49db7a3', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 1374, '849a1091-ff57-434e-b72b-2ae2330d0cc5'),
	('bc6b7e33-13c4-48b4-b4d8-46b2b9dee70c', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 0, '1e6b155a-5a35-4191-83bd-baef2237ba2c'),
	('0f6dec61-dd7b-4bb9-8911-47b8b46ccfb1', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, 'd7cd73fd-22a9-11ef-a189-f889d2572590'),
	('ee8e1d39-bc59-4aaa-87d2-47c126ec0b12', '4269ab2b-0297-4d45-8bc9-23d389f57708', 0, 'e21c0573-17aa-11ef-a189-f889d2572590'),
	('e10b72d8-8ead-4fba-b532-488a826899d9', '917851c1-61a1-47f0-86c2-716d43fac8b1', 1600, 'ffdfcea1-5e2d-407c-b625-6a1a333625bd'),
	('60a4449a-26ea-4ad1-8fc5-4be8267441ab', 'f0d11e31-cbdb-4121-9130-c067b0563475', 2133, 'e21c0560-17aa-11ef-a189-f889d2572590'),
	('1a46cc6f-4c37-479f-ad3a-4c8b32ba881a', '7958f135-22b1-4816-b724-7900307e2373', 2181, 'e9ff102c-7bbe-4725-bc82-4b6790a5442a'),
	('b1bced73-59de-44c2-b227-4de7b98ee1bd', '9d9eba98-4941-4081-985c-67d236d917c7', 1219, '8f696e03-4fe9-48f9-9902-6bd00f3590fe'),
	('8186af6f-6685-49c6-a4da-4e5ee733546b', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 400, '974d5cea-52c4-40c8-b3fa-f65048472cd3'),
	('ec15b1ab-51b0-4d0d-9d68-4e9cbd8bd96b', '917851c1-61a1-47f0-86c2-716d43fac8b1', 193, '1f55611d-5c3c-4b66-b321-362a41b4da97'),
	('87d0e352-19d2-4687-9e17-4f7c93c970b3', 'b495c526-e886-4a33-ba84-e5a2f160e254', 1014, 'e21c052d-17aa-11ef-a189-f889d2572590'),
	('484285cd-9639-4262-837f-521bb1164acb', '762a0e9e-b005-4cfb-8c9a-f8664055f03b', 705, '81083afa-e15b-4af3-842c-3737d773dac3'),
	('e5bf12b9-6a54-4074-839b-533f815df4c8', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, 'b66d8980-f36d-4c90-9640-e0e40c355f87'),
	('07de93c5-4666-45ec-8182-53bcdb083dc5', '8b35ba94-1cbe-42ea-87c3-ca82dd03817b', 330, 'e21c04f2-17aa-11ef-a189-f889d2572590'),
	('039116f2-f01f-4710-a535-542d2da96418', '4269ab2b-0297-4d45-8bc9-23d389f57708', 5, 'd7e0e847-1d2d-11ef-a189-f889d2572590'),
	('3671a692-2ae3-4ebc-b2e0-54ae84055257', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, 'bb3e7339-c84a-472a-be11-e742090afd18'),
	('da250323-2b98-4cff-b38c-54d00a9d0c77', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 1873, 'e21c0509-17aa-11ef-a189-f889d2572590'),
	('5e3320f5-1372-4b1c-949b-58ad10d6d1bc', 'd205d61a-1c70-48a6-95e7-58a887380315', 0, 'fdd8d6fd-46c4-48ed-8088-c7d2c66b71a0'),
	('3063d87e-eb96-474c-98bf-5902d647e29a', 'f0d11e31-cbdb-4121-9130-c067b0563475', 775, 'd7e0e839-1d2d-11ef-a189-f889d2572590'),
	('eb228bb8-6603-44a2-a5a9-596e74215daf', 'd205d61a-1c70-48a6-95e7-58a887380315', 44, 'fd877af1-30cb-4604-82aa-c27f7047b98d'),
	('436811a2-2018-40d6-a387-59bc24ea6540', '4269ab2b-0297-4d45-8bc9-23d389f57708', 760, '5a6a8822-49b8-413f-8276-493e49a8f2b4'),
	('e9bc7552-1acd-46a0-802b-5a82684c2afb', 'b495c526-e886-4a33-ba84-e5a2f160e254', 2897, 'd7cd7494-22a9-11ef-a189-f889d2572590'),
	('b0639ab1-137f-4659-9ce9-5acbb77b79b0', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 352, 'e21c052d-17aa-11ef-a189-f889d2572590'),
	('9f91ede4-2453-443a-a49a-5beec50823a0', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 328, 'f0b74d07-8935-4fe8-a12a-1915e153376a'),
	('def17391-3fd4-4e52-bb0d-5c709d8eba93', '9d9eba98-4941-4081-985c-67d236d917c7', 40, 'd7e0e764-1d2d-11ef-a189-f889d2572590'),
	('318fd418-d0b1-4644-a737-5cb27d2bfdbf', '7958f135-22b1-4816-b724-7900307e2373', 1469, 'ccc5164a-5a70-404a-a26c-1d8ec2d2e6c2'),
	('2c3c3a3c-0427-49ad-9bbc-5f1a2961b6a7', '4269ab2b-0297-4d45-8bc9-23d389f57708', 361, 'c8a65981-7b2a-4a04-bb61-3a0a44a46475'),
	('331caf90-792b-44ca-9e3d-617f419d75c9', '917851c1-61a1-47f0-86c2-716d43fac8b1', 2697, 'c60ade8f-c98a-44c5-934e-4262e3c03002'),
	('acfd74a3-16da-477b-9a02-61d0444183ed', 'd336919f-534a-4e07-aa05-c9377b71f5c9', 0, '81083afa-e15b-4af3-842c-3737d773dac3'),
	('f64e71e6-0a63-4945-a37d-639cc957f507', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 616, 'd7e0e810-1d2d-11ef-a189-f889d2572590'),
	('2923452d-c819-4cb7-8366-65560e3ccffb', '762a0e9e-b005-4cfb-8c9a-f8664055f03b', 645, 'aaf40ed6-1fe6-4053-9b86-9dfc3bec23a9'),
	('02e56234-0de4-4bf3-9bd5-660e6103ae0f', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, '2af34564-2b67-4ba5-a4b3-fb92d48c6797'),
	('ae0d62fe-db06-48ea-af4c-66d6bf8869b4', 'b495c526-e886-4a33-ba84-e5a2f160e254', 23, 'd804e4c8-fe7b-48b5-a4af-a462ff008ec7'),
	('49bc05ba-489f-4a1f-a6fb-678ecb8be3a7', 'd205d61a-1c70-48a6-95e7-58a887380315', 32, 'b3ac4b20-a2c5-4763-a307-e82592caedec'),
	('fef5a770-136f-48f7-8443-67d040bc05c2', '15846b1f-4889-4257-b8fc-e6939d110456', 0, 'd7e0e7e5-1d2d-11ef-a189-f889d2572590'),
	('ad556565-a013-467e-8994-68b3ea8ff40d', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 380, 'fd877af1-30cb-4604-82aa-c27f7047b98d'),
	('460cb0a1-c3c6-40cd-b3f0-694834b3d12c', '9d9eba98-4941-4081-985c-67d236d917c7', 2018, '40661122-2a4c-4796-82ca-b2c92806083b'),
	('4b5cf623-ef79-4676-b0e9-6a78d23336bf', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 48, 'fdd8d6fd-46c4-48ed-8088-c7d2c66b71a0'),
	('72e568bd-0144-4257-8c9f-6b27ca6b1764', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 2434, 'b3ac4b20-a2c5-4763-a307-e82592caedec'),
	('a21c8d3b-1f25-41e2-9da2-6b4ab6be6442', '917851c1-61a1-47f0-86c2-716d43fac8b1', 2054, 'e21c0560-17aa-11ef-a189-f889d2572590'),
	('21ef040a-c812-4aea-96a5-6c9076cdc61c', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 0, '2188fa3a-b0ba-4643-9cd9-5d5dc76ae837'),
	('5fbc5e8a-0e23-48a3-a7f0-6cc06536c977', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, '7edc8d95-93c7-44cd-99a8-f9dd3a477188'),
	('d76b81eb-0ce5-4429-a91e-6d4c50b03dc6', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 0, 'e177fc5a-a446-4390-8261-d419628333ca'),
	('1c8af48f-9773-4b53-8718-6df48d3d4ad2', '762a0e9e-b005-4cfb-8c9a-f8664055f03b', 0, '0ebe72f7-41ef-48ab-9ce7-24e023c2253d'),
	('74968c5f-3c62-4f90-bb04-6ead14b51e83', 'd336919f-534a-4e07-aa05-c9377b71f5c9', 0, '0ebe72f7-41ef-48ab-9ce7-24e023c2253d'),
	('c7def026-285d-48b9-9e8a-6f98052f3a93', '4f962a53-9850-42a9-9a2b-fa8cffbaef38', 3348, 'aaf40ed6-1fe6-4053-9b86-9dfc3bec23a9'),
	('dee184c9-f514-4689-987f-6fb8a9553394', 'f0d11e31-cbdb-4121-9130-c067b0563475', 819, 'ffdfcea1-5e2d-407c-b625-6a1a333625bd'),
	('e9d7a085-2c58-449f-b976-703cc614de64', 'd336919f-534a-4e07-aa05-c9377b71f5c9', 0, 'd7e0e82b-1d2d-11ef-a189-f889d2572590'),
	('4ec68c6a-123d-46b3-9663-70672a21c7c7', '9d9eba98-4941-4081-985c-67d236d917c7', 1127, 'd7cd73ce-22a9-11ef-a189-f889d2572590'),
	('65173e07-2e9b-43e0-98e4-70c8cb98731d', 'd205d61a-1c70-48a6-95e7-58a887380315', 10, '0f36a580-9e52-4cc2-8677-f4f668245e69'),
	('a285c900-982b-4c67-a7f6-70e6cdbfbf1f', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, '6427c1c6-2e28-49b3-9f30-290165022ba1'),
	('3a0fcc33-ba2f-4768-a6c1-72cb20c51e1a', '7958f135-22b1-4816-b724-7900307e2373', 1053, '22b68639-6320-4e38-8de2-3a43440fd682'),
	('9b7ee649-1706-48ba-9802-764118e5865d', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 2, '98fc3073-0521-4b9d-9b29-5616de0f6f37'),
	('d4f01e38-bc99-469a-ab0c-77a24f49cf7e', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, '76d2fa03-7ec7-4e82-ac6b-395107f4e27a'),
	('8a034035-dd56-429e-aeac-7a87d12eeeb7', 'b495c526-e886-4a33-ba84-e5a2f160e254', 0, 'bc3a3892-8629-476e-b333-54723a30e7d5'),
	('62016d27-1f9f-4a9c-8b46-7abfb4734483', '4269ab2b-0297-4d45-8bc9-23d389f57708', 512, '3ae3c131-dca9-457a-a163-ae66fee68494'),
	('00a7923a-f7df-4639-8fe6-7e78d5a5e0ad', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 27, '31e9d281-39f1-40cb-8a4c-dd819fd60875'),
	('4887df74-f084-4b8a-80f2-7eb0489718f3', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 267, 'fb9ad430-0118-4fbc-91ee-00c05edd33db'),
	('4ae190e8-589f-4508-96bd-7f77dbe9fe8a', 'd205d61a-1c70-48a6-95e7-58a887380315', 20, 'ad182af3-76d0-45f1-9fb3-335e3c190e32'),
	('de1a12d9-c09c-43e6-88f6-7fd7d80546fe', 'a6dd490b-7fbf-4dd5-9e01-7f6bf5fbec03', 0, 'e21c051c-17aa-11ef-a189-f889d2572590'),
	('03244952-5670-45df-926a-80945fe03db3', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 1314, '6bad8221-924a-4773-b373-87ec2a353850'),
	('2c16911c-7671-4dd1-8eb0-815686583d97', 'f0d11e31-cbdb-4121-9130-c067b0563475', 320, '126c0463-2e70-4737-855b-3dfadbd2874f'),
	('58a0a10d-86c1-461a-8046-81fed05538b1', 'b495c526-e886-4a33-ba84-e5a2f160e254', 84, 'd7e0e810-1d2d-11ef-a189-f889d2572590'),
	('37728790-881c-4a7a-b8e2-822e20b4f90d', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 1600, 'c062ccdf-bb7a-4643-8b64-481bc99ae094'),
	('ea8e4729-94dc-4bad-852c-828744306fd6', '4f962a53-9850-42a9-9a2b-fa8cffbaef38', 0, '0ebe72f7-41ef-48ab-9ce7-24e023c2253d'),
	('7ba1fc1e-0cc4-4a28-9e14-82b52bd65a84', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 1178, 'e9ff102c-7bbe-4725-bc82-4b6790a5442a'),
	('311a24c4-e67f-4203-9fc3-8327a79186e1', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, 'b943bffe-f1c3-42f5-9f87-57c9c526e232'),
	('c4c8c967-3d44-45a9-9d14-8344bd7983f0', 'd205d61a-1c70-48a6-95e7-58a887380315', 13, 'd7cd7447-22a9-11ef-a189-f889d2572590'),
	('00e87b4b-892e-4039-904a-85b55404110b', '917851c1-61a1-47f0-86c2-716d43fac8b1', 443, '98e3cd77-9555-401e-9c52-36ae922586cf'),
	('e2832dbf-aabf-47e8-b901-860bc6a78866', '762a0e9e-b005-4cfb-8c9a-f8664055f03b', 1396, 'e21c054f-17aa-11ef-a189-f889d2572590'),
	('643f6240-1bb0-4cad-ba3a-8b5439dc8cc4', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 124, '482085f3-dc67-4e67-a677-2d36c355b136'),
	('b0031b87-48e5-4788-9e25-8baba1d2334c', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, '7c9e01ba-11f1-4171-adf5-4e640e9cd4b4'),
	('e28dd049-403a-4d5a-a5a5-8c89124b4315', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 3, 'd79f4db0-75b7-498b-9a9c-e041eeafa55e'),
	('a4366c29-35a8-42a1-84c2-8d309bd5663d', '4269ab2b-0297-4d45-8bc9-23d389f57708', 1853, 'd7cd7533-22a9-11ef-a189-f889d2572590'),
	('7e0b8169-4fd9-4287-b428-8fcd775dade2', 'd205d61a-1c70-48a6-95e7-58a887380315', 14, 'd7e0e7f3-1d2d-11ef-a189-f889d2572590'),
	('a663414e-88a2-48fa-9396-904e95a71f54', 'da22ca04-cd6e-4f78-b754-a94698ef4bba', 210, 'bf5f9532-972f-44eb-8764-6c4e644366ef'),
	('282846ad-b23b-4c60-b277-9058a4941fb8', '4f962a53-9850-42a9-9a2b-fa8cffbaef38', 1071, 'd7e0e82b-1d2d-11ef-a189-f889d2572590'),
	('e8a23e35-06b1-4482-be31-91499e28d7a2', '762a0e9e-b005-4cfb-8c9a-f8664055f03b', 194, 'd7e0e82b-1d2d-11ef-a189-f889d2572590'),
	('7cd1b76c-f8aa-45b0-a3d7-91d025760b5e', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 854, '61f8b380-59ae-49bf-9368-5eb64a14f23c'),
	('8e7259b4-fd31-4797-869c-93f26b2b910a', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 2725, '22b68639-6320-4e38-8de2-3a43440fd682'),
	('f644d04f-ba78-41a5-b772-97e00a14dd26', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 3310, 'd7cd7533-22a9-11ef-a189-f889d2572590'),
	('51df1ad2-3a30-469e-baf6-97ed1203bda7', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 0, '150f9151-1f92-411f-931e-58b9d5651f89'),
	('c8f63080-2fdd-495e-b936-98b52359cd6a', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, 'd7cd73fd-22a9-11ef-a189-f889d2572590'),
	('bb80d368-ac9e-4f5a-bbc6-98fa334dd87d', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 654, 'e21c0334-17aa-11ef-a189-f889d2572590'),
	('fe9af911-1a7f-4431-9165-9a6a475881a0', '4f962a53-9850-42a9-9a2b-fa8cffbaef38', 2295, '7c16ced9-c504-41ff-a8d5-976d573129ff'),
	('e94c040f-94f1-4781-87ea-9af977d449df', '9d9eba98-4941-4081-985c-67d236d917c7', 380, 'd85c2d4d-a4bc-4ab1-8f07-391a8dec23ae'),
	('e2257b47-8568-493e-9f88-9c14b16edbc1', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 990, '8f696e03-4fe9-48f9-9902-6bd00f3590fe'),
	('342e1ea1-3b80-439f-9080-9c3b5174dce2', '4f962a53-9850-42a9-9a2b-fa8cffbaef38', 2472, 'e21c054f-17aa-11ef-a189-f889d2572590'),
	('03093885-ad5a-407d-a46c-9cc455d11dc4', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 27, '7edc8d95-93c7-44cd-99a8-f9dd3a477188'),
	('42cbfb4b-abac-4787-80cc-9e16f09e9f7c', '9d9eba98-4941-4081-985c-67d236d917c7', 228, '3f3f20c6-f3e2-4a7d-b12f-8ceeace31092'),
	('0fd85874-4c16-4a02-b1e4-9e35e9f75217', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 2530, '017216fc-3228-4ec8-9c98-0d6fb47f4717'),
	('b87c9647-50f7-4085-a98c-a0497acf6d3f', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 6894, 'd7cd7494-22a9-11ef-a189-f889d2572590'),
	('12b67f24-a33d-48b5-bc9b-a1f9e14d60ec', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, 'b66d8980-f36d-4c90-9640-e0e40c355f87'),
	('2d047eab-f2a7-4d17-a968-a2dd30937300', 'f0d11e31-cbdb-4121-9130-c067b0563475', 815, 'c60ade8f-c98a-44c5-934e-4262e3c03002'),
	('57b649cc-0614-4015-8f78-a511fe74ad56', 'd336919f-534a-4e07-aa05-c9377b71f5c9', 0, '7c16ced9-c504-41ff-a8d5-976d573129ff'),
	('c176f505-7575-4cae-bdff-a91babc6c179', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 1150, 'd7e0e764-1d2d-11ef-a189-f889d2572590'),
	('ec73a005-590b-4138-b72d-aabecee13283', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, '2af34564-2b67-4ba5-a4b3-fb92d48c6797'),
	('cf7e3b35-6b7b-4650-9998-abe7875521cd', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 1421, 'c06c0360-ae0b-4df4-8948-68f485f31d16'),
	('ede42d13-93f1-4f5c-b107-ac19996e5bbf', 'd336919f-534a-4e07-aa05-c9377b71f5c9', 0, 'd7cd74e4-22a9-11ef-a189-f889d2572590'),
	('76fdd6e4-fcf4-4200-a4a1-adcfd1bd52ff', 'b495c526-e886-4a33-ba84-e5a2f160e254', 228, '1e3ad71f-f700-4ae7-83a4-f481fcf07f9c'),
	('8906a010-0af5-4870-aeb8-ae28167c8173', '917851c1-61a1-47f0-86c2-716d43fac8b1', 2570, '33e7d345-9fb7-45b2-b82e-e684b650dd71'),
	('d7aa64a7-29e9-4ef3-aa0f-b1132cd96bb9', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 1259, 'd7cd73ce-22a9-11ef-a189-f889d2572590'),
	('9df98926-d0b1-48ea-84df-b183cfb92de4', 'b495c526-e886-4a33-ba84-e5a2f160e254', 13, '9b4b8e85-52e9-49ff-8d1b-355a66eed66b'),
	('5b9b4723-cf0d-49b0-8ef3-b18f32702224', '7958f135-22b1-4816-b724-7900307e2373', 1466, '69440f3b-7eae-4e05-b86b-9f911cba19c8'),
	('c3519602-5bda-4989-9319-b380344ce381', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, '7edc8d95-93c7-44cd-99a8-f9dd3a477188'),
	('ce2a7e6a-03e6-44bb-972f-b69644c732c9', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 0, 'd7cd72bc-22a9-11ef-a189-f889d2572590'),
	('ddb8d901-7a71-464a-b333-b6ba52c1294c', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, 'f0a589e8-0b4c-48de-81f8-26582e747a38'),
	('959a2def-581b-429e-93ec-b7918cdd2b48', 'd336919f-534a-4e07-aa05-c9377b71f5c9', 0, 'e21c054f-17aa-11ef-a189-f889d2572590'),
	('77223016-6a54-4406-830a-b822cc40bd16', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 700, '7db76e35-4bf1-4867-9842-0442f69d4684'),
	('08cabe3c-b80c-4143-a5bb-b955647b729d', 'd6295885-3006-4017-b1a6-cff23c4156cf', 1022, 'd7e0e7d5-1d2d-11ef-a189-f889d2572590'),
	('eb085b4c-a2ad-488f-a909-b98492feaf78', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 3002, 'd804e4c8-fe7b-48b5-a4af-a462ff008ec7'),
	('c7ab66be-7e78-4d24-9eee-b9884cb8682b', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 3583, '6763f4f6-a7e0-4f14-a304-a64b7003069d'),
	('d3d4bc3a-c70a-4861-a10b-ba40224c631a', '917851c1-61a1-47f0-86c2-716d43fac8b1', 3243, 'a9186c7c-e125-4d25-8918-9fed2f0134ad'),
	('295ec67a-95b6-4d74-b7da-bb78c877d510', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 2536, '40661122-2a4c-4796-82ca-b2c92806083b'),
	('f2fc0231-5a84-4c18-af01-bdfe5f29df61', '4269ab2b-0297-4d45-8bc9-23d389f57708', 496, 'f0b74d07-8935-4fe8-a12a-1915e153376a'),
	('dc7dcca9-3f3e-44fb-a39d-c2b11e94b3ae', '7958f135-22b1-4816-b724-7900307e2373', 4002, 'fd877af1-30cb-4604-82aa-c27f7047b98d'),
	('6072d868-3f21-4b2e-adde-c30f8a04e31b', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 67, '7c9e01ba-11f1-4171-adf5-4e640e9cd4b4'),
	('b78c02bd-a1eb-4652-a234-c44eee386fa3', 'b495c526-e886-4a33-ba84-e5a2f160e254', 200, 'b08f32f0-919c-457f-ba4e-b774ac5773a9'),
	('a01fedf3-3a65-4b4e-9b4a-c4b4fbc59829', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 5, 'a921df62-7eb4-44ec-831a-897b1c9bf996'),
	('8c7d892b-3f68-431d-b18e-c541a7b834ea', 'b495c526-e886-4a33-ba84-e5a2f160e254', 53, 'a21d397a-40db-46bb-9a43-ddc9a5889057'),
	('46f57e93-19ae-44dd-968f-c706460b09fb', 'da22ca04-cd6e-4f78-b754-a94698ef4bba', 469, '8ed71007-a27e-4102-861e-4aeac725b4e9'),
	('177cf50c-f21b-47e4-8877-c7c31c26c188', '4269ab2b-0297-4d45-8bc9-23d389f57708', 1195, 'a73e1336-53b9-4487-bffe-19d2a2a2cc6d'),
	('0b8b0dcc-45fc-42b9-b363-c82a02b0a9cd', 'b495c526-e886-4a33-ba84-e5a2f160e254', 475, '68c6d686-85f9-4c3a-ab00-63115436e288'),
	('5f186715-1cd8-4381-bd45-c84280bf615e', 'f0d11e31-cbdb-4121-9130-c067b0563475', 797, 'a94190be-f058-4b77-af0b-27c98be819ec'),
	('5ddbfea5-1ec1-4368-a5ed-c8dfb39ec596', '9d9eba98-4941-4081-985c-67d236d917c7', 3, '31e9d281-39f1-40cb-8a4c-dd819fd60875'),
	('a6d3dc58-5ca6-4fa3-bb62-c9a65b3e6857', '43a36f95-a918-4015-b3a2-0b270e09c6f6', 0, 'd7e0e81e-1d2d-11ef-a189-f889d2572590'),
	('e6efa94c-a455-419c-8314-cb05c383c3f9', 'bde158e6-6c2f-492a-ab14-d4f0332025bb', 24, 'cf089975-5629-4359-9e83-2e9548125b1d'),
	('6fe31577-5167-4c57-bc60-cc17ca4c164c', 'b495c526-e886-4a33-ba84-e5a2f160e254', 877, 'bd52bb6d-1489-4d2e-b346-52a40c678dd7'),
	('077584c7-9a26-45e6-839c-cff85da58df5', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, '7c9e01ba-11f1-4171-adf5-4e640e9cd4b4'),
	('19ba294c-7705-416c-ab8c-d0ecd615050d', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, 'bce1a145-bf97-43e0-be5c-14e83b4ce3e2'),
	('8dace127-9d57-4832-b144-d11f44193f14', '8b35ba94-1cbe-42ea-87c3-ca82dd03817b', 0, 'd7e0e7e5-1d2d-11ef-a189-f889d2572590'),
	('65a54b78-2b1a-470c-9710-d124a4d4551a', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 0, 'e177fc5a-a446-4390-8261-d419628333ca'),
	('5965ae50-5d3f-4fb1-bfab-d1aa27ce1a83', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 1849, 'd7e0e7f3-1d2d-11ef-a189-f889d2572590'),
	('24bf67e2-165e-4839-bfa5-d20c1a5ffc59', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 27, 'b943bffe-f1c3-42f5-9f87-57c9c526e232'),
	('1cca90ae-60a7-4b0b-acee-d2a2efde0886', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 1960, '0f36a580-9e52-4cc2-8677-f4f668245e69'),
	('01fef6ba-175a-460b-8652-d66c09952da0', '762a0e9e-b005-4cfb-8c9a-f8664055f03b', 312, 'd7cd74e4-22a9-11ef-a189-f889d2572590'),
	('8418e200-7711-4d14-b0e0-d6a142fce102', '7958f135-22b1-4816-b724-7900307e2373', 4766, '0f36a580-9e52-4cc2-8677-f4f668245e69'),
	('4b55c87e-8934-4d3c-aea0-d850f72089ea', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 2292, '3ae3c131-dca9-457a-a163-ae66fee68494'),
	('4d4ec643-bcd1-4da5-b536-d882bade8059', '9d9eba98-4941-4081-985c-67d236d917c7', 41, '7db76e35-4bf1-4867-9842-0442f69d4684'),
	('86a4513f-5815-418c-bbae-da65c0ecc645', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 0, 'ee6f3f2c-8efb-4900-b08e-fe393c656433'),
	('b5708550-b769-4e70-a26c-da746b390c16', 'b7555714-28d6-4cd7-9136-b29f0dca1554', 0, 'd7e0e81e-1d2d-11ef-a189-f889d2572590'),
	('21b64bff-7687-48d5-9b52-da8103ba5cce', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, 'e21c0334-17aa-11ef-a189-f889d2572590'),
	('9b3f03bb-491a-4891-91f7-dc43eec92c3f', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 700, 'd7e0e7d5-1d2d-11ef-a189-f889d2572590'),
	('58cc0a86-f01c-4aad-a517-dc6f0feb550e', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, '6e201446-c729-42c6-89c8-bf9fee5c831e'),
	('6c0d4185-e992-4c17-80c5-dcf4eb7469d6', '9d9eba98-4941-4081-985c-67d236d917c7', 113, 'cf089975-5629-4359-9e83-2e9548125b1d'),
	('48603e23-303c-4bf0-8ea0-df24f28dc077', '917851c1-61a1-47f0-86c2-716d43fac8b1', 2757, 'd7e0e839-1d2d-11ef-a189-f889d2572590'),
	('e7caf5b0-dff9-475c-8a93-dfda57f9ad1b', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 400, 'cf089975-5629-4359-9e83-2e9548125b1d'),
	('fcbe7219-016f-49fa-97b1-e0ed024b1809', 'b7555714-28d6-4cd7-9136-b29f0dca1554', 0, 'e21c053e-17aa-11ef-a189-f889d2572590'),
	('f10e9ce8-dd3d-406c-9df6-e29dedb2ee54', '4269ab2b-0297-4d45-8bc9-23d389f57708', 577, 'a921df62-7eb4-44ec-831a-897b1c9bf996'),
	('ba261ab6-1e14-4ac0-b034-e3113f2f7782', 'b495c526-e886-4a33-ba84-e5a2f160e254', 162, 'b85536e9-1632-41bd-ac01-02c1b07a1313'),
	('612a091c-a6aa-48be-8667-e4691f0298ec', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 260, '3f3f20c6-f3e2-4a7d-b12f-8ceeace31092'),
	('1489ef7e-183f-4985-a883-e4ebab077fb8', 'f0d11e31-cbdb-4121-9130-c067b0563475', 0, 'f2bceb71-cd8a-45c0-9ce6-3a46a12ceceb'),
	('ee0778ae-2732-4f44-b1e5-e5ca7a4bc39c', 'd205d61a-1c70-48a6-95e7-58a887380315', 49, '6763f4f6-a7e0-4f14-a304-a64b7003069d'),
	('a97daed8-3cb7-4848-9b8c-e68ad58c2fdf', 'b495c526-e886-4a33-ba84-e5a2f160e254', 69, 'c062ccdf-bb7a-4643-8b64-481bc99ae094'),
	('c08c8b01-0e74-4995-a6ba-e6f82507a763', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 0, '1e6b155a-5a35-4191-83bd-baef2237ba2c'),
	('3102ee42-2f90-44fe-ba16-e708680ed01c', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, '37ed0d9c-c0ec-4cf5-8fb6-cd26132ac8da'),
	('0b6717a3-d5c7-4bb7-b2df-e7166fb39731', 'd205d61a-1c70-48a6-95e7-58a887380315', 15, 'e21c0509-17aa-11ef-a189-f889d2572590'),
	('ca75bf93-56ba-4fb1-8039-e82c98b13739', '917851c1-61a1-47f0-86c2-716d43fac8b1', 914, '8e971008-609a-490b-b54b-9765d545e89b'),
	('f7eded8c-f737-44bd-af41-ea15fb789a2b', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 433, '9b4b8e85-52e9-49ff-8d1b-355a66eed66b'),
	('82a2e978-379d-45c3-a34d-ea55ed54e342', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 4220, '69440f3b-7eae-4e05-b86b-9f911cba19c8'),
	('166dccb6-5e9a-46a5-b322-ea62bb4f0f56', 'fa92ee06-d548-4a63-aa74-b8d421393d23', 2437, 'd85c2d4d-a4bc-4ab1-8f07-391a8dec23ae'),
	('046d5447-6a19-4944-9a8f-eab37fa69415', 'b78900dc-7c53-4b00-b87c-1c9e55c43a55', 0, '1217b415-a359-480d-90d7-59f22ff0fa99'),
	('831992cb-f23f-4329-b0e3-eab8c0241dd4', 'd205d61a-1c70-48a6-95e7-58a887380315', 16, 'e9ff102c-7bbe-4725-bc82-4b6790a5442a'),
	('fd69dc55-905c-4500-97a5-eafffe321fbb', 'f0d11e31-cbdb-4121-9130-c067b0563475', 2584, '98e3cd77-9555-401e-9c52-36ae922586cf'),
	('d71e8a3e-9ea1-44b0-85df-ebca68daf834', 'eb4f9dca-1446-49a7-91d5-dda7c15ba502', 5349, 'ad182af3-76d0-45f1-9fb3-335e3c190e32'),
	('d1651a33-7a28-4f3c-9eae-ec879b9cd7d6', '7958f135-22b1-4816-b724-7900307e2373', 3270, 'c06c0360-ae0b-4df4-8948-68f485f31d16'),
	('a55479bf-cb89-427b-935e-ef09e47306a8', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 0, 'ee6f3f2c-8efb-4900-b08e-fe393c656433'),
	('33f96121-82b1-46b7-bd1e-efd7c37b0329', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 931, 'bc3a3892-8629-476e-b333-54723a30e7d5'),
	('3924fa2a-b82d-4cbb-b934-f01f92831cb1', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, '76d2fa03-7ec7-4e82-ac6b-395107f4e27a'),
	('31aac11f-076a-478c-b703-f034957e2de4', '4269ab2b-0297-4d45-8bc9-23d389f57708', 121, 'd79f4db0-75b7-498b-9a9c-e041eeafa55e'),
	('ad16dea5-e992-422c-9885-f1cf6574288a', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, '37ed0d9c-c0ec-4cf5-8fb6-cd26132ac8da'),
	('33c6d58c-db18-403f-abb1-f24539f4b9b9', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 854, '0cbae480-339c-443a-8fd2-d02236615291'),
	('a22e2519-7932-4ba0-b54a-f30b9dcef61e', '7958f135-22b1-4816-b724-7900307e2373', 1112, 'ad182af3-76d0-45f1-9fb3-335e3c190e32'),
	('74d07209-57d3-40a9-b21f-f3239b2fdb2d', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 1446, 'a21d397a-40db-46bb-9a43-ddc9a5889057'),
	('d1779100-451f-4329-9401-f353576e5c3a', 'b495c526-e886-4a33-ba84-e5a2f160e254', 435, '2438c763-0f01-4769-b2b8-ab2e8ffa0911'),
	('8ffe3ea9-776a-4b5a-999d-f3f60a9b6d83', 'd6295885-3006-4017-b1a6-cff23c4156cf', 5, '6e201446-c729-42c6-89c8-bf9fee5c831e'),
	('d0890344-dcf4-4bc2-bf0c-f4576ca4b25c', '9d9eba98-4941-4081-985c-67d236d917c7', 141, '017216fc-3228-4ec8-9c98-0d6fb47f4717'),
	('d618304c-e367-4a7d-ba0a-f458f3459f67', 'f04f3ba0-8a17-49ca-adc0-6c1cbf0fe102', 0, '2188fa3a-b0ba-4643-9cd9-5d5dc76ae837'),
	('e0fee754-c7f2-4693-ba32-f595574adf64', '7958f135-22b1-4816-b724-7900307e2373', 1495, '6763f4f6-a7e0-4f14-a304-a64b7003069d'),
	('5a9f4044-7e34-463f-91bf-f5c1005a196a', '917851c1-61a1-47f0-86c2-716d43fac8b1', 680, 'd7cd750b-22a9-11ef-a189-f889d2572590'),
	('7b75f3a7-c126-4078-afa3-f60d5107fb53', '9d9eba98-4941-4081-985c-67d236d917c7', 0, '849a1091-ff57-434e-b72b-2ae2330d0cc5'),
	('fe932e1a-d9a6-4146-876b-f6c4f7164b34', 'd6295885-3006-4017-b1a6-cff23c4156cf', 0, '2af34564-2b67-4ba5-a4b3-fb92d48c6797'),
	('35454f6a-0c49-42bb-a9e6-f6e042d5a9bd', 'f0d11e31-cbdb-4121-9130-c067b0563475', 0, '8e971008-609a-490b-b54b-9765d545e89b'),
	('108c70bc-c269-4302-9be5-f7657c6e02e5', '207dc492-2b8e-4e58-96cc-4d60e1cda4b0', 464, '98fc3073-0521-4b9d-9b29-5616de0f6f37'),
	('49f3bc71-397a-451c-8dfe-f8677c81b572', 'd336919f-534a-4e07-aa05-c9377b71f5c9', 200, 'aaf40ed6-1fe6-4053-9b86-9dfc3bec23a9'),
	('f9b052c5-f052-45a0-8dac-f934eb64b9af', 'c9a63bd4-bdeb-4c5b-9b63-08a829da32b4', 538, '2438c763-0f01-4769-b2b8-ab2e8ffa0911'),
	('be19ada5-6cff-4452-bf38-f99b672042cd', '762fa940-fce9-4f0b-8b3e-348de5e15e73', 0, '1217b415-a359-480d-90d7-59f22ff0fa99'),
	('48a2b820-3155-4877-a96a-fb6ca99d7440', 'aab3877d-1af4-45e1-aed8-6a744d9cc6df', 4400, '5e39eea3-81d8-4150-b68b-6c47db476063'),
	('2a8c7008-c958-460e-9022-fbf9bd2a3540', '7958f135-22b1-4816-b724-7900307e2373', 2107, 'd7e0e7f3-1d2d-11ef-a189-f889d2572590'),
	('79d36b86-c810-471d-b913-fca42178aa79', 'd205d61a-1c70-48a6-95e7-58a887380315', 44, 'c06c0360-ae0b-4df4-8948-68f485f31d16'),
	('d959f865-6137-468d-a717-fceecf1150b9', 'f0d11e31-cbdb-4121-9130-c067b0563475', 0, 'fd56dbc9-e3ee-4c11-bc37-fb1fbee96239');

-- Dumping structure for tabel studio.models
CREATE TABLE IF NOT EXISTS `models` (
  `Id` uuid NOT NULL,
  `Name` varchar(1000) NOT NULL DEFAULT '',
  `Active` bit(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio.models: ~13 rows (tilnærmelsesvis)
DELETE FROM `models`;
INSERT INTO `models` (`Id`, `Name`, `Active`) VALUES
	('2acd9deb-9f41-47f5-87b9-02fe8d261ecc', 'Julieth Stefany Guevara Torres', b'0'),
	('0ffdf296-2191-461c-950f-03025604b43a', 'Kedin Albeiro Lopez Quintero', b'1'),
	('20023412-5689-467c-bfd4-245b63970215', 'Cristian David Guitérrez Moreno', b'1'),
	('e3e90abd-5dbb-44a3-b970-518c2cd20e82', 'Carlos Daniel Cortes Quiñones', b'0'),
	('53ca84ed-9d5a-4d75-a47f-57b4d3cd3682', 'Albany Victoria Barrios Barrios', b'0'),
	('8673d76c-9e9a-408c-847c-6af03c1b075c', 'Monica Paulin Avendaño Caro', b'1'),
	('87db29cd-1822-4317-8cf5-775ac3d28b9c', 'Janner Asis Toscano Gamba', b'1'),
	('5d169101-96cc-44ea-8eed-88ea847900e7', 'Johans Stiv Gonzales Pinzon', b'1'),
	('c36aab53-bc0a-4872-a445-a0f269f21a0d', 'Cristian Camilo Aristizabal Giraldo', b'1'),
	('13da5ea4-74c6-49b1-bca9-a528bc5d69f7', 'Sneyder Moreno', b'1'),
	('3a1a9f59-006e-47a5-9178-af73e6f787c7', 'Dayana Andrea Pacheco Mateus', b'1'),
	('c4d7c553-8ae3-4cb8-9e9b-c2b58eaffc2a', 'Mariana Diaz Uzeta & Cristian Camilo Aristizabal Giraldo', b'1'),
	('fa5be2dc-f5c8-408a-93ec-d7a0318b99cd', 'Magdy Lorena Perdomo Culma', b'0'),
	('2a128185-ce47-42f7-a4cb-dc7f34dc9192', 'Rafael Arturo Figueroa Amaris', b'1');


-- Dumping database structure for studio_test
CREATE DATABASE IF NOT EXISTS `studio_test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `studio_test`;

-- Dumping structure for tabel studio_test.earningperiods
CREATE TABLE IF NOT EXISTS `earningperiods` (
  `Id` uuid NOT NULL,
  `FromDate` date NOT NULL,
  `ToDate` date NOT NULL,
  `TRM` float NOT NULL,
  `TRMDate` date NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.earningperiods: ~2 rows (tilnærmelsesvis)
DELETE FROM `earningperiods`;
INSERT INTO `earningperiods` (`Id`, `FromDate`, `ToDate`, `TRM`, `TRMDate`) VALUES
	('dac91a67-0c3b-43fd-8b0c-5e689a56133a', '2024-03-11', '2024-03-18', 3780, '2024-03-20'),
	('2dc79111-a093-493f-bd23-ab8a1003a95e', '2024-03-01', '2024-03-10', 3560, '2024-03-11');

-- Dumping structure for tabel studio_test.modelaccounts
CREATE TABLE IF NOT EXISTS `modelaccounts` (
  `Id` uuid NOT NULL,
  `Username` varchar(300) NOT NULL DEFAULT '',
  `Website` varchar(50) NOT NULL DEFAULT '',
  `ModelsId` uuid NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelaccount_models` (`ModelsId`),
  CONSTRAINT `FK_modelaccount_models` FOREIGN KEY (`ModelsId`) REFERENCES `models` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.modelaccounts: ~2 rows (tilnærmelsesvis)
DELETE FROM `modelaccounts`;
INSERT INTO `modelaccounts` (`Id`, `Username`, `Website`, `ModelsId`) VALUES
	('f1de3a58-9230-47f4-adcb-0a79474c85f0', 'miss_bell', 'CB', 'e9fd1f24-d976-454e-b1ea-84683cc384f5'),
	('ea284bc1-1834-4302-98c5-719b3a18eca4', 'madam_greece', 'C4', '324d8dda-b380-422c-9d05-09677718d0c6'),
	('be785262-d526-41c9-8ae0-bea4370e8217', 'miss_bell', 'SC', 'e9fd1f24-d976-454e-b1ea-84683cc384f5');

-- Dumping structure for tabel studio_test.modelearningperiods
CREATE TABLE IF NOT EXISTS `modelearningperiods` (
  `Id` uuid NOT NULL,
  `earningperiodId` uuid NOT NULL,
  `Percentage` float NOT NULL DEFAULT 0,
  `modelId` uuid NOT NULL,
  `SpecialTRM` float DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelearning_earningperiods` (`earningperiodId`),
  KEY `FK_modelearning_modelaccounts` (`modelId`) USING BTREE,
  CONSTRAINT `FK_modelearning_earningperiods` FOREIGN KEY (`earningperiodId`) REFERENCES `earningperiods` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_modelearningperiods_models` FOREIGN KEY (`modelId`) REFERENCES `models` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.modelearningperiods: ~3 rows (tilnærmelsesvis)
DELETE FROM `modelearningperiods`;
INSERT INTO `modelearningperiods` (`Id`, `earningperiodId`, `Percentage`, `modelId`, `SpecialTRM`) VALUES
	('d9eeca3f-81d6-49d3-98cd-25d026cca33b', 'dac91a67-0c3b-43fd-8b0c-5e689a56133a', 65, 'e9fd1f24-d976-454e-b1ea-84683cc384f5', NULL),
	('ac0225e3-f56b-498a-90e9-d75b7b90dbb2', 'dac91a67-0c3b-43fd-8b0c-5e689a56133a', 80, '324d8dda-b380-422c-9d05-09677718d0c6', 1111),
	('ff3c1e65-1463-4be4-baeb-eeffee2accb5', '2dc79111-a093-493f-bd23-ab8a1003a95e', 65, 'e9fd1f24-d976-454e-b1ea-84683cc384f5', 3333);

-- Dumping structure for tabel studio_test.modelearnings
CREATE TABLE IF NOT EXISTS `modelearnings` (
  `Id` uuid NOT NULL,
  `ModelAccountsId` uuid NOT NULL,
  `noOfUnits` double NOT NULL DEFAULT 0,
  `ModelEarningPeriodId` uuid NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_modelearnings_modelaccounts` (`ModelAccountsId`),
  KEY `FK_modelearnings_modelearningperiods` (`ModelEarningPeriodId`),
  CONSTRAINT `FK_modelearnings_modelearningperiods` FOREIGN KEY (`ModelEarningPeriodId`) REFERENCES `modelearningperiods` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.modelearnings: ~3 rows (tilnærmelsesvis)
DELETE FROM `modelearnings`;
INSERT INTO `modelearnings` (`Id`, `ModelAccountsId`, `noOfUnits`, `ModelEarningPeriodId`) VALUES
	('bbc57fc6-64d0-4b54-8d76-6f94586fdbff', 'f1de3a58-9230-47f4-adcb-0a79474c85f0', 461, 'd9eeca3f-81d6-49d3-98cd-25d026cca33b'),
	('54245614-7acf-4490-8b3f-b38b8e1246bc', 'be785262-d526-41c9-8ae0-bea4370e8217', 162, 'd9eeca3f-81d6-49d3-98cd-25d026cca33b'),
	('826f021a-ea20-453f-b35b-d8f703206ff5', 'f1de3a58-9230-47f4-adcb-0a79474c85f0', 25, 'ff3c1e65-1463-4be4-baeb-eeffee2accb5');

-- Dumping structure for tabel studio_test.models
CREATE TABLE IF NOT EXISTS `models` (
  `Id` uuid NOT NULL,
  `Name` varchar(1000) NOT NULL DEFAULT '',
  `Active` bit(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table studio_test.models: ~2 rows (tilnærmelsesvis)
DELETE FROM `models`;
INSERT INTO `models` (`Id`, `Name`, `Active`) VALUES
	('324d8dda-b380-422c-9d05-09677718d0c6', 'Model with C4 only', b'1'),
	('e9fd1f24-d976-454e-b1ea-84683cc384f5', 'Model with CB and SC', b'1');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
