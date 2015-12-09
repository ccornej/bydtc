-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: mysql1.cs.clemson.edu    Database: bydtc_0bhv
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AttendeeHunts`
--

DROP TABLE IF EXISTS `AttendeeHunts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AttendeeHunts` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `attendId` mediumint(9) DEFAULT NULL,
  `huntId` mediumint(9) DEFAULT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendId` (`attendId`),
  KEY `huntId` (`huntId`),
  CONSTRAINT `AttendeeHunts_ibfk_1` FOREIGN KEY (`attendId`) REFERENCES `Attendees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `AttendeeHunts_ibfk_2` FOREIGN KEY (`huntId`) REFERENCES `Hunts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AttendeeHunts`
--

LOCK TABLES `AttendeeHunts` WRITE;
/*!40000 ALTER TABLE `AttendeeHunts` DISABLE KEYS */;
INSERT INTO `AttendeeHunts` VALUES (28,2,1,NULL),(29,2,2,NULL),(30,2,3,NULL);
/*!40000 ALTER TABLE `AttendeeHunts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Attendees`
--

DROP TABLE IF EXISTS `Attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attendees` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT '0',
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attendees`
--

LOCK TABLES `Attendees` WRITE;
/*!40000 ALTER TABLE `Attendees` DISABLE KEYS */;
INSERT INTO `Attendees` VALUES (1,'Brad','Kennedy',24,0,'8432767824'),(2,'Evan','Dorn',23,0,'8643372354'),(3,'Chris','Cornejo',22,0,'6784468716');
/*!40000 ALTER TABLE `Attendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventAttendees`
--

DROP TABLE IF EXISTS `EventAttendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventAttendees` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `eventId` mediumint(9) DEFAULT NULL,
  `attendId` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eventId` (`eventId`),
  KEY `attendId` (`attendId`),
  CONSTRAINT `EventAttendees_ibfk_1` FOREIGN KEY (`eventId`) REFERENCES `Events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `EventAttendees_ibfk_2` FOREIGN KEY (`attendId`) REFERENCES `Attendees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventAttendees`
--

LOCK TABLES `EventAttendees` WRITE;
/*!40000 ALTER TABLE `EventAttendees` DISABLE KEYS */;
INSERT INTO `EventAttendees` VALUES (1,11,1),(3,4,1),(4,7,1),(6,8,1),(7,7,2),(10,9,2),(12,12,3),(23,1,2),(24,8,2),(26,8,3);
/*!40000 ALTER TABLE `EventAttendees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `enrolled` int(11) DEFAULT NULL,
  `longitude` float(11,8) DEFAULT NULL,
  `latitude` float(11,8) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT '0',
  `room` varchar(63) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
INSERT INTO `Events` VALUES (1,'Orientation','Meet with your group leaders and plan your fun weekend at Clemson.',900,20,1,-82.83661652,34.68100357,0,'Bowman F'),(4,'Arts and Crafts','Make awesome Clemson art with your friends',930,25,1,-82.83545685,34.67718124,0,'Daniel 214'),(5,'Decorate your Door Contest','Decorate your own dorm door! Winners will be announced at the end of the day.',1015,25,0,-82.83214569,34.67714691,0,'Manning Hall'),(6,'Soccer','Soccer tournament, which group will be champion?',1030,25,0,-82.84361267,34.68112946,0,'Upper Intrmural Fields'),(7,'Lunch','Eat Lunch!',1100,25,2,-82.83283234,34.67694092,0,'Schilletter Dining Hall'),(8,'What is Clemson?','Find out what Clemson is all about. Learn about the different majors, clubs and more!',1130,25,3,-82.83641052,34.67674637,0,'Cooper Library'),(9,'Dinner','Come end your day eating with Clemson athletes.',1800,25,1,-82.83885193,34.67958069,0,'Harcombe Dining Hall'),(10,'Put on a show!','Come put on your very own show in Clemson\'s outdoor theater',1345,25,0,-82.83625031,34.67823410,0,'Outdoor Theater'),(11,'I scream you scream!','Who doesn\'t love Ice Cream? Come enjoy Clemson\'s world famous `55 Exchange!',1400,25,0,-82.83190155,34.67602539,0,'`55 Exchange'),(12,'Run down the Hill!','Experience the 25 most exicting seconds in College Football!',1430,30,1,-82.84329987,34.67926788,0,'Clemson Memorial Stadium');
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hunts`
--

DROP TABLE IF EXISTS `Hunts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Hunts` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `longitude` float(11,8) DEFAULT '-82.83920288',
  `latitude` float(11,8) DEFAULT '34.67829895',
  `deleted` tinyint(4) DEFAULT '0',
  `clue1` varchar(255) DEFAULT NULL,
  `clue2` varchar(255) DEFAULT NULL,
  `clue3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hunts`
--

LOCK TABLES `Hunts` WRITE;
/*!40000 ALTER TABLE `Hunts` DISABLE KEYS */;
INSERT INTO `Hunts` VALUES (1,'Item 1','Tiger Statue',-82.83641052,34.67674637,0,'With his hand in the sky, he roars near the entrance of Death Valley.','',NULL),(2,'Item 2','Howard\'s Rock',-82.83113861,34.68999100,0,'If you aren\'t giving 110%...',NULL,NULL),(3,'Item 3','Campus Friday Flyer',-82.83920288,34.67829895,0,'Flying over Perimeter road.',NULL,NULL),(4,'Item 4','Item 4 is hard to find.',-82.83920288,34.67829895,1,'clue for item 4',NULL,NULL),(5,'Item 5','Look for item 5.',-82.83920288,34.67829895,1,'clue for item 5',NULL,NULL);
/*!40000 ALTER TABLE `Hunts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Staff` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(63) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (1,'Director ','Oversees all staff members for BYDTC.','rrast@nextgen.com','Robin Rast','4043143125',0),(2,'Director of Events','Controls all events for BYDTC.','ricardocornejo@comcast.net','Ricardo Cornejo','6786378113',0),(3,'Director of Awesome','Responsible for everything awesome about BYDTC.','dswinney@clemson.edu','Dabo Swinney','6234337101',0);
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-07 18:29:25
