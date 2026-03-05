CREATE DATABASE  IF NOT EXISTS `sql_db_1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sql_db_1`;
-- MySQL dump 10.13  Distrib 8.4.8, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: sql_db_1
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `MCInstance`
--

DROP TABLE IF EXISTS `MCInstance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MCInstance` (
  `InstanceID` mediumint NOT NULL AUTO_INCREMENT,
  `InstanceName` varchar(50) NOT NULL,
  `Playtime` int NOT NULL,
  `ModLdrID` mediumint NOT NULL,
  `Difficulty` int DEFAULT NULL,
  PRIMARY KEY (`InstanceID`),
  KEY `ModLdrID` (`ModLdrID`),
  CONSTRAINT `MCInstance_ibfk_1` FOREIGN KEY (`ModLdrID`) REFERENCES `ModLoader` (`ModLdrID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MCInstance`
--

LOCK TABLES `MCInstance` WRITE;
/*!40000 ALTER TABLE `MCInstance` DISABLE KEYS */;
INSERT INTO `MCInstance` VALUES (3,'TestProfile',12,3,0),(4,'EvilProfile',0,3,0),(5,'SuperEvilProfile',420,3,0),(6,'Parasite Survival',23,3,7),(7,'Vanilla plus',400,4,3);
/*!40000 ALTER TABLE `MCInstance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ModList`
--

DROP TABLE IF EXISTS `ModList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ModList` (
  `ModListID` mediumint NOT NULL AUTO_INCREMENT,
  `InstanceID` mediumint NOT NULL,
  `ModID` mediumint NOT NULL,
  PRIMARY KEY (`ModListID`),
  KEY `InstanceID` (`InstanceID`),
  KEY `ModID` (`ModID`),
  CONSTRAINT `ModList_ibfk_1` FOREIGN KEY (`InstanceID`) REFERENCES `MCInstance` (`InstanceID`),
  CONSTRAINT `ModList_ibfk_2` FOREIGN KEY (`ModID`) REFERENCES `Mods` (`ModID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ModList`
--

LOCK TABLES `ModList` WRITE;
/*!40000 ALTER TABLE `ModList` DISABLE KEYS */;
INSERT INTO `ModList` VALUES (15,4,8),(16,4,9),(17,6,10),(18,7,16);
/*!40000 ALTER TABLE `ModList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ModLoader`
--

DROP TABLE IF EXISTS `ModLoader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ModLoader` (
  `ModLdrID` mediumint NOT NULL AUTO_INCREMENT,
  `Version` varchar(20) NOT NULL,
  `ModLoader` varchar(20) NOT NULL,
  PRIMARY KEY (`ModLdrID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ModLoader`
--

LOCK TABLES `ModLoader` WRITE;
/*!40000 ALTER TABLE `ModLoader` DISABLE KEYS */;
INSERT INTO `ModLoader` VALUES (3,'1.12.2','Forge'),(4,'1.20.1','Fabric');
/*!40000 ALTER TABLE `ModLoader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mods`
--

DROP TABLE IF EXISTS `Mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mods` (
  `ModID` mediumint NOT NULL AUTO_INCREMENT,
  `ModName` varchar(30) NOT NULL,
  `Difficulty` int NOT NULL,
  `ModLdrID` mediumint NOT NULL,
  PRIMARY KEY (`ModID`),
  KEY `ModLdrID` (`ModLdrID`),
  CONSTRAINT `Mods_ibfk_1` FOREIGN KEY (`ModLdrID`) REFERENCES `ModLoader` (`ModLdrID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mods`
--

LOCK TABLES `Mods` WRITE;
/*!40000 ALTER TABLE `Mods` DISABLE KEYS */;
INSERT INTO `Mods` VALUES (8,'JEI',0,3),(9,'Project E',0,3),(10,'Scape And Run Parasites',5,3),(11,'Spartan Sheilds',0,3),(12,'BloodMagic Reborn',2,3),(13,'BloodMagic Reborn',3,4),(14,'WI Zoom',0,4),(16,'Wi Zoom',0,4);
/*!40000 ALTER TABLE `Mods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Owner`
--

DROP TABLE IF EXISTS `Owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Owner` (
  `OwnID` mediumint NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `InstanceID` mediumint NOT NULL,
  PRIMARY KEY (`OwnID`),
  KEY `InstanceID` (`InstanceID`),
  CONSTRAINT `Owner_ibfk_1` FOREIGN KEY (`InstanceID`) REFERENCES `MCInstance` (`InstanceID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Owner`
--

LOCK TABLES `Owner` WRITE;
/*!40000 ALTER TABLE `Owner` DISABLE KEYS */;
INSERT INTO `Owner` VALUES (2,'Not Walter',3),(3,'Tovarish Boo',3),(4,'Not Walter',4),(5,'NotW',3),(6,'TovB',3),(7,'NotW',4),(8,'NotW',5),(9,'K3sa',7);
/*!40000 ALTER TABLE `Owner` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-05 16:30:04
