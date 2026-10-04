CREATE DATABASE  IF NOT EXISTS `charityevents_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `charityevents_db`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: charityevents_db
-- ------------------------------------------------------
-- Server version	9.7.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '1b90f0e8-55e7-11f1-b1ac-025004129257:1-50';

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Fun Run'),(2,'Concert'),(3,'Auction'),(4,'Gala Dinner'),(5,'Community Festival');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charity`
--

DROP TABLE IF EXISTS `charity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charity` (
  `charity_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `contact_email` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`charity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charity`
--

LOCK TABLES `charity` WRITE;
/*!40000 ALTER TABLE `charity` DISABLE KEYS */;
INSERT INTO `charity` VALUES (1,'Hope Foundation','A charity supporting children and families in need.','contact@hopefoundation.org','0400123456'),(2,'Green Future','A charity focused on environmental protection.','info@greenfuture.org','0400654321');
/*!40000 ALTER TABLE `charity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `charity_id` int NOT NULL,
  `category_id` int NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `event_date` date NOT NULL,
  `location` varchar(150) NOT NULL,
  `purpose` text,
  `ticket_price` decimal(10,2) DEFAULT NULL,
  `goal_amount` decimal(10,2) DEFAULT NULL,
  `current_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `charity_id` (`charity_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`charity_id`) REFERENCES `charity` (`charity_id`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,1,1,'Sydney Charity Fun Run','A community fun run raising funds for children and families in need.','2026-10-15','Sydney','Raise funds to support children and families in need.',25.00,10000.00,3500.00,'active','funrun.jpg'),(2,2,2,'Green Future Charity Concert','A live music event supporting environmental protection projects.','2026-10-20','Melbourne','Raise awareness and funds for local environmental projects.',40.00,15000.00,5200.00,'active','concert.jpg'),(3,1,3,'Hope Charity Auction','A charity auction featuring donated items from local businesses.','2026-11-05','Brisbane','Raise funds for children and families in need.',10.00,12000.00,2800.00,'active','auction.jpg'),(4,2,4,'Green Future Gala Dinner','A formal fundraising dinner supporting environmental programs.','2026-11-12','Sydney','Support environmental education and conservation programs.',80.00,20000.00,7000.00,'active','gala.jpg'),(5,1,5,'Hope Community Festival','A family-friendly community festival with food, games and performances.','2026-11-22','Melbourne','Bring the community together while raising funds for families in need.',0.00,8000.00,1600.00,'active','festival.jpg'),(6,2,1,'Green Future Fun Run','A public fun run promoting healthy living and environmental awareness.','2026-12-02','Brisbane','Raise funds for tree planting and environmental restoration.',20.00,10000.00,3100.00,'active','greenrun.jpg'),(7,1,2,'Hope Christmas Concert','A seasonal charity concert featuring local musicians.','2026-12-15','Sydney','Raise funds for holiday support programs for families.',35.00,18000.00,6400.00,'active','christmasconcert.jpg'),(8,2,3,'Eco Art Auction','An auction of environmentally themed artwork donated by local artists.','2027-01-18','Melbourne','Raise funds for community environmental initiatives.',15.00,14000.00,4200.00,'active','ecoauction.jpg');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-04 12:33:03
