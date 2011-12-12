-- MySQL dump 10.11
--
-- Host: mysql.beta.lifemasher.com    Database: lifemasher_beta_prod
-- ------------------------------------------------------
-- Server version	5.0.67-userstats-log

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
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` int(11) NOT NULL auto_increment,
  `contacter_id` int(11) default NULL,
  `contactee_id` int(11) default NULL,
  `contacter_life_id` int(11) default NULL,
  `token` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (2,1,2,4,NULL,'2009-01-14 20:49:31','2009-01-15 00:45:01'),(3,3,2,6,'1220425934','2009-01-15 00:43:10','2009-01-15 00:43:10'),(4,3,1,6,'2110233768','2009-01-15 00:43:35','2009-01-15 00:43:35'),(5,2,1,1,NULL,'2009-01-15 00:47:38','2009-01-15 00:51:32'),(6,1,3,4,NULL,'2009-01-15 01:01:59','2009-01-15 01:02:16'),(7,2,3,1,NULL,'2009-01-15 01:04:13','2009-01-15 01:05:21'),(8,2,4,1,NULL,'2009-01-15 02:55:55','2009-01-15 03:43:13'),(9,2,4,11,NULL,'2009-01-15 03:50:15','2009-01-15 03:57:51'),(10,1,4,4,NULL,'2009-01-15 04:00:43','2009-01-15 04:01:58'),(11,2,5,15,NULL,'2009-06-26 05:34:53','2009-06-26 05:34:53'),(12,2,5,16,NULL,'2009-06-26 05:48:57','2009-06-26 05:48:57');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts_lives`
--

DROP TABLE IF EXISTS `contacts_lives`;
CREATE TABLE `contacts_lives` (
  `contact_id` int(11) default NULL,
  `life_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contacts_lives`
--

LOCK TABLES `contacts_lives` WRITE;
/*!40000 ALTER TABLE `contacts_lives` DISABLE KEYS */;
INSERT INTO `contacts_lives` VALUES (2,1),(5,4),(6,6),(7,6),(8,7),(9,12),(10,13);
/*!40000 ALTER TABLE `contacts_lives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lives`
--

DROP TABLE IF EXISTS `lives`;
CREATE TABLE `lives` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lives`
--

LOCK TABLES `lives` WRITE;
/*!40000 ALTER TABLE `lives` DISABLE KEYS */;
INSERT INTO `lives` VALUES (1,2,'The Coding Room','','2009-01-14 04:02:01','2009-01-15 03:55:59'),(2,2,'Ju Jitsu','','2009-01-14 04:02:17','2009-01-14 04:02:17'),(3,1,'Home','','2009-01-14 20:12:24','2009-01-15 03:51:24'),(4,1,'Work','Rocket Boys','2009-01-14 20:44:42','2009-01-14 20:44:42'),(5,2,'Flat','','2009-01-15 00:40:38','2009-01-15 00:40:38'),(6,3,'Work','','2009-01-15 00:42:49','2009-01-15 00:42:49'),(7,4,'Auckland','Moving up there','2009-01-15 01:58:19','2009-01-15 01:58:19'),(8,2,'Rocket Boys','','2009-01-15 03:38:33','2009-01-15 03:38:33'),(9,2,'The Viral Studio','','2009-01-15 03:39:03','2009-01-15 03:39:03'),(10,2,'Axius','','2009-01-15 03:39:33','2009-01-15 03:39:33'),(11,2,'PM','','2009-01-15 03:48:06','2009-01-15 03:51:58'),(12,4,'Business','','2009-01-15 03:57:34','2009-01-15 03:57:34'),(13,4,'Rocket Boys','','2009-01-15 04:01:39','2009-01-15 04:01:39'),(14,5,'electric escape','test group from shaun','2009-06-26 05:33:51','2009-06-26 05:33:51'),(15,2,'WizFire','','2009-06-26 05:34:03','2009-06-26 05:34:03'),(16,2,'Electric Escape','','2009-06-26 05:47:37','2009-06-26 05:47:37');
/*!40000 ALTER TABLE `lives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lives_projects`
--

DROP TABLE IF EXISTS `lives_projects`;
CREATE TABLE `lives_projects` (
  `project_id` int(11) default NULL,
  `life_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lives_projects`
--

LOCK TABLES `lives_projects` WRITE;
/*!40000 ALTER TABLE `lives_projects` DISABLE KEYS */;
INSERT INTO `lives_projects` VALUES (1,3),(2,3),(2,4),(4,7),(6,2),(12,1),(13,15),(14,16);
/*!40000 ALTER TABLE `lives_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lives_tasks`
--

DROP TABLE IF EXISTS `lives_tasks`;
CREATE TABLE `lives_tasks` (
  `life_id` int(11) default NULL,
  `task_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lives_tasks`
--

LOCK TABLES `lives_tasks` WRITE;
/*!40000 ALTER TABLE `lives_tasks` DISABLE KEYS */;
INSERT INTO `lives_tasks` VALUES (3,2),(3,1),(4,3),(7,8),(2,12),(2,13),(3,16),(3,22),(2,25),(16,26),(16,27);
/*!40000 ALTER TABLE `lives_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `sender_id` int(11) default '0',
  `sender` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `subject` varchar(255) default NULL,
  `body` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,2,1,'nate','read','New Contact Request','nate wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/1384510889\">http://beta.lifemasher.com/contacts/confirm/1384510889</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-14 20:44:16','2009-01-15 03:04:43'),(2,2,1,'nate','read','New Contact Request','nate wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/172002303\">http://beta.lifemasher.com/contacts/confirm/172002303</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-14 20:49:32','2009-01-15 00:40:45'),(3,2,3,'Pete','read','New Contact Request','Pete wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/1220425934\">http://beta.lifemasher.com/contacts/confirm/1220425934</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 00:43:11','2009-01-15 03:04:17'),(7,2,1,'nate','read','Contact Request Accepted','nate has accepted your contact request. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/lives/1/contacts\">http://beta.lifemasher.com/lives/1/contacts</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 00:51:32','2009-01-15 00:59:09'),(8,3,1,'nate','read','New Contact Request','nate wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/1358640024\">http://beta.lifemasher.com/contacts/confirm/1358640024</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 01:02:00','2009-01-15 01:02:11'),(10,2,3,'Pete','read','HEY BEN','Hi','2009-01-15 01:03:36','2009-01-15 01:03:48'),(11,3,1,'nate','read','Oh Noes!','Oh Noes!','2009-01-15 01:03:49','2009-01-15 01:03:56'),(12,3,2,'ben','read','New Contact Request','ben wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/-154744139\">http://beta.lifemasher.com/contacts/confirm/-154744139</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 01:04:13','2009-01-15 01:05:11'),(13,2,3,'Pete','read','Contact Request Accepted','Pete has accepted your contact request. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/lives/1/contacts\">http://beta.lifemasher.com/lives/1/contacts</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 01:05:21','2009-01-15 03:03:57'),(15,2,0,'LifeMasher Admin','read','New Changes','There have been new fields added to your user account. <br />Please access your settings page and add your First and Last names','2009-01-15 01:43:36','2009-01-15 01:43:53'),(16,3,0,'LifeMasher Admin','read','New Changes','There have been new fields added to your user account. <br />Please access your settings page and add your First and Last names','2009-01-15 01:43:37','2009-01-20 03:20:03'),(18,2,0,'LifeMasher Admin','read','New Changes','There have been new fields added to your user account. <br />Please access your settings page and add your First and Last names','2009-01-15 01:45:20','2009-01-15 01:45:39'),(19,3,0,'LifeMasher Admin','read','New Changes','There have been new fields added to your user account. <br />Please access your settings page and add your First and Last names','2009-01-15 01:45:20','2009-01-20 03:19:59'),(20,4,2,'ben','read','New Contact Request','ben wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/1495654662\">http://beta.lifemasher.com/contacts/confirm/1495654662</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 02:55:55','2009-01-15 03:43:42'),(21,3,2,'ben','read','New Goal','ben has added you to a goal. <br />To see the goal just click the link below: <br /><a href=\"http://beta.lifemasher.com/projects/5\">http://beta.lifemasher.com/projects/5</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:07:17','2009-01-20 03:19:56'),(24,3,2,'ben','read','New Goal','ben has added you to a goal. <br />To see the goal just click the link below: <br /><a href=\"http://beta.lifemasher.com/projects/3\">http://beta.lifemasher.com/projects/3</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:11:04','2009-01-20 03:19:50'),(28,4,2,'ben','read','New Goal','ben has added you to a goal. <br />To see the goal just click the link below: <br /><a href=\"http://beta.lifemasher.com/projects/3\">http://beta.lifemasher.com/projects/3</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:45:02','2009-01-15 03:58:03'),(29,4,2,'ben','read','New Contact Request','ben wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/-1470220298\">http://beta.lifemasher.com/contacts/confirm/-1470220298</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:50:15','2009-01-15 03:57:46'),(30,4,2,'ben','read','New Goal','ben has added you to a goal. <br />To see the goal just click the link below: <br /><a href=\"http://beta.lifemasher.com/projects/5\">http://beta.lifemasher.com/projects/5</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:56:56','2009-01-15 03:58:29'),(31,2,4,'Guinness','read','Contact Request Accepted','Guinness has accepted your contact request. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/lives/11/contacts\">http://beta.lifemasher.com/lives/11/contacts</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:57:51','2009-01-15 04:28:52'),(33,4,2,'ben','read','New Goal','ben has added you to a goal. <br />To see the goal just click the link below: <br /><a href=\"http://beta.lifemasher.com/projects/7\">http://beta.lifemasher.com/projects/7</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:59:19','2009-01-15 04:00:04'),(34,4,2,'ben','read','New Goal','ben has added you to a goal. <br />To see the goal just click the link below: <br /><a href=\"http://beta.lifemasher.com/projects/9\">http://beta.lifemasher.com/projects/9</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:59:32','2009-01-15 04:00:37'),(35,4,2,'ben','read','New Goal','ben has added you to a goal. <br />To see the goal just click the link below: <br /><a href=\"http://beta.lifemasher.com/projects/8\">http://beta.lifemasher.com/projects/8</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 03:59:48','2009-01-15 04:00:54'),(36,4,1,'nate','read','New Contact Request','nate wants to add you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts/confirm/-1129148033\">http://beta.lifemasher.com/contacts/confirm/-1129148033</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 04:00:44','2009-01-15 04:01:10'),(37,4,2,'ben','read','New Task','ben has added you to a task. <br />To see the task just click the link below: <br /><a href=\"http://beta.lifemasher.com/tasks/9\">http://beta.lifemasher.com/tasks/9</a> <br />Name: Ideas <br />Due: 2009-01-14 18:00:00 -1100 <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-15 04:01:16','2009-01-15 04:02:27'),(47,2,1,'nate','read','New Step','nate has added you to a step. <br />To see the step just click the link below: <br /><a href=\"http://beta.lifemasher.com/tasks/24\">http://beta.lifemasher.com/tasks/24</a> <br />Name: Reinstall <br />Due:  <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-01-20 22:14:10','2009-01-20 22:35:04'),(48,5,2,'Ben','read','New Contact Request','Ben has added you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts\">http://beta.lifemasher.com/contacts</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-06-26 05:34:53','2009-06-26 05:37:10'),(49,5,2,'Ben Jepsen','read','New Goal','Ben Jepsen has added you to a goal. <br />Goal Name: Design the layout of the site','2009-06-26 05:37:29','2009-06-26 05:49:18'),(50,5,2,'Ben','read','New Contact Request','Ben has added you to their contacts. <br />To see their profile just click the link below: <br /><a href=\"http://beta.lifemasher.com/contacts\">http://beta.lifemasher.com/contacts</a> <br />If the above URL does not work try copying and pasting it into your browser. <br />If you continue to have problem please feel free to contact us. <br />','2009-06-26 05:48:57','2009-06-26 05:49:14'),(51,5,2,'Ben Jepsen','unread','New Goal','Ben Jepsen has added you to a goal. <br />Goal Name: New Client','2009-06-26 05:50:45','2009-06-26 05:50:45');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifiers`
--

DROP TABLE IF EXISTS `notifiers`;
CREATE TABLE `notifiers` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notifiers`
--

LOCK TABLES `notifiers` WRITE;
/*!40000 ALTER TABLE `notifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `id` int(11) NOT NULL auto_increment,
  `life_id` int(11) default NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `address_1` varchar(255) default NULL,
  `address_2` varchar(255) default NULL,
  `address_3` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,'Ben',' Jepsen','200 Armagh St','','','Christchurch','027 637 6391','ben@rocketboys.co.nz','2009-01-14 20:33:08','2009-01-15 01:07:02'),(2,2,'Ben ','Jepsen','','','','','027 637 6391','','2009-01-14 20:33:08','2009-01-15 03:43:28'),(3,3,'Nate','','','','','','','','2009-01-14 20:33:08','2009-01-15 00:39:09'),(4,4,'Nate','Walker','Rocket Boys','','','Christchurch','','nate@rocketboys.co.nz','2009-01-14 20:44:42','2009-01-14 20:47:56'),(5,5,'Ben','Jepsen','108a Elizabeth St','Riccarton','','Christchurch','027 637 6391','jepsen.ben@gmail.com','2009-01-15 00:40:38','2009-01-15 03:42:45'),(6,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-15 00:42:49','2009-01-15 00:42:49'),(7,7,'Steve','Guinness','','','','','+642317343','steve.guinness@gmail.com','2009-01-15 01:58:19','2009-01-15 03:44:42'),(8,8,'Ben','Jepsen','','','','','','ben@rocketboys.co.nz','2009-01-15 03:38:33','2009-01-15 03:41:40'),(9,9,'Ben','Jepsen','','','','','','ben@theviralstudio.co.nz','2009-01-15 03:39:03','2009-01-15 03:41:11'),(10,10,'Ben ','Jepsen','','','','','','ben.jepsen@axius.co.nz','2009-01-15 03:39:33','2009-01-15 03:40:09'),(11,11,'Ben','Jepsen','','','','','027 637 6391','ben@prestigiousmemorabilia.co.nz','2009-01-15 03:48:06','2009-01-15 03:49:14'),(12,12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-15 03:57:34','2009-01-15 03:57:34'),(13,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-01-15 04:01:39','2009-01-15 04:01:39'),(14,NULL,'Nate','Dubyah','','','','','','','2009-01-18 23:27:41','2009-06-26 05:33:52'),(15,14,'shaun','ross','-','-','-','chch','3765600','shaun@electricescape.com','2009-06-26 05:33:52','2009-06-26 05:34:37'),(16,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-06-26 05:34:03','2009-06-26 05:34:03'),(17,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-06-26 05:47:37','2009-06-26 05:47:37');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles_projects`
--

DROP TABLE IF EXISTS `profiles_projects`;
CREATE TABLE `profiles_projects` (
  `project_id` int(11) default NULL,
  `profile_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `profiles_projects`
--

LOCK TABLES `profiles_projects` WRITE;
/*!40000 ALTER TABLE `profiles_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles_tasks`
--

DROP TABLE IF EXISTS `profiles_tasks`;
CREATE TABLE `profiles_tasks` (
  `task_id` int(11) default NULL,
  `profile_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `profiles_tasks`
--

LOCK TABLES `profiles_tasks` WRITE;
/*!40000 ALTER TABLE `profiles_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `token` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Move House','',NULL,NULL,'2009-01-14 20:44:01','2009-01-14 20:44:01'),(2,'New Job','',NULL,NULL,'2009-01-14 20:44:51','2009-01-14 20:44:51'),(4,'Get to Auckland','Move up there',NULL,NULL,'2009-01-15 01:59:35','2009-01-15 01:59:35'),(6,'Get Uniform (Gi)','',NULL,NULL,'2009-01-15 03:47:03','2009-01-15 03:47:03'),(12,'New Consultant','',NULL,'-974026257','2009-01-19 20:54:20','2009-01-19 20:54:20'),(13,'Design the layout of the site','',NULL,'-616977115','2009-06-26 05:37:28','2009-06-26 05:37:28'),(14,'New Client','',NULL,'-796908023','2009-06-26 05:49:56','2009-06-26 05:50:45');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20081214204412'),('20081214204947'),('20081215031001'),('20081215225957'),('20081218211445'),('20090111212048'),('20090111212300'),('20090112211320'),('20090113004222'),('20090114020819'),('20090115011714'),('20090118210029'),('20090119020527');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `due` datetime default NULL,
  `description` varchar(255) default NULL,
  `duration` int(11) default NULL,
  `state` varchar(255) default NULL,
  `project_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `position` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Find House','2009-01-29 22:26:00','Find a house!',90,'open',1,'2009-01-14 21:26:49','2009-01-19 03:54:09',2),(2,'Let Mike know','2009-01-19 00:16:00','Write to Mike',15,'closed',1,'2009-01-14 23:17:02','2009-01-19 03:53:04',NULL),(3,'Meet Kelly Services','2009-01-15 04:00:00','',30,'closed',2,'2009-01-14 23:19:50','2009-01-19 03:53:04',NULL),(8,'Move some stuff up there','2009-01-16 20:59:00','Do it',0,'open',4,'2009-01-15 03:59:31','2009-01-19 03:53:36',1),(12,'Ring Martial Art Supplies','2009-01-18 03:44:00','',30,'in_progress',6,'2009-01-18 02:44:28','2009-01-20 01:11:10',2),(13,'Purchase off trademe','2009-01-18 03:44:00','',0,'in_progress',6,'2009-01-18 02:44:48','2009-05-07 10:14:23',1),(16,'Letter to Mike','2009-01-19 07:00:00','',15,'closed',1,'2009-01-19 00:54:32','2009-01-20 18:05:37',1),(22,'Agnu 2',NULL,'',15,'closed',1,'2009-01-19 03:53:55','2009-01-19 03:54:04',3),(25,'See if it looks good',NULL,'do I look like an idiot.?',15,'in_progress',6,'2009-05-07 10:29:24','2009-05-07 10:34:56',3),(26,'Interview Client',NULL,'',15,'closed',14,'2009-06-26 05:51:22','2009-06-26 05:53:56',1),(27,'Write up the brief',NULL,'',30,'paused',14,'2009-06-26 05:51:50','2009-06-26 05:54:52',2);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `timezone` varchar(255) default NULL,
  `crypted_password` varchar(255) default NULL,
  `password_salt` varchar(255) default NULL,
  `persistence_token` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `perishable_token` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `receive_emails` tinyint(1) default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'nate','Wellington','$2a$10$LJwiwXZx.rhdrKpdCeacxeO6XExjLEGF3zDTheXHW18LdUlaBbVe2','97aaa4c2171ae07d416450aaed1463faffbadf180df4397befee4f2cb88d00014943659350f9c1454f5f88e2c2cdf265e6223cd5c78b6382652a91f6e59fc191','910e038d3df1f9ae83282a78be16b3bb0dd5a3fa1757d7f70a1b677ee7a9a17b0003348ae72c3ac05e900c0c12d12dde32b1f2d02561fd4fe6728af454017415','active','RxzRUByOs5ax4HxtCMBW','kiwinewt@gmail.com',0,'2009-01-14 03:59:28','2009-01-22 00:40:46','Nate','Walker'),(2,'Ben','International Date Line West','$2a$10$LjgOsN4bfv01KMRZK853Z.iGjtzJwLajlSNtjtZahBrvLQGQuku4u','1d4d2f9487b1c17e0b3206d1515e41930afb4b5c6cdeefb35d40c74a4680b164f2e4561d06701d9cb31674439af69720f94a1ac95f611c9243fdf0cc4a139467','12157add013188f974831824ca4a40cebc7bc8d4f3064b1609ea779144bd2f7ddf087ca6c0dcd501e2038878375a7f2ef127fb94424501a517b1a581e4b576a2','active','YkG5OGJveKnBiLWJ6YwH','jepsen.ben@gmail.com',1,'2009-01-14 04:00:03','2009-05-12 08:48:28','Ben','Jepsen'),(3,'Pete',NULL,'$2a$10$9yqJC3wZ4ccFMgXSW63ameL9m6dxZGCs.rDCv41LiVCW4skV37upW','ae4e3c3efecca1ab06913ead64899bbb4d9f147f8ad2d5cc206ebdeb559c8ad4f84e0d6096ccc04623da40bbf92fdbe0ebc0f8d951e5f4d27cb21ccbacd20dfa','d949ebe3905fdfb9b7b2dff7a9d1568815cf490d4d335c42544209d2c1dfa355b6f17b5a18d5e8340ace9acc70af6ddc8fae47d8cdff8a9aa63a148920b350b9','active','7X3mYyyeg6zg8enF6E6y','aupajo@gmail.com',1,'2009-01-14 21:17:55','2009-01-15 01:45:20','Pete',''),(4,'Guinness','Wellington','$2a$10$jQaspQjrRLQf2DtSVSuK0.8YVsfvW4Z7F3w/YZD8lLr2asRJBI2eC','aa5216095a3468571ee68f5498188ce44406adb515599a293ae6107b53f1e6fd2ba35d0a7838f878437259491a031febc53c11762544aac4b5743860139cffe4','63279e516a99fc68ab88160f44379c5b6d2c928d6eab59b7b2d105848455fbee2146be0e48c7d24528de1d1e4b85e7fed8873f82754855aa7aaf274dc6f3ca7d','active','ASj6FqDUAr6PRR1Hm8e0','steve.guinness@gmail.com',1,'2009-01-15 01:50:49','2009-05-27 09:11:54','Steve','Guinness'),(5,'razor',NULL,'$2a$10$aa01x4HcuJ0NHQo7aOlDC.UpovaBmRrnFicSZF78RW91cx77u4VFa','f7496d9c7d572d7c7c0073cf40003888e9a89d2c7d02278443edfee8b9a74ea80106dbb5699c5a5a21ed07077b6229f4c87d190f7aaf1076f42b31fdf34acdaf','ae7edbec544144bedd704135ab62a4f0530537fece10c6981f65ffd3c69b272b04439f5c951dfb0504657088c70d1749abbda4a78391a7e4e1a5a37a7486aaff','active','nUpdpTEXA85RqoX4ZeiD','shaun@electricescape.com',1,'2009-06-26 05:32:16','2009-06-26 05:37:01','Shaun','Ross');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-07-13 23:29:05
