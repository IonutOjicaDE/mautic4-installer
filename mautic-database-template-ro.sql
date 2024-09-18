-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mautic2
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

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
-- Table structure for table `asset_downloads`
--

DROP TABLE IF EXISTS `asset_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_downloads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `email_id` int(10) unsigned DEFAULT NULL,
  `date_download` datetime NOT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext DEFAULT NULL,
  `tracking_id` varchar(191) NOT NULL,
  `source` varchar(191) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A6494C8F5DA1941` (`asset_id`),
  KEY `IDX_A6494C8FA03F5E9F` (`ip_id`),
  KEY `IDX_A6494C8F55458D` (`lead_id`),
  KEY `IDX_A6494C8FA832C1C9` (`email_id`),
  KEY `download_tracking_search` (`tracking_id`),
  KEY `download_source_search` (`source`,`source_id`),
  KEY `asset_date_download` (`date_download`),
  CONSTRAINT `FK_A6494C8F55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_A6494C8F5DA1941` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A6494C8FA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_A6494C8FA832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_downloads`
--

LOCK TABLES `asset_downloads` WRITE;
/*!40000 ALTER TABLE `asset_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `alias` varchar(191) NOT NULL,
  `storage_location` varchar(191) DEFAULT NULL,
  `path` varchar(191) DEFAULT NULL,
  `remote_path` longtext DEFAULT NULL,
  `original_file_name` longtext DEFAULT NULL,
  `lang` varchar(191) NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `download_count` int(11) NOT NULL,
  `unique_download_count` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `extension` varchar(191) DEFAULT NULL,
  `mime` varchar(191) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `disallow` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_79D17D8E12469DE2` (`category_id`),
  KEY `asset_alias_search` (`alias`),
  CONSTRAINT `FK_79D17D8E12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(191) NOT NULL,
  `bundle` varchar(50) NOT NULL,
  `object` varchar(50) NOT NULL,
  `object_id` bigint(20) unsigned NOT NULL,
  `action` varchar(50) NOT NULL,
  `details` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `date_added` datetime NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_search` (`object`,`object_id`),
  KEY `timeline_search` (`bundle`,`object`,`action`,`object_id`),
  KEY `date_added_index` (`date_added`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bundle_grapesjsbuilder`
--

DROP TABLE IF EXISTS `bundle_grapesjsbuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bundle_grapesjsbuilder` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(10) unsigned DEFAULT NULL,
  `custom_mjml` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_56A1EB07A832C1C9` (`email_id`),
  CONSTRAINT `FK_56A1EB07A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bundle_grapesjsbuilder`
--

LOCK TABLES `bundle_grapesjsbuilder` WRITE;
/*!40000 ALTER TABLE `bundle_grapesjsbuilder` DISABLE KEYS */;
/*!40000 ALTER TABLE `bundle_grapesjsbuilder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_items`
--

DROP TABLE IF EXISTS `cache_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_items` (
  `item_id` varbinary(255) NOT NULL,
  `item_data` longblob NOT NULL,
  `item_lifetime` int(10) unsigned DEFAULT NULL,
  `item_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_items`
--

LOCK TABLES `cache_items` WRITE;
/*!40000 ALTER TABLE `cache_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_events`
--

DROP TABLE IF EXISTS `campaign_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `event_order` int(11) NOT NULL,
  `properties` longtext NOT NULL COMMENT '(DC2Type:array)',
  `trigger_date` datetime DEFAULT NULL,
  `trigger_interval` int(11) DEFAULT NULL,
  `trigger_interval_unit` varchar(1) DEFAULT NULL,
  `trigger_hour` time DEFAULT NULL,
  `trigger_restricted_start_hour` time DEFAULT NULL,
  `trigger_restricted_stop_hour` time DEFAULT NULL,
  `trigger_restricted_dow` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `trigger_mode` varchar(10) DEFAULT NULL,
  `decision_path` varchar(191) DEFAULT NULL,
  `temp_id` varchar(191) DEFAULT NULL,
  `channel` varchar(191) DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8EC42EE7F639F774` (`campaign_id`),
  KEY `IDX_8EC42EE7727ACA70` (`parent_id`),
  KEY `campaign_event_search` (`type`,`event_type`),
  KEY `campaign_event_type` (`event_type`),
  KEY `campaign_event_channel` (`channel`,`channel_id`),
  CONSTRAINT `FK_8EC42EE7727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `campaign_events` (`id`),
  CONSTRAINT `FK_8EC42EE7F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_events`
--

LOCK TABLES `campaign_events` WRITE;
/*!40000 ALTER TABLE `campaign_events` DISABLE KEYS */;
INSERT INTO `campaign_events` VALUES
(1,1,NULL,'Este un Robot?',NULL,'lead.field_value','condition',1,'a:20:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"707\";s:8:\"droppedY\";s:3:\"155\";}s:4:\"name\";s:14:\"Este un Robot?\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:2:{s:5:\"field\";s:7:\"capcana\";s:8:\"operator\";s:6:\"!empty\";}s:4:\"type\";s:16:\"lead.field_value\";s:9:\"eventType\";s:9:\"condition\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"field\";s:7:\"capcana\";s:8:\"operator\";s:6:\"!empty\";s:5:\"value\";N;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new9692f12e4d863246dddd540bf717581a63571d49',NULL,0),
(2,1,1,'Adaug Eticheta Robot',NULL,'lead.changetags','action',2,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"348\";}s:4:\"name\";s:20:\"Adaug Eticheta Robot\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"3\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:7:\"Z-Robot\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new54d23bfe887235aa871a277e7092212af06e19f8',NULL,0),
(3,1,2,'Robot:Adaug Nu-Contacta',NULL,'lead.adddnc','action',3,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"453\";}s:4:\"name\";s:23:\"Robot:Adaug Nu-Contacta\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:2:{s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:5:\"ROBOT\";}s:4:\"type\";s:11:\"lead.adddnc\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:5:\"ROBOT\";}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new39b584a89102785aa1b50186da3dd24e02dadd32',NULL,0),
(4,1,3,'Robot:Înlătur din campanie',NULL,'campaign.addremovelead','action',4,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"558\";}s:4:\"name\";s:28:\"Robot:Înlătur din campanie\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newb3e8c70fa343525a30847e31740471ac4641e0e9',NULL,0),
(5,1,1,'Are email valid?',NULL,'email.validate.address','condition',2,'a:0:{}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','newe153ad99c164ca0d7be3804ae62e51e063ad7a01',NULL,0),
(6,1,5,'Adaug Eticheta Email-Invalid',NULL,'lead.changetags','action',3,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"348\";}s:4:\"name\";s:28:\"Adaug Eticheta Email-Invalid\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"2\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:15:\"Z-Email-Invalid\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new8b029d0bbc25a311a346dfa08a1773cfbc59c80e',NULL,0),
(7,1,6,'Email invalid:Adaug Nu-Contacta',NULL,'lead.adddnc','action',4,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"453\";}s:4:\"name\";s:31:\"Email invalid:Adaug Nu-Contacta\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:2:{s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:13:\"Email invalid\";}s:4:\"type\";s:11:\"lead.adddnc\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:13:\"Email invalid\";}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new8bda97956147527d0a1323ff9d4e7601eaa7be75',NULL,0),
(8,1,7,'Email invalid:Înlătur din campanie',NULL,'campaign.addremovelead','action',5,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"558\";}s:4:\"name\";s:36:\"Email invalid:Înlătur din campanie\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newa857f7b18783cab1919cf1eaaef98a69b0596e33',NULL,0),
(9,1,11,'Introdu aici acţiunile TALE',NULL,'lead.changetags','action',4,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"238\";s:8:\"droppedY\";s:3:\"348\";}s:4:\"name\";s:28:\"Introdu aici acţiunile TALE\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:11:\"remove_tags\";a:1:{i:0;s:1:\"1\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"remove_tags\";a:1:{i:0;s:1:\"z\";}s:8:\"add_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newcb76af4d0647fa7361fe301fd13ceb63f7b76f1f',NULL,0),
(10,2,NULL,'Şterg contact anonim',NULL,'lead.deletecontact','action',0,'a:0:{}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newe0283b318e528457fc9828cabde06cb352faae0f',NULL,0),
(11,1,5,'Set Owner: ###SENDER_FIRSTNAME###',NULL,'lead.changeowner','action',3,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:0:\"\";s:8:\"droppedY\";s:0:\"\";}s:4:\"name\";s:16:\"Set Owner: ###SENDER_FIRSTNAME###\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:2:{s:5:\"owner\";s:1:\"1\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}}s:4:\"type\";s:16:\"lead.changeowner\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:1:\"1\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:5:\"owner\";i:1;s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new6c67be825a85e234eaee15edae8e4f981c3d76c9',NULL,0),
(12,3,NULL,'Scot din Segmente',NULL,'lead.changelist','action',0,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"760\";s:8:\"droppedY\";s:3:\"155\";}s:4:\"name\";s:17:\"Scot din Segmente\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:1:{s:15:\"removeFromLists\";a:5:{i:0;s:2:\"13\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:2:\"11\";i:4;s:2:\"12\";}}s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_bb561a02b1e533bd345ba371e37ff29a5e728f6b\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:15:\"removeFromLists\";a:5:{i:0;i:13;i:1;i:5;i:2;i:6;i:3;i:11;i:4;i:12;}s:10:\"addToLists\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newd77c5867dbfe40019cfc91ecaa0c83bd1a6a9f6e',NULL,NULL),
(13,4,NULL,'Este un Robot?',NULL,'lead.field_value','condition',1,'a:20:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"707\";s:8:\"droppedY\";s:3:\"155\";}s:4:\"name\";s:14:\"Este un Robot?\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:2:{s:5:\"field\";s:7:\"capcana\";s:8:\"operator\";s:6:\"!empty\";}s:4:\"type\";s:16:\"lead.field_value\";s:9:\"eventType\";s:9:\"condition\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"field\";s:7:\"capcana\";s:8:\"operator\";s:6:\"!empty\";s:5:\"value\";N;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new1',NULL,0),
(14,4,NULL,'Înlătur din campanie',NULL,'campaign.addremovelead','action',1,'a:29:{s:2:\"id\";s:4:\"new4\";s:4:\"name\";s:28:\"Robot:Înlătur din campanie\";s:11:\"description\";N;s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:4;s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:4:\"new4\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:2:{s:6:\"tempId\";a:2:{i:0;N;i:1;s:4:\"new4\";}s:6:\"parent\";a:2:{i:0;i:3;i:1;N;}}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"558\";}s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,2,'i',NULL,NULL,NULL,'a:0:{}','interval',NULL,'new4',NULL,0),
(15,4,13,'Adaug Eticheta Robot',NULL,'lead.changetags','action',2,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"348\";}s:4:\"name\";s:20:\"Adaug Eticheta Robot\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"3\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:7:\"Z-Robot\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new2',NULL,0),
(16,4,13,'Are email valid?',NULL,'email.validate.address','condition',2,'a:0:{}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new5',NULL,0),
(17,4,15,'Robot:Adaug Nu-Contacta',NULL,'lead.adddnc','action',3,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"453\";}s:4:\"name\";s:23:\"Robot:Adaug Nu-Contacta\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:2:{s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:5:\"ROBOT\";}s:4:\"type\";s:11:\"lead.adddnc\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:5:\"ROBOT\";}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new3',NULL,0),
(18,4,16,'Adaug Eticheta Email-Invalid',NULL,'lead.changetags','action',3,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"348\";}s:4:\"name\";s:28:\"Adaug Eticheta Email-Invalid\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"2\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:15:\"Z-Email-Invalid\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new6',NULL,0),
(19,4,16,'Set Owner: ###SENDER_FIRSTNAME###',NULL,'lead.changeowner','action',3,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:0:\"\";s:8:\"droppedY\";s:0:\"\";}s:4:\"name\";s:16:\"Set Owner: ###SENDER_FIRSTNAME###\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:2:{s:5:\"owner\";s:1:\"1\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}}s:4:\"type\";s:16:\"lead.changeowner\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:1:\"1\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:5:\"owner\";i:1;s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new11',NULL,0),
(20,4,18,'Email invalid:Adaug Nu-Contacta',NULL,'lead.adddnc','action',4,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"453\";}s:4:\"name\";s:31:\"Email invalid:Adaug Nu-Contacta\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:2:{s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:13:\"Email invalid\";}s:4:\"type\";s:11:\"lead.adddnc\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:13:\"Email invalid\";}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new7',NULL,0),
(21,4,19,'Este DEJA înscris la Webinar?',NULL,'lead.segments','condition',4,'a:28:{s:2:\"id\";i:21;s:4:\"name\";s:31:\"*Este DEJA înscris la Webinar?\";s:11:\"description\";N;s:4:\"type\";s:13:\"lead.segments\";s:9:\"eventType\";s:9:\"condition\";s:5:\"order\";i:4;s:10:\"properties\";a:1:{s:8:\"segments\";a:1:{i:0;s:1:\"5\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new72b9be1f4330a2fa791760f76ee29b650666576c\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:3:\"yes\";s:15:\"anchorEventType\";s:9:\"condition\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"663\";}s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"segments\";a:1:{i:0;i:5;}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new72b9be1f4330a2fa791760f76ee29b650666576c',NULL,0),
(22,4,21,'Email:Deja înscris',NULL,'email.send','action',5,'a:31:{s:2:\"id\";i:22;s:4:\"name\";s:20:\"*Email:Deja înscris\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:5;s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"3\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";s:3:\"yes\";s:6:\"tempId\";s:43:\"newbef9efb91c2668773f5f0e53219e6dd40696921d\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:3;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:3:\"yes\";s:15:\"anchorEventType\";s:9:\"condition\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"661\";}s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"3\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','newbef9efb91c2668773f5f0e53219e6dd40696921d','email',3),
(23,4,21,'***Fixează data webinarului',NULL,'lead.updatelead','action',5,'a:27:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"604\";s:8:\"droppedY\";s:3:\"235\";}s:4:\"name\";s:28:\"***Fixează data webinarului\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:10:{s:6:\"wgdata\";s:10:\"2024-04-23\";s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:6:\"mobile\";s:0:\"\";s:6:\"points\";s:0:\"\";s:8:\"timezone\";s:13:\"Europe/Berlin\";s:11:\"last_active\";s:0:\"\";s:7:\"company\";s:0:\"\";s:7:\"capcana\";s:0:\"\";}s:4:\"type\";s:15:\"lead.updatelead\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:6:\"wgdata\";s:10:\"2024-04-23\";s:9:\"firstname\";N;s:8:\"lastname\";N;s:5:\"email\";N;s:6:\"mobile\";N;s:6:\"points\";N;s:8:\"timezone\";s:13:\"Europe/Berlin\";s:11:\"last_active\";N;s:7:\"company\";N;s:7:\"capcana\";N;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new362149dc4b770881c878ffc86cc9ad7c1bd600a9',NULL,0),
(24,4,23,'Webinarul urmează?',NULL,'lead.field_value','condition',6,'a:30:{s:2:\"id\";i:24;s:4:\"name\";s:20:\"*Webinarul urmează?\";s:11:\"description\";N;s:4:\"type\";s:16:\"lead.field_value\";s:9:\"eventType\";s:9:\"condition\";s:5:\"order\";i:6;s:10:\"properties\";a:3:{s:5:\"field\";s:6:\"wgdata\";s:8:\"operator\";s:3:\"gte\";s:5:\"value\";s:6:\"0 days\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new7b33d12445ae61651313883ad858810ba4723a28\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"781\";s:8:\"droppedY\";s:3:\"143\";}s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"field\";s:6:\"wgdata\";s:8:\"operator\";s:3:\"gte\";s:5:\"value\";s:6:\"0 days\";}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new7b33d12445ae61651313883ad858810ba4723a28',NULL,0),
(25,4,24,'Email:Confirmare inscriere',NULL,'email.send','action',7,'a:31:{s:2:\"id\";i:25;s:4:\"name\";s:27:\"*Email:Confirmare inscriere\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:7;s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"2\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";s:3:\"yes\";s:6:\"tempId\";s:43:\"newfe063ff56140077e70a4d61926d80533a1278329\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:2;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:3:\"yes\";s:15:\"anchorEventType\";s:9:\"condition\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"705\";s:8:\"droppedY\";s:3:\"235\";}s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"2\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','newfe063ff56140077e70a4d61926d80533a1278329','email',2),
(26,4,24,'Email:Webinarul a trecut',NULL,'email.send','action',7,'a:31:{s:2:\"id\";i:26;s:4:\"name\";s:25:\"*Email:Webinarul a trecut\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:7;s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"4\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";s:2:\"no\";s:6:\"tempId\";s:43:\"newc04b56a9b43c0a6717d1d7d85ebf7c7c47ae43da\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:4;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:2:\"no\";s:15:\"anchorEventType\";s:9:\"condition\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"905\";s:8:\"droppedY\";s:3:\"235\";}s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"4\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','newc04b56a9b43c0a6717d1d7d85ebf7c7c47ae43da','email',4),
(27,4,25,'Adaug in Lista:Inscrisi',NULL,'lead.changelist','action',8,'a:30:{s:2:\"id\";i:27;s:4:\"name\";s:19:\"Adaug in L:Inscrisi\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:8;s:10:\"properties\";a:2:{s:10:\"addToLists\";a:1:{i:0;s:1:\"5\";}s:15:\"removeFromLists\";a:1:{i:0;s:1:\"6\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new14bdd5b07ae66f52cfd9d46c9c87991f21fe4e52\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:3:\"yes\";s:15:\"anchorEventType\";s:9:\"condition\";s:8:\"settings\";a:4:{s:5:\"label\";s:32:\"Modifică segmentele contactelor\";s:11:\"description\";s:49:\"Adaugă contactul la sau înlătură din segmente\";s:8:\"formType\";s:42:\"Mautic\\LeadBundle\\Form\\Type\\ListActionType\";s:9:\"eventName\";s:38:\"mautic.lead.on_campaign_trigger_action\";}s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"705\";s:8:\"droppedY\";s:3:\"235\";}s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"addToLists\";a:1:{i:0;i:5;}s:15:\"removeFromLists\";a:1:{i:0;i:6;}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new14bdd5b07ae66f52cfd9d46c9c87991f21fe4e52',NULL,0),
(28,4,26,'Adaug in Lista:InscrisiDupa',NULL,'lead.changelist','action',8,'a:30:{s:2:\"id\";s:43:\"newa91a2c084f3b91d38b25d3d1ec618a2366258b34\";s:4:\"name\";s:23:\"Adaug in L:InscrisiDupa\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:8;s:10:\"properties\";a:1:{s:10:\"addToLists\";a:1:{i:0;s:1:\"6\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newa91a2c084f3b91d38b25d3d1ec618a2366258b34\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:2:\"no\";s:15:\"anchorEventType\";s:9:\"condition\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"905\";s:8:\"droppedY\";s:3:\"235\";}s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:4:{s:5:\"label\";s:32:\"Modifică segmentele contactelor\";s:11:\"description\";s:49:\"Adaugă contactul la sau înlătură din segmente\";s:8:\"formType\";s:42:\"Mautic\\LeadBundle\\Form\\Type\\ListActionType\";s:9:\"eventName\";s:38:\"mautic.lead.on_campaign_trigger_action\";}s:10:\"addToLists\";a:1:{i:0;i:6;}s:15:\"removeFromLists\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newa91a2c084f3b91d38b25d3d1ec618a2366258b34',NULL,0),
(29,4,27,'***Adaug eticheta WG-Inscris (adaug WG-Data)',NULL,'lead.changetags','action',9,'a:29:{s:2:\"id\";s:4:\"new9\";s:4:\"name\";s:28:\"Introdu aici acţiunile TALE\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:4;s:10:\"properties\";a:1:{s:11:\"remove_tags\";a:1:{i:0;s:1:\"1\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:4:\"new9\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:2:{s:6:\"tempId\";a:2:{i:0;N;i:1;s:4:\"new9\";}s:6:\"parent\";a:2:{i:0;i:11;i:1;N;}}s:6:\"anchor\";s:3:\"yes\";s:15:\"anchorEventType\";s:9:\"condition\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"238\";s:8:\"droppedY\";s:3:\"348\";}s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"remove_tags\";a:0:{}s:8:\"add_tags\";a:1:{i:0;s:10:\"WG-Inscris\";}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new9',NULL,0),
(30,4,29,'Adauga 2 puncte',NULL,'lead.changepoints','action',10,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"705\";s:8:\"droppedY\";s:3:\"235\";}s:4:\"name\";s:15:\"Adauga 2 puncte\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:6:\"points\";s:1:\"2\";}s:4:\"type\";s:17:\"lead.changepoints\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_590288db7456bb45dfceed26774ee73bb0818e22\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:6:\"points\";i:2;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new1d4541871a50f5cad0360f9ce978cc93eeb0ec87',NULL,0),
(31,5,NULL,'Aşteaptă 4 ore',NULL,'lead.changetags','action',1,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"260\";}s:4:\"name\";s:16:\"Aşteaptă 4 ore\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"4\";s:19:\"triggerIntervalUnit\";s:1:\"h\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:1:{s:11:\"remove_tags\";a:1:{i:0;s:1:\"1\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"remove_tags\";a:1:{i:0;s:1:\"z\";}s:8:\"add_tags\";a:0:{}}',NULL,4,'h',NULL,NULL,NULL,'a:0:{}','interval',NULL,'new6a1a68c8977f12803ab8b35d52f9d487944b145c',NULL,NULL),
(32,5,31,'Email 0zi07:01...17:01',NULL,'email.send','action',2,'a:20:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"74\";s:8:\"droppedY\";s:3:\"609\";}s:4:\"name\";s:22:\"Email 0zi07:01...17:01\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:26:\"triggerRestrictedStartHour\";s:5:\"07:01\";s:25:\"triggerRestrictedStopHour\";s:5:\"17:01\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"5\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"5\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,0,'d',NULL,'07:01:00','17:01:00','a:0:{}','interval',NULL,'newc526de8b8184e294bb73905461a1c282192af472','email',5),
(33,6,NULL,'Aşteaptă 4 ore',NULL,'lead.changetags','action',1,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"260\";}s:4:\"name\";s:16:\"Aşteaptă 4 ore\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"4\";s:19:\"triggerIntervalUnit\";s:1:\"h\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:1:{s:11:\"remove_tags\";a:1:{i:0;s:1:\"1\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"remove_tags\";a:1:{i:0;s:1:\"z\";}s:8:\"add_tags\";a:0:{}}',NULL,4,'h',NULL,NULL,NULL,'a:0:{}','interval',NULL,'new31',NULL,0),
(34,6,33,'Email 0zi07:01...17:01',NULL,'email.send','action',2,'a:32:{s:2:\"id\";s:5:\"new32\";s:4:\"name\";s:22:\"Email 0zi07:01...17:01\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:2;s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"5\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";N;s:26:\"triggerRestrictedStartHour\";s:5:\"07:01\";s:25:\"triggerRestrictedStopHour\";s:5:\"17:01\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:5:\"new32\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:2:{s:6:\"tempId\";a:2:{i:0;N;i:1;s:5:\"new32\";}s:6:\"parent\";a:2:{i:0;i:31;i:1;N;}}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"74\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"6\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,0,'d',NULL,'07:01:00','17:01:00','a:0:{}','interval',NULL,'new32','email',6),
(35,7,NULL,'Aşteaptă 4 ore',NULL,'lead.changetags','action',1,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"260\";}s:4:\"name\";s:16:\"Aşteaptă 4 ore\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"4\";s:19:\"triggerIntervalUnit\";s:1:\"h\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:1:{s:11:\"remove_tags\";a:1:{i:0;s:1:\"1\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"remove_tags\";a:1:{i:0;s:1:\"z\";}s:8:\"add_tags\";a:0:{}}',NULL,4,'h',NULL,NULL,NULL,'a:0:{}','interval',NULL,'new33',NULL,0),
(36,7,35,'Email 0zi07:01...10:01',NULL,'email.send','action',2,'a:32:{s:2:\"id\";s:5:\"new32\";s:4:\"name\";s:22:\"Email 0zi07:01...17:01\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:2;s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"5\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";N;s:26:\"triggerRestrictedStartHour\";s:5:\"07:01\";s:25:\"triggerRestrictedStopHour\";s:5:\"17:01\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:5:\"new32\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:2:{s:6:\"tempId\";a:2:{i:0;N;i:1;s:5:\"new32\";}s:6:\"parent\";a:2:{i:0;i:31;i:1;N;}}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"74\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"7\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,0,'d',NULL,'07:01:00','10:01:00','a:0:{}','interval',NULL,'new34','email',7),
(37,8,NULL,'Aşteaptă 2min',NULL,'lead.changetags','action',1,'a:30:{s:2:\"id\";s:5:\"new35\";s:4:\"name\";s:16:\"Aşteaptă 4 ore\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:1;s:10:\"properties\";a:1:{s:11:\"remove_tags\";a:1:{i:0;s:1:\"1\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"4\";s:19:\"triggerIntervalUnit\";s:1:\"h\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:5:\"new35\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:1:{s:6:\"tempId\";a:2:{i:0;N;i:1;s:5:\"new35\";}}s:5:\"label\";s:16:\"aşteaptă 4 ore\";s:6:\"anchor\";s:10:\"leadsource\";s:15:\"anchorEventType\";s:6:\"source\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"260\";}s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"remove_tags\";a:1:{i:0;s:1:\"z\";}s:8:\"add_tags\";a:0:{}}',NULL,2,'i',NULL,NULL,NULL,'a:0:{}','interval',NULL,'new35',NULL,0),
(38,8,NULL,'Inlatur din Lista:Inscrisi',NULL,'lead.changelist','action',1,'a:31:{s:2:\"id\";i:38;s:4:\"name\";s:23:\"Inlătur din L:Inscrisi\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:1;s:10:\"properties\";a:1:{s:15:\"removeFromLists\";a:1:{i:0;s:1:\"5\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";N;s:26:\"triggerRestrictedStartHour\";s:5:\"22:00\";s:25:\"triggerRestrictedStopHour\";s:5:\"23:59\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newfdeb516c857dc48ef3367d08d92724a954201c37\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:10:\"leadsource\";s:15:\"anchorEventType\";s:6:\"source\";s:8:\"settings\";a:4:{s:5:\"label\";s:32:\"Modifică segmentele contactelor\";s:11:\"description\";s:49:\"Adaugă contactul la sau înlătură din segmente\";s:8:\"formType\";s:42:\"Mautic\\LeadBundle\\Form\\Type\\ListActionType\";s:9:\"eventName\";s:38:\"mautic.lead.on_campaign_trigger_action\";}s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_e1b7d8f6de18f02c8d2938b5bdc7230b46799073\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:15:\"removeFromLists\";a:1:{i:0;i:5;}s:10:\"addToLists\";a:0:{}}',NULL,0,'d',NULL,'22:00:00','23:59:00','a:0:{}','interval',NULL,'newfdeb516c857dc48ef3367d08d92724a954201c37',NULL,0),
(39,8,37,'Email 4h 0zi15:00...15:25',NULL,'email.send','action',2,'a:32:{s:2:\"id\";s:5:\"new32\";s:4:\"name\";s:22:\"Email 0zi07:01...17:01\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:2;s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"5\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";N;s:26:\"triggerRestrictedStartHour\";s:5:\"07:01\";s:25:\"triggerRestrictedStopHour\";s:5:\"17:01\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:5:\"new32\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:2:{s:6:\"tempId\";a:2:{i:0;N;i:1;s:5:\"new32\";}s:6:\"parent\";a:2:{i:0;i:31;i:1;N;}}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"74\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_9ab5cf2c4e725f64320b7f4567ce12d684183c18\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"8\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,0,'d',NULL,'15:00:00','15:25:00','a:0:{}','interval',NULL,'new36','email',8),
(40,8,37,'Email 20min 0zi18:39...18:45',NULL,'email.send','action',2,'a:32:{s:2:\"id\";i:40;s:4:\"name\";s:29:\"*Email 20min 0zi18:39...18:45\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:2;s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"9\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";N;s:26:\"triggerRestrictedStartHour\";s:5:\"18:39\";s:25:\"triggerRestrictedStopHour\";s:5:\"18:45\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new50f4952184b144c92baa0552341255649c1da219\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:9;s:7:\"changes\";a:0:{}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"74\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_e1b7d8f6de18f02c8d2938b5bdc7230b46799073\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"9\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,0,'d',NULL,'18:39:00','18:45:00','a:0:{}','interval',NULL,'new50f4952184b144c92baa0552341255649c1da219','email',9),
(41,8,37,'A intrat deja live? 0zi19:10...19:25',NULL,'lead.segments','condition',2,'a:29:{s:2:\"id\";i:41;s:4:\"name\";s:37:\"*A intrat deja live? 0zi19:10...19:25\";s:11:\"description\";N;s:4:\"type\";s:13:\"lead.segments\";s:9:\"eventType\";s:9:\"condition\";s:5:\"order\";i:2;s:10:\"properties\";a:1:{s:8:\"segments\";a:1:{i:0;s:1:\"5\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";N;s:26:\"triggerRestrictedStartHour\";s:5:\"19:10\";s:25:\"triggerRestrictedStopHour\";s:5:\"19:25\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newf9157a46fb0bda48740326f68efbd545b1580cfb\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"74\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_e1b7d8f6de18f02c8d2938b5bdc7230b46799073\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"segments\";a:1:{i:0;i:12;}}',NULL,0,'d',NULL,'19:10:00','19:25:00','a:0:{}','interval',NULL,'newf9157a46fb0bda48740326f68efbd545b1580cfb',NULL,0),
(42,8,40,'Adaug în Camp:Live',NULL,'campaign.addremovelead','action',3,'a:30:{s:2:\"id\";s:43:\"new10425657978f3091f9112817a4e995fb83b0dcc7\";s:4:\"name\";s:20:\"*Adaug în Camp:Live\";s:11:\"description\";N;s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:3;s:10:\"properties\";a:1:{s:5:\"addTo\";a:1:{i:0;s:1:\"3\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new10425657978f3091f9112817a4e995fb83b0dcc7\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"286\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_e1b7d8f6de18f02c8d2938b5bdc7230b46799073\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:5:{s:5:\"label\";s:20:\"Modifică campaniile\";s:11:\"description\";s:125:\"Adăugă contactul la anumite campanii și/sau îndepărtează din anumite campanii atunci când evenimentul este declanșat.\";s:8:\"formType\";s:62:\"Mautic\\CampaignBundle\\Form\\Type\\CampaignEventAddRemoveLeadType\";s:15:\"formTypeOptions\";a:1:{s:12:\"include_this\";b:1;}s:14:\"batchEventName\";s:48:\"mautic.lead.on_campaign_action_change_membership\";}s:5:\"addTo\";a:1:{i:0;i:9;}s:10:\"removeFrom\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new10425657978f3091f9112817a4e995fb83b0dcc7',NULL,0),
(43,8,41,'Email: Azi-19:10',NULL,'email.send','action',3,'a:31:{s:2:\"id\";i:43;s:4:\"name\";s:17:\"*Email: Azi-19:10\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:3;s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"10\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";s:2:\"no\";s:6:\"tempId\";s:43:\"newf25051dd818e9292d9b23bf0e3330d942f7af8d9\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:10;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:2:\"no\";s:15:\"anchorEventType\";s:9:\"condition\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:4:\"1203\";s:8:\"droppedY\";s:3:\"371\";}s:10:\"campaignId\";s:47:\"mautic_e1b7d8f6de18f02c8d2938b5bdc7230b46799073\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"10\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','newf25051dd818e9292d9b23bf0e3330d942f7af8d9','email',10),
(44,8,43,'Este in Camp:Vanzare sau Live?',NULL,'lead.campaigns','condition',4,'a:31:{s:2:\"id\";i:44;s:4:\"name\";s:31:\"*Este in Camp:Vanzare sau Live?\";s:11:\"description\";N;s:4:\"type\";s:14:\"lead.campaigns\";s:9:\"eventType\";s:9:\"condition\";s:5:\"order\";i:4;s:10:\"properties\";a:4:{s:9:\"campaigns\";a:1:{i:0;s:1:\"3\";}s:14:\"dataAddedLimit\";s:1:\"0\";s:4:\"expr\";s:0:\"\";s:9:\"dateAdded\";s:0:\"\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new21cf75158f524cc4dd6965dc4658ba0f0c013a85\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"504\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_e1b7d8f6de18f02c8d2938b5bdc7230b46799073\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:9:\"campaigns\";a:2:{i:0;i:9;i:1;i:10;}s:14:\"dataAddedLimit\";i:0;s:4:\"expr\";N;s:9:\"dateAdded\";N;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new21cf75158f524cc4dd6965dc4658ba0f0c013a85',NULL,0),
(45,8,44,'Sar:Adaug in Camp:Live',NULL,'campaign.jump_to_event','action',5,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"604\";s:8:\"droppedY\";s:3:\"580\";}s:4:\"name\";s:22:\"Sar:Adaug in Camp:Live\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:11:\"jumpToEvent\";s:43:\"new10425657978f3091f9112817a4e995fb83b0dcc7\";}s:4:\"type\";s:22:\"campaign.jump_to_event\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_e1b7d8f6de18f02c8d2938b5bdc7230b46799073\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"jumpToEvent\";i:42;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new4a5eef26441b19151af9b39b7bf56d2ce470427e',NULL,0),
(46,9,NULL,'Adaug în Lista:Inactivi',NULL,'lead.changelist','action',1,'a:29:{s:2:\"id\";i:46;s:4:\"name\";s:21:\"*Adaug în L:Inactivi\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:1;s:10:\"properties\";a:1:{s:10:\"addToLists\";a:1:{i:0;s:2:\"11\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new017933771e30cef0fdb84ed515701c1c00c29af1\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:10:\"leadsource\";s:15:\"anchorEventType\";s:6:\"source\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_fe89d47ee405938bcc09a68751cf60e139510a28\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"addToLists\";a:1:{i:0;i:11;}s:15:\"removeFromLists\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new017933771e30cef0fdb84ed515701c1c00c29af1',NULL,0),
(47,9,46,'A intrat Live?',NULL,'page.pagehit','decision',2,'a:30:{s:2:\"id\";i:47;s:4:\"name\";s:15:\"*A intrat Live?\";s:11:\"description\";N;s:4:\"type\";s:12:\"page.pagehit\";s:9:\"eventType\";s:8:\"decision\";s:5:\"order\";i:2;s:10:\"properties\";a:3:{s:5:\"pages\";a:1:{i:0;s:1:\"1\";}s:3:\"url\";s:0:\"\";s:7:\"referer\";s:0:\"\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";i:0;s:19:\"triggerIntervalUnit\";N;s:11:\"triggerHour\";N;s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";N;s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newa00bdb22b37aa2fc75c8ed626177ed2e67122470\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:4:\"page\";s:9:\"channelId\";i:1;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"264\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_fe89d47ee405938bcc09a68751cf60e139510a28\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"pages\";a:1:{i:0;i:1;}s:3:\"url\";N;s:7:\"referer\";N;}',NULL,0,NULL,NULL,NULL,NULL,'a:0:{}',NULL,NULL,'newa00bdb22b37aa2fc75c8ed626177ed2e67122470','page',1),
(48,9,47,'Mut în Lista:Live',NULL,'lead.changelist','action',3,'a:29:{s:2:\"id\";i:48;s:4:\"name\";s:15:\"*Mut în L:Live\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:3;s:10:\"properties\";a:2:{s:10:\"addToLists\";a:1:{i:0;s:2:\"12\";}s:15:\"removeFromLists\";a:1:{i:0;s:2:\"11\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";s:3:\"yes\";s:6:\"tempId\";s:43:\"new1c5f26197fc6682fd4b1ca6dd89e9b437d18417b\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:3:\"yes\";s:15:\"anchorEventType\";s:8:\"decision\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_fe89d47ee405938bcc09a68751cf60e139510a28\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"addToLists\";a:1:{i:0;i:12;}s:15:\"removeFromLists\";a:1:{i:0;i:11;}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new1c5f26197fc6682fd4b1ca6dd89e9b437d18417b',NULL,0),
(49,9,48,'***Adaug eticheta WG-[Data]-LIVE',NULL,'lead.changetags','action',4,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"124\";s:8:\"droppedY\";s:3:\"609\";}s:4:\"name\";s:32:\"***Adaug eticheta WG-[Data]-LIVE\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"5\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_fe89d47ee405938bcc09a68751cf60e139510a28\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:7:\"WG-LIVE\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new7f52a03e28cec313ed950a74f266bba20001ade4',NULL,0),
(50,9,49,'Mut în Camp:Vanzare',NULL,'campaign.addremovelead','action',5,'a:29:{s:2:\"id\";i:50;s:4:\"name\";s:21:\"*Mut în Camp:Vanzare\";s:11:\"description\";N;s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:5;s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newe10d829f1068446078b76c42e37beef07338cd7e\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"124\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_fe89d47ee405938bcc09a68751cf60e139510a28\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:1:{i:0;i:10;}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newe10d829f1068446078b76c42e37beef07338cd7e',NULL,0),
(51,9,47,'Inlatur din Lista:Inactivi 1ora',NULL,'lead.changelist','action',3,'a:30:{s:2:\"id\";i:51;s:4:\"name\";s:29:\"*Scot din Lista:Inactivi 1ora\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:3;s:10:\"properties\";a:1:{s:15:\"removeFromLists\";a:1:{i:0;s:2:\"11\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"h\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";s:2:\"no\";s:6:\"tempId\";s:43:\"newf5d904b07773f8d51cdc8f378b8e5ff793d21ac9\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:5:\"label\";s:10:\"în 1 oră\";s:6:\"anchor\";s:2:\"no\";s:15:\"anchorEventType\";s:8:\"decision\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:4:\"1199\";s:8:\"droppedY\";s:3:\"347\";}s:10:\"campaignId\";s:47:\"mautic_fe89d47ee405938bcc09a68751cf60e139510a28\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:15:\"removeFromLists\";a:1:{i:0;i:11;}s:10:\"addToLists\";a:0:{}}',NULL,1,'h',NULL,NULL,NULL,'a:0:{}','interval','no','newf5d904b07773f8d51cdc8f378b8e5ff793d21ac9',NULL,0),
(52,9,51,'Inlatur din Campanie',NULL,'campaign.addremovelead','action',4,'a:29:{s:2:\"id\";i:52;s:4:\"name\";s:20:\"Inlatur din campanie\";s:11:\"description\";N;s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:4;s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newc8625cb271830a7a8ed9edea6779ee139e37aace\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"356\";s:8:\"droppedY\";s:3:\"606\";}s:10:\"campaignId\";s:47:\"mautic_fe89d47ee405938bcc09a68751cf60e139510a28\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newc8625cb271830a7a8ed9edea6779ee139e37aace',NULL,0),
(53,10,NULL,'Email Prima zi dupa Webinar 1zi7:00',NULL,'email.send','action',1,'a:32:{s:2:\"id\";i:53;s:4:\"name\";s:36:\"*Email Prima zi dupa Webinar 1zi7:00\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:1;s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"11\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new568732e46880c4ef96dc68aad79d13336ed46986\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:11;s:7:\"changes\";a:0:{}s:5:\"label\";s:15:\"aşteaptă 1 zi\";s:6:\"anchor\";s:10:\"leadsource\";s:15:\"anchorEventType\";s:6:\"source\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"11\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'new568732e46880c4ef96dc68aad79d13336ed46986','email',11),
(54,10,53,'Email A 2-a zi dupa Webinar 1zi7:00',NULL,'email.send','action',2,'a:32:{s:2:\"id\";i:54;s:4:\"name\";s:36:\"*Email A 2-a zi dupa Webinar 1zi7:00\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:2;s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"12\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newfa7c7b9bc8dcc19b97bb1d80e4b1e7e8e4a21d7c\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:12;s:7:\"changes\";a:0:{}s:5:\"label\";s:15:\"aşteaptă 1 zi\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"12\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'newfa7c7b9bc8dcc19b97bb1d80e4b1e7e8e4a21d7c','email',12),
(55,10,54,'Email A 3-a zi Dimineata 1zi7:00',NULL,'email.send','action',3,'a:32:{s:2:\"id\";i:55;s:4:\"name\";s:33:\"*Email A 3-a zi Dimineata 1zi7:00\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:3;s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"13\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new6c993eb7e515b273124a5145620c1367c5880142\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:13;s:7:\"changes\";a:0:{}s:5:\"label\";s:15:\"aşteaptă 1 zi\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"13\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'new6c993eb7e515b273124a5145620c1367c5880142','email',13),
(56,10,55,'Email a 3-a zi Seara 0zi19:00',NULL,'email.send','action',4,'a:32:{s:2:\"id\";i:56;s:4:\"name\";s:30:\"*Email a 3-a zi Seara 0zi19:00\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:4;s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"14\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"19:00\";s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newaa64bae4e198a1ec7860a9c78db7dd34053d49cf\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:14;s:7:\"changes\";a:0:{}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:3:\"609\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"14\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,0,'d','19:00:00',NULL,NULL,'a:0:{}','interval',NULL,'newaa64bae4e198a1ec7860a9c78db7dd34053d49cf','email',14),
(57,10,56,'Email a 4-a zi Dimineata 1zi7:00',NULL,'email.send','action',5,'a:32:{s:2:\"id\";i:57;s:4:\"name\";s:33:\"*Email a 4-a zi Dimineata 1zi7:00\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:5;s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"15\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"newe4fcbdcbebc9811eb4c75792bb06431e140eaa55\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:15;s:7:\"changes\";a:0:{}s:5:\"label\";s:15:\"aşteaptă 1 zi\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:3:\"595\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"15\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'newe4fcbdcbebc9811eb4c75792bb06431e140eaa55','email',15),
(58,10,57,'Email a 4-a zi Seara 0zi19:00',NULL,'email.send','action',6,'a:32:{s:2:\"id\";i:58;s:4:\"name\";s:30:\"*Email a 4-a zi Seara 0zi19:00\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:6;s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"16\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"0\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"19:00\";s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new469b33bb91a452ca909b14e595e82f790d1d0890\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:16;s:7:\"changes\";a:0:{}s:5:\"label\";s:17:\"aşteaptă 0 zile\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:4:\"1020\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"16\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,0,'d','19:00:00',NULL,NULL,'a:0:{}','interval',NULL,'new469b33bb91a452ca909b14e595e82f790d1d0890','email',16),
(59,10,58,'Email a 5-a zi 1zi7:20',NULL,'email.send','action',7,'a:33:{s:2:\"id\";s:43:\"new6b0d7da4f010c49a56e72e687ce03d170d015ed9\";s:4:\"name\";s:23:\"*Email a 5-a zi 1zi7:20\";s:11:\"description\";N;s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:7;s:10:\"properties\";a:4:{s:5:\"email\";s:3:\"new\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:20\";s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new6b0d7da4f010c49a56e72e687ce03d170d015ed9\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";s:5:\"email\";s:9:\"channelId\";i:17;s:7:\"changes\";a:0:{}s:5:\"label\";s:15:\"aşteaptă 1 zi\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:3:\"805\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:8:{s:5:\"label\";s:13:\"Trimite email\";s:11:\"description\";s:35:\"Trimite emailul selectat la contact\";s:14:\"batchEventName\";s:37:\"mautic.email.on_campaign_batch_action\";s:8:\"formType\";s:42:\"Mautic\\EmailBundle\\Form\\Type\\EmailSendType\";s:15:\"formTypeOptions\";a:2:{s:13:\"update_select\";s:30:\"campaignevent_properties_email\";s:16:\"with_email_types\";b:1;}s:9:\"formTheme\";s:41:\"MauticEmailBundle:FormTheme\\EmailSendList\";s:7:\"channel\";s:5:\"email\";s:14:\"channelIdField\";s:5:\"email\";}s:5:\"email\";s:2:\"17\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:20:00',NULL,NULL,'a:0:{}','interval',NULL,'new6b0d7da4f010c49a56e72e687ce03d170d015ed9','email',17),
(60,10,59,'Scot din Lista:Live 4h',NULL,'lead.changelist','action',8,'a:30:{s:2:\"id\";i:60;s:4:\"name\";s:19:\"*Scot din L:Live 4h\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:8;s:10:\"properties\";a:1:{s:15:\"removeFromLists\";a:1:{i:0;s:2:\"12\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"4\";s:19:\"triggerIntervalUnit\";s:1:\"h\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:8:\"interval\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new51c8b15ba33ba42ad4479722efcde0591aaeb032\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:0:{}s:5:\"label\";s:16:\"aşteaptă 4 ore\";s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:4:\"1068\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:15:\"removeFromLists\";a:1:{i:0;i:12;}s:10:\"addToLists\";a:0:{}}',NULL,4,'h',NULL,NULL,NULL,'a:0:{}','interval',NULL,'new51c8b15ba33ba42ad4479722efcde0591aaeb032',NULL,0),
(61,10,60,'Inlatur din Campanie',NULL,'campaign.addremovelead','action',9,'a:29:{s:2:\"id\";i:61;s:4:\"name\";s:22:\"Înlătur din campanie\";s:11:\"description\";N;s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:9;s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:43:\"new9f99dadf3cd26e81109df4c4715a2ea98a09aacc\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";i:0;s:7:\"changes\";a:0:{}s:6:\"anchor\";s:6:\"bottom\";s:15:\"anchorEventType\";s:6:\"action\";s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"206\";s:8:\"droppedY\";s:4:\"1068\";}s:10:\"campaignId\";s:47:\"mautic_de036f25feadef2563f8e782c2fbd9edfb87a230\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new9f99dadf3cd26e81109df4c4715a2ea98a09aacc',NULL,0),
(62,10,NULL,'Adaug 2 puncte',NULL,'lead.changepoints','action',1,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:4:\"1115\";}s:4:\"name\";s:14:\"Adaug 2 puncte\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:1:{s:6:\"points\";s:1:\"2\";}s:4:\"type\";s:17:\"lead.changepoints\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:2:\"10\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:6:\"points\";i:2;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new681e7886527cb291db394ff6e402d2982e1bb7d2',NULL,0),
(63,11,NULL,'Este un Robot?',NULL,'lead.field_value','condition',1,'a:20:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"707\";s:8:\"droppedY\";s:3:\"155\";}s:4:\"name\";s:14:\"Este un Robot?\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:2:{s:5:\"field\";s:7:\"capcana\";s:8:\"operator\";s:6:\"!empty\";}s:4:\"type\";s:16:\"lead.field_value\";s:9:\"eventType\";s:9:\"condition\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"field\";s:7:\"capcana\";s:8:\"operator\";s:6:\"!empty\";s:5:\"value\";N;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new1',NULL,0),
(64,11,63,'Adaug Eticheta Robot',NULL,'lead.changetags','action',2,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"348\";}s:4:\"name\";s:20:\"Adaug Eticheta Robot\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"3\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:7:\"Z-Robot\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new2',NULL,0),
(65,11,63,'Are email valid?',NULL,'email.validate.address','condition',2,'a:0:{}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new5',NULL,0),
(66,11,64,'Robot:Adaug Nu-Contacta',NULL,'lead.adddnc','action',3,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"453\";}s:4:\"name\";s:23:\"Robot:Adaug Nu-Contacta\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:2:{s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:5:\"ROBOT\";}s:4:\"type\";s:11:\"lead.adddnc\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:5:\"ROBOT\";}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new3',NULL,0),
(67,11,65,'Adaug Eticheta Email-Invalid',NULL,'lead.changetags','action',3,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"348\";}s:4:\"name\";s:28:\"Adaug Eticheta Email-Invalid\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"2\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:15:\"Z-Email-Invalid\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new6',NULL,0),
(68,11,65,'Set Owner: ###SENDER_FIRSTNAME###',NULL,'lead.changeowner','action',3,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:0:\"\";s:8:\"droppedY\";s:0:\"\";}s:4:\"name\";s:16:\"Set Owner: ###SENDER_FIRSTNAME###\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:2:{s:5:\"owner\";s:1:\"1\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}}s:4:\"type\";s:16:\"lead.changeowner\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:1:\"1\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:5:\"owner\";i:1;s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new11',NULL,0),
(69,11,66,'Robot:Înlătur din campanie',NULL,'campaign.addremovelead','action',4,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:3:\"558\";}s:4:\"name\";s:28:\"Robot:Înlătur din campanie\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new4',NULL,0),
(70,11,67,'Email invalid:Adaug Nu-Contacta',NULL,'lead.adddnc','action',4,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"453\";}s:4:\"name\";s:31:\"Email invalid:Adaug Nu-Contacta\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:2:{s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:13:\"Email invalid\";}s:4:\"type\";s:11:\"lead.adddnc\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"channels\";a:1:{i:0;s:5:\"email\";}s:6:\"reason\";s:13:\"Email invalid\";}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new7',NULL,0),
(71,11,68,'Primeste deja materialul?',NULL,'lead.segments','condition',4,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"538\";s:8:\"droppedY\";s:3:\"674\";}s:4:\"name\";s:25:\"Primeste deja materialul?\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:8:\"segments\";a:1:{i:0;s:2:\"13\";}}s:4:\"type\";s:13:\"lead.segments\";s:9:\"eventType\";s:9:\"condition\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"segments\";a:1:{i:0;i:13;}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newca214c2e313d998bcb4109b2043f0016a559d831',NULL,0),
(72,11,70,'Email invalid:Înlătur din campanie',NULL,'campaign.addremovelead','action',5,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"478\";s:8:\"droppedY\";s:3:\"558\";}s:4:\"name\";s:36:\"Email invalid:Înlătur din campanie\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new8',NULL,0),
(73,11,71,'Email Deja inscris',NULL,'email.send','action',5,'a:21:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"10\";s:8:\"droppedY\";s:4:\"1115\";}s:4:\"name\";s:18:\"Email Deja inscris\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"23\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:2:\"23\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','yes','new65977176e8456ce84aed141eff47f5d586e698df','email',23),
(74,11,71,'Adaug în Lista:SE-Automatizare/Funnel',NULL,'lead.changelist','action',5,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:4:\"1203\";s:8:\"droppedY\";s:3:\"228\";}s:4:\"name\";s:38:\"Adaug în Lista:SE-Automatizare/Funnel\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:10:\"addToLists\";a:1:{i:0;s:2:\"13\";}}s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"addToLists\";a:1:{i:0;i:13;}s:15:\"removeFromLists\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','newaeb9bd79eed9036c510f78ed9784813464b6b658',NULL,0),
(75,11,71,'Email 01',NULL,'email.send','action',5,'a:25:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:4:\"1203\";s:8:\"droppedY\";s:3:\"228\";}s:4:\"name\";s:8:\"Email 01\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"18\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:8:{s:5:\"label\";s:13:\"Trimite email\";s:11:\"description\";s:35:\"Trimite emailul selectat la contact\";s:14:\"batchEventName\";s:37:\"mautic.email.on_campaign_batch_action\";s:8:\"formType\";s:42:\"Mautic\\EmailBundle\\Form\\Type\\EmailSendType\";s:15:\"formTypeOptions\";a:2:{s:13:\"update_select\";s:30:\"campaignevent_properties_email\";s:16:\"with_email_types\";b:1;}s:9:\"formTheme\";s:41:\"MauticEmailBundle:FormTheme\\EmailSendList\";s:7:\"channel\";s:5:\"email\";s:14:\"channelIdField\";s:5:\"email\";}s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:6:\"tempId\";s:43:\"new8b1f2920cee04e56e932360164da2497c447e8b1\";s:2:\"id\";s:43:\"new8b1f2920cee04e56e932360164da2497c447e8b1\";s:5:\"email\";s:2:\"18\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate','no','new8b1f2920cee04e56e932360164da2497c447e8b1','email',18),
(76,11,74,'Adaug Eticheta SE-Automatizare/Funnel',NULL,'lead.changetags','action',6,'a:30:{s:2:\"id\";s:4:\"new9\";s:4:\"name\";s:28:\"Introdu aici acţiunile TALE\";s:11:\"description\";N;s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:5:\"order\";i:4;s:10:\"properties\";a:1:{s:11:\"remove_tags\";a:1:{i:0;s:1:\"1\";}}s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:11:\"triggerMode\";s:9:\"immediate\";s:12:\"decisionPath\";N;s:6:\"tempId\";s:4:\"new9\";s:10:\"contactLog\";a:0:{}s:7:\"channel\";N;s:9:\"channelId\";N;s:7:\"changes\";a:2:{s:6:\"tempId\";a:2:{i:0;N;i:1;s:4:\"new9\";}s:6:\"parent\";a:2:{i:0;i:11;i:1;N;}}s:6:\"anchor\";s:3:\"yes\";s:15:\"anchorEventType\";s:9:\"condition\";s:8:\"settings\";a:4:{s:5:\"label\";s:32:\"Modifică etichetele contactului\";s:11:\"description\";s:46:\"Adaugă sau înlătură etichete de la contact\";s:8:\"formType\";s:46:\"Mautic\\LeadBundle\\Form\\Type\\ModifyLeadTagsType\";s:9:\"eventName\";s:38:\"mautic.lead.on_campaign_trigger_action\";}s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"238\";s:8:\"droppedY\";s:3:\"348\";}s:10:\"campaignId\";s:47:\"mautic_2407d5f64a1c470e8314e8e7eb146e05b818d8a9\";s:6:\"_token\";s:43:\"kcCOmBn0YbCXiNR-HfWz8tY7EeFSt829q3DZ0VGn_nY\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:11:\"remove_tags\";a:0:{}s:8:\"add_tags\";a:1:{i:0;s:22:\"SE-Automatizare/Funnel\";}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new9',NULL,0),
(77,11,75,'Email 02 1zi07:00',NULL,'email.send','action',6,'a:25:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"680\";s:8:\"droppedY\";s:3:\"674\";}s:4:\"name\";s:17:\"Email 02 1zi07:00\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"19\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:8:{s:5:\"label\";s:13:\"Trimite email\";s:11:\"description\";s:35:\"Trimite emailul selectat la contact\";s:14:\"batchEventName\";s:37:\"mautic.email.on_campaign_batch_action\";s:8:\"formType\";s:42:\"Mautic\\EmailBundle\\Form\\Type\\EmailSendType\";s:15:\"formTypeOptions\";a:2:{s:13:\"update_select\";s:30:\"campaignevent_properties_email\";s:16:\"with_email_types\";b:1;}s:9:\"formTheme\";s:41:\"MauticEmailBundle:FormTheme\\EmailSendList\";s:7:\"channel\";s:5:\"email\";s:14:\"channelIdField\";s:5:\"email\";}s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:6:\"tempId\";s:43:\"newb977d4def10eaba7ad37b4891b36cce275f28b81\";s:2:\"id\";s:43:\"newb977d4def10eaba7ad37b4891b36cce275f28b81\";s:5:\"email\";s:2:\"19\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'newb977d4def10eaba7ad37b4891b36cce275f28b81','email',19),
(78,11,77,'Email 03 1zi07:00',NULL,'email.send','action',7,'a:25:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"680\";s:8:\"droppedY\";s:3:\"678\";}s:4:\"name\";s:17:\"Email 03 1zi07:00\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"20\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:8:{s:5:\"label\";s:13:\"Trimite email\";s:11:\"description\";s:35:\"Trimite emailul selectat la contact\";s:14:\"batchEventName\";s:37:\"mautic.email.on_campaign_batch_action\";s:8:\"formType\";s:42:\"Mautic\\EmailBundle\\Form\\Type\\EmailSendType\";s:15:\"formTypeOptions\";a:2:{s:13:\"update_select\";s:30:\"campaignevent_properties_email\";s:16:\"with_email_types\";b:1;}s:9:\"formTheme\";s:41:\"MauticEmailBundle:FormTheme\\EmailSendList\";s:7:\"channel\";s:5:\"email\";s:14:\"channelIdField\";s:5:\"email\";}s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:6:\"tempId\";s:43:\"newc922fa62a6476f45b7a3d27209b57a3ab214a18a\";s:2:\"id\";s:43:\"newc922fa62a6476f45b7a3d27209b57a3ab214a18a\";s:5:\"email\";s:2:\"20\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'newc922fa62a6476f45b7a3d27209b57a3ab214a18a','email',20),
(79,11,78,'Email 04 1zi07:00',NULL,'email.send','action',8,'a:25:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"680\";s:8:\"droppedY\";s:3:\"678\";}s:4:\"name\";s:17:\"Email 04 1zi07:00\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"21\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:8:{s:5:\"label\";s:13:\"Trimite email\";s:11:\"description\";s:35:\"Trimite emailul selectat la contact\";s:14:\"batchEventName\";s:37:\"mautic.email.on_campaign_batch_action\";s:8:\"formType\";s:42:\"Mautic\\EmailBundle\\Form\\Type\\EmailSendType\";s:15:\"formTypeOptions\";a:2:{s:13:\"update_select\";s:30:\"campaignevent_properties_email\";s:16:\"with_email_types\";b:1;}s:9:\"formTheme\";s:41:\"MauticEmailBundle:FormTheme\\EmailSendList\";s:7:\"channel\";s:5:\"email\";s:14:\"channelIdField\";s:5:\"email\";}s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:6:\"tempId\";s:43:\"newc9199efc5cbd60a03cf10a84008995ddf8a25102\";s:2:\"id\";s:43:\"newc9199efc5cbd60a03cf10a84008995ddf8a25102\";s:5:\"email\";s:2:\"21\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'newc9199efc5cbd60a03cf10a84008995ddf8a25102','email',21),
(80,11,79,'Email 05 1zi07:00',NULL,'email.send','action',9,'a:25:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"680\";s:8:\"droppedY\";s:3:\"785\";}s:4:\"name\";s:17:\"Email 05 1zi07:00\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:5:\"07:00\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:4:{s:5:\"email\";s:2:\"22\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:8:{s:5:\"label\";s:13:\"Trimite email\";s:11:\"description\";s:35:\"Trimite emailul selectat la contact\";s:14:\"batchEventName\";s:37:\"mautic.email.on_campaign_batch_action\";s:8:\"formType\";s:42:\"Mautic\\EmailBundle\\Form\\Type\\EmailSendType\";s:15:\"formTypeOptions\";a:2:{s:13:\"update_select\";s:30:\"campaignevent_properties_email\";s:16:\"with_email_types\";b:1;}s:9:\"formTheme\";s:41:\"MauticEmailBundle:FormTheme\\EmailSendList\";s:7:\"channel\";s:5:\"email\";s:14:\"channelIdField\";s:5:\"email\";}s:26:\"triggerRestrictedStartHour\";N;s:25:\"triggerRestrictedStopHour\";N;s:27:\"triggerRestrictedDaysOfWeek\";a:0:{}s:6:\"tempId\";s:43:\"new17f2099e8400e5ab83a0966edec18182b228f37b\";s:2:\"id\";s:43:\"new17f2099e8400e5ab83a0966edec18182b228f37b\";s:5:\"email\";s:2:\"22\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','07:00:00',NULL,NULL,'a:0:{}','interval',NULL,'new17f2099e8400e5ab83a0966edec18182b228f37b','email',22),
(81,11,80,'Scot din Lista 1h',NULL,'lead.changelist','action',10,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"680\";s:8:\"droppedY\";s:3:\"757\";}s:4:\"name\";s:17:\"Scot din Lista 1h\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"h\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:15:\"removeFromLists\";a:1:{i:0;s:2:\"13\";}}s:4:\"type\";s:15:\"lead.changelist\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:15:\"removeFromLists\";a:1:{i:0;i:13;}s:10:\"addToLists\";a:0:{}}',NULL,1,'h',NULL,NULL,NULL,'a:0:{}','interval',NULL,'new25b93d93f88527964e08aaf0813c66f750ea0f31',NULL,0),
(82,11,81,'Inlatur din Campanie',NULL,'campaign.addremovelead','action',11,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"680\";s:8:\"droppedY\";s:3:\"862\";}s:4:\"name\";s:20:\"Inlatur din Campanie\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}}s:4:\"type\";s:22:\"campaign.addremovelead\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_4bfbfa067c8b39fb86db52447c551f6da6e90bfd\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:10:\"removeFrom\";a:1:{i:0;s:4:\"this\";}s:5:\"addTo\";a:0:{}}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'new09b2b82f7a07f97cacd8b01d938d033d5ccdb01d',NULL,0),
(83,11,76,'Adaug 2 puncte',NULL,'lead.changepoints','action',7,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"898\";s:8:\"droppedY\";s:3:\"416\";}s:4:\"name\";s:14:\"Adaug 2 puncte\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:11:\"triggerHour\";s:0:\"\";s:26:\"triggerRestrictedStartHour\";s:0:\"\";s:25:\"triggerRestrictedStopHour\";s:0:\"\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:6:\"points\";s:1:\"2\";}s:4:\"type\";s:17:\"lead.changepoints\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:2:\"11\";s:6:\"_token\";s:43:\"RypM3SQtM5gvWnEwVKjgAuNRXym-gBzf2ApeB78fRDU\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:6:\"points\";i:2;}',NULL,1,'d',NULL,NULL,NULL,'a:0:{}','immediate',NULL,'newb878f2ff9d3d496047c8c8cbefc6f24713b30c9f',NULL,NULL);
/*!40000 ALTER TABLE `campaign_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_form_xref`
--

DROP TABLE IF EXISTS `campaign_form_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_form_xref` (
  `campaign_id` int(10) unsigned NOT NULL,
  `form_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`campaign_id`,`form_id`),
  KEY `IDX_3048A8B25FF69B7D` (`form_id`),
  CONSTRAINT `FK_3048A8B25FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3048A8B2F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_form_xref`
--

LOCK TABLES `campaign_form_xref` WRITE;
/*!40000 ALTER TABLE `campaign_form_xref` DISABLE KEYS */;
INSERT INTO `campaign_form_xref` VALUES
(1,1),
(4,2),
(4,3),
(9,1),
(10,1),
(11,4),
(11,5);
/*!40000 ALTER TABLE `campaign_form_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_lead_event_failed_log`
--

DROP TABLE IF EXISTS `campaign_lead_event_failed_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_lead_event_failed_log` (
  `log_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `reason` longtext DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `campaign_event_failed_date` (`date_added`),
  CONSTRAINT `FK_E50614D2EA675D86` FOREIGN KEY (`log_id`) REFERENCES `campaign_lead_event_log` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_lead_event_failed_log`
--

LOCK TABLES `campaign_lead_event_failed_log` WRITE;
/*!40000 ALTER TABLE `campaign_lead_event_failed_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_lead_event_failed_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_lead_event_log`
--

DROP TABLE IF EXISTS `campaign_lead_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_lead_event_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `campaign_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `rotation` int(11) NOT NULL,
  `date_triggered` datetime DEFAULT NULL,
  `is_scheduled` tinyint(1) NOT NULL,
  `trigger_date` datetime DEFAULT NULL,
  `system_triggered` tinyint(1) NOT NULL,
  `metadata` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `channel` varchar(191) DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `non_action_path_taken` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `campaign_rotation` (`event_id`,`lead_id`,`rotation`),
  KEY `IDX_B7420BA171F7E88B` (`event_id`),
  KEY `IDX_B7420BA155458D` (`lead_id`),
  KEY `IDX_B7420BA1F639F774` (`campaign_id`),
  KEY `IDX_B7420BA1A03F5E9F` (`ip_id`),
  KEY `campaign_event_upcoming_search` (`is_scheduled`,`lead_id`),
  KEY `campaign_event_schedule_counts` (`campaign_id`,`is_scheduled`,`trigger_date`),
  KEY `campaign_date_triggered` (`date_triggered`),
  KEY `campaign_leads` (`lead_id`,`campaign_id`,`rotation`),
  KEY `campaign_log_channel` (`channel`,`channel_id`,`lead_id`),
  KEY `campaign_actions` (`campaign_id`,`event_id`,`date_triggered`),
  KEY `campaign_stats` (`campaign_id`,`date_triggered`,`event_id`,`non_action_path_taken`),
  KEY `campaign_trigger_date_order` (`trigger_date`),
  CONSTRAINT `FK_B7420BA155458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B7420BA171F7E88B` FOREIGN KEY (`event_id`) REFERENCES `campaign_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B7420BA1A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_B7420BA1F639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_lead_event_log`
--

LOCK TABLES `campaign_lead_event_log` WRITE;
/*!40000 ALTER TABLE `campaign_lead_event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_lead_event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_leadlist_xref`
--

DROP TABLE IF EXISTS `campaign_leadlist_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_leadlist_xref` (
  `campaign_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`campaign_id`,`leadlist_id`),
  KEY `IDX_6480052EB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_6480052EB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6480052EF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_leadlist_xref`
--

LOCK TABLES `campaign_leadlist_xref` WRITE;
/*!40000 ALTER TABLE `campaign_leadlist_xref` DISABLE KEYS */;
INSERT INTO `campaign_leadlist_xref` VALUES
(2,1),
(3,2),
(5,7),
(6,8),
(7,9),
(8,10);
/*!40000 ALTER TABLE `campaign_leadlist_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_leads`
--

DROP TABLE IF EXISTS `campaign_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_leads` (
  `campaign_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  `date_last_exited` datetime DEFAULT NULL,
  `rotation` int(11) NOT NULL,
  PRIMARY KEY (`campaign_id`,`lead_id`),
  KEY `IDX_5995213D55458D` (`lead_id`),
  KEY `campaign_leads_date_added` (`date_added`),
  KEY `campaign_leads_date_exited` (`date_last_exited`),
  KEY `campaign_leads` (`campaign_id`,`manually_removed`,`lead_id`,`rotation`),
  CONSTRAINT `FK_5995213D55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_5995213DF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_leads`
--

LOCK TABLES `campaign_leads` WRITE;
/*!40000 ALTER TABLE `campaign_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_summary`
--

DROP TABLE IF EXISTS `campaign_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_summary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned DEFAULT NULL,
  `event_id` int(10) unsigned NOT NULL,
  `date_triggered` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  `scheduled_count` int(11) NOT NULL,
  `triggered_count` int(11) NOT NULL,
  `non_action_path_taken_count` int(11) NOT NULL,
  `failed_count` int(11) NOT NULL,
  `log_counts_processed` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `campaign_event_date_triggered` (`campaign_id`,`event_id`,`date_triggered`),
  KEY `IDX_6692FA4FF639F774` (`campaign_id`),
  KEY `IDX_6692FA4F71F7E88B` (`event_id`),
  CONSTRAINT `FK_6692FA4F71F7E88B` FOREIGN KEY (`event_id`) REFERENCES `campaign_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6692FA4FF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_summary`
--

LOCK TABLES `campaign_summary` WRITE;
/*!40000 ALTER TABLE `campaign_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `canvas_settings` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `allow_restart` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E373747012469DE2` (`category_id`),
  CONSTRAINT `FK_E373747012469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES
(1,NULL,0,'2024-03-06 19:04:14',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:55:30',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Z1-Sablon','<p>Folosim această campanie ca un şablon (nu o modific, ci creez o clonă) sau ca inspiraţie pentru înscrierile prin formulare.</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:11:{i:0;a:3:{s:2:\"id\";s:1:\"1\";s:9:\"positionX\";s:3:\"259\";s:9:\"positionY\";s:3:\"130\";}i:1;a:3:{s:2:\"id\";s:1:\"2\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"348\";}i:2;a:3:{s:2:\"id\";s:1:\"5\";s:9:\"positionX\";s:3:\"258\";s:9:\"positionY\";s:3:\"250\";}i:3;a:3:{s:2:\"id\";s:1:\"3\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"453\";}i:4;a:3:{s:2:\"id\";s:1:\"6\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"347\";}i:5;a:3:{s:2:\"id\";s:1:\"9\";s:9:\"positionX\";s:3:\"538\";s:9:\"positionY\";s:3:\"129\";}i:6;a:3:{s:2:\"id\";s:1:\"4\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"558\";}i:7;a:3:{s:2:\"id\";s:1:\"7\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"454\";}i:8;a:3:{s:2:\"id\";s:1:\"8\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"558\";}i:9;a:3:{s:2:\"id\";s:2:\"11\";s:9:\"positionX\";s:3:\"538\";s:9:\"positionY\";s:2:\"31\";}i:10;a:3:{s:2:\"id\";s:5:\"forms\";s:9:\"positionX\";s:3:\"259\";s:9:\"positionY\";s:2:\"32\";}}s:11:\"connections\";a:10:{i:0;a:3:{s:8:\"sourceId\";s:5:\"forms\";s:8:\"targetId\";s:1:\"1\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:1:\"1\";s:8:\"targetId\";s:1:\"2\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:1:\"2\";s:8:\"targetId\";s:1:\"3\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:3;a:3:{s:8:\"sourceId\";s:1:\"3\";s:8:\"targetId\";s:1:\"4\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:4;a:3:{s:8:\"sourceId\";s:1:\"1\";s:8:\"targetId\";s:1:\"5\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:5;a:3:{s:8:\"sourceId\";s:1:\"5\";s:8:\"targetId\";s:1:\"6\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:6;a:3:{s:8:\"sourceId\";s:1:\"6\";s:8:\"targetId\";s:1:\"7\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:7;a:3:{s:8:\"sourceId\";s:1:\"7\";s:8:\"targetId\";s:1:\"8\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:8;a:3:{s:8:\"sourceId\";s:1:\"5\";s:8:\"targetId\";s:2:\"11\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:9;a:3:{s:8:\"sourceId\";s:2:\"11\";s:8:\"targetId\";s:1:\"9\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}}}',0),
(2,NULL,1,'2024-03-06 19:06:30',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:56:00',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Z9-Şterge Contactele Anonime (S)','<p>Şterg contactele din lista Z0-ContacteAnonime imediat ce intră în listă</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:2:{i:0;a:3:{s:2:\"id\";s:2:\"10\";s:9:\"positionX\";s:3:\"707\";s:9:\"positionY\";s:3:\"155\";}i:1;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:3:\"807\";s:9:\"positionY\";s:2:\"50\";}}s:11:\"connections\";a:1:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:2:\"10\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}}}',0),
(3,NULL,1,'2024-04-20 10:10:41',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:10:41',NULL,NULL,NULL,NULL,NULL,'Z1-Scot Dezabonatii din Segmente si Campanii (S)','<p>adaug doar segmentele statice si campaniile de formulare<br /></p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:2:{i:0;a:3:{s:2:\"id\";s:2:\"12\";s:9:\"positionX\";s:3:\"860\";s:9:\"positionY\";s:3:\"165\";}i:1;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:3:\"860\";s:9:\"positionY\";s:2:\"50\";}}s:11:\"connections\";a:1:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:2:\"12\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}}}',0),
(4,1,1,'2024-04-20 10:24:11',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:21:14',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-1-Inscriere ***','<p><span style=\"color: rgb(184, 49, 47);\">*** Aici este nevoie de actualizat data noului webinar in format AAAA-LL-ZZ (ex. 2024-05-20). <strong>Si eticheta.</strong></span></p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:19:{i:0;a:3:{s:2:\"id\";s:2:\"13\";s:9:\"positionX\";s:3:\"259\";s:9:\"positionY\";s:3:\"130\";}i:1;a:3:{s:2:\"id\";s:2:\"14\";s:9:\"positionX\";s:2:\"24\";s:9:\"positionY\";s:3:\"130\";}i:2;a:3:{s:2:\"id\";s:2:\"15\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"348\";}i:3;a:3:{s:2:\"id\";s:2:\"16\";s:9:\"positionX\";s:3:\"258\";s:9:\"positionY\";s:3:\"250\";}i:4;a:3:{s:2:\"id\";s:2:\"17\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"453\";}i:5;a:3:{s:2:\"id\";s:2:\"18\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"347\";}i:6;a:3:{s:2:\"id\";s:2:\"19\";s:9:\"positionX\";s:3:\"504\";s:9:\"positionY\";s:2:\"33\";}i:7;a:3:{s:2:\"id\";s:2:\"20\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"454\";}i:8;a:3:{s:2:\"id\";s:2:\"21\";s:9:\"positionX\";s:3:\"504\";s:9:\"positionY\";s:3:\"130\";}i:9;a:3:{s:2:\"id\";s:2:\"22\";s:9:\"positionX\";s:3:\"501\";s:9:\"positionY\";s:3:\"249\";}i:10;a:3:{s:2:\"id\";s:2:\"23\";s:9:\"positionX\";s:3:\"742\";s:9:\"positionY\";s:2:\"34\";}i:11;a:3:{s:2:\"id\";s:2:\"24\";s:9:\"positionX\";s:3:\"742\";s:9:\"positionY\";s:3:\"129\";}i:12;a:3:{s:2:\"id\";s:2:\"25\";s:9:\"positionX\";s:3:\"735\";s:9:\"positionY\";s:3:\"249\";}i:13;a:3:{s:2:\"id\";s:2:\"26\";s:9:\"positionX\";s:3:\"963\";s:9:\"positionY\";s:3:\"248\";}i:14;a:3:{s:2:\"id\";s:2:\"27\";s:9:\"positionX\";s:3:\"735\";s:9:\"positionY\";s:3:\"342\";}i:15;a:3:{s:2:\"id\";s:2:\"28\";s:9:\"positionX\";s:3:\"963\";s:9:\"positionY\";s:3:\"342\";}i:16;a:3:{s:2:\"id\";s:2:\"29\";s:9:\"positionX\";s:3:\"735\";s:9:\"positionY\";s:3:\"437\";}i:17;a:3:{s:2:\"id\";s:2:\"30\";s:9:\"positionX\";s:3:\"735\";s:9:\"positionY\";s:3:\"522\";}i:18;a:3:{s:2:\"id\";s:5:\"forms\";s:9:\"positionX\";s:3:\"259\";s:9:\"positionY\";s:2:\"32\";}}s:11:\"connections\";a:18:{i:0;a:3:{s:8:\"sourceId\";s:5:\"forms\";s:8:\"targetId\";s:2:\"13\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"13\";s:8:\"targetId\";s:2:\"15\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:2:\"15\";s:8:\"targetId\";s:2:\"17\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:3;a:3:{s:8:\"sourceId\";s:2:\"13\";s:8:\"targetId\";s:2:\"16\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:4;a:3:{s:8:\"sourceId\";s:2:\"16\";s:8:\"targetId\";s:2:\"18\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:5;a:3:{s:8:\"sourceId\";s:2:\"18\";s:8:\"targetId\";s:2:\"20\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:6;a:3:{s:8:\"sourceId\";s:2:\"16\";s:8:\"targetId\";s:2:\"19\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:7;a:3:{s:8:\"sourceId\";s:2:\"21\";s:8:\"targetId\";s:2:\"22\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:8;a:3:{s:8:\"sourceId\";s:5:\"forms\";s:8:\"targetId\";s:2:\"14\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:9;a:3:{s:8:\"sourceId\";s:2:\"19\";s:8:\"targetId\";s:2:\"21\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:10;a:3:{s:8:\"sourceId\";s:2:\"21\";s:8:\"targetId\";s:2:\"23\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:11;a:3:{s:8:\"sourceId\";s:2:\"23\";s:8:\"targetId\";s:2:\"24\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:12;a:3:{s:8:\"sourceId\";s:2:\"24\";s:8:\"targetId\";s:2:\"25\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:13;a:3:{s:8:\"sourceId\";s:2:\"24\";s:8:\"targetId\";s:2:\"26\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:14;a:3:{s:8:\"sourceId\";s:2:\"26\";s:8:\"targetId\";s:2:\"28\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:15;a:3:{s:8:\"sourceId\";s:2:\"25\";s:8:\"targetId\";s:2:\"27\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:16;a:3:{s:8:\"sourceId\";s:2:\"27\";s:8:\"targetId\";s:2:\"29\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:17;a:3:{s:8:\"sourceId\";s:2:\"29\";s:8:\"targetId\";s:2:\"30\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}}}',1),
(5,1,1,'2024-04-20 10:26:59',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:54:34',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'WG-2-Cu 7 zile inainte de Webinar (S)','<p>Celor de aici va fi trimis emailul cu 7 zile inainte de webinar</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:3:{i:0;a:3:{s:2:\"id\";s:2:\"31\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"151\";}i:1;a:3:{s:2:\"id\";s:2:\"32\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"265\";}i:2;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:2:\"38\";}}s:11:\"connections\";a:2:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:2:\"31\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"31\";s:8:\"targetId\";s:2:\"32\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}}}',1),
(6,1,1,'2024-04-20 10:27:34',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:54:33',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-3-Cu 3 zile inainte de Webinar (S)','<p>Celor de aici va fi trimis emailul cu 3 zile inainte de webinar</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:3:{i:0;a:3:{s:2:\"id\";s:2:\"33\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"151\";}i:1;a:3:{s:2:\"id\";s:2:\"34\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"265\";}i:2;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:2:\"38\";}}s:11:\"connections\";a:2:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:2:\"33\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"33\";s:8:\"targetId\";s:2:\"34\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}}}',1),
(7,1,1,'2024-04-20 10:28:38',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:54:32',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-4-Cu o zi inainte de Webinar (S)','<p>Celor de aici va fi trimis emailul cu o zi inainte de webinar</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:3:{i:0;a:3:{s:2:\"id\";s:2:\"35\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"151\";}i:1;a:3:{s:2:\"id\";s:2:\"36\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"265\";}i:2;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:2:\"38\";}}s:11:\"connections\";a:2:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:2:\"35\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"35\";s:8:\"targetId\";s:2:\"36\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}}}',1),
(8,1,1,'2024-04-20 10:37:51',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:01:01',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-5-In ziua Webinarului (S)','<p>Trimite emailurile din ziua webinarului</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:10:{i:0;a:3:{s:2:\"id\";s:2:\"37\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"151\";}i:1;a:3:{s:2:\"id\";s:2:\"38\";s:9:\"positionX\";s:3:\"728\";s:9:\"positionY\";s:3:\"266\";}i:2;a:3:{s:2:\"id\";s:2:\"39\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:3:\"265\";}i:3;a:3:{s:2:\"id\";s:2:\"40\";s:9:\"positionX\";s:3:\"286\";s:9:\"positionY\";s:3:\"266\";}i:4;a:3:{s:2:\"id\";s:2:\"41\";s:9:\"positionX\";s:3:\"504\";s:9:\"positionY\";s:3:\"265\";}i:5;a:3:{s:2:\"id\";s:2:\"42\";s:9:\"positionX\";s:3:\"286\";s:9:\"positionY\";s:3:\"365\";}i:6;a:3:{s:2:\"id\";s:2:\"43\";s:9:\"positionX\";s:3:\"504\";s:9:\"positionY\";s:3:\"365\";}i:7;a:3:{s:2:\"id\";s:2:\"44\";s:9:\"positionX\";s:3:\"504\";s:9:\"positionY\";s:3:\"474\";}i:8;a:3:{s:2:\"id\";s:2:\"45\";s:9:\"positionX\";s:3:\"502\";s:9:\"positionY\";s:3:\"573\";}i:9;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:2:\"74\";s:9:\"positionY\";s:2:\"38\";}}s:11:\"connections\";a:9:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:2:\"37\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"37\";s:8:\"targetId\";s:2:\"39\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:2:\"37\";s:8:\"targetId\";s:2:\"40\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:3;a:3:{s:8:\"sourceId\";s:2:\"40\";s:8:\"targetId\";s:2:\"42\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:4;a:3:{s:8:\"sourceId\";s:2:\"37\";s:8:\"targetId\";s:2:\"41\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:5;a:3:{s:8:\"sourceId\";s:2:\"41\";s:8:\"targetId\";s:2:\"43\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:6;a:3:{s:8:\"sourceId\";s:2:\"43\";s:8:\"targetId\";s:2:\"44\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:7;a:3:{s:8:\"sourceId\";s:2:\"44\";s:8:\"targetId\";s:2:\"45\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:8;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:2:\"38\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}}}',1),
(9,2,1,'2024-04-20 10:44:46',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:54:22',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-6-Live ***','<p>Verifică dacă intră Live la webinar <span style=\"color: rgb(184, 49, 47);\"><strong>*** Aici este nevoie de actualizat eticheta.</strong></span></p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:8:{i:0;a:3:{s:2:\"id\";s:2:\"46\";s:9:\"positionX\";s:3:\"264\";s:9:\"positionY\";s:3:\"136\";}i:1;a:3:{s:2:\"id\";s:2:\"47\";s:9:\"positionX\";s:3:\"264\";s:9:\"positionY\";s:3:\"242\";}i:2;a:3:{s:2:\"id\";s:2:\"48\";s:9:\"positionX\";s:3:\"124\";s:9:\"positionY\";s:3:\"347\";}i:3;a:3:{s:2:\"id\";s:2:\"51\";s:9:\"positionX\";s:3:\"356\";s:9:\"positionY\";s:3:\"346\";}i:4;a:3:{s:2:\"id\";s:2:\"49\";s:9:\"positionX\";s:3:\"124\";s:9:\"positionY\";s:3:\"446\";}i:5;a:3:{s:2:\"id\";s:2:\"52\";s:9:\"positionX\";s:3:\"356\";s:9:\"positionY\";s:3:\"446\";}i:6;a:3:{s:2:\"id\";s:2:\"50\";s:9:\"positionX\";s:3:\"124\";s:9:\"positionY\";s:3:\"546\";}i:7;a:3:{s:2:\"id\";s:5:\"forms\";s:9:\"positionX\";s:3:\"264\";s:9:\"positionY\";s:2:\"35\";}}s:11:\"connections\";a:7:{i:0;a:3:{s:8:\"sourceId\";s:5:\"forms\";s:8:\"targetId\";s:2:\"46\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"46\";s:8:\"targetId\";s:2:\"47\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:2:\"47\";s:8:\"targetId\";s:2:\"48\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:3;a:3:{s:8:\"sourceId\";s:2:\"48\";s:8:\"targetId\";s:2:\"49\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:4;a:3:{s:8:\"sourceId\";s:2:\"49\";s:8:\"targetId\";s:2:\"50\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:5;a:3:{s:8:\"sourceId\";s:2:\"47\";s:8:\"targetId\";s:2:\"51\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:6;a:3:{s:8:\"sourceId\";s:2:\"51\";s:8:\"targetId\";s:2:\"52\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}}}',1),
(10,2,1,'2024-04-20 10:54:10',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:53:42',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-7-Vanzare (dupa webinar)','<p>Trimite emailurile de follow-up</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:11:{i:0;a:3:{s:2:\"id\";s:2:\"53\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"158\";}i:1;a:3:{s:2:\"id\";s:2:\"62\";s:9:\"positionX\";s:1:\"0\";s:9:\"positionY\";s:3:\"158\";}i:2;a:3:{s:2:\"id\";s:2:\"54\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"269\";}i:3;a:3:{s:2:\"id\";s:2:\"55\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"382\";}i:4;a:3:{s:2:\"id\";s:2:\"56\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"490\";}i:5;a:3:{s:2:\"id\";s:2:\"57\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"595\";}i:6;a:3:{s:2:\"id\";s:2:\"58\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"700\";}i:7;a:3:{s:2:\"id\";s:2:\"59\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"804\";}i:8;a:3:{s:2:\"id\";s:2:\"60\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:3:\"910\";}i:9;a:3:{s:2:\"id\";s:2:\"61\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:4:\"1010\";}i:10;a:3:{s:2:\"id\";s:5:\"forms\";s:9:\"positionX\";s:3:\"206\";s:9:\"positionY\";s:2:\"40\";}}s:11:\"connections\";a:10:{i:0;a:3:{s:8:\"sourceId\";s:5:\"forms\";s:8:\"targetId\";s:2:\"53\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"53\";s:8:\"targetId\";s:2:\"54\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:2:\"54\";s:8:\"targetId\";s:2:\"55\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:3;a:3:{s:8:\"sourceId\";s:2:\"55\";s:8:\"targetId\";s:2:\"56\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:4;a:3:{s:8:\"sourceId\";s:2:\"56\";s:8:\"targetId\";s:2:\"57\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:5;a:3:{s:8:\"sourceId\";s:2:\"57\";s:8:\"targetId\";s:2:\"58\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:6;a:3:{s:8:\"sourceId\";s:2:\"58\";s:8:\"targetId\";s:2:\"59\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:7;a:3:{s:8:\"sourceId\";s:2:\"59\";s:8:\"targetId\";s:2:\"60\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:8;a:3:{s:8:\"sourceId\";s:2:\"60\";s:8:\"targetId\";s:2:\"61\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:9;a:3:{s:8:\"sourceId\";s:5:\"forms\";s:8:\"targetId\";s:2:\"62\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}}}',1),
(11,3,1,'2024-04-20 11:20:59',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:34:09',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','SE-Automatizare/Funnel','<p>Cei care s-au abonat să primească seria de emailuri</p>',NULL,NULL,'a:2:{s:5:\"nodes\";a:22:{i:0;a:3:{s:2:\"id\";s:2:\"63\";s:9:\"positionX\";s:3:\"259\";s:9:\"positionY\";s:3:\"130\";}i:1;a:3:{s:2:\"id\";s:2:\"64\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"348\";}i:2;a:3:{s:2:\"id\";s:2:\"65\";s:9:\"positionX\";s:3:\"258\";s:9:\"positionY\";s:3:\"250\";}i:3;a:3:{s:2:\"id\";s:2:\"66\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"453\";}i:4;a:3:{s:2:\"id\";s:2:\"67\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"347\";}i:5;a:3:{s:2:\"id\";s:2:\"68\";s:9:\"positionX\";s:3:\"538\";s:9:\"positionY\";s:2:\"31\";}i:6;a:3:{s:2:\"id\";s:2:\"69\";s:9:\"positionX\";s:2:\"10\";s:9:\"positionY\";s:3:\"558\";}i:7;a:3:{s:2:\"id\";s:2:\"70\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"454\";}i:8;a:3:{s:2:\"id\";s:2:\"71\";s:9:\"positionX\";s:3:\"601\";s:9:\"positionY\";s:3:\"123\";}i:9;a:3:{s:2:\"id\";s:2:\"72\";s:9:\"positionX\";s:3:\"256\";s:9:\"positionY\";s:3:\"558\";}i:10;a:3:{s:2:\"id\";s:2:\"73\";s:9:\"positionX\";s:3:\"472\";s:9:\"positionY\";s:3:\"224\";}i:11;a:3:{s:2:\"id\";s:2:\"74\";s:9:\"positionX\";s:3:\"897\";s:9:\"positionY\";s:3:\"224\";}i:12;a:3:{s:2:\"id\";s:2:\"75\";s:9:\"positionX\";s:3:\"680\";s:9:\"positionY\";s:3:\"224\";}i:13;a:3:{s:2:\"id\";s:2:\"76\";s:9:\"positionX\";s:3:\"897\";s:9:\"positionY\";s:3:\"327\";}i:14;a:3:{s:2:\"id\";s:2:\"77\";s:9:\"positionX\";s:3:\"680\";s:9:\"positionY\";s:3:\"327\";}i:15;a:3:{s:2:\"id\";s:2:\"78\";s:9:\"positionX\";s:3:\"680\";s:9:\"positionY\";s:3:\"438\";}i:16;a:3:{s:2:\"id\";s:2:\"79\";s:9:\"positionX\";s:3:\"680\";s:9:\"positionY\";s:3:\"543\";}i:17;a:3:{s:2:\"id\";s:2:\"80\";s:9:\"positionX\";s:3:\"680\";s:9:\"positionY\";s:3:\"652\";}i:18;a:3:{s:2:\"id\";s:2:\"81\";s:9:\"positionX\";s:3:\"680\";s:9:\"positionY\";s:3:\"757\";}i:19;a:3:{s:2:\"id\";s:2:\"82\";s:9:\"positionX\";s:3:\"680\";s:9:\"positionY\";s:3:\"862\";}i:20;a:3:{s:2:\"id\";s:2:\"83\";s:9:\"positionX\";s:3:\"897\";s:9:\"positionY\";s:3:\"437\";}i:21;a:3:{s:2:\"id\";s:5:\"forms\";s:9:\"positionX\";s:3:\"259\";s:9:\"positionY\";s:2:\"32\";}}s:11:\"connections\";a:21:{i:0;a:3:{s:8:\"sourceId\";s:5:\"forms\";s:8:\"targetId\";s:2:\"63\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:2:\"63\";s:8:\"targetId\";s:2:\"64\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:2:\"64\";s:8:\"targetId\";s:2:\"66\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:3;a:3:{s:8:\"sourceId\";s:2:\"66\";s:8:\"targetId\";s:2:\"69\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:4;a:3:{s:8:\"sourceId\";s:2:\"63\";s:8:\"targetId\";s:2:\"65\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:5;a:3:{s:8:\"sourceId\";s:2:\"65\";s:8:\"targetId\";s:2:\"67\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:6;a:3:{s:8:\"sourceId\";s:2:\"67\";s:8:\"targetId\";s:2:\"70\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:7;a:3:{s:8:\"sourceId\";s:2:\"70\";s:8:\"targetId\";s:2:\"72\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:8;a:3:{s:8:\"sourceId\";s:2:\"65\";s:8:\"targetId\";s:2:\"68\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:9;a:3:{s:8:\"sourceId\";s:2:\"68\";s:8:\"targetId\";s:2:\"71\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:10;a:3:{s:8:\"sourceId\";s:2:\"71\";s:8:\"targetId\";s:2:\"73\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:11;a:3:{s:8:\"sourceId\";s:2:\"71\";s:8:\"targetId\";s:2:\"74\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:12;a:3:{s:8:\"sourceId\";s:2:\"71\";s:8:\"targetId\";s:2:\"75\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:13;a:3:{s:8:\"sourceId\";s:2:\"74\";s:8:\"targetId\";s:2:\"76\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:14;a:3:{s:8:\"sourceId\";s:2:\"75\";s:8:\"targetId\";s:2:\"77\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:15;a:3:{s:8:\"sourceId\";s:2:\"77\";s:8:\"targetId\";s:2:\"78\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:16;a:3:{s:8:\"sourceId\";s:2:\"78\";s:8:\"targetId\";s:2:\"79\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:17;a:3:{s:8:\"sourceId\";s:2:\"79\";s:8:\"targetId\";s:2:\"80\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:18;a:3:{s:8:\"sourceId\";s:2:\"80\";s:8:\"targetId\";s:2:\"81\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:19;a:3:{s:8:\"sourceId\";s:2:\"81\";s:8:\"targetId\";s:2:\"82\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:20;a:3:{s:8:\"sourceId\";s:2:\"76\";s:8:\"targetId\";s:2:\"83\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}}}',1);
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `alias` varchar(191) NOT NULL,
  `color` varchar(7) DEFAULT NULL,
  `bundle` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_alias_search` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,1,'2024-04-20 07:27:53',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-Reamintire','Emailurile de dinaintea webinarului: confirmare, reamintire','wg-reamintire','f37c7c','global'),
(2,1,'2024-04-20 07:28:10',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-Vanzare','Emailurile de dupa webinar: de vanzare','wg-vanzare','f54f4f','global'),
(3,1,'2024-04-20 08:47:09',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','SE-SerieEmailuri','Serie Emailuri','se-serieemailuri','0051ff','global');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_url_trackables`
--

DROP TABLE IF EXISTS `channel_url_trackables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_url_trackables` (
  `channel_id` int(11) NOT NULL,
  `redirect_id` bigint(20) unsigned NOT NULL,
  `channel` varchar(191) NOT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  PRIMARY KEY (`redirect_id`,`channel_id`),
  KEY `channel_url_trackable_search` (`channel`,`channel_id`),
  CONSTRAINT `FK_2F81A41DB42D874D` FOREIGN KEY (`redirect_id`) REFERENCES `page_redirects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_url_trackables`
--

LOCK TABLES `channel_url_trackables` WRITE;
/*!40000 ALTER TABLE `channel_url_trackables` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel_url_trackables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `social_cache` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `score` int(11) DEFAULT NULL,
  `companyemail` varchar(191) DEFAULT NULL,
  `companyaddress1` varchar(191) DEFAULT NULL,
  `companyaddress2` varchar(191) DEFAULT NULL,
  `companyphone` varchar(191) DEFAULT NULL,
  `companycity` varchar(191) DEFAULT NULL,
  `companystate` varchar(191) DEFAULT NULL,
  `companyzipcode` varchar(191) DEFAULT NULL,
  `companycountry` varchar(191) DEFAULT NULL,
  `companyname` varchar(191) DEFAULT NULL,
  `companywebsite` varchar(191) DEFAULT NULL,
  `companyindustry` varchar(191) DEFAULT NULL,
  `companydescription` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8244AA3A7E3C61F9` (`owner_id`),
  KEY `company_filter` (`companyname`,`companyemail`),
  KEY `company_match` (`companyname`,`companycity`,`companycountry`,`companystate`),
  CONSTRAINT `FK_8244AA3A7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies_leads`
--

DROP TABLE IF EXISTS `companies_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies_leads` (
  `company_id` int(11) NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `is_primary` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`company_id`,`lead_id`),
  KEY `IDX_F4190AB655458D` (`lead_id`),
  CONSTRAINT `FK_F4190AB655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F4190AB6979B1AD6` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies_leads`
--

LOCK TABLES `companies_leads` WRITE;
/*!40000 ALTER TABLE `companies_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies_leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_merge_records`
--

DROP TABLE IF EXISTS `contact_merge_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_merge_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `merged_id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D9B4F2BFE7A1254A` (`contact_id`),
  KEY `contact_merge_date_added` (`date_added`),
  KEY `contact_merge_ids` (`merged_id`),
  CONSTRAINT `FK_D9B4F2BFE7A1254A` FOREIGN KEY (`contact_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_merge_records`
--

LOCK TABLES `contact_merge_records` WRITE;
/*!40000 ALTER TABLE `contact_merge_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_merge_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dynamic_content`
--

DROP TABLE IF EXISTS `dynamic_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `translation_parent_id` int(10) unsigned DEFAULT NULL,
  `variant_parent_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `sent_count` int(11) NOT NULL,
  `content` longtext DEFAULT NULL,
  `utm_tags` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `lang` varchar(191) NOT NULL,
  `variant_settings` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  `filters` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `is_campaign_based` tinyint(1) NOT NULL DEFAULT 1,
  `slot_name` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_20B9DEB212469DE2` (`category_id`),
  KEY `IDX_20B9DEB29091A2FB` (`translation_parent_id`),
  KEY `IDX_20B9DEB291861123` (`variant_parent_id`),
  KEY `is_campaign_based_index` (`is_campaign_based`),
  KEY `slot_name_index` (`slot_name`),
  CONSTRAINT `FK_20B9DEB212469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_20B9DEB29091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `dynamic_content` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_20B9DEB291861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `dynamic_content` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dynamic_content`
--

LOCK TABLES `dynamic_content` WRITE;
/*!40000 ALTER TABLE `dynamic_content` DISABLE KEYS */;
INSERT INTO `dynamic_content` VALUES
(1,NULL,NULL,NULL,1,'2024-03-06 19:14:02',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-03-06 19:24:10',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','z9-dezabonare','',NULL,NULL,0,'<div style=\"text-align: center; margin-top: 10px; margin-bottom: 5px; border-radius: 50%;\"><img src=\"https://###MAUTIC_SUBDOMAIN###/media/images/avatar.png\" alt=\"###SENDER_FIRSTNAME### ###SENDER_LASTNAME###\" class=\"fr-fic fr-dii\" width=\"100\" height=\"100\" style=\"border-radius:50%;border: white 3px solid;\"></div><p style=\"text-align: center; padding-top: 5px; padding-bottom: 5px;\">Acest email a fost trimis de<br>###SENDER_FIRSTNAME### ###SENDER_LASTNAME###<br>Adresa ta completă</p><div style=\"text-align: center; margin-top:10px; margin-bottom:5px;\"><a href=\"https://www.facebook.com/\" mautic:disable-tracking=\"true\" rel=\"noopener noreferrer\" target=\"_blank\"><img src=\"https://###MAUTIC_SUBDOMAIN###/media/images/icon_128/facebook.png\" style=\"width: 26px; height=26px;\" alt=\"facebook\" class=\"fr-fic fr-dii\" width=\"26\" height=\"26\"></a>&nbsp; <a href=\"https://www.instagram.com/\" mautic:disable-tracking=\"true\" rel=\"noopener noreferrer\" target=\"_blank\"><img src=\"https://###MAUTIC_SUBDOMAIN###/media/images/icon_128/instagram.png\" style=\"width: 26px; height=26px;\" alt=\"instagram\" class=\"fr-fic fr-dii\" width=\"26\" height=\"26\"></a>&nbsp; <a href=\"https://www.youtube.com/\" mautic:disable-tracking=\"true\" rel=\"noopener noreferrer\" target=\"_blank\"><img src=\"https://###MAUTIC_SUBDOMAIN###/media/images/icon_128/youtube.png\" style=\"width: 26px; height=26px;\" alt=\"youtube\" class=\"fr-fic fr-dii\" width=\"26\" height=\"26\"></a></div><p style=\"text-align: center; padding-top: 5px; padding-bottom: 5px;\"><a href=\"{unsubscribe_url}\">Te poţi dezabona aici.</a></p>','{\"utmSource\":null,\"utmMedium\":null,\"utmCampaign\":null,\"utmContent\":null}','ro','a:0:{}',NULL,'a:0:{}',1,''),
(2,NULL,NULL,NULL,1,'2024-03-06 19:16:28',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,NULL,NULL,NULL,'z8-semnatura','',NULL,NULL,0,'<div style=\"margin:10px 0px;\"><img src=\"https://###MAUTIC_SUBDOMAIN###/media/images/avatar.png\" style=\"width: 150px;\" class=\"fr-fic fr-dib\" width=\"150\" alt=\"###SENDER_FIRSTNAME###\" /></div>','{\"utmSource\":null,\"utmMedium\":null,\"utmCampaign\":null,\"utmContent\":null}','ro','a:0:{}',NULL,'a:0:{}',1,'');
/*!40000 ALTER TABLE `dynamic_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dynamic_content_lead_data`
--

DROP TABLE IF EXISTS `dynamic_content_lead_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_content_lead_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `dynamic_content_id` int(10) unsigned DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `slot` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_515B221B55458D` (`lead_id`),
  KEY `IDX_515B221BD9D0CD7` (`dynamic_content_id`),
  CONSTRAINT `FK_515B221B55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_515B221BD9D0CD7` FOREIGN KEY (`dynamic_content_id`) REFERENCES `dynamic_content` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dynamic_content_lead_data`
--

LOCK TABLES `dynamic_content_lead_data` WRITE;
/*!40000 ALTER TABLE `dynamic_content_lead_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_content_lead_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dynamic_content_stats`
--

DROP TABLE IF EXISTS `dynamic_content_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_content_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_content_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `source` varchar(191) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `sent_count` int(11) DEFAULT NULL,
  `last_sent` datetime DEFAULT NULL,
  `sent_details` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_E48FBF80D9D0CD7` (`dynamic_content_id`),
  KEY `IDX_E48FBF8055458D` (`lead_id`),
  KEY `stat_dynamic_content_search` (`dynamic_content_id`,`lead_id`),
  KEY `stat_dynamic_content_source_search` (`source`,`source_id`),
  CONSTRAINT `FK_E48FBF8055458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_E48FBF80D9D0CD7` FOREIGN KEY (`dynamic_content_id`) REFERENCES `dynamic_content` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dynamic_content_stats`
--

LOCK TABLES `dynamic_content_stats` WRITE;
/*!40000 ALTER TABLE `dynamic_content_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_content_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_assets_xref`
--

DROP TABLE IF EXISTS `email_assets_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_assets_xref` (
  `email_id` int(10) unsigned NOT NULL,
  `asset_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`email_id`,`asset_id`),
  KEY `IDX_CA3157785DA1941` (`asset_id`),
  CONSTRAINT `FK_CA3157785DA1941` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_CA315778A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_assets_xref`
--

LOCK TABLES `email_assets_xref` WRITE;
/*!40000 ALTER TABLE `email_assets_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_assets_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_copies`
--

DROP TABLE IF EXISTS `email_copies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_copies` (
  `id` varchar(32) NOT NULL,
  `date_created` datetime NOT NULL,
  `body` longtext DEFAULT NULL,
  `subject` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_copies`
--

LOCK TABLES `email_copies` WRITE;
/*!40000 ALTER TABLE `email_copies` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_copies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_list_xref`
--

DROP TABLE IF EXISTS `email_list_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_list_xref` (
  `email_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`email_id`,`leadlist_id`),
  KEY `IDX_2E24F01CB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_2E24F01CA832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2E24F01CB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_list_xref`
--

LOCK TABLES `email_list_xref` WRITE;
/*!40000 ALTER TABLE `email_list_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_list_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_stat_replies`
--

DROP TABLE IF EXISTS `email_stat_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_stat_replies` (
  `id` char(36) NOT NULL COMMENT '(DC2Type:guid)',
  `stat_id` bigint(20) unsigned NOT NULL,
  `date_replied` datetime NOT NULL,
  `message_id` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_11E9F6E09502F0B` (`stat_id`),
  KEY `email_replies` (`stat_id`,`message_id`),
  KEY `date_email_replied` (`date_replied`),
  CONSTRAINT `FK_11E9F6E09502F0B` FOREIGN KEY (`stat_id`) REFERENCES `email_stats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_stat_replies`
--

LOCK TABLES `email_stat_replies` WRITE;
/*!40000 ALTER TABLE `email_stat_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_stat_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_stats`
--

DROP TABLE IF EXISTS `email_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `copy_id` varchar(32) DEFAULT NULL,
  `email_address` varchar(191) NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `is_failed` tinyint(1) NOT NULL,
  `viewed_in_browser` tinyint(1) NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `tracking_hash` varchar(191) DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(191) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `open_count` int(11) DEFAULT NULL,
  `last_opened` datetime DEFAULT NULL,
  `open_details` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `generated_sent_date` date GENERATED ALWAYS AS (concat(year(`date_sent`),'-',lpad(month(`date_sent`),2,'0'),'-',lpad(dayofmonth(`date_sent`),2,'0'))) VIRTUAL COMMENT '(DC2Type:generated)',
  PRIMARY KEY (`id`),
  KEY `IDX_CA0A2625A832C1C9` (`email_id`),
  KEY `IDX_CA0A262555458D` (`lead_id`),
  KEY `IDX_CA0A26253DAE168B` (`list_id`),
  KEY `IDX_CA0A2625A03F5E9F` (`ip_id`),
  KEY `IDX_CA0A2625A8752772` (`copy_id`),
  KEY `stat_email_search` (`email_id`,`lead_id`),
  KEY `stat_email_search2` (`lead_id`,`email_id`),
  KEY `stat_email_failed_search` (`is_failed`),
  KEY `is_read_date_sent` (`is_read`,`date_sent`),
  KEY `stat_email_hash_search` (`tracking_hash`),
  KEY `stat_email_source_search` (`source`,`source_id`),
  KEY `email_date_sent` (`date_sent`),
  KEY `email_date_read_lead` (`date_read`,`lead_id`),
  KEY `generated_sent_date_email_id` (`generated_sent_date`,`email_id`),
  CONSTRAINT `FK_CA0A26253DAE168B` FOREIGN KEY (`list_id`) REFERENCES `lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CA0A262555458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CA0A2625A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_CA0A2625A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CA0A2625A8752772` FOREIGN KEY (`copy_id`) REFERENCES `email_copies` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_stats`
--

LOCK TABLES `email_stats` WRITE;
/*!40000 ALTER TABLE `email_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_stats_devices`
--

DROP TABLE IF EXISTS `email_stats_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_stats_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) unsigned DEFAULT NULL,
  `stat_id` bigint(20) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_opened` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7A8A1C6F94A4C7D4` (`device_id`),
  KEY `IDX_7A8A1C6F9502F0B` (`stat_id`),
  KEY `IDX_7A8A1C6FA03F5E9F` (`ip_id`),
  KEY `date_opened_search` (`date_opened`),
  CONSTRAINT `FK_7A8A1C6F94A4C7D4` FOREIGN KEY (`device_id`) REFERENCES `lead_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_7A8A1C6F9502F0B` FOREIGN KEY (`stat_id`) REFERENCES `email_stats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_7A8A1C6FA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_stats_devices`
--

LOCK TABLES `email_stats_devices` WRITE;
/*!40000 ALTER TABLE `email_stats_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_stats_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `translation_parent_id` int(10) unsigned DEFAULT NULL,
  `variant_parent_id` int(10) unsigned DEFAULT NULL,
  `unsubscribeform_id` int(10) unsigned DEFAULT NULL,
  `preference_center_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `subject` longtext DEFAULT NULL,
  `from_address` varchar(191) DEFAULT NULL,
  `from_name` varchar(191) DEFAULT NULL,
  `reply_to_address` varchar(191) DEFAULT NULL,
  `bcc_address` varchar(191) DEFAULT NULL,
  `use_owner_as_mailer` tinyint(1) DEFAULT NULL,
  `template` varchar(191) DEFAULT NULL,
  `content` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `utm_tags` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `plain_text` longtext DEFAULT NULL,
  `custom_html` longtext DEFAULT NULL,
  `email_type` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `read_count` int(11) NOT NULL,
  `sent_count` int(11) NOT NULL,
  `variant_sent_count` int(11) NOT NULL,
  `variant_read_count` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `lang` varchar(191) NOT NULL,
  `variant_settings` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  `dynamic_content` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `headers` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  `public_preview` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4C81E85212469DE2` (`category_id`),
  KEY `IDX_4C81E8529091A2FB` (`translation_parent_id`),
  KEY `IDX_4C81E85291861123` (`variant_parent_id`),
  KEY `IDX_4C81E8522DC494F6` (`unsubscribeform_id`),
  KEY `IDX_4C81E852834F9C5B` (`preference_center_id`),
  CONSTRAINT `FK_4C81E85212469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_4C81E8522DC494F6` FOREIGN KEY (`unsubscribeform_id`) REFERENCES `forms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_4C81E852834F9C5B` FOREIGN KEY (`preference_center_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_4C81E8529091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_4C81E85291861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `emails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT INTO `emails` VALUES
(1,NULL,NULL,NULL,NULL,NULL,0,'2024-03-06 19:20:07',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-03-06 19:20:07',NULL,NULL,NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','z9-şablon de email',NULL,'Aici introdu subiectul emailului',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Bună {contactfield=firstname},<br /><br />aici introdu conţinutul emailului tău.<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(2,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:11:49',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:25:14',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:33:28',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-1-Confirmare inscriere',NULL,'Felicitări, te-ai înscris la webinarul LIVE !',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Super, {contactfield=firstname}!<br /><br />Te-ai înscris cu succes la webinarul<br /><br /><div style=\"text-align: center;\"><strong>Titlul Webinarului<br /></strong></div><br /><br />{% TWIG_BLOCK %}{% set x = \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days : 8 %}{% if x == 0 %}<strong>care va avea loc chiar astăzi!</strong>{% else %}care va avea loc peste {{ x }} zile, în data de {{ \"[\" not in lead.wgdata ? lead.wgdata|date(\"j.m.Y\") : \'14.11.2023\' }}.{% endif %}{% END_TWIG_BLOCK %} De la ora 19:00.<br /><br />Linkul spre Webinar este acesta:<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {% TWIG_BLOCK %}{% set x = \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days : 8 %}{% if x == 0 %}astăzi{% else %}{{ \"[\" not in lead.wgdata ? lead.wgdata|date(\"j.m.Y\") : \'14.11.2023\' }}{% endif %}{% END_TWIG_BLOCK %}, ora 19:00 )</em></div>Ești pe drumul spre a-ți schimba radical viața, din toate punctele de vedere.<br /><br /><strong>Alături de mine vei învăța:<br /></strong><br /><ul><li>1</li></ul>(descriere)<br /><br /><ul><li>2</li></ul>(descriere)<br /><br /><ul><li>3</li></ul>(descriere)<br /><br /><ul><li>4</li></ul>(descriere)<br /><br /><ul><li>5</li></ul>(descriere)<br /><br /><ul><li>LIVE Q&amp;A</li></ul>(La sfârșitul webinarului, vei putea să îmi adresezi orice întrebare dorești)<br /><br />Pe final, vreau să mai reții încă un lucru important:<br /><br />Nu voi acorda o înregistrare publică a prezentării.<br /><br />Vei avea acces la toate informațiile utile, doar dacă participi LIVE.<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(3,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:22:36',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:25:15',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'WG-1-Deja inscris',NULL,'Te-ai înscris deja la webinar',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Bună din nou, {contactfield=firstname}<br /><br /><br />Te-ai înscris deja la webinar.<br /><br /><em>Dacă, din întâmplare, acest email a ajuns în <strong>Spam sau Promoții, te rog să îl muți în Inbox</strong>. Așa te asiguri că nu pierzi nicio informație valoroasă de la mine.</em><br /><br />Linkul spre Webinar este acesta:<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {% TWIG_BLOCK %}{% set x = \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days : 88 %}{% if x == 0 %}astăzi, pe lead.wgdata|date(\"j.m.Y\")<br />{% elseif x == 1 %}mâine, pe lead.wgdata|date(\"j.m.Y\")<br />{% else %}cândva în viitor{% endif %}{% END_TWIG_BLOCK %}, ora 19:00 uk )</em></div><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(4,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:25:01',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:25:14',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'WG-1-Trecut',NULL,'Webinarul a trecut. Te voi anunţa când va fi următorul!',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br />sunt încântată să văd că ești interesată de webinar!<br /><br />Înscrierea ta vine după ce evenimentul a avut loc, și vreau să îți mulțumesc pentru dorința ta de a participa.<br /><br /><br />Pentru că știu cât de importantă este informaţia din webinar, te invit să rămâi abonat la Newsletterele mele.<br /><br />Astfel vei fi la curent cu următorul eveniment din timp şi vei avea ocazia să participi atunci.<br /><br /><br />Mult succes în tot ce faci!<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(5,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:30:49',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:32:39',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-2-Cu 7 zile inainte de Webinar',NULL,'Ai luat o decizie bună! La ce să te aștepți',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br /><br />{ownerfield=firstname} aici, am emoții, ca de fiecare dată să mă asigur că toți cei care participă Live, își iau informații valoroase.<br /><br />Mai sunt {% TWIG_BLOCK %}{{ \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days + 1 : \'8\' }}{% END_TWIG_BLOCK %} zile până la webinar.<br /><br />Dacă nu ai făcut-o deja, notează data webinarului în calendarul tău: {contactfield=wgdata|date}, ora 19:00.<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {% TWIG_BLOCK %}{% set x = \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days : 8 %}{% if x == 0 %}astăzi{% else %}{{ \"[\" not in lead.wgdata ? lead.wgdata|date(\"j.m.Y\") : \'14.11.2023\' }}{% endif %}{% END_TWIG_BLOCK %}, ora 19:00 )</em></div><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(6,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:31:30',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:32:38',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-3-Cu 3 zile inainte de Webinar',NULL,':alarm_clock: În 3 zile ne vedem live',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br /><br />{ownerfield=firstname} aici, am emoții, ca de fiecare dată să mă asigur că toți cei care participă Live, își iau informații valoroase.<br /><br />Mai sunt {% TWIG_BLOCK %}{{ \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days + 1 : \'8\' }}{% END_TWIG_BLOCK %} zile până la webinar.<br /><br />Dacă nu ai făcut-o deja, notează data webinarului în calendarul tău: {contactfield=wgdata|date}, ora 19:00.<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {% TWIG_BLOCK %}{% set x = \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days : 8 %}{% if x == 0 %}astăzi{% else %}{{ \"[\" not in lead.wgdata ? lead.wgdata|date(\"j.m.Y\") : \'14.11.2023\' }}{% endif %}{% END_TWIG_BLOCK %}, ora 19:00 )</em></div><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(7,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:32:33',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:32:38',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-4-Cu o zi inainte de Webinar',NULL,'Webinarul are loc mâine',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br /><br />{ownerfield=firstname} aici, am emoții, ca de fiecare dată să mă asigur că toți cei care participă Live, își iau informații valoroase.<br /><br />Mâine este webinarul.<br /><br />Dacă nu ai făcut-o deja, notează data webinarului în calendarul tău: {contactfield=wgdata|date}, ora 19:00.<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {% TWIG_BLOCK %}{% set x = \"[\" not in lead.wgdata ? date().diff(date(lead.wgdata)).days : 8 %}{% if x == 0 %}astăzi{% else %}{{ \"[\" not in lead.wgdata ? lead.wgdata|date(\"j.m.Y\") : \'14.11.2023\' }}{% endif %}{% END_TWIG_BLOCK %}, ora 19:00 )</em></div><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(8,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:38:48',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:40:24',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'WG-5-In ziua Webinarului-15:00-🥳 Inca 4 ore si ne vedem LIVE!',NULL,'🥳 Inca 4 ore si ne vedem LIVE!',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br /><br />{ownerfield=firstname} aici, am emoții, ca de fiecare dată să mă asigur că toți cei care participă Live, își iau informații valoroase.<br /><br />Astăzi este webinarul.<br /><br />Dacă nu ai făcut-o deja, notează data webinarului în calendarul tău: {contactfield=wgdata|date}, ora 19:00.<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {contactfield=wgdata|date}, ora 19:00 )</em></div><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(9,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:39:48',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:40:25',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'WG-5-In ziua Webinarului-18:40-🚀 Începem în 20 de minute',NULL,':rocket: Începem în 20 de minute webinarul',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br /><br />{ownerfield=firstname} aici, am emoții, ca de fiecare dată să mă asigur că toți cei care participă Live, își iau informații valoroase.<br /><br />Astăzi este webinarul.<br /><br />Dacă nu ai făcut-o deja, notează data webinarului în calendarul tău: {contactfield=wgdata|date}, ora 19:00.<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {contactfield=wgdata|date}, ora 19:00 )</em></div><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(10,1,NULL,NULL,NULL,NULL,0,'2024-04-20 09:40:21',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:40:26',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'WG-5-In ziua Webinarului-19:10-👀 Am început webinarul de 10 minute',NULL,':eyes: Am început webinarul de 10 minute',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br /><br />{ownerfield=firstname} aici, am emoții, ca de fiecare dată să mă asigur că toți cei care participă Live, își iau informații valoroase.<br /><br />Astăzi este webinarul.<br /><br />Dacă nu ai făcut-o deja, notează data webinarului în calendarul tău: {contactfield=wgdata|date}, ora 19:00.<br /><br /><div style=\"text-align: center;\"><span style=\"font-size: 24px;\"><a href=\"{pagelink=1}\" rel=\"noopener noreferrer\" target=\"_blank\" title=\"Intră la Webinar - clic aici\">Acces Webinar Live</a></span></div><div style=\"text-align: center;\"><em>( {contactfield=wgdata|date}, ora 19:00 )</em></div><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(11,2,NULL,NULL,NULL,NULL,0,'2024-04-20 09:44:20',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:54:20',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-6-prima zi dupa Webinar-Descoperă programul',NULL,'Descoperă programul',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salutare {contactfield=firstname},<br /><br /><br />În primul rând te felicit pentru participarea la webinarul \"Titlul Webinarului\".<br /><br />Sper că acum ai o imagine de ansamblu al pașilor pe care trebuie să-i parcurgi de acum încolo.<br /><br />...<br /><br />Ia o decizie acum, <u>vrei să rămâi în același loc și luna viitoare sau ne apucăm de treaba?</u><br /><br /><a href=\"http://###MAIN_DOMAIN###/program/\" rel=\"noopener noreferrer\" target=\"_blank\"><strong>Înscrie-te Acum<br /></strong></a><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(12,2,NULL,NULL,NULL,NULL,0,'2024-04-20 09:45:22',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:54:15',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-7-a 2-a zi dupa Webinar-Poveste Emotionala',NULL,'De la Webinar la Împlinire',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salutare {contactfield=firstname},<br /><br /><br />În primul rând te felicit pentru participarea la webinarul \"Titlul Webinarului\".<br /><br />Sper că acum ai o imagine de ansamblu al pașilor pe care trebuie să-i parcurgi de acum încolo.<br /><br />...<br /><br />Ia o decizie acum, <u>vrei să rămâi în același loc și luna viitoare sau ne apucăm de treaba?</u><br /><br /><a href=\"http://###MAIN_DOMAIN###/program/\" rel=\"noopener noreferrer\" target=\"_blank\"><strong>Înscrie-te Acum<br /></strong></a><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,3,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(13,2,NULL,NULL,NULL,NULL,0,'2024-04-20 09:47:03',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:54:02',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-8-a 3-a zi dupa Webinar 07:00-E scump să te pregăteşti?',NULL,'E scump să te pregăteşti?',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salutare {contactfield=firstname},<br /><br /><br />În primul rând te felicit pentru participarea la webinarul \"Titlul Webinarului\".<br /><br />Sper că acum ai o imagine de ansamblu al pașilor pe care trebuie să-i parcurgi de acum încolo.<br /><br />...<br /><br />Ia o decizie acum, <u>vrei să rămâi în același loc și luna viitoare sau ne apucăm de treaba?</u><br /><br /><a href=\"http://###MAIN_DOMAIN###/program/\" rel=\"noopener noreferrer\" target=\"_blank\"><strong>Înscrie-te Acum<br /></strong></a><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(14,2,NULL,NULL,NULL,NULL,0,'2024-04-20 09:48:33',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:53:57',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-8-a 3-a zi dupa Webinar 19:00-Încă 5 ore în care te poţi înscrie',NULL,'Încă 5 ore în care te poţi înscrie',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salutare {contactfield=firstname},<br /><br /><br />În primul rând te felicit pentru participarea la webinarul \"Titlul Webinarului\".<br /><br />Sper că acum ai o imagine de ansamblu al pașilor pe care trebuie să-i parcurgi de acum încolo.<br /><br />...<br /><br />Ia o decizie acum, <u>vrei să rămâi în același loc și luna viitoare sau ne apucăm de treaba?</u><br /><br /><a href=\"http://###MAIN_DOMAIN###/program/\" rel=\"noopener noreferrer\" target=\"_blank\"><strong>Înscrie-te Acum<br /></strong></a><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(15,2,NULL,NULL,NULL,NULL,0,'2024-04-20 09:49:15',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:53:53',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-9-a 4-a zi dupa Webinar 07:00-O soluție mai accesibilă pentru tine!',NULL,'O soluție mai accesibilă pentru tine!',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salutare {contactfield=firstname},<br /><br /><br />În primul rând te felicit pentru participarea la webinarul \"Titlul Webinarului\".<br /><br />Sper că acum ai o imagine de ansamblu al pașilor pe care trebuie să-i parcurgi de acum încolo.<br /><br />...<br /><br />Ia o decizie acum, <u>vrei să rămâi în același loc și luna viitoare sau ne apucăm de treaba?</u><br /><br /><a href=\"http://###MAIN_DOMAIN###/program/\" rel=\"noopener noreferrer\" target=\"_blank\"><strong>Înscrie-te Acum<br /></strong></a><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(16,2,NULL,NULL,NULL,NULL,0,'2024-04-20 09:49:41',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:53:47',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-9-a 4-a zi dupa Webinar 19:00-Ultima ofertă pentru tine',NULL,'Ultima ofertă pentru tine, {contactfield=firstname}!',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salutare {contactfield=firstname},<br /><br /><br />În primul rând te felicit pentru participarea la webinarul \"Titlul Webinarului\".<br /><br />Sper că acum ai o imagine de ansamblu al pașilor pe care trebuie să-i parcurgi de acum încolo.<br /><br />...<br /><br />Ia o decizie acum, <u>vrei să rămâi în același loc și luna viitoare sau ne apucăm de treaba?</u><br /><br /><a href=\"http://###MAIN_DOMAIN###/program/\" rel=\"noopener noreferrer\" target=\"_blank\"><strong>Înscrie-te Acum<br /></strong></a><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(17,2,NULL,NULL,NULL,NULL,0,'2024-04-20 09:53:31',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:53:31',NULL,NULL,NULL,NULL,NULL,'WG-A-a 5-a zi dupa Webinar-Mă poți ajuta cu un feedback',NULL,'Mă poți ajuta cu un feedback, {contactfield=firstname}?',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Salut {contactfield=firstname},<br /><br /><br />Am vrut să îți mulțumesc pentru participare la webinar și îți respect decizia pe care ai luat-o de a colabora sau nu cu mine.<br /><br />Astăzi îmi doresc să te rog doar un lucru:<br /><br />Să îmi lași un feedback onest la fel cum au făcut-o mulți alții înaintea ta aici: <a href=\"https://###MAIN_DOMAIN###/feedback/\" rel=\"noopener noreferrer\" target=\"_blank\">Lasă un Feedback Aici</a><br /><br />Feedback-ul tău va ajuta și inspira și alți români.<br /><br />Mă va ajută pe mine pentru a îmbunătăți materialele mele și calitatea informațiilor pe care o ofer.<br /><br />Îți mulțumesc mult încă o dată!<br /><br />Apropo, dacă nu te-ai abonat deja la materialele gratuite pe care le ofer, o poți face aici: <a href=\"https://###MAIN_DOMAIN###\" rel=\"noopener noreferrer\" target=\"_blank\">https://###MAIN_DOMAIN###</a><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(18,3,NULL,NULL,NULL,NULL,0,'2024-04-20 10:00:41',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:03:04',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','SE-01-Prezentare',NULL,'Felicitări ! Vei primi emailurile la care te-ai abonat',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Super, {contactfield=firstname}!<br /><br />Deja aici este primul email din seria de emailuri la care te-ai abonat.<br /><br />De ce te-ai abonat?<br /><br />Ce schimbare va fi după ce parcurgi emailurile?<br /><br />Ce vei primi concret:<br /><br />Cine sunt eu?<br /><br />Te bucuri că te-ai abonat? Ţi-am împlinit aşteptările?<br /><br />Te rog neapărat să-mi laşi un reply.<br /><br />Aici introdu conţinutul emailului tău.<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,2,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(19,3,NULL,NULL,NULL,NULL,0,'2024-04-20 10:02:44',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:02:44',NULL,NULL,NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','SE-02-Detaliu',NULL,'Aici găseşti următorul pas spre a deveni NOU',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Super, {contactfield=firstname}!<br /><br />Te-ai aşteptat că va veni o schimbare după primul email?<br /><br />Dacă încă nu a venit, atunci răspunde sincer: ai făcut exerciţiul prezentat acolo?<br /><br />Dacă nu, atunci să ştii că nu-l pot face în locul tău!<br /><br />Şi să mai ştii că durează doar 5 minute!<br /><br />Valorează schimbarea ta aceste 5 minute?<br /><br />Poţi face ceva mai bun în 5 minute?<br /><br />Ca să nu mai cauţi emailul, îţi las exerciţiul în PS =&gt; vezi jos, la capătul emailului.<br /><br />Pentru astăzi am pregătit un al doilea exerciţiu:<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(20,3,NULL,NULL,NULL,NULL,0,'2024-04-20 10:04:34',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:04:34',NULL,NULL,NULL,NULL,NULL,'SE-03-Schimbare',NULL,'Ai devenit NOU? Cum a fost schimbarea?',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Super, {contactfield=firstname}!<br /><br />Cum e ziua ta?<br /><br />Ai reuşit să parcurgi emailurile şi exerciţiile până aici?<br /><br />Au fost doar două. Dar puternice!<br /><br />Ai simţit asta?<br /><br />Astăzi am o poveste, ca o pauză şi un moment de încărcare a bateriilor.<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(21,3,NULL,NULL,NULL,NULL,0,'2024-04-20 10:05:14',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:05:14',NULL,NULL,NULL,NULL,NULL,'SE-04-Te-ai gandit la asta?',NULL,'Te-ai gandit la asta?',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Super, {contactfield=firstname}!<br /><br />Cum e ziua ta?<br /><br />Ai reuşit să parcurgi emailurile şi exerciţiile până aici?<br /><br />Au fost doar două. Dar puternice!<br /><br />Ai simţit asta?<br /><br />Astăzi am o poveste, ca o pauză şi un moment de încărcare a bateriilor.<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(22,3,NULL,NULL,NULL,NULL,0,'2024-04-20 10:05:35',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:05:35',NULL,NULL,NULL,NULL,NULL,'SE-05-Uite ce am pregatit pentru tine',NULL,'Uite ce am pregatit pentru tine',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Super, {contactfield=firstname}!<br /><br />Cum e ziua ta?<br /><br />Ai reuşit să parcurgi emailurile şi exerciţiile până aici?<br /><br />Au fost doar două. Dar puternice!<br /><br />Ai simţit asta?<br /><br />Astăzi am o poveste, ca o pauză şi un moment de încărcare a bateriilor.<br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0),
(23,3,NULL,NULL,NULL,NULL,0,'2024-04-20 11:07:48',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:07:48',NULL,NULL,NULL,NULL,NULL,'SE-00-Deja inscris',NULL,'Te-ai înscris deja sa primesti materialul',NULL,NULL,NULL,NULL,1,'460c-Simplu','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n	<title>{subject}</title>\r\n	<style>\r\ntable.body pre,\r\ntable.body code {\r\n	padding: 2px !important;\r\n	color: #222222 !important;\r\n	background-color: #f1f1f1 !important;\r\n	white-space: pre-wrap;\r\n	white-space: -moz-pre-wrap;\r\n	white-space: -pre-wrap;\r\n	white-space: -o-pre-wrap;\r\n	word-wrap: break-word;\r\n}\r\n@media only screen and (max-width: 620px) {\r\ntable.body .wrapper,\r\ntable.body .article {\r\n	padding: 10px !important;\r\n}\r\ntable.body .content {\r\n	padding: 0 !important;\r\n}\r\ntable.body .container {\r\n	padding: 0 !important;\r\n	width: 100% !important;\r\n}\r\ntable.body .main {\r\n	border-left-width: 0 !important;\r\n	border-radius: 0 !important;\r\n	border-right-width: 0 !important;\r\n}\r\ntable.body .btn table {\r\n	width: 100% !important;\r\n}\r\ntable.body .btn a {\r\n	width: 100% !important;\r\n}\r\ntable.body .img-responsive {\r\n	height: auto !important;\r\n	max-width: 100% !important;\r\n	width: auto !important;\r\n}\r\n}\r\n@media all {\r\n.ExternalClass {\r\n	width: 100%;\r\n}\r\n.ExternalClass,\r\n.ExternalClass p,\r\n.ExternalClass span,\r\n.ExternalClass font,\r\n.ExternalClass td,\r\n.ExternalClass div {\r\n	line-height: 1.6;\r\n}\r\n.apple-link a {\r\n	color: inherit !important;\r\n	font-family: inherit !important;\r\n	font-size: inherit !important;\r\n	font-weight: inherit !important;\r\n	line-height: inherit !important;\r\n	text-decoration: none !important;\r\n}\r\n#MessageViewBody a {\r\n	color: inherit;\r\n	text-decoration: none;\r\n	font-size: inherit;\r\n	font-family: inherit;\r\n	font-weight: inherit;\r\n	line-height: inherit;\r\n}\r\n.btn-primary table td:hover {\r\n	background-color: #34495e !important;\r\n}\r\n.btn-primary a:hover {\r\n	background-color: #34495e !important;\r\n	border-color: #34495e !important;\r\n}\r\n}\r\n	</style></head>\r\n<body style=\"background-color: #ffffff; font-family: Verdana,Geneva,sans-serif; -webkit-font-smoothing: antialiased; font-size: 16px; line-height: 1.6; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;\" class=\"ui-sortable\">\r\n	<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #ffffff; width: 100%;\" width=\"100%\" bgcolor=\"#ffffff\" data-section-wrapper=\"1\">\r\n		<tbody><tr>\r\n			<td> </td>\r\n			<td class=\"container\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; display: block; max-width: 460px; padding: 10px; width: 460px; margin: 0 auto;\" width=\"460\" valign=\"top\">\r\n				<div class=\"content\" style=\"box-sizing: border-box; display: block; margin: 0 auto; max-width: 460px; padding: 10px;\">\r\n					<!-- START CENTERED WHITE CONTAINER -->\r\n					<table role=\"presentation\" class=\"main\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; background: #ffffff; border-radius: 3px; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n						<!-- START MAIN CONTENT AREA -->\r\n						<tbody><tr>\r\n							<td class=\"wrapper\" style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; vertical-align: top; box-sizing: border-box; padding: 20px;\" valign=\"top\">\r\n								<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\">\r\n									<tbody><tr>\r\n										<td style=\"font-family: Verdana,Geneva,sans-serif; font-size: 16px; line-height: 1.6; vertical-align: top;\" valign=\"top\" data-slot-container=\"1\" class=\"ui-sortable\">\r\n											<div data-slot=\"text\" class=\"\">Bună din nou, {contactfield=firstname}<br /><br />Te-ai înscris deja să primeşti paşii ...<br /><br />N-ai primit emailurile de la mine? Te rog să-mi trimiţi un reply şi rezolvăm.<br /><br /><em>Dacă, din întâmplare, acest email a ajuns în <strong>Spam sau Promoții, te rog să îl muți în Inbox</strong>. Așa te asiguri că nu pierzi nicio informație valoroasă de la mine.</em><br /><br />Cu prietenie,<br />{% TWIG_BLOCK %}{{ include(\'dc:z8-semnatura\') }}{% END_TWIG_BLOCK %}</div>\r\n										</td>\r\n									</tr>\r\n								</tbody></table>\r\n							</td>\r\n						</tr>\r\n					<!-- END MAIN CONTENT AREA -->\r\n					</tbody></table>\r\n					<!-- END CENTERED WHITE CONTAINER -->\r\n					<!-- START FOOTER -->\r\n					<div class=\"footer\" style=\"clear: both; margin-top: 10px; text-align: center; width: 100%;\">\r\n						<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;\" width=\"100%\" data-section=\"1\">\r\n							<tbody><tr>\r\n								<td class=\"content-block ui-sortable\" style=\"font-family: Verdana,Geneva,sans-serif; vertical-align: top; padding-bottom: 10px; padding-top: 10px; color: #999999; font-size: 12px; line-height: 1.2; text-align: center;\" valign=\"top\" align=\"center\" data-slot-container=\"1\">\r\n									<div data-slot=\"text\">{% TWIG_BLOCK %}{{ include(\'dc:z9-dezabonare\') }}{% END_TWIG_BLOCK %}</div>\r\n								</td>\r\n							</tr>\r\n						</tbody></table>\r\n					</div>\r\n					<!-- END FOOTER -->\r\n				</div>\r\n			</td>\r\n			<td> </td>\r\n		</tr>\r\n	</tbody></table>\r\n</body></html>','template',NULL,NULL,0,0,0,0,1,'ro','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}','[]',0);
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `focus`
--

DROP TABLE IF EXISTS `focus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `focus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `focus_type` varchar(191) NOT NULL,
  `style` varchar(191) NOT NULL,
  `website` varchar(191) DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `properties` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `utm_tags` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `form_id` int(11) DEFAULT NULL,
  `cache` longtext DEFAULT NULL,
  `html_mode` varchar(191) DEFAULT NULL,
  `editor` longtext DEFAULT NULL,
  `html` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_62C04AE912469DE2` (`category_id`),
  KEY `focus_type` (`focus_type`),
  KEY `focus_style` (`style`),
  KEY `focus_form` (`form_id`),
  CONSTRAINT `FK_62C04AE912469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `focus`
--

LOCK TABLES `focus` WRITE;
/*!40000 ALTER TABLE `focus` DISABLE KEYS */;
/*!40000 ALTER TABLE `focus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `focus_stats`
--

DROP TABLE IF EXISTS `focus_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `focus_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `focus_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(191) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C36970DC51804B42` (`focus_id`),
  KEY `IDX_C36970DC55458D` (`lead_id`),
  KEY `focus_type` (`type`),
  KEY `focus_type_id` (`type`,`type_id`),
  KEY `focus_date_added` (`date_added`),
  CONSTRAINT `FK_C36970DC51804B42` FOREIGN KEY (`focus_id`) REFERENCES `focus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C36970DC55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `focus_stats`
--

LOCK TABLES `focus_stats` WRITE;
/*!40000 ALTER TABLE `focus_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `focus_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_actions`
--

DROP TABLE IF EXISTS `form_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `action_order` int(11) NOT NULL,
  `properties` longtext NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_342491D45FF69B7D` (`form_id`),
  KEY `form_action_type_search` (`type`),
  CONSTRAINT `FK_342491D45FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_actions`
--

LOCK TABLES `form_actions` WRITE;
/*!40000 ALTER TABLE `form_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_fields`
--

DROP TABLE IF EXISTS `form_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) unsigned NOT NULL,
  `label` longtext NOT NULL,
  `show_label` tinyint(1) DEFAULT NULL,
  `alias` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `is_custom` tinyint(1) NOT NULL,
  `custom_parameters` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `default_value` longtext DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL,
  `validation_message` longtext DEFAULT NULL,
  `help_message` longtext DEFAULT NULL,
  `field_order` int(11) DEFAULT NULL,
  `properties` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `validation` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `parent_id` varchar(191) DEFAULT NULL,
  `conditions` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `label_attr` varchar(191) DEFAULT NULL,
  `input_attr` varchar(191) DEFAULT NULL,
  `container_attr` varchar(191) DEFAULT NULL,
  `lead_field` varchar(191) DEFAULT NULL,
  `save_result` tinyint(1) DEFAULT NULL,
  `is_auto_fill` tinyint(1) DEFAULT NULL,
  `show_when_value_exists` tinyint(1) DEFAULT NULL,
  `show_after_x_submissions` int(11) DEFAULT NULL,
  `always_display` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7C0B37265FF69B7D` (`form_id`),
  KEY `form_field_type_search` (`type`),
  CONSTRAINT `FK_7C0B37265FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_fields`
--

LOCK TABLES `form_fields` WRITE;
/*!40000 ALTER TABLE `form_fields` DISABLE KEYS */;
INSERT INTO `form_fields` VALUES
(1,1,'Prenume',0,'prenume','text',0,'a:0:{}',NULL,1,'Te rog să introduci prenumele tau.',NULL,1,'a:1:{s:11:\"placeholder\";s:8:\"Prenume*\";}','[]',NULL,'[]',NULL,NULL,NULL,'firstname',1,1,1,NULL,1),
(2,1,'Email',0,'email','email',0,'a:0:{}',NULL,1,'Te rog să introduci adresa ta de email principală.',NULL,2,'a:1:{s:11:\"placeholder\";s:6:\"Email*\";}','[]',NULL,'[]',NULL,NULL,NULL,'email',1,1,1,NULL,1),
(3,1,'Email2',0,'email2','email',0,'a:0:{}',NULL,0,NULL,NULL,3,'a:1:{s:11:\"placeholder\";s:18:\"Confirm your email\";}','[]',NULL,'[]',NULL,NULL,'class=\"mauticform-field-hidden\"','capcana',1,0,1,NULL,1),
(4,1,'Vreau materialul',1,'submit','button',0,'a:0:{}',NULL,0,NULL,NULL,5,'a:0:{}','[]',NULL,'[]',NULL,'class=\"btn btn-default\"',NULL,NULL,1,0,NULL,NULL,NULL),
(5,1,'GDPR',0,'gdpr','checkboxgrp',0,'a:0:{}',NULL,1,'Te rog să citeşti şi să fii de acord cu politica de confidenţialitate.',NULL,4,'a:3:{s:8:\"syncList\";i:0;s:10:\"optionlist\";a:1:{s:4:\"list\";a:1:{i:0;a:2:{s:5:\"label\";s:130:\"Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a>\";s:5:\"value\";i:1;}}}s:15:\"labelAttributes\";N;}','[]',NULL,'[]',NULL,NULL,'style=\"display:inline-block;\"',NULL,1,1,1,NULL,1),
(6,2,'Prenume',0,'prenume','text',0,'a:0:{}',NULL,1,'Te rog să introduci prenumele tau.',NULL,1,'a:1:{s:11:\"placeholder\";s:8:\"Prenume*\";}','[]',NULL,'[]',NULL,NULL,NULL,'firstname',1,1,1,NULL,1),
(7,2,'Email',0,'email','email',0,'a:0:{}',NULL,1,'Te rog să introduci adresa ta de email principală.',NULL,2,'a:1:{s:11:\"placeholder\";s:6:\"Email*\";}','[]',NULL,'[]',NULL,NULL,NULL,'email',1,1,1,NULL,1),
(8,2,'Email2',0,'email2','email',0,'a:0:{}',NULL,0,NULL,NULL,3,'a:1:{s:11:\"placeholder\";s:18:\"Confirm your email\";}','[]',NULL,'[]',NULL,NULL,'class=\"mauticform-field-hidden\"','capcana',1,0,1,NULL,1),
(9,2,'GDPR',0,'gdpr','checkboxgrp',0,'a:0:{}',NULL,1,'Te rog să fii de acord cu politica de confidenţialitate.',NULL,4,'a:3:{s:8:\"syncList\";i:0;s:10:\"optionlist\";a:1:{s:4:\"list\";a:1:{i:0;a:2:{s:5:\"label\";s:130:\"Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a>\";s:5:\"value\";i:1;}}}s:15:\"labelAttributes\";N;}','[]',NULL,'[]',NULL,NULL,'style=\"display:inline-block;\"',NULL,1,1,1,NULL,1),
(10,2,'Particip LIVE',1,'submit','button',0,'a:0:{}',NULL,0,NULL,NULL,5,'a:0:{}','[]',NULL,'[]',NULL,'class=\"btn btn-default\"',NULL,NULL,1,0,NULL,NULL,NULL),
(11,3,'Prenume',0,'prenume','text',0,'a:0:{}',NULL,1,'Te rog să introduci prenumele tau.',NULL,1,'a:1:{s:11:\"placeholder\";s:8:\"Prenume*\";}','[]',NULL,'[]',NULL,NULL,NULL,'firstname',1,1,1,NULL,1),
(12,3,'Email',0,'email','email',0,'a:0:{}',NULL,1,'Te rog să introduci adresa ta de email principală.',NULL,2,'a:1:{s:11:\"placeholder\";s:6:\"Email*\";}','[]',NULL,'[]',NULL,NULL,NULL,'email',1,1,1,NULL,1),
(13,3,'Email2',0,'email2','email',0,'a:0:{}',NULL,0,NULL,NULL,3,'a:1:{s:11:\"placeholder\";s:18:\"Confirm your email\";}','[]',NULL,'[]',NULL,NULL,'class=\"mauticform-field-hidden\"','capcana',1,0,1,NULL,1),
(14,3,'GDPR2',0,'gdpr2','checkboxgrp',0,'a:0:{}',NULL,1,'Te rog să fii de acord cu politica de confidenţialitate.',NULL,4,'a:3:{s:8:\"syncList\";i:0;s:10:\"optionlist\";a:1:{s:4:\"list\";a:1:{i:0;a:2:{s:5:\"label\";s:130:\"Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a>\";s:5:\"value\";i:1;}}}s:15:\"labelAttributes\";N;}','[]',NULL,'[]',NULL,NULL,'style=\"display:inline-block;\"',NULL,1,1,1,NULL,1),
(15,3,'Vreau să particip LIVE',1,'submit','button',0,'a:0:{}',NULL,0,NULL,NULL,5,'a:0:{}','[]',NULL,'[]',NULL,'class=\"btn btn-default\"',NULL,NULL,1,0,NULL,NULL,NULL),
(16,4,'Prenume',0,'prenume','text',0,'a:0:{}',NULL,1,'Te rog să introduci prenumele tau.',NULL,1,'a:1:{s:11:\"placeholder\";s:8:\"Prenume*\";}','[]',NULL,'[]',NULL,NULL,NULL,'firstname',1,1,1,NULL,1),
(17,4,'Email',0,'email','email',0,'a:0:{}',NULL,1,'Te rog să introduci adresa ta de email principală.',NULL,2,'a:1:{s:11:\"placeholder\";s:6:\"Email*\";}','[]',NULL,'[]',NULL,NULL,NULL,'email',1,1,1,NULL,1),
(18,4,'Email2',0,'email2','email',0,'a:0:{}',NULL,0,NULL,NULL,3,'a:1:{s:11:\"placeholder\";s:18:\"Confirm your email\";}','[]',NULL,'[]',NULL,NULL,'class=\"mauticform-field-hidden\"','capcana',1,0,1,NULL,1),
(19,4,'GDPR',0,'gdpr','checkboxgrp',0,'a:0:{}',NULL,1,'Te rog să fii de acord cu politica de confidenţialitate.',NULL,4,'a:3:{s:8:\"syncList\";i:0;s:10:\"optionlist\";a:1:{s:4:\"list\";a:1:{i:0;a:2:{s:5:\"label\";s:130:\"Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a>\";s:5:\"value\";i:1;}}}s:15:\"labelAttributes\";N;}','[]',NULL,'[]',NULL,NULL,'style=\"display:inline-block;\"',NULL,1,1,1,NULL,1),
(20,4,'Trimite-mi Materialul',1,'submit','button',0,'a:0:{}',NULL,0,NULL,NULL,5,'a:0:{}','[]',NULL,'[]',NULL,'class=\"btn btn-default\"',NULL,NULL,1,0,NULL,NULL,NULL),
(21,5,'Prenume',0,'prenume','text',0,'a:0:{}',NULL,1,'Te rog să introduci prenumele tau.',NULL,1,'a:1:{s:11:\"placeholder\";s:8:\"Prenume*\";}','[]',NULL,'[]',NULL,NULL,NULL,'firstname',1,1,1,NULL,1),
(22,5,'Email',0,'email','email',0,'a:0:{}',NULL,1,'Te rog să introduci adresa ta de email principală.',NULL,2,'a:1:{s:11:\"placeholder\";s:6:\"Email*\";}','[]',NULL,'[]',NULL,NULL,NULL,'email',1,1,1,NULL,1),
(23,5,'Email2',0,'email2','email',0,'a:0:{}',NULL,0,NULL,NULL,3,'a:1:{s:11:\"placeholder\";s:18:\"Confirm your email\";}','[]',NULL,'[]',NULL,NULL,'class=\"mauticform-field-hidden\"','capcana',1,0,1,NULL,1),
(24,5,'GDPR2',0,'gdpr2','checkboxgrp',0,'a:0:{}',NULL,1,'Te rog să fii de acord cu politica de confidenţialitate.',NULL,4,'a:3:{s:8:\"syncList\";i:0;s:10:\"optionlist\";a:1:{s:4:\"list\";a:1:{i:0;a:2:{s:5:\"label\";s:130:\"Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a>\";s:5:\"value\";i:1;}}}s:15:\"labelAttributes\";N;}','[]',NULL,'[]',NULL,NULL,'style=\"display:inline-block;\"',NULL,1,1,1,NULL,1),
(25,5,'Vreau Materialul',1,'submit','button',0,'a:0:{}',NULL,0,NULL,NULL,5,'a:0:{}','[]',NULL,'[]',NULL,'class=\"btn btn-default\"',NULL,NULL,1,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `form_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_results_1_z9sablon`
--

DROP TABLE IF EXISTS `form_results_1_z9sablon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_results_1_z9sablon` (
  `submission_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `prenume` longtext DEFAULT NULL,
  `email` longtext DEFAULT NULL,
  `email2` longtext DEFAULT NULL,
  `gdpr` longtext DEFAULT NULL,
  PRIMARY KEY (`submission_id`),
  UNIQUE KEY `UNIQ_392A6E52E1FD49335FF69B7D` (`submission_id`,`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_results_1_z9sablon`
--

LOCK TABLES `form_results_1_z9sablon` WRITE;
/*!40000 ALTER TABLE `form_results_1_z9sablon` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_results_1_z9sablon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_results_2_wgsus`
--

DROP TABLE IF EXISTS `form_results_2_wgsus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_results_2_wgsus` (
  `submission_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `prenume` longtext DEFAULT NULL,
  `email` longtext DEFAULT NULL,
  `email2` longtext DEFAULT NULL,
  `gdpr` longtext DEFAULT NULL,
  PRIMARY KEY (`submission_id`),
  UNIQUE KEY `UNIQ_78568B8EE1FD49335FF69B7D` (`submission_id`,`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_results_2_wgsus`
--

LOCK TABLES `form_results_2_wgsus` WRITE;
/*!40000 ALTER TABLE `form_results_2_wgsus` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_results_2_wgsus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_results_3_wgjos`
--

DROP TABLE IF EXISTS `form_results_3_wgjos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_results_3_wgjos` (
  `submission_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `prenume` longtext DEFAULT NULL,
  `email` longtext DEFAULT NULL,
  `email2` longtext DEFAULT NULL,
  `gdpr2` longtext DEFAULT NULL,
  PRIMARY KEY (`submission_id`),
  UNIQUE KEY `UNIQ_7DFBE21EE1FD49335FF69B7D` (`submission_id`,`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_results_3_wgjos`
--

LOCK TABLES `form_results_3_wgjos` WRITE;
/*!40000 ALTER TABLE `form_results_3_wgjos` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_results_3_wgjos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_results_4_sesus`
--

DROP TABLE IF EXISTS `form_results_4_sesus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_results_4_sesus` (
  `submission_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `prenume` longtext DEFAULT NULL,
  `email` longtext DEFAULT NULL,
  `email2` longtext DEFAULT NULL,
  `gdpr` longtext DEFAULT NULL,
  PRIMARY KEY (`submission_id`),
  UNIQUE KEY `UNIQ_440FD0FFE1FD49335FF69B7D` (`submission_id`,`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_results_4_sesus`
--

LOCK TABLES `form_results_4_sesus` WRITE;
/*!40000 ALTER TABLE `form_results_4_sesus` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_results_4_sesus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_results_5_sejos`
--

DROP TABLE IF EXISTS `form_results_5_sejos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_results_5_sejos` (
  `submission_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `prenume` longtext DEFAULT NULL,
  `email` longtext DEFAULT NULL,
  `email2` longtext DEFAULT NULL,
  `gdpr2` longtext DEFAULT NULL,
  PRIMARY KEY (`submission_id`),
  UNIQUE KEY `UNIQ_41A2B96FE1FD49335FF69B7D` (`submission_id`,`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_results_5_sejos`
--

LOCK TABLES `form_results_5_sejos` WRITE;
/*!40000 ALTER TABLE `form_results_5_sejos` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_results_5_sejos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_submissions`
--

DROP TABLE IF EXISTS `form_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_submissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) unsigned NOT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  `tracking_id` varchar(191) DEFAULT NULL,
  `date_submitted` datetime NOT NULL,
  `referer` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C80AF9E65FF69B7D` (`form_id`),
  KEY `IDX_C80AF9E6A03F5E9F` (`ip_id`),
  KEY `IDX_C80AF9E655458D` (`lead_id`),
  KEY `IDX_C80AF9E6C4663E4` (`page_id`),
  KEY `form_submission_tracking_search` (`tracking_id`),
  KEY `form_date_submitted` (`date_submitted`),
  CONSTRAINT `FK_C80AF9E655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_C80AF9E65FF69B7D` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C80AF9E6A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_C80AF9E6C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_submissions`
--

LOCK TABLES `form_submissions` WRITE;
/*!40000 ALTER TABLE `form_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forms`
--

DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `alias` varchar(191) NOT NULL,
  `form_attr` varchar(191) DEFAULT NULL,
  `cached_html` longtext DEFAULT NULL,
  `post_action` varchar(191) NOT NULL,
  `post_action_property` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `template` varchar(191) DEFAULT NULL,
  `in_kiosk_mode` tinyint(1) DEFAULT NULL,
  `render_style` tinyint(1) DEFAULT NULL,
  `form_type` varchar(191) DEFAULT NULL,
  `no_index` tinyint(1) DEFAULT NULL,
  `progressive_profiling_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FD3F1BF712469DE2` (`category_id`),
  CONSTRAINT `FK_FD3F1BF712469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forms`
--

LOCK TABLES `forms` WRITE;
/*!40000 ALTER TABLE `forms` DISABLE KEYS */;
INSERT INTO `forms` VALUES
(1,NULL,1,'2024-03-06 18:58:00',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 07:48:57',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Z9-Sablon','<p>Foloseşte acest formular ca un şablon (nu-l modifica, ci creează o clonă) sau ca inspiraţie.</p>','z9sablon',NULL,'\n<style type=\"text/css\" scoped>\n    .mauticform-field-hidden { display:none }\n</style>\n\n<div id=\"mauticform_wrapper_z9sablon\" class=\"mauticform_wrapper\">\n    <form autocomplete=\"false\" role=\"form\" method=\"post\" action=\"https://###MAUTIC_SUBDOMAIN###/form/submit?formId=1\" id=\"mauticform_z9sablon\"  data-mautic-form=\"z9sablon\" enctype=\"multipart/form-data\" >\n        <div class=\"mauticform-error\" id=\"mauticform_z9sablon_error\"></div>\n        <div class=\"mauticform-message\" id=\"mauticform_z9sablon_message\"></div>\n        <div class=\"mauticform-innerform\">\n            \n          <div class=\"mauticform-page-wrapper mauticform-page-1\" data-mautic-form-page=\"1\">\n\n            <div id=\"mauticform_z9sablon_prenume\"  data-validate=\"prenume\" data-validation-type=\"text\" class=\"mauticform-row mauticform-text mauticform-field-1 mauticform-required\">\n                <input id=\"mauticform_input_z9sablon_prenume\" name=\"mauticform[prenume]\" value=\"\" placeholder=\"Prenume*\" class=\"mauticform-input\" type=\"text\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci prenumele tau.</span>\n            </div>\n\n            <div id=\"mauticform_z9sablon_email\"  data-validate=\"email\" data-validation-type=\"email\" class=\"mauticform-row mauticform-email mauticform-field-2 mauticform-required\">\n                <input id=\"mauticform_input_z9sablon_email\" name=\"mauticform[email]\" value=\"\" placeholder=\"Email*\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci adresa ta de email principală.</span>\n            </div>\n\n            <div id=\"mauticform_z9sablon_email2\" class=\"mauticform-row mauticform-email mauticform-field-3 mauticform-field-hidden\">\n                <input id=\"mauticform_input_z9sablon_email2\" name=\"mauticform[email2]\" value=\"\" placeholder=\"Confirm your email\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\"></span>\n            </div>\n\n            <div id=\"mauticform_z9sablon_gdpr\" style=\"display:inline-block;\" data-validate=\"gdpr\" data-validation-type=\"checkboxgrp\" class=\"mauticform-row mauticform-checkboxgrp mauticform-field-4 mauticform-required\">\n                <div class=\"mauticform-checkboxgrp-row\">                    <input  class=\"mauticform-checkboxgrp-checkbox\" name=\"mauticform[gdpr][]\" id=\"mauticform_checkboxgrp_checkbox_gdpr_10\" type=\"checkbox\" value=\"1\" />\n                    <label id=\"mauticform_checkboxgrp_label_gdpr_10\" for=\"mauticform_checkboxgrp_checkbox_gdpr_10\"  class=\"mauticform-checkboxgrp-label\">Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a></label>\n                </div>\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să citeşti şi să fii de acord cu politica de confidenţialitate.</span>\n            </div>\n\n            <div id=\"mauticform_z9sablon_submit\"  class=\"mauticform-row mauticform-button-wrapper mauticform-field-5\">\n                <button type=\"submit\" name=\"mauticform[submit]\" id=\"mauticform_input_z9sablon_submit\" name=\"mauticform[submit]\" value=\"\" class=\"mauticform-button btn btn-default\" value=\"1\">Vreau materialul</button>\n            </div>\n            </div>\n        </div>\n\n        <input type=\"hidden\" name=\"mauticform[formId]\" id=\"mauticform_z9sablon_id\" value=\"1\"/>\n        <input type=\"hidden\" name=\"mauticform[return]\" id=\"mauticform_z9sablon_return\" value=\"\"/>\n        <input type=\"hidden\" name=\"mauticform[formName]\" id=\"mauticform_z9sablon_name\" value=\"z9sablon\"/>\n\n        </form>\n</div>\n','message','Confirm că vei primi informaţiile cerute pe email.',NULL,NULL,NULL,0,0,'campaign',1,NULL),
(2,1,1,'2024-04-20 07:51:19',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 08:44:21',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-SUS','<p>Formularul de SUS de pe pagina de abonare la webinar: <a href=\"https://###MAIN_DOMAIN###/webinar/\">https://###MAIN_DOMAIN###/webinar/</a></p>','wgsus',NULL,'\n<style type=\"text/css\" scoped>\n    .mauticform-field-hidden { display:none }\n</style>\n\n<div id=\"mauticform_wrapper_wgsus\" class=\"mauticform_wrapper\">\n    <form autocomplete=\"false\" role=\"form\" method=\"post\" action=\"https://###MAUTIC_SUBDOMAIN###/form/submit?formId=2\" id=\"mauticform_wgsus\"  data-mautic-form=\"wgsus\" enctype=\"multipart/form-data\" >\n        <div class=\"mauticform-error\" id=\"mauticform_wgsus_error\"></div>\n        <div class=\"mauticform-message\" id=\"mauticform_wgsus_message\"></div>\n        <div class=\"mauticform-innerform\">\n            \n          <div class=\"mauticform-page-wrapper mauticform-page-1\" data-mautic-form-page=\"1\">\n\n            <div id=\"mauticform_wgsus_prenume\"  data-validate=\"prenume\" data-validation-type=\"text\" class=\"mauticform-row mauticform-text mauticform-field-1 mauticform-required\">\n                <input id=\"mauticform_input_wgsus_prenume\" name=\"mauticform[prenume]\" value=\"\" placeholder=\"Prenume*\" class=\"mauticform-input\" type=\"text\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci prenumele tau.</span>\n            </div>\n\n            <div id=\"mauticform_wgsus_email\"  data-validate=\"email\" data-validation-type=\"email\" class=\"mauticform-row mauticform-email mauticform-field-2 mauticform-required\">\n                <input id=\"mauticform_input_wgsus_email\" name=\"mauticform[email]\" value=\"\" placeholder=\"Email*\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci adresa ta de email principală.</span>\n            </div>\n\n            <div id=\"mauticform_wgsus_email2\" class=\"mauticform-row mauticform-email mauticform-field-3 mauticform-field-hidden\">\n                <input id=\"mauticform_input_wgsus_email2\" name=\"mauticform[email2]\" value=\"\" placeholder=\"Confirm your email\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\"></span>\n            </div>\n\n            <div id=\"mauticform_wgsus_gdpr\" style=\"display:inline-block;\" data-validate=\"gdpr\" data-validation-type=\"checkboxgrp\" class=\"mauticform-row mauticform-checkboxgrp mauticform-field-4 mauticform-required\">\n                <div class=\"mauticform-checkboxgrp-row\">                    <input  class=\"mauticform-checkboxgrp-checkbox\" name=\"mauticform[gdpr][]\" id=\"mauticform_checkboxgrp_checkbox_gdpr_10\" type=\"checkbox\" value=\"1\" />\n                    <label id=\"mauticform_checkboxgrp_label_gdpr_10\" for=\"mauticform_checkboxgrp_checkbox_gdpr_10\"  class=\"mauticform-checkboxgrp-label\">Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a></label>\n                </div>\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să fii de acord cu politica de confidenţialitate.</span>\n            </div>\n\n            <div id=\"mauticform_wgsus_submit\"  class=\"mauticform-row mauticform-button-wrapper mauticform-field-5\">\n                <button type=\"submit\" name=\"mauticform[submit]\" id=\"mauticform_input_wgsus_submit\" name=\"mauticform[submit]\" value=\"\" class=\"mauticform-button btn btn-default\" value=\"1\">Particip LIVE</button>\n            </div>\n            </div>\n        </div>\n\n        <input type=\"hidden\" name=\"mauticform[formId]\" id=\"mauticform_wgsus_id\" value=\"2\"/>\n        <input type=\"hidden\" name=\"mauticform[return]\" id=\"mauticform_wgsus_return\" value=\"\"/>\n        <input type=\"hidden\" name=\"mauticform[formName]\" id=\"mauticform_wgsus_name\" value=\"wgsus\"/>\n\n        </form>\n</div>\n','redirect','https://###MAIN_DOMAIN###/multumesc/',NULL,NULL,NULL,0,0,'campaign',1,NULL),
(3,1,1,'2024-04-20 08:44:08',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 08:44:08',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'WG-JOS','<p>Formularul de JOS de pe pagina de abonare la webinar: <a href=\"https://###MAIN_DOMAIN###/webinar/\">https://###MAIN_DOMAIN###/webinar/</a></p>','wgjos',NULL,'\n<style type=\"text/css\" scoped>\n    .mauticform-field-hidden { display:none }\n</style>\n\n<div id=\"mauticform_wrapper_wgjos\" class=\"mauticform_wrapper\">\n    <form autocomplete=\"false\" role=\"form\" method=\"post\" action=\"https://###MAUTIC_SUBDOMAIN###/form/submit?formId=3\" id=\"mauticform_wgjos\"  data-mautic-form=\"wgjos\" enctype=\"multipart/form-data\" >\n        <div class=\"mauticform-error\" id=\"mauticform_wgjos_error\"></div>\n        <div class=\"mauticform-message\" id=\"mauticform_wgjos_message\"></div>\n        <div class=\"mauticform-innerform\">\n            \n          <div class=\"mauticform-page-wrapper mauticform-page-1\" data-mautic-form-page=\"1\">\n\n            <div id=\"mauticform_wgjos_prenume\"  data-validate=\"prenume\" data-validation-type=\"text\" class=\"mauticform-row mauticform-text mauticform-field-1 mauticform-required\">\n                <input id=\"mauticform_input_wgjos_prenume\" name=\"mauticform[prenume]\" value=\"\" placeholder=\"Prenume*\" class=\"mauticform-input\" type=\"text\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci prenumele tau.</span>\n            </div>\n\n            <div id=\"mauticform_wgjos_email\"  data-validate=\"email\" data-validation-type=\"email\" class=\"mauticform-row mauticform-email mauticform-field-2 mauticform-required\">\n                <input id=\"mauticform_input_wgjos_email\" name=\"mauticform[email]\" value=\"\" placeholder=\"Email*\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci adresa ta de email principală.</span>\n            </div>\n\n            <div id=\"mauticform_wgjos_email2\" class=\"mauticform-row mauticform-email mauticform-field-3 mauticform-field-hidden\">\n                <input id=\"mauticform_input_wgjos_email2\" name=\"mauticform[email2]\" value=\"\" placeholder=\"Confirm your email\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\"></span>\n            </div>\n\n            <div id=\"mauticform_wgjos_gdpr2\" style=\"display:inline-block;\" data-validate=\"gdpr2\" data-validation-type=\"checkboxgrp\" class=\"mauticform-row mauticform-checkboxgrp mauticform-field-4 mauticform-required\">\n                <div class=\"mauticform-checkboxgrp-row\">                    <input  class=\"mauticform-checkboxgrp-checkbox\" name=\"mauticform[gdpr2][]\" id=\"mauticform_checkboxgrp_checkbox_gdpr2_10\" type=\"checkbox\" value=\"1\" />\n                    <label id=\"mauticform_checkboxgrp_label_gdpr2_10\" for=\"mauticform_checkboxgrp_checkbox_gdpr2_10\"  class=\"mauticform-checkboxgrp-label\">Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a></label>\n                </div>\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să fii de acord cu politica de confidenţialitate.</span>\n            </div>\n\n            <div id=\"mauticform_wgjos_submit\"  class=\"mauticform-row mauticform-button-wrapper mauticform-field-5\">\n                <button type=\"submit\" name=\"mauticform[submit]\" id=\"mauticform_input_wgjos_submit\" name=\"mauticform[submit]\" value=\"\" class=\"mauticform-button btn btn-default\" value=\"1\">Vreau să particip LIVE</button>\n            </div>\n            </div>\n        </div>\n\n        <input type=\"hidden\" name=\"mauticform[formId]\" id=\"mauticform_wgjos_id\" value=\"3\"/>\n        <input type=\"hidden\" name=\"mauticform[return]\" id=\"mauticform_wgjos_return\" value=\"\"/>\n        <input type=\"hidden\" name=\"mauticform[formName]\" id=\"mauticform_wgjos_name\" value=\"wgjos\"/>\n\n        </form>\n</div>\n','redirect','https://###MAIN_DOMAIN###/multumesc/',NULL,NULL,NULL,0,0,'campaign',1,NULL),
(4,3,1,'2024-04-20 08:51:41',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 08:51:41',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'SE-SUS','<p>Formularul de SUS de pe pagina de abonare la magnet: <a href=\"https://###MAIN_DOMAIN###/material/\">https://###MAIN_DOMAIN###/material/</a></p>','sesus',NULL,'\n<style type=\"text/css\" scoped>\n    .mauticform-field-hidden { display:none }\n</style>\n\n<div id=\"mauticform_wrapper_sesus\" class=\"mauticform_wrapper\">\n    <form autocomplete=\"false\" role=\"form\" method=\"post\" action=\"https://###MAUTIC_SUBDOMAIN###/form/submit?formId=4\" id=\"mauticform_sesus\"  data-mautic-form=\"sesus\" enctype=\"multipart/form-data\" >\n        <div class=\"mauticform-error\" id=\"mauticform_sesus_error\"></div>\n        <div class=\"mauticform-message\" id=\"mauticform_sesus_message\"></div>\n        <div class=\"mauticform-innerform\">\n            \n          <div class=\"mauticform-page-wrapper mauticform-page-1\" data-mautic-form-page=\"1\">\n\n            <div id=\"mauticform_sesus_prenume\"  data-validate=\"prenume\" data-validation-type=\"text\" class=\"mauticform-row mauticform-text mauticform-field-1 mauticform-required\">\n                <input id=\"mauticform_input_sesus_prenume\" name=\"mauticform[prenume]\" value=\"\" placeholder=\"Prenume*\" class=\"mauticform-input\" type=\"text\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci prenumele tau.</span>\n            </div>\n\n            <div id=\"mauticform_sesus_email\"  data-validate=\"email\" data-validation-type=\"email\" class=\"mauticform-row mauticform-email mauticform-field-2 mauticform-required\">\n                <input id=\"mauticform_input_sesus_email\" name=\"mauticform[email]\" value=\"\" placeholder=\"Email*\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci adresa ta de email principală.</span>\n            </div>\n\n            <div id=\"mauticform_sesus_email2\" class=\"mauticform-row mauticform-email mauticform-field-3 mauticform-field-hidden\">\n                <input id=\"mauticform_input_sesus_email2\" name=\"mauticform[email2]\" value=\"\" placeholder=\"Confirm your email\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\"></span>\n            </div>\n\n            <div id=\"mauticform_sesus_gdpr\" style=\"display:inline-block;\" data-validate=\"gdpr\" data-validation-type=\"checkboxgrp\" class=\"mauticform-row mauticform-checkboxgrp mauticform-field-4 mauticform-required\">\n                <div class=\"mauticform-checkboxgrp-row\">                    <input  class=\"mauticform-checkboxgrp-checkbox\" name=\"mauticform[gdpr][]\" id=\"mauticform_checkboxgrp_checkbox_gdpr_10\" type=\"checkbox\" value=\"1\" />\n                    <label id=\"mauticform_checkboxgrp_label_gdpr_10\" for=\"mauticform_checkboxgrp_checkbox_gdpr_10\"  class=\"mauticform-checkboxgrp-label\">Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a></label>\n                </div>\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să fii de acord cu politica de confidenţialitate.</span>\n            </div>\n\n            <div id=\"mauticform_sesus_submit\"  class=\"mauticform-row mauticform-button-wrapper mauticform-field-5\">\n                <button type=\"submit\" name=\"mauticform[submit]\" id=\"mauticform_input_sesus_submit\" name=\"mauticform[submit]\" value=\"\" class=\"mauticform-button btn btn-default\" value=\"1\">Trimite-mi Materialul</button>\n            </div>\n            </div>\n        </div>\n\n        <input type=\"hidden\" name=\"mauticform[formId]\" id=\"mauticform_sesus_id\" value=\"4\"/>\n        <input type=\"hidden\" name=\"mauticform[return]\" id=\"mauticform_sesus_return\" value=\"\"/>\n        <input type=\"hidden\" name=\"mauticform[formName]\" id=\"mauticform_sesus_name\" value=\"sesus\"/>\n\n        </form>\n</div>\n','redirect','https://###MAIN_DOMAIN###/multumesc/',NULL,NULL,NULL,0,0,'campaign',1,NULL),
(5,3,1,'2024-04-20 08:52:30',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 08:52:30',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'SE-JOS','<p>Formularul de JOS de pe pagina de abonare la magnet: <a href=\"https://###MAIN_DOMAIN###/material/\">https://###MAIN_DOMAIN###/material/</a></p>','sejos',NULL,'\n<style type=\"text/css\" scoped>\n    .mauticform-field-hidden { display:none }\n</style>\n\n<div id=\"mauticform_wrapper_sejos\" class=\"mauticform_wrapper\">\n    <form autocomplete=\"false\" role=\"form\" method=\"post\" action=\"https://###MAUTIC_SUBDOMAIN###/form/submit?formId=5\" id=\"mauticform_sejos\"  data-mautic-form=\"sejos\" enctype=\"multipart/form-data\" >\n        <div class=\"mauticform-error\" id=\"mauticform_sejos_error\"></div>\n        <div class=\"mauticform-message\" id=\"mauticform_sejos_message\"></div>\n        <div class=\"mauticform-innerform\">\n            \n          <div class=\"mauticform-page-wrapper mauticform-page-1\" data-mautic-form-page=\"1\">\n\n            <div id=\"mauticform_sejos_prenume\"  data-validate=\"prenume\" data-validation-type=\"text\" class=\"mauticform-row mauticform-text mauticform-field-1 mauticform-required\">\n                <input id=\"mauticform_input_sejos_prenume\" name=\"mauticform[prenume]\" value=\"\" placeholder=\"Prenume*\" class=\"mauticform-input\" type=\"text\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci prenumele tau.</span>\n            </div>\n\n            <div id=\"mauticform_sejos_email\"  data-validate=\"email\" data-validation-type=\"email\" class=\"mauticform-row mauticform-email mauticform-field-2 mauticform-required\">\n                <input id=\"mauticform_input_sejos_email\" name=\"mauticform[email]\" value=\"\" placeholder=\"Email*\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să introduci adresa ta de email principală.</span>\n            </div>\n\n            <div id=\"mauticform_sejos_email2\" class=\"mauticform-row mauticform-email mauticform-field-3 mauticform-field-hidden\">\n                <input id=\"mauticform_input_sejos_email2\" name=\"mauticform[email2]\" value=\"\" placeholder=\"Confirm your email\" class=\"mauticform-input\" type=\"email\" />\n                <span class=\"mauticform-errormsg\" style=\"display: none;\"></span>\n            </div>\n\n            <div id=\"mauticform_sejos_gdpr2\" style=\"display:inline-block;\" data-validate=\"gdpr2\" data-validation-type=\"checkboxgrp\" class=\"mauticform-row mauticform-checkboxgrp mauticform-field-4 mauticform-required\">\n                <div class=\"mauticform-checkboxgrp-row\">                    <input  class=\"mauticform-checkboxgrp-checkbox\" name=\"mauticform[gdpr2][]\" id=\"mauticform_checkboxgrp_checkbox_gdpr2_10\" type=\"checkbox\" value=\"1\" />\n                    <label id=\"mauticform_checkboxgrp_label_gdpr2_10\" for=\"mauticform_checkboxgrp_checkbox_gdpr2_10\"  class=\"mauticform-checkboxgrp-label\">Sunt de acord cu <a href=\"https://###MAIN_DOMAIN###/politica-de-confidentialitate\" target=\"_blank\">politica de confidenţialitate</a></label>\n                </div>\n                <span class=\"mauticform-errormsg\" style=\"display: none;\">Te rog să fii de acord cu politica de confidenţialitate.</span>\n            </div>\n\n            <div id=\"mauticform_sejos_submit\"  class=\"mauticform-row mauticform-button-wrapper mauticform-field-5\">\n                <button type=\"submit\" name=\"mauticform[submit]\" id=\"mauticform_input_sejos_submit\" name=\"mauticform[submit]\" value=\"\" class=\"mauticform-button btn btn-default\" value=\"1\">Vreau Materialul</button>\n            </div>\n            </div>\n        </div>\n\n        <input type=\"hidden\" name=\"mauticform[formId]\" id=\"mauticform_sejos_id\" value=\"5\"/>\n        <input type=\"hidden\" name=\"mauticform[return]\" id=\"mauticform_sejos_return\" value=\"\"/>\n        <input type=\"hidden\" name=\"mauticform[formName]\" id=\"mauticform_sejos_name\" value=\"sejos\"/>\n\n        </form>\n</div>\n','redirect','https://###MAIN_DOMAIN###/multumesc/',NULL,NULL,NULL,0,0,'campaign',1,NULL);
/*!40000 ALTER TABLE `forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imports`
--

DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `dir` varchar(191) NOT NULL,
  `file` varchar(191) NOT NULL,
  `original_file` varchar(191) DEFAULT NULL,
  `line_count` int(11) NOT NULL,
  `inserted_count` int(11) NOT NULL,
  `updated_count` int(11) NOT NULL,
  `ignored_count` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `date_started` datetime DEFAULT NULL,
  `date_ended` datetime DEFAULT NULL,
  `object` varchar(191) NOT NULL,
  `properties` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `import_object` (`object`),
  KEY `import_status` (`status`),
  KEY `import_priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imports`
--

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integration_entity`
--

DROP TABLE IF EXISTS `integration_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integration_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_added` datetime NOT NULL,
  `integration` varchar(191) DEFAULT NULL,
  `integration_entity` varchar(191) DEFAULT NULL,
  `integration_entity_id` varchar(191) DEFAULT NULL,
  `internal_entity` varchar(191) DEFAULT NULL,
  `internal_entity_id` int(11) DEFAULT NULL,
  `last_sync_date` datetime DEFAULT NULL,
  `internal` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `integration_external_entity` (`integration`,`integration_entity`,`integration_entity_id`),
  KEY `integration_internal_entity` (`integration`,`internal_entity`,`internal_entity_id`),
  KEY `integration_entity_match` (`integration`,`internal_entity`,`integration_entity`),
  KEY `integration_last_sync_date` (`integration`,`last_sync_date`),
  KEY `internal_integration_entity` (`internal_entity_id`,`integration_entity_id`,`internal_entity`,`integration_entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integration_entity`
--

LOCK TABLES `integration_entity` WRITE;
/*!40000 ALTER TABLE `integration_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `integration_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_addresses`
--

DROP TABLE IF EXISTS `ip_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) NOT NULL,
  `ip_details` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `ip_search` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_addresses`
--

LOCK TABLES `ip_addresses` WRITE;
/*!40000 ALTER TABLE `ip_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_categories`
--

DROP TABLE IF EXISTS `lead_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_12685DF412469DE2` (`category_id`),
  KEY `IDX_12685DF455458D` (`lead_id`),
  CONSTRAINT `FK_12685DF412469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_12685DF455458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_categories`
--

LOCK TABLES `lead_categories` WRITE;
/*!40000 ALTER TABLE `lead_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_companies_change_log`
--

DROP TABLE IF EXISTS `lead_companies_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_companies_change_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `type` tinytext NOT NULL,
  `event_name` varchar(191) NOT NULL,
  `action_name` varchar(191) NOT NULL,
  `company_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A034C81B55458D` (`lead_id`),
  KEY `company_date_added` (`date_added`),
  CONSTRAINT `FK_A034C81B55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_companies_change_log`
--

LOCK TABLES `lead_companies_change_log` WRITE;
/*!40000 ALTER TABLE `lead_companies_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_companies_change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_devices`
--

DROP TABLE IF EXISTS `lead_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `client_info` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `device` varchar(191) DEFAULT NULL,
  `device_os_name` varchar(191) DEFAULT NULL,
  `device_os_shortname` varchar(191) DEFAULT NULL,
  `device_os_version` varchar(191) DEFAULT NULL,
  `device_os_platform` varchar(191) DEFAULT NULL,
  `device_brand` varchar(191) DEFAULT NULL,
  `device_model` varchar(191) DEFAULT NULL,
  `tracking_id` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_48C912F47D05ABBE` (`tracking_id`),
  KEY `IDX_48C912F455458D` (`lead_id`),
  KEY `date_added_search` (`date_added`),
  KEY `device_search` (`device`),
  KEY `device_os_name_search` (`device_os_name`),
  KEY `device_os_shortname_search` (`device_os_shortname`),
  KEY `device_os_version_search` (`device_os_version`),
  KEY `device_os_platform_search` (`device_os_platform`),
  KEY `device_brand_search` (`device_brand`),
  KEY `device_model_search` (`device_model`),
  CONSTRAINT `FK_48C912F455458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_devices`
--

LOCK TABLES `lead_devices` WRITE;
/*!40000 ALTER TABLE `lead_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_donotcontact`
--

DROP TABLE IF EXISTS `lead_donotcontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_donotcontact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `reason` smallint(6) NOT NULL,
  `channel` varchar(191) NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `comments` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_71DC0B1D55458D` (`lead_id`),
  KEY `dnc_reason_search` (`reason`),
  CONSTRAINT `FK_71DC0B1D55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_donotcontact`
--

LOCK TABLES `lead_donotcontact` WRITE;
/*!40000 ALTER TABLE `lead_donotcontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_donotcontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_event_log`
--

DROP TABLE IF EXISTS `lead_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_event_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(191) DEFAULT NULL,
  `bundle` varchar(191) DEFAULT NULL,
  `object` varchar(191) DEFAULT NULL,
  `action` varchar(191) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `properties` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `lead_id_index` (`lead_id`),
  KEY `lead_object_index` (`object`,`object_id`),
  KEY `lead_timeline_index` (`bundle`,`object`,`action`,`object_id`),
  KEY `IDX_SEARCH` (`bundle`,`object`,`action`,`object_id`,`date_added`),
  KEY `lead_timeline_action_index` (`action`),
  KEY `lead_date_added_index` (`date_added`),
  CONSTRAINT `FK_753AF2E55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_event_log`
--

LOCK TABLES `lead_event_log` WRITE;
/*!40000 ALTER TABLE `lead_event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_fields`
--

DROP TABLE IF EXISTS `lead_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `label` varchar(191) NOT NULL,
  `alias` varchar(191) NOT NULL,
  `type` varchar(50) NOT NULL,
  `field_group` varchar(191) DEFAULT NULL,
  `default_value` varchar(191) DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_fixed` tinyint(1) NOT NULL,
  `is_visible` tinyint(1) NOT NULL,
  `is_short_visible` tinyint(1) NOT NULL,
  `is_listable` tinyint(1) NOT NULL,
  `is_publicly_updatable` tinyint(1) NOT NULL,
  `is_unique_identifer` tinyint(1) DEFAULT NULL,
  `field_order` int(11) DEFAULT NULL,
  `object` varchar(191) DEFAULT NULL,
  `properties` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `column_is_not_created` tinyint(1) NOT NULL DEFAULT 0,
  `original_is_published_value` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `search_by_object` (`object`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_fields`
--

LOCK TABLES `lead_fields` WRITE;
/*!40000 ALTER TABLE `lead_fields` DISABLE KEYS */;
INSERT INTO `lead_fields` VALUES
(1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Titlu','title','lookup','core',NULL,0,1,1,0,1,0,0,2,'lead','a:1:{s:4:\"list\";a:2:{i:0;s:3:\"Dl.\";i:1;s:4:\"Dna.\";}}',0,0),
(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prenume','firstname','text','core',NULL,0,1,1,1,1,0,0,3,'lead','a:0:{}',0,0),
(3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Nume de Familie','lastname','text','core',NULL,0,1,1,1,1,0,0,4,'lead','a:0:{}',0,0),
(4,1,NULL,NULL,NULL,'2024-04-20 07:23:34',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,'Nume Firma (contact)','company','text','core',NULL,0,1,1,0,1,0,0,18,'lead','a:0:{}',0,0),
(5,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Pozitia','position','text','core',NULL,0,1,1,0,1,0,0,22,'lead','a:0:{}',0,0),
(6,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Email','email','email','core',NULL,0,1,1,1,1,0,1,5,'lead','a:0:{}',0,0),
(7,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Telefon Mobil','mobile','tel','core',NULL,0,1,1,0,1,0,0,6,'lead','a:0:{}',0,0),
(8,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Telefon Fix','phone','tel','core',NULL,0,1,1,0,1,0,0,7,'lead','a:0:{}',0,0),
(9,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Puncte','points','number','core','0',0,1,1,0,1,0,0,8,'lead','a:2:{s:9:\"roundmode\";s:1:\"3\";s:5:\"scale\";s:0:\"\";}',0,0),
(11,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Adresa 1','address1','text','core',NULL,0,1,1,0,1,0,0,9,'lead','a:0:{}',0,0),
(12,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Adresa 2','address2','text','core',NULL,0,1,1,0,1,0,0,10,'lead','a:0:{}',0,0),
(13,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Oras','city','text','core',NULL,0,1,1,0,1,0,0,11,'lead','a:0:{}',0,0),
(14,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Judet','state','region','core',NULL,0,1,1,0,1,0,0,12,'lead','a:0:{}',0,0),
(15,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cod Postal','zipcode','text','core',NULL,0,1,1,0,1,0,0,13,'lead','a:0:{}',0,0),
(16,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tara','country','country','core',NULL,0,1,1,0,1,0,0,14,'lead','a:0:{}',0,0),
(17,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Limba Preferata','preferred_locale','locale','core',NULL,0,1,1,0,1,0,0,15,'lead','a:0:{}',0,0),
(18,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fus Orar Preferat','timezone','timezone','core',NULL,0,1,1,0,1,0,0,16,'lead','a:0:{}',0,0),
(19,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ultima Data Activ','last_active','datetime','core',NULL,0,1,1,0,1,0,0,17,'lead','a:0:{}',0,0),
(20,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Data Atribuirii','attribution_date','datetime','core',NULL,0,1,1,0,1,0,0,32,'lead','a:0:{}',0,0),
(21,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Atribuire','attribution','number','core',NULL,0,1,1,0,1,0,0,33,'lead','a:2:{s:9:\"roundmode\";s:1:\"4\";s:5:\"scale\";s:1:\"0\";}',0,0),
(29,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Adresa 1 Firma','companyaddress1','text','core',NULL,0,1,1,0,1,0,0,23,'company','a:0:{}',0,0),
(30,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Adresa 2 Firma','companyaddress2','text','core',NULL,0,1,1,0,1,0,0,24,'company','a:0:{}',0,0),
(31,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Email Firma','companyemail','email','core',NULL,0,1,1,0,1,0,0,20,'company','a:0:{}',0,0),
(32,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Telefon Firma','companyphone','tel','core',NULL,0,1,1,0,1,0,0,21,'company','a:0:{}',0,0),
(33,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Oras Firma','companycity','text','core',NULL,0,1,1,0,1,0,0,25,'company','a:0:{}',0,0),
(34,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Judet Firma','companystate','region','core',NULL,0,1,1,0,1,0,0,26,'company','a:0:{}',0,0),
(35,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cod Postal Firma','companyzipcode','text','core',NULL,0,1,1,0,1,0,0,27,'company','a:0:{}',0,0),
(36,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tara Firma','companycountry','country','core',NULL,0,1,1,0,1,0,0,28,'company','a:0:{}',0,0),
(37,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Nume Firma','companyname','text','core',NULL,1,1,1,0,1,0,1,19,'company','a:0:{}',0,0),
(38,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Website Firma','companywebsite','url','core',NULL,0,1,1,0,1,0,0,29,'company','a:0:{}',0,0),
(42,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Industrie Firma','companyindustry','select','professional',NULL,0,1,1,0,1,0,0,30,'company','a:1:{s:4:\"list\";a:31:{i:0;a:2:{s:5:\"label\";s:11:\"Agriculture\";s:5:\"value\";s:11:\"Agriculture\";}i:1;a:2:{s:5:\"label\";s:7:\"Apparel\";s:5:\"value\";s:7:\"Apparel\";}i:2;a:2:{s:5:\"label\";s:7:\"Banking\";s:5:\"value\";s:7:\"Banking\";}i:3;a:2:{s:5:\"label\";s:13:\"Biotechnology\";s:5:\"value\";s:13:\"Biotechnology\";}i:4;a:2:{s:5:\"label\";s:9:\"Chemicals\";s:5:\"value\";s:9:\"Chemicals\";}i:5;a:2:{s:5:\"label\";s:14:\"Communications\";s:5:\"value\";s:14:\"Communications\";}i:6;a:2:{s:5:\"label\";s:12:\"Construction\";s:5:\"value\";s:12:\"Construction\";}i:7;a:2:{s:5:\"label\";s:9:\"Education\";s:5:\"value\";s:9:\"Education\";}i:8;a:2:{s:5:\"label\";s:11:\"Electronics\";s:5:\"value\";s:11:\"Electronics\";}i:9;a:2:{s:5:\"label\";s:6:\"Energy\";s:5:\"value\";s:6:\"Energy\";}i:10;a:2:{s:5:\"label\";s:11:\"Engineering\";s:5:\"value\";s:11:\"Engineering\";}i:11;a:2:{s:5:\"label\";s:13:\"Entertainment\";s:5:\"value\";s:13:\"Entertainment\";}i:12;a:2:{s:5:\"label\";s:13:\"Environmental\";s:5:\"value\";s:13:\"Environmental\";}i:13;a:2:{s:5:\"label\";s:7:\"Finance\";s:5:\"value\";s:7:\"Finance\";}i:14;a:2:{s:5:\"label\";s:15:\"Food & Beverage\";s:5:\"value\";s:15:\"Food & Beverage\";}i:15;a:2:{s:5:\"label\";s:10:\"Government\";s:5:\"value\";s:10:\"Government\";}i:16;a:2:{s:5:\"label\";s:10:\"Healthcare\";s:5:\"value\";s:10:\"Healthcare\";}i:17;a:2:{s:5:\"label\";s:11:\"Hospitality\";s:5:\"value\";s:11:\"Hospitality\";}i:18;a:2:{s:5:\"label\";s:9:\"Insurance\";s:5:\"value\";s:9:\"Insurance\";}i:19;a:2:{s:5:\"label\";s:9:\"Machinery\";s:5:\"value\";s:9:\"Machinery\";}i:20;a:2:{s:5:\"label\";s:13:\"Manufacturing\";s:5:\"value\";s:13:\"Manufacturing\";}i:21;a:2:{s:5:\"label\";s:5:\"Media\";s:5:\"value\";s:5:\"Media\";}i:22;a:2:{s:5:\"label\";s:14:\"Not for Profit\";s:5:\"value\";s:14:\"Not for Profit\";}i:23;a:2:{s:5:\"label\";s:10:\"Recreation\";s:5:\"value\";s:10:\"Recreation\";}i:24;a:2:{s:5:\"label\";s:6:\"Retail\";s:5:\"value\";s:6:\"Retail\";}i:25;a:2:{s:5:\"label\";s:8:\"Shipping\";s:5:\"value\";s:8:\"Shipping\";}i:26;a:2:{s:5:\"label\";s:10:\"Technology\";s:5:\"value\";s:10:\"Technology\";}i:27;a:2:{s:5:\"label\";s:18:\"Telecommunications\";s:5:\"value\";s:18:\"Telecommunications\";}i:28;a:2:{s:5:\"label\";s:14:\"Transportation\";s:5:\"value\";s:14:\"Transportation\";}i:29;a:2:{s:5:\"label\";s:9:\"Utilities\";s:5:\"value\";s:9:\"Utilities\";}i:30;a:2:{s:5:\"label\";s:5:\"Other\";s:5:\"value\";s:5:\"Other\";}}}',0,0),
(43,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Descriere Firma','companydescription','text','professional',NULL,0,1,1,0,1,0,0,31,'company','a:0:{}',0,0),
(44,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Capcana','capcana','text','professional',NULL,0,0,0,1,0,0,0,34,'lead','a:0:{}',0,0),
(45,1,'2024-04-20 07:24:36',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,NULL,NULL,NULL,NULL,'WG-Data','wgdata','date','core',NULL,0,0,1,0,1,0,0,1,'lead','a:0:{}',0,0);
/*!40000 ALTER TABLE `lead_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_frequencyrules`
--

DROP TABLE IF EXISTS `lead_frequencyrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_frequencyrules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `frequency_number` smallint(6) DEFAULT NULL,
  `frequency_time` varchar(25) DEFAULT NULL,
  `channel` varchar(191) NOT NULL,
  `preferred_channel` tinyint(1) NOT NULL,
  `pause_from_date` datetime DEFAULT NULL,
  `pause_to_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AA8A57F455458D` (`lead_id`),
  KEY `channel_frequency` (`channel`),
  CONSTRAINT `FK_AA8A57F455458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_frequencyrules`
--

LOCK TABLES `lead_frequencyrules` WRITE;
/*!40000 ALTER TABLE `lead_frequencyrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_frequencyrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_ips_xref`
--

DROP TABLE IF EXISTS `lead_ips_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_ips_xref` (
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lead_id`,`ip_id`),
  KEY `IDX_9EED7E66A03F5E9F` (`ip_id`),
  CONSTRAINT `FK_9EED7E6655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_9EED7E66A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_ips_xref`
--

LOCK TABLES `lead_ips_xref` WRITE;
/*!40000 ALTER TABLE `lead_ips_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_ips_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_lists`
--

DROP TABLE IF EXISTS `lead_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `alias` varchar(191) NOT NULL,
  `public_name` varchar(191) NOT NULL,
  `filters` longtext NOT NULL COMMENT '(DC2Type:array)',
  `is_global` tinyint(1) NOT NULL,
  `is_preference_center` tinyint(1) NOT NULL,
  `last_built_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6EC1522A12469DE2` (`category_id`),
  CONSTRAINT `FK_6EC1522A12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_lists`
--

LOCK TABLES `lead_lists` WRITE;
/*!40000 ALTER TABLE `lead_lists` DISABLE KEYS */;
INSERT INTO `lead_lists` VALUES
(1,NULL,1,'2024-03-06 18:49:32',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:11:39',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Z9-ContacteAnonime (D)','<p>Contactele anonime (care au doar IP, neabonate, fără adresă de email) de peste o lună (îi ştergem direct)</p>','z9-contacteanonime-d','Z9-ContacteAnonime (D)','a:2:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:5:\"email\";s:4:\"type\";s:5:\"email\";s:8:\"operator\";s:5:\"empty\";s:10:\"properties\";a:2:{s:6:\"filter\";N;s:7:\"display\";N;}s:6:\"filter\";N;s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:11:\"last_active\";s:4:\"type\";s:8:\"datetime\";s:8:\"operator\";s:2:\"lt\";s:10:\"properties\";a:1:{s:6:\"filter\";s:8:\"-30 days\";}s:6:\"filter\";s:8:\"-30 days\";s:7:\"display\";N;}}',1,0,'2024-04-19 19:41:01'),
(2,NULL,1,'2024-03-06 18:50:38',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:11:29',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Z8-Dezabonati+Bounced (D)','<p>Toţi cei dezabonaţi de la email (manual sau automat) şi bounced</p>','z8-dezabonatibounced-d','Z8-Dezabonati+Bounced (D)','a:3:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:16:\"dnc_unsubscribed\";s:4:\"type\";s:7:\"boolean\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";i:1;}s:6:\"filter\";i:1;s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:2:\"or\";s:5:\"field\";s:16:\"dnc_manual_email\";s:4:\"type\";s:7:\"boolean\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";i:1;}s:6:\"filter\";i:1;s:7:\"display\";N;}i:2;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:2:\"or\";s:5:\"field\";s:11:\"dnc_bounced\";s:4:\"type\";s:7:\"boolean\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";i:1;}s:6:\"filter\";i:1;s:7:\"display\";N;}}',1,0,'2024-04-19 19:41:01'),
(3,NULL,1,'2024-03-06 18:52:17',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:11:21',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Z7-Abonati (D)','<p>Toţi abonaţii, de la toate materialele şi programele (fără cei dezabonaţi)</p>','z7-abonati-d','Z7-Abonati (D)','a:4:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:5:\"email\";s:4:\"type\";s:5:\"email\";s:8:\"operator\";s:6:\"!empty\";s:10:\"properties\";a:2:{s:6:\"filter\";N;s:7:\"display\";N;}s:6:\"filter\";N;s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:16:\"dnc_unsubscribed\";s:4:\"type\";s:7:\"boolean\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";i:0;}s:6:\"filter\";i:0;s:7:\"display\";N;}i:2;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:16:\"dnc_manual_email\";s:4:\"type\";s:7:\"boolean\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";i:0;}s:6:\"filter\";i:0;s:7:\"display\";N;}i:3;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:11:\"dnc_bounced\";s:4:\"type\";s:7:\"boolean\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";i:0;}s:6:\"filter\";i:0;s:7:\"display\";N;}}',1,0,'2024-04-19 19:41:01'),
(4,NULL,1,'2024-03-06 18:53:25',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 10:11:11',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Z6-ContacteInactive (D)','<p>Contactele inactive de 2 luni (pornim o campanie de resuscitare; dacă nu reacţionează, îi ştergem)</p>','z6-contacteinactive-d','Z6-ContacteInactive (D)','a:2:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:8:\"leadlist\";s:4:\"type\";s:8:\"leadlist\";s:8:\"operator\";s:2:\"in\";s:10:\"properties\";a:1:{s:6:\"filter\";a:1:{i:0;i:3;}}s:6:\"filter\";a:1:{i:0;i:3;}s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:11:\"last_active\";s:4:\"type\";s:8:\"datetime\";s:8:\"operator\";s:3:\"lte\";s:10:\"properties\";a:1:{s:6:\"filter\";s:8:\"-60 days\";}s:6:\"filter\";s:8:\"-60 days\";s:7:\"display\";N;}}',1,0,'2024-04-19 19:41:01'),
(5,1,1,'2024-04-20 07:29:32',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 07:29:32',NULL,NULL,'2024-04-20 11:00:15',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-1-Inscrisi','<p>Cei care sunt înscrişi la următorul Webinar - <span style=\"color: rgb(184, 49, 47);\"><strong>intra din formular</strong></span></p>','wg-1-inscrisi','WG-1-Inscrisi','a:0:{}',1,0,'2024-04-20 07:29:32'),
(6,1,1,'2024-04-20 07:30:04',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:02:10',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-1-Inscrisi-Dupa','<p>S-au inscris dupa ce Webinarul a trecut ; <strong>dupa ce actualizam data</strong> in campania Inscriere - ii <span style=\"color: rgb(184, 49, 47);\"><strong>adaugam manual in campania Inscriere</strong></span>.</p>','wg-1-inscrisi-dupa','WG-1-Inscrisi-Dupa','a:0:{}',1,0,'2024-04-20 07:30:04'),
(7,1,1,'2024-04-20 07:31:07',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:02:13',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-2-Cu 7 zile inainte de Webinar (D)','<p>Celor de aici va fi trimis emailul cu 7 zile inainte de webinar - <span style=\"color: rgb(184, 49, 47);\"><strong>intra automat din filtru</strong></span></p>','wg-2-cu-7-zile-inainte-de-webinar-d','WG-2-Cu 7 zile inainte de Webinar (D)','a:2:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:8:\"leadlist\";s:4:\"type\";s:8:\"leadlist\";s:8:\"operator\";s:2:\"in\";s:10:\"properties\";a:1:{s:6:\"filter\";a:1:{i:0;i:5;}}s:6:\"filter\";a:1:{i:0;i:5;}s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:6:\"wgdata\";s:4:\"type\";s:4:\"date\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";s:7:\"+7 days\";}s:6:\"filter\";s:7:\"+7 days\";s:7:\"display\";N;}}',1,0,'2024-04-20 07:31:07'),
(8,1,1,'2024-04-20 07:33:41',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:02:16',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-3-Cu 3 zile inainte de Webinar (D)','<p>Celor de aici va fi trimis emailul cu 3 zile inainte de webinar - <span style=\"color: rgb(184, 49, 47);\"><strong>intra automat din filtru</strong></span></p>','wg-3-cu-3-zile-inainte-de-webinar-d','WG-3-Cu 3 zile inainte de Webinar (D)','a:2:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:8:\"leadlist\";s:4:\"type\";s:8:\"leadlist\";s:8:\"operator\";s:2:\"in\";s:10:\"properties\";a:1:{s:6:\"filter\";a:1:{i:0;i:5;}}s:6:\"filter\";a:1:{i:0;i:5;}s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:6:\"wgdata\";s:4:\"type\";s:4:\"date\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";s:7:\"+3 days\";}s:6:\"filter\";s:7:\"+3 days\";s:7:\"display\";N;}}',1,0,'2024-04-20 07:33:41'),
(9,1,1,'2024-04-20 07:36:29',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:02:19',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-4-Cu o zi inainte de Webinar (D)','<p>Celor de aici va fi trimis emailul cu o zi inainte de webinar - <span style=\"color: rgb(184, 49, 47);\"><strong>intra automat din filtru</strong></span></p>','wg-4-cu-o-zi-inainte-de-webinar-d','WG-4-Cu o zi inainte de Webinar (D)','a:2:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:8:\"leadlist\";s:4:\"type\";s:8:\"leadlist\";s:8:\"operator\";s:2:\"in\";s:10:\"properties\";a:1:{s:6:\"filter\";a:1:{i:0;i:5;}}s:6:\"filter\";a:1:{i:0;i:5;}s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:6:\"wgdata\";s:4:\"type\";s:4:\"date\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";s:7:\"+1 days\";}s:6:\"filter\";s:7:\"+1 days\";s:7:\"display\";N;}}',1,0,'2024-04-20 07:36:29'),
(10,1,1,'2024-04-20 07:38:19',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:02:23',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-5-In ziua Webinarului (D)','<p>Celor de aici vor fi trimise emailurile din ziua webinarului - <span style=\"color: rgb(184, 49, 47);\"><strong>intra automat din filtru</strong></span></p>','wg-5-in-ziua-webinarului-d','WG-5-In ziua Webinarului (D)','a:2:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:8:\"leadlist\";s:4:\"type\";s:8:\"leadlist\";s:8:\"operator\";s:2:\"in\";s:10:\"properties\";a:1:{s:6:\"filter\";a:1:{i:0;i:5;}}s:6:\"filter\";a:1:{i:0;i:5;}s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:6:\"wgdata\";s:4:\"type\";s:4:\"date\";s:8:\"operator\";s:1:\"=\";s:10:\"properties\";a:1:{s:6:\"filter\";s:5:\"today\";}s:6:\"filter\";s:5:\"today\";s:7:\"display\";N;}}',1,0,'2024-04-20 07:38:19'),
(11,1,1,'2024-04-20 07:40:12',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:02:27',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-6-Inactivi','<p>N-au fost Live la Webinar, nici n-au urmărit înregistrarea</p>','wg-6-inactivi','WG-6-Inactivi','a:0:{}',1,0,'2024-04-20 07:40:12'),
(12,2,1,'2024-04-20 07:40:58',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:00:11',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','WG-7-Live','<p>Au participat LIVE la Webinar</p>','wg-7-live','WG-7-Live','a:0:{}',1,0,'2024-04-20 07:40:58'),
(13,3,1,'2024-04-20 09:57:49',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:57:49',NULL,NULL,NULL,NULL,NULL,'SE-Automatizare/Funnel','<p>Cei care s-au abonat să primească seria de emailuri</p>','se-automatizarefunnel','SE-Automatizare/Funnel','a:0:{}',1,0,'2024-04-20 09:57:49'),
(14,NULL,1,'2024-04-20 11:25:52',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:55:05',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','LISTA MARE (D)','<p>Toate contactele care nu sunt în alte automatizări. <span style=\"color: rgb(184, 49, 47);\"><strong>Lor le putem trimite Newslettere</strong></span>. Adaug <span style=\"color: rgb(184, 49, 47);\"><strong><u>doar</u></strong></span> segmente statice si campanii de formulare.</p>','lista-mare-d','LISTA MARE (D)','a:2:{i:0;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:8:\"leadlist\";s:4:\"type\";s:8:\"leadlist\";s:8:\"operator\";s:2:\"in\";s:10:\"properties\";a:1:{s:6:\"filter\";a:1:{i:0;i:3;}}s:6:\"filter\";a:1:{i:0;i:3;}s:7:\"display\";N;}i:1;a:8:{s:6:\"object\";s:4:\"lead\";s:4:\"glue\";s:3:\"and\";s:5:\"field\";s:8:\"leadlist\";s:4:\"type\";s:8:\"leadlist\";s:8:\"operator\";s:3:\"!in\";s:10:\"properties\";a:1:{s:6:\"filter\";a:5:{i:0;i:13;i:1;i:5;i:2;i:6;i:3;i:11;i:4;i:12;}}s:6:\"filter\";a:5:{i:0;i:13;i:1;i:5;i:2;i:6;i:3;i:11;i:4;i:12;}s:7:\"display\";N;}}',1,0,'2024-04-20 11:25:52');
/*!40000 ALTER TABLE `lead_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_lists_leads`
--

DROP TABLE IF EXISTS `lead_lists_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_lists_leads` (
  `leadlist_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `manually_removed` tinyint(1) NOT NULL,
  `manually_added` tinyint(1) NOT NULL,
  PRIMARY KEY (`leadlist_id`,`lead_id`),
  KEY `IDX_F5F47C7C55458D` (`lead_id`),
  KEY `manually_removed` (`manually_removed`),
  CONSTRAINT `FK_F5F47C7C55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F5F47C7CB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_lists_leads`
--

LOCK TABLES `lead_lists_leads` WRITE;
/*!40000 ALTER TABLE `lead_lists_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_lists_leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_notes`
--

DROP TABLE IF EXISTS `lead_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `text` longtext NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_67FC6B0355458D` (`lead_id`),
  CONSTRAINT `FK_67FC6B0355458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_notes`
--

LOCK TABLES `lead_notes` WRITE;
/*!40000 ALTER TABLE `lead_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_points_change_log`
--

DROP TABLE IF EXISTS `lead_points_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_points_change_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `type` tinytext NOT NULL,
  `event_name` varchar(191) NOT NULL,
  `action_name` varchar(191) NOT NULL,
  `delta` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_949C2CCC55458D` (`lead_id`),
  KEY `IDX_949C2CCCA03F5E9F` (`ip_id`),
  KEY `point_date_added` (`date_added`),
  CONSTRAINT `FK_949C2CCC55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_949C2CCCA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_points_change_log`
--

LOCK TABLES `lead_points_change_log` WRITE;
/*!40000 ALTER TABLE `lead_points_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_points_change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_stages_change_log`
--

DROP TABLE IF EXISTS `lead_stages_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_stages_change_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `stage_id` int(10) unsigned DEFAULT NULL,
  `event_name` varchar(191) NOT NULL,
  `action_name` varchar(191) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_73B42EF355458D` (`lead_id`),
  KEY `IDX_73B42EF32298D193` (`stage_id`),
  CONSTRAINT `FK_73B42EF32298D193` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_73B42EF355458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_stages_change_log`
--

LOCK TABLES `lead_stages_change_log` WRITE;
/*!40000 ALTER TABLE `lead_stages_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_stages_change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_tags`
--

DROP TABLE IF EXISTS `lead_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lead_tag_search` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_tags`
--

LOCK TABLES `lead_tags` WRITE;
/*!40000 ALTER TABLE `lead_tags` DISABLE KEYS */;
INSERT INTO `lead_tags` VALUES
(1,'z','<p><span style=\"color: rgb(184, 49, 47);\"><strong>NU O STERGE</strong></span> - o folosim in actiunile de asteptare din campanii</p>'),
(2,'Z-Email-Invalid','<p>Mautic a detectat aceste adrese de email ca invalide - poti corecta manual adresele de email<br /></p>'),
(3,'Z-Robot','<p>campania a detectat ca un robot a completat formularul<br /></p>'),
(4,'WG-Inscris',NULL),
(5,'WG-LIVE',NULL),
(6,'SE-Automatizare/Funnel',NULL);
/*!40000 ALTER TABLE `lead_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_tags_xref`
--

DROP TABLE IF EXISTS `lead_tags_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_tags_xref` (
  `lead_id` bigint(20) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lead_id`,`tag_id`),
  KEY `IDX_F2E51EB6BAD26311` (`tag_id`),
  CONSTRAINT `FK_F2E51EB655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F2E51EB6BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `lead_tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_tags_xref`
--

LOCK TABLES `lead_tags_xref` WRITE;
/*!40000 ALTER TABLE `lead_tags_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_tags_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_utmtags`
--

DROP TABLE IF EXISTS `lead_utmtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_utmtags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  `query` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `referer` longtext DEFAULT NULL,
  `remote_host` varchar(191) DEFAULT NULL,
  `url` longtext DEFAULT NULL,
  `user_agent` longtext DEFAULT NULL,
  `utm_campaign` varchar(191) DEFAULT NULL,
  `utm_content` varchar(191) DEFAULT NULL,
  `utm_medium` varchar(191) DEFAULT NULL,
  `utm_source` varchar(191) DEFAULT NULL,
  `utm_term` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C51BCB8D55458D` (`lead_id`),
  CONSTRAINT `FK_C51BCB8D55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_utmtags`
--

LOCK TABLES `lead_utmtags` WRITE;
/*!40000 ALTER TABLE `lead_utmtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_utmtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads`
--

DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `stage_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `points` int(11) NOT NULL,
  `last_active` datetime DEFAULT NULL,
  `internal` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `social_cache` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `date_identified` datetime DEFAULT NULL,
  `preferred_profile_image` varchar(191) DEFAULT NULL,
  `title` varchar(191) DEFAULT NULL,
  `firstname` varchar(191) DEFAULT NULL,
  `lastname` varchar(191) DEFAULT NULL,
  `company` varchar(191) DEFAULT NULL,
  `position` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `mobile` varchar(191) DEFAULT NULL,
  `address1` varchar(191) DEFAULT NULL,
  `address2` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `zipcode` varchar(191) DEFAULT NULL,
  `timezone` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `preferred_locale` varchar(191) DEFAULT NULL,
  `attribution_date` datetime DEFAULT NULL,
  `attribution` double DEFAULT NULL,
  `generated_email_domain` varchar(255) GENERATED ALWAYS AS (substr(`email`,locate('@',`email`) + 1)) VIRTUAL COMMENT '(DC2Type:generated)',
  `capcana` varchar(191) DEFAULT NULL,
  `wgdata` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_179045527E3C61F9` (`owner_id`),
  KEY `IDX_179045522298D193` (`stage_id`),
  KEY `lead_date_added` (`date_added`),
  KEY `date_identified` (`date_identified`),
  KEY `preferred_locale_search` (`preferred_locale`),
  KEY `attribution_date_search` (`attribution_date`),
  KEY `attribution_search` (`attribution`),
  KEY `contact_attribution` (`attribution`,`attribution_date`),
  KEY `date_added_country_index` (`date_added`,`country`),
  KEY `generated_email_domain` (`generated_email_domain`),
  KEY `capcana_search` (`capcana`),
  CONSTRAINT `FK_179045522298D193` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_179045527E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads`
--

LOCK TABLES `leads` WRITE;
/*!40000 ALTER TABLE `leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_channels`
--

DROP TABLE IF EXISTS `message_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL,
  `channel` varchar(191) NOT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `properties` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  `is_enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `channel_index` (`message_id`,`channel`),
  KEY `IDX_FA3226A7537A1329` (`message_id`),
  KEY `channel_entity_index` (`channel`,`channel_id`),
  KEY `channel_enabled_index` (`channel`,`is_enabled`),
  CONSTRAINT `FK_FA3226A7537A1329` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_channels`
--

LOCK TABLES `message_channels` WRITE;
/*!40000 ALTER TABLE `message_channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_queue`
--

DROP TABLE IF EXISTS `message_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_queue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `channel` varchar(191) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `priority` smallint(6) NOT NULL,
  `max_attempts` smallint(6) NOT NULL,
  `attempts` smallint(6) NOT NULL,
  `success` tinyint(1) NOT NULL,
  `status` varchar(191) NOT NULL,
  `date_published` datetime DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `last_attempt` datetime DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `options` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_805B808871F7E88B` (`event_id`),
  KEY `IDX_805B808855458D` (`lead_id`),
  KEY `message_status_search` (`status`),
  KEY `message_date_sent` (`date_sent`),
  KEY `message_scheduled_date` (`scheduled_date`),
  KEY `message_priority` (`priority`),
  KEY `message_success` (`success`),
  KEY `message_channel_search` (`channel`,`channel_id`),
  CONSTRAINT `FK_805B808855458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_805B808871F7E88B` FOREIGN KEY (`event_id`) REFERENCES `campaign_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_queue`
--

LOCK TABLES `message_queue` WRITE;
/*!40000 ALTER TABLE `message_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DB021E9612469DE2` (`category_id`),
  KEY `date_message_added` (`date_added`),
  CONSTRAINT `FK_DB021E9612469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitor_post_count`
--

DROP TABLE IF EXISTS `monitor_post_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_post_count` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monitor_id` int(10) unsigned DEFAULT NULL,
  `post_date` date NOT NULL,
  `post_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E3AC20CA4CE1C902` (`monitor_id`),
  CONSTRAINT `FK_E3AC20CA4CE1C902` FOREIGN KEY (`monitor_id`) REFERENCES `monitoring` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitor_post_count`
--

LOCK TABLES `monitor_post_count` WRITE;
/*!40000 ALTER TABLE `monitor_post_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitor_post_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitoring`
--

DROP TABLE IF EXISTS `monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `lists` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `network_type` varchar(191) DEFAULT NULL,
  `revision` int(11) NOT NULL,
  `stats` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `properties` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BA4F975D12469DE2` (`category_id`),
  CONSTRAINT `FK_BA4F975D12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoring`
--

LOCK TABLES `monitoring` WRITE;
/*!40000 ALTER TABLE `monitoring` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitoring_leads`
--

DROP TABLE IF EXISTS `monitoring_leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitoring_leads` (
  `monitor_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`monitor_id`,`lead_id`),
  KEY `IDX_45207A4A55458D` (`lead_id`),
  CONSTRAINT `FK_45207A4A4CE1C902` FOREIGN KEY (`monitor_id`) REFERENCES `monitoring` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_45207A4A55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoring_leads`
--

LOCK TABLES `monitoring_leads` WRITE;
/*!40000 ALTER TABLE `monitoring_leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitoring_leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(25) DEFAULT NULL,
  `header` varchar(512) DEFAULT NULL,
  `message` longtext NOT NULL,
  `date_added` datetime NOT NULL,
  `icon_class` varchar(191) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6000B0D3A76ED395` (`user_id`),
  KEY `notification_read_status` (`is_read`),
  KEY `notification_type` (`type`),
  KEY `notification_user_read_status` (`is_read`,`user_id`),
  CONSTRAINT `FK_6000B0D3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_accesstokens`
--

DROP TABLE IF EXISTS `oauth2_accesstokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_accesstokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `token` varchar(191) NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_3A18CA5A5F37A13B` (`token`),
  KEY `IDX_3A18CA5A19EB6921` (`client_id`),
  KEY `IDX_3A18CA5AA76ED395` (`user_id`),
  KEY `oauth2_access_token_search` (`token`),
  CONSTRAINT `FK_3A18CA5A19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_3A18CA5AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_accesstokens`
--

LOCK TABLES `oauth2_accesstokens` WRITE;
/*!40000 ALTER TABLE `oauth2_accesstokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_accesstokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_authcodes`
--

DROP TABLE IF EXISTS `oauth2_authcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_authcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(191) NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(191) DEFAULT NULL,
  `redirect_uri` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D2B4847B5F37A13B` (`token`),
  KEY `IDX_D2B4847B19EB6921` (`client_id`),
  KEY `IDX_D2B4847BA76ED395` (`user_id`),
  CONSTRAINT `FK_D2B4847B19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D2B4847BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_authcodes`
--

LOCK TABLES `oauth2_authcodes` WRITE;
/*!40000 ALTER TABLE `oauth2_authcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_authcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_clients`
--

DROP TABLE IF EXISTS `oauth2_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `random_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `redirect_uris` longtext NOT NULL COMMENT '(DC2Type:array)',
  `allowed_grant_types` longtext NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_F9D02AE6D60322AC` (`role_id`),
  KEY `client_id_search` (`random_id`),
  CONSTRAINT `FK_F9D02AE6D60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_clients`
--

LOCK TABLES `oauth2_clients` WRITE;
/*!40000 ALTER TABLE `oauth2_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_refreshtokens`
--

DROP TABLE IF EXISTS `oauth2_refreshtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_refreshtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(191) NOT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `scope` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_328C5B1B5F37A13B` (`token`),
  KEY `IDX_328C5B1B19EB6921` (`client_id`),
  KEY `IDX_328C5B1BA76ED395` (`user_id`),
  KEY `oauth2_refresh_token_search` (`token`),
  CONSTRAINT `FK_328C5B1B19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_328C5B1BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_refreshtokens`
--

LOCK TABLES `oauth2_refreshtokens` WRITE;
/*!40000 ALTER TABLE `oauth2_refreshtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_refreshtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_user_client_xref`
--

DROP TABLE IF EXISTS `oauth2_user_client_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_user_client_xref` (
  `client_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`client_id`,`user_id`),
  KEY `IDX_1AE34413A76ED395` (`user_id`),
  CONSTRAINT `FK_1AE3441319EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1AE34413A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_user_client_xref`
--

LOCK TABLES `oauth2_user_client_xref` WRITE;
/*!40000 ALTER TABLE `oauth2_user_client_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_user_client_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_hits`
--

DROP TABLE IF EXISTS `page_hits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_hits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(10) unsigned DEFAULT NULL,
  `redirect_id` bigint(20) unsigned DEFAULT NULL,
  `email_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `device_id` bigint(20) unsigned DEFAULT NULL,
  `date_hit` datetime NOT NULL,
  `date_left` datetime DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `region` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `isp` varchar(191) DEFAULT NULL,
  `organization` varchar(191) DEFAULT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext DEFAULT NULL,
  `url` longtext DEFAULT NULL,
  `url_title` varchar(191) DEFAULT NULL,
  `user_agent` longtext DEFAULT NULL,
  `remote_host` varchar(191) DEFAULT NULL,
  `page_language` varchar(191) DEFAULT NULL,
  `browser_languages` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `tracking_id` varchar(191) NOT NULL,
  `source` varchar(191) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `query` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_9D4B70F1C4663E4` (`page_id`),
  KEY `IDX_9D4B70F1B42D874D` (`redirect_id`),
  KEY `IDX_9D4B70F1A832C1C9` (`email_id`),
  KEY `IDX_9D4B70F155458D` (`lead_id`),
  KEY `IDX_9D4B70F1A03F5E9F` (`ip_id`),
  KEY `IDX_9D4B70F194A4C7D4` (`device_id`),
  KEY `page_hit_tracking_search` (`tracking_id`),
  KEY `page_hit_code_search` (`code`),
  KEY `page_hit_source_search` (`source`,`source_id`),
  KEY `date_hit_left_index` (`date_hit`,`date_left`),
  KEY `page_hit_url` (`url`(128)),
  CONSTRAINT `FK_9D4B70F155458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F194A4C7D4` FOREIGN KEY (`device_id`) REFERENCES `lead_devices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F1A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_9D4B70F1A832C1C9` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F1B42D874D` FOREIGN KEY (`redirect_id`) REFERENCES `page_redirects` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_9D4B70F1C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_hits`
--

LOCK TABLES `page_hits` WRITE;
/*!40000 ALTER TABLE `page_hits` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_hits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_redirects`
--

DROP TABLE IF EXISTS `page_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_redirects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `redirect_id` varchar(25) NOT NULL,
  `url` longtext NOT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_redirects`
--

LOCK TABLES `page_redirects` WRITE;
/*!40000 ALTER TABLE `page_redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_redirects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `translation_parent_id` int(10) unsigned DEFAULT NULL,
  `variant_parent_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `alias` varchar(191) NOT NULL,
  `template` varchar(191) DEFAULT NULL,
  `custom_html` longtext DEFAULT NULL,
  `content` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `hits` int(11) NOT NULL,
  `unique_hits` int(11) NOT NULL,
  `variant_hits` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  `meta_description` varchar(191) DEFAULT NULL,
  `head_script` longtext DEFAULT NULL,
  `footer_script` longtext DEFAULT NULL,
  `redirect_type` varchar(100) DEFAULT NULL,
  `redirect_url` varchar(2048) DEFAULT NULL,
  `is_preference_center` tinyint(1) DEFAULT NULL,
  `no_index` tinyint(1) DEFAULT NULL,
  `lang` varchar(191) NOT NULL,
  `variant_settings` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `variant_start_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2074E57512469DE2` (`category_id`),
  KEY `IDX_2074E5759091A2FB` (`translation_parent_id`),
  KEY `IDX_2074E57591861123` (`variant_parent_id`),
  KEY `page_alias_search` (`alias`),
  CONSTRAINT `FK_2074E57512469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_2074E5759091A2FB` FOREIGN KEY (`translation_parent_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2074E57591861123` FOREIGN KEY (`variant_parent_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(1,1,NULL,NULL,0,'2024-04-20 09:08:11',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 09:08:11',NULL,NULL,NULL,NULL,NULL,'LINK-ul Webinarului - sa ramana DEZACTIVAT','webinar-sedinta-online','blank','<!DOCTYPE html>\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients no-cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths responsejs \" style=\"\"><head>\r\n        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n                <title>{pagetitle}</title>\r\n            <meta name=\"description\" content=\"{pagemetadescription}\" />\r\n</head>\r\n    <body class=\"ui-sortable\">\r\n        <div data-section-wrapper=\"1\">\r\n    <center>\r\n        <table data-section=\"1\" style=\"width: 600;\" width=\"600\" cellpadding=\"0\" cellspacing=\"0\">\r\n            <tbody>\r\n                <tr>\r\n                    <td>\r\n                        <div data-slot-container=\"1\" style=\"min-height: 30px\" class=\"ui-sortable\">\r\n                            <div data-slot=\"text\"><br /><h2>Salut</h2><br />N-ar trebui să vezi acest mesaj.<br />Linkul ar fi trebuit să te ducă automat în camera de şedinţă.<br />Mai dă rateuri şi tehnica sau implementarea ei :)<br /><h2>Rezolvarea</h2><br /><span style=\"color: rgb(184, 49, 47);\"><strong>Te rog să-mi trimiţi un mesaj (email / Messenger) şi să-mi spui că <u>nu poţi intra în camera de şedinţă deoarece linkul nu funcţionează</u>.</strong></span><br /><br />Tehnic ar fi de făcut următoarele:<ol><li>În Mautic de dus la Componente - Pagini de Aterizare</li><li>De dezactivat Pagina cu LINK-ul Webinarului <em>(în acest fel se va face redirecţionarea automată)</em></li><li>şi gata, linkul va funcţiona.</li></ol>În mesaj trimite-mi şi tot acest mesaj. Şi îţi mulţumesc şi ne vedem live în webinar.<br /><br />###SENDER_FIRSTNAME### ###SENDER_LASTNAME### * <a href=\"mailto:###SENDER_EMAIL###\" rel=\"noopener noreferrer\" target=\"_blank\">###SENDER_EMAIL###</a> * <a href=\"https://###MAIN_DOMAIN###\" rel=\"noopener noreferrer\" target=\"_blank\">https://###MAIN_DOMAIN###</a><br /></div>\r\n                        </div>\r\n                    </td>\r\n                </tr>\r\n            </tbody>\r\n        </table>\r\n    </center>\r\n</div>\r\n</body></html>','a:0:{}',NULL,NULL,0,0,0,1,NULL,NULL,NULL,'302','https://zoom.us/j/###SENDER_FIRSTNAME######SENDER_LASTNAME###',0,1,'ro','a:0:{}',NULL);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `bundle` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `bitwise` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_perm` (`bundle`,`name`,`role_id`),
  KEY `IDX_2DEDCC6FD60322AC` (`role_id`),
  CONSTRAINT `FK_2DEDCC6FD60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_citrix_events`
--

DROP TABLE IF EXISTS `plugin_citrix_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_citrix_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned NOT NULL,
  `product` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `event_name` varchar(191) NOT NULL,
  `event_desc` varchar(191) DEFAULT NULL,
  `event_type` varchar(50) NOT NULL,
  `event_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D77731055458D` (`lead_id`),
  KEY `citrix_event_email` (`product`,`email`),
  KEY `citrix_event_name` (`product`,`event_name`,`event_type`),
  KEY `citrix_event_type` (`product`,`event_type`,`event_date`),
  KEY `citrix_event_product` (`product`,`email`,`event_type`),
  KEY `citrix_event_product_name` (`product`,`email`,`event_type`,`event_name`),
  KEY `citrix_event_product_name_lead` (`product`,`event_type`,`event_name`,`lead_id`),
  KEY `citrix_event_product_type_lead` (`product`,`event_type`,`lead_id`),
  KEY `citrix_event_date` (`event_date`),
  CONSTRAINT `FK_D77731055458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_citrix_events`
--

LOCK TABLES `plugin_citrix_events` WRITE;
/*!40000 ALTER TABLE `plugin_citrix_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_citrix_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_crm_pipedrive_owners`
--

DROP TABLE IF EXISTS `plugin_crm_pipedrive_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_crm_pipedrive_owners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_crm_pipedrive_owners`
--

LOCK TABLES `plugin_crm_pipedrive_owners` WRITE;
/*!40000 ALTER TABLE `plugin_crm_pipedrive_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_crm_pipedrive_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_integration_settings`
--

DROP TABLE IF EXISTS `plugin_integration_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_integration_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `supported_features` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `api_keys` longtext NOT NULL COMMENT '(DC2Type:array)',
  `feature_settings` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_941A2CE0EC942BCF` (`plugin_id`),
  CONSTRAINT `FK_941A2CE0EC942BCF` FOREIGN KEY (`plugin_id`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_integration_settings`
--

LOCK TABLES `plugin_integration_settings` WRITE;
/*!40000 ALTER TABLE `plugin_integration_settings` DISABLE KEYS */;
INSERT INTO `plugin_integration_settings` VALUES
(1,1,'GrapesJsBuilder',0,'a:0:{}','a:0:{}','a:0:{}'),
(2,NULL,'OneSignal',0,'a:4:{i:0;s:6:\"mobile\";i:1;s:20:\"landing_page_enabled\";i:2;s:28:\"welcome_notification_enabled\";i:3;s:21:\"tracking_page_enabled\";}','a:0:{}','a:0:{}'),
(3,NULL,'Twilio',0,'a:0:{}','a:0:{}','a:0:{}');
/*!40000 ALTER TABLE `plugin_integration_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_missing` tinyint(1) NOT NULL,
  `bundle` varchar(50) NOT NULL,
  `version` varchar(191) DEFAULT NULL,
  `author` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_bundle` (`bundle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES
(1,'GrapesJS Builder','GrapesJS Builder with MJML support for Mautic',0,'GrapesJsBuilderBundle','1.0.0','Mautic Community');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point_lead_action_log`
--

DROP TABLE IF EXISTS `point_lead_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_lead_action_log` (
  `point_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`point_id`,`lead_id`),
  KEY `IDX_6DF94A5655458D` (`lead_id`),
  KEY `IDX_6DF94A56A03F5E9F` (`ip_id`),
  CONSTRAINT `FK_6DF94A5655458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6DF94A56A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_6DF94A56C028CEA2` FOREIGN KEY (`point_id`) REFERENCES `points` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_lead_action_log`
--

LOCK TABLES `point_lead_action_log` WRITE;
/*!40000 ALTER TABLE `point_lead_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_lead_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point_lead_event_log`
--

DROP TABLE IF EXISTS `point_lead_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_lead_event_log` (
  `event_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`event_id`,`lead_id`),
  KEY `IDX_C2A3BDBA55458D` (`lead_id`),
  KEY `IDX_C2A3BDBAA03F5E9F` (`ip_id`),
  CONSTRAINT `FK_C2A3BDBA55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C2A3BDBA71F7E88B` FOREIGN KEY (`event_id`) REFERENCES `point_trigger_events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C2A3BDBAA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_lead_event_log`
--

LOCK TABLES `point_lead_event_log` WRITE;
/*!40000 ALTER TABLE `point_lead_event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_lead_event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point_trigger_events`
--

DROP TABLE IF EXISTS `point_trigger_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_trigger_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trigger_id` int(10) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `action_order` int(11) NOT NULL,
  `properties` longtext NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_D5669585FDDDCD6` (`trigger_id`),
  KEY `trigger_type_search` (`type`),
  CONSTRAINT `FK_D5669585FDDDCD6` FOREIGN KEY (`trigger_id`) REFERENCES `point_triggers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_trigger_events`
--

LOCK TABLES `point_trigger_events` WRITE;
/*!40000 ALTER TABLE `point_trigger_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_trigger_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point_triggers`
--

DROP TABLE IF EXISTS `point_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_triggers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `points` int(11) NOT NULL,
  `color` varchar(7) NOT NULL,
  `trigger_existing_leads` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9CABD32F12469DE2` (`category_id`),
  CONSTRAINT `FK_9CABD32F12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_triggers`
--

LOCK TABLES `point_triggers` WRITE;
/*!40000 ALTER TABLE `point_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points`
--

DROP TABLE IF EXISTS `points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `repeatable` tinyint(1) NOT NULL,
  `delta` int(11) NOT NULL,
  `properties` longtext NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_27BA8E2912469DE2` (`category_id`),
  KEY `point_type_search` (`type`),
  CONSTRAINT `FK_27BA8E2912469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `points`
--

LOCK TABLES `points` WRITE;
/*!40000 ALTER TABLE `points` DISABLE KEYS */;
/*!40000 ALTER TABLE `points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_ids`
--

DROP TABLE IF EXISTS `push_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_ids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `push_id` varchar(191) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4F2393E855458D` (`lead_id`),
  CONSTRAINT `FK_4F2393E855458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_ids`
--

LOCK TABLES `push_ids` WRITE;
/*!40000 ALTER TABLE `push_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_list_xref`
--

DROP TABLE IF EXISTS `push_notification_list_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_list_xref` (
  `notification_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`notification_id`,`leadlist_id`),
  KEY `IDX_473919EFB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_473919EFB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_473919EFEF1A9D84` FOREIGN KEY (`notification_id`) REFERENCES `push_notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_list_xref`
--

LOCK TABLES `push_notification_list_xref` WRITE;
/*!40000 ALTER TABLE `push_notification_list_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_list_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notification_stats`
--

DROP TABLE IF EXISTS `push_notification_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notification_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `is_clicked` tinyint(1) NOT NULL,
  `date_clicked` datetime DEFAULT NULL,
  `tracking_hash` varchar(191) DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(191) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `click_count` int(11) DEFAULT NULL,
  `last_clicked` datetime DEFAULT NULL,
  `click_details` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_DE63695EEF1A9D84` (`notification_id`),
  KEY `IDX_DE63695E55458D` (`lead_id`),
  KEY `IDX_DE63695E3DAE168B` (`list_id`),
  KEY `IDX_DE63695EA03F5E9F` (`ip_id`),
  KEY `stat_notification_search` (`notification_id`,`lead_id`),
  KEY `stat_notification_clicked_search` (`is_clicked`),
  KEY `stat_notification_hash_search` (`tracking_hash`),
  KEY `stat_notification_source_search` (`source`,`source_id`),
  CONSTRAINT `FK_DE63695E3DAE168B` FOREIGN KEY (`list_id`) REFERENCES `lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DE63695E55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_DE63695EA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_DE63695EEF1A9D84` FOREIGN KEY (`notification_id`) REFERENCES `push_notifications` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notification_stats`
--

LOCK TABLES `push_notification_stats` WRITE;
/*!40000 ALTER TABLE `push_notification_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notification_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_notifications`
--

DROP TABLE IF EXISTS `push_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `lang` varchar(191) NOT NULL,
  `url` longtext DEFAULT NULL,
  `heading` longtext NOT NULL,
  `message` longtext NOT NULL,
  `button` longtext DEFAULT NULL,
  `utm_tags` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `notification_type` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `read_count` int(11) NOT NULL,
  `sent_count` int(11) NOT NULL,
  `mobile` tinyint(1) NOT NULL,
  `mobileSettings` longtext NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_5B9B7E4F12469DE2` (`category_id`),
  CONSTRAINT `FK_5B9B7E4F12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notifications`
--

LOCK TABLES `push_notifications` WRITE;
/*!40000 ALTER TABLE `push_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `push_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `system` tinyint(1) NOT NULL,
  `source` varchar(191) NOT NULL,
  `columns` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `filters` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `table_order` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `graphs` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `group_by` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `aggregators` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `settings` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `is_scheduled` tinyint(1) NOT NULL,
  `schedule_unit` varchar(191) DEFAULT NULL,
  `to_address` varchar(191) DEFAULT NULL,
  `schedule_day` varchar(191) DEFAULT NULL,
  `schedule_month_frequency` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES
(1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Visits published Pages',NULL,1,'page.hits','a:7:{i:0;s:11:\"ph.date_hit\";i:1;s:6:\"ph.url\";i:2;s:12:\"ph.url_title\";i:3;s:10:\"ph.referer\";i:4;s:12:\"i.ip_address\";i:5;s:7:\"ph.city\";i:6;s:10:\"ph.country\";}','a:2:{i:0;a:3:{s:6:\"column\";s:7:\"ph.code\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:3:\"200\";}i:1;a:3:{s:6:\"column\";s:14:\"p.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:1:{i:0;a:2:{s:6:\"column\";s:11:\"ph.date_hit\";s:9:\"direction\";s:3:\"ASC\";}}','a:8:{i:0;s:35:\"mautic.page.graph.line.time.on.site\";i:1;s:27:\"mautic.page.graph.line.hits\";i:2;s:38:\"mautic.page.graph.pie.new.vs.returning\";i:3;s:31:\"mautic.page.graph.pie.languages\";i:4;s:34:\"mautic.page.graph.pie.time.on.site\";i:5;s:27:\"mautic.page.table.referrers\";i:6;s:30:\"mautic.page.table.most.visited\";i:7;s:37:\"mautic.page.table.most.visited.unique\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),
(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Downloads of all Assets',NULL,1,'asset.downloads','a:7:{i:0;s:16:\"ad.date_download\";i:1;s:7:\"a.title\";i:2;s:12:\"i.ip_address\";i:3;s:11:\"l.firstname\";i:4;s:10:\"l.lastname\";i:5;s:7:\"l.email\";i:6;s:4:\"a.id\";}','a:1:{i:0;a:3:{s:6:\"column\";s:14:\"a.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:1:{i:0;a:2:{s:6:\"column\";s:16:\"ad.date_download\";s:9:\"direction\";s:3:\"ASC\";}}','a:4:{i:0;s:33:\"mautic.asset.graph.line.downloads\";i:1;s:31:\"mautic.asset.graph.pie.statuses\";i:2;s:34:\"mautic.asset.table.most.downloaded\";i:3;s:32:\"mautic.asset.table.top.referrers\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),
(3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Submissions of published Forms',NULL,1,'form.submissions','a:0:{}','a:1:{i:1;a:3:{s:6:\"column\";s:14:\"f.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:0:{}','a:3:{i:0;s:34:\"mautic.form.graph.line.submissions\";i:1;s:32:\"mautic.form.table.most.submitted\";i:2;s:31:\"mautic.form.table.top.referrers\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),
(4,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'All Emails',NULL,1,'email.stats','a:5:{i:0;s:12:\"es.date_sent\";i:1;s:12:\"es.date_read\";i:2;s:9:\"e.subject\";i:3;s:16:\"es.email_address\";i:4;s:4:\"e.id\";}','a:1:{i:0;a:3:{s:6:\"column\";s:14:\"e.is_published\";s:9:\"condition\";s:2:\"eq\";s:5:\"value\";s:1:\"1\";}}','a:1:{i:0;a:2:{s:6:\"column\";s:12:\"es.date_sent\";s:9:\"direction\";s:3:\"ASC\";}}','a:6:{i:0;s:29:\"mautic.email.graph.line.stats\";i:1;s:42:\"mautic.email.graph.pie.ignored.read.failed\";i:2;s:35:\"mautic.email.table.most.emails.read\";i:3;s:35:\"mautic.email.table.most.emails.sent\";i:4;s:43:\"mautic.email.table.most.emails.read.percent\";i:5;s:37:\"mautic.email.table.most.emails.failed\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),
(5,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Leads and Points',NULL,1,'lead.pointlog','a:7:{i:0;s:13:\"lp.date_added\";i:1;s:7:\"lp.type\";i:2;s:13:\"lp.event_name\";i:3;s:11:\"l.firstname\";i:4;s:10:\"l.lastname\";i:5;s:7:\"l.email\";i:6;s:8:\"lp.delta\";}','a:0:{}','a:1:{i:0;a:2:{s:6:\"column\";s:13:\"lp.date_added\";s:9:\"direction\";s:3:\"ASC\";}}','a:6:{i:0;s:29:\"mautic.lead.graph.line.points\";i:1;s:29:\"mautic.lead.table.most.points\";i:2;s:29:\"mautic.lead.table.top.actions\";i:3;s:28:\"mautic.lead.table.top.cities\";i:4;s:31:\"mautic.lead.table.top.countries\";i:5;s:28:\"mautic.lead.table.top.events\";}','a:0:{}','a:0:{}','[]',0,NULL,NULL,NULL,NULL),
(6,1,'2024-04-20 11:30:31',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:31:57',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Situatia Emailuri Webinar-Reamintire',NULL,0,'email.stats','a:2:{i:0;s:6:\"e.name\";i:1;s:12:\"e.sent_count\";}','a:2:{i:2;a:5:{s:6:\"column\";s:12:\"e.sent_count\";s:4:\"glue\";s:3:\"and\";s:5:\"value\";s:1:\"5\";s:7:\"dynamic\";N;s:9:\"condition\";s:2:\"eq\";}i:3;a:5:{s:6:\"column\";s:7:\"c.title\";s:4:\"glue\";s:3:\"and\";s:5:\"value\";s:13:\"WG-Reamintire\";s:7:\"dynamic\";N;s:9:\"condition\";s:2:\"eq\";}}','a:1:{i:2;a:2:{s:6:\"column\";s:12:\"i.ip_address\";s:9:\"direction\";s:3:\"ASC\";}}','a:0:{}','a:1:{i:0;s:6:\"e.name\";}','a:4:{i:2;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:10:\"es.is_read\";}i:3;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:4:\"hits\";}i:4;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:11:\"unique_hits\";}i:5;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:12:\"unsubscribed\";}}','{\"showGraphsAboveTable\":0,\"showDynamicFilters\":0,\"hideDateRangeFilter\":0}',0,NULL,NULL,NULL,NULL),
(7,1,'2024-04-20 11:32:50',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','2024-04-20 11:32:54',1,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###',NULL,NULL,'###SENDER_FIRSTNAME### ###SENDER_LASTNAME###','Situatia Emailuri Webinar-Vanzare',NULL,0,'email.stats','a:2:{i:0;s:6:\"e.name\";i:1;s:12:\"e.sent_count\";}','a:2:{i:2;a:5:{s:6:\"column\";s:12:\"e.sent_count\";s:4:\"glue\";s:3:\"and\";s:5:\"value\";s:1:\"5\";s:7:\"dynamic\";N;s:9:\"condition\";s:2:\"eq\";}i:3;a:5:{s:6:\"column\";s:7:\"c.title\";s:4:\"glue\";s:3:\"and\";s:5:\"value\";s:10:\"WG-Vanzare\";s:7:\"dynamic\";N;s:9:\"condition\";s:2:\"eq\";}}','a:1:{i:2;a:2:{s:6:\"column\";s:12:\"i.ip_address\";s:9:\"direction\";s:3:\"ASC\";}}','a:0:{}','a:1:{i:0;s:6:\"e.name\";}','a:4:{i:2;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:10:\"es.is_read\";}i:3;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:4:\"hits\";}i:4;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:11:\"unique_hits\";}i:5;a:2:{s:8:\"function\";s:3:\"SUM\";s:6:\"column\";s:12:\"unsubscribed\";}}','{\"showGraphsAboveTable\":0,\"showDynamicFilters\":0,\"hideDateRangeFilter\":0}',0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_schedulers`
--

DROP TABLE IF EXISTS `reports_schedulers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_schedulers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_id` int(10) unsigned NOT NULL,
  `schedule_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C74CA6B84BD2A4C0` (`report_id`),
  CONSTRAINT `FK_C74CA6B84BD2A4C0` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_schedulers`
--

LOCK TABLES `reports_schedulers` WRITE;
/*!40000 ALTER TABLE `reports_schedulers` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_schedulers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `readable_permissions` longtext NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Administrator','Full system access',1,'N;');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saml_id_entry`
--

DROP TABLE IF EXISTS `saml_id_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saml_id_entry` (
  `id` varchar(191) NOT NULL,
  `entity_id` varchar(191) NOT NULL,
  `expiryTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saml_id_entry`
--

LOCK TABLES `saml_id_entry` WRITE;
/*!40000 ALTER TABLE `saml_id_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `saml_id_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_message_list_xref`
--

DROP TABLE IF EXISTS `sms_message_list_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_message_list_xref` (
  `sms_id` int(10) unsigned NOT NULL,
  `leadlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sms_id`,`leadlist_id`),
  KEY `IDX_B032FC2EB9FC8874` (`leadlist_id`),
  CONSTRAINT `FK_B032FC2EB9FC8874` FOREIGN KEY (`leadlist_id`) REFERENCES `lead_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_B032FC2EBD5C7E60` FOREIGN KEY (`sms_id`) REFERENCES `sms_messages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_message_list_xref`
--

LOCK TABLES `sms_message_list_xref` WRITE;
/*!40000 ALTER TABLE `sms_message_list_xref` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_message_list_xref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_message_stats`
--

DROP TABLE IF EXISTS `sms_message_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_message_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sms_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` int(10) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_sent` datetime NOT NULL,
  `is_failed` tinyint(1) DEFAULT NULL,
  `tracking_hash` varchar(191) DEFAULT NULL,
  `source` varchar(191) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `tokens` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `details` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_FE1BAE9BD5C7E60` (`sms_id`),
  KEY `IDX_FE1BAE955458D` (`lead_id`),
  KEY `IDX_FE1BAE93DAE168B` (`list_id`),
  KEY `IDX_FE1BAE9A03F5E9F` (`ip_id`),
  KEY `stat_sms_search` (`sms_id`,`lead_id`),
  KEY `stat_sms_hash_search` (`tracking_hash`),
  KEY `stat_sms_source_search` (`source`,`source_id`),
  KEY `stat_sms_failed_search` (`is_failed`),
  CONSTRAINT `FK_FE1BAE93DAE168B` FOREIGN KEY (`list_id`) REFERENCES `lead_lists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_FE1BAE955458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_FE1BAE9A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `FK_FE1BAE9BD5C7E60` FOREIGN KEY (`sms_id`) REFERENCES `sms_messages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_message_stats`
--

LOCK TABLES `sms_message_stats` WRITE;
/*!40000 ALTER TABLE `sms_message_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_message_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_messages`
--

DROP TABLE IF EXISTS `sms_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `lang` varchar(191) NOT NULL,
  `message` longtext NOT NULL,
  `sms_type` longtext DEFAULT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  `sent_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BDF43F9712469DE2` (`category_id`),
  CONSTRAINT `FK_BDF43F9712469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_messages`
--

LOCK TABLES `sms_messages` WRITE;
/*!40000 ALTER TABLE `sms_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stage_lead_action_log`
--

DROP TABLE IF EXISTS `stage_lead_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stage_lead_action_log` (
  `stage_id` int(10) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned NOT NULL,
  `ip_id` int(10) unsigned DEFAULT NULL,
  `date_fired` datetime NOT NULL,
  PRIMARY KEY (`stage_id`,`lead_id`),
  KEY `IDX_A506AFBE55458D` (`lead_id`),
  KEY `IDX_A506AFBEA03F5E9F` (`ip_id`),
  CONSTRAINT `FK_A506AFBE2298D193` FOREIGN KEY (`stage_id`) REFERENCES `stages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A506AFBE55458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A506AFBEA03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stage_lead_action_log`
--

LOCK TABLES `stage_lead_action_log` WRITE;
/*!40000 ALTER TABLE `stage_lead_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `stage_lead_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stages`
--

DROP TABLE IF EXISTS `stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `weight` int(11) NOT NULL,
  `publish_up` datetime DEFAULT NULL,
  `publish_down` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2FA26A6412469DE2` (`category_id`),
  CONSTRAINT `FK_2FA26A6412469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stages`
--

LOCK TABLES `stages` WRITE;
/*!40000 ALTER TABLE `stages` DISABLE KEYS */;
/*!40000 ALTER TABLE `stages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_object_field_change_report`
--

DROP TABLE IF EXISTS `sync_object_field_change_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_object_field_change_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `integration` varchar(191) NOT NULL,
  `object_id` bigint(20) unsigned NOT NULL,
  `object_type` varchar(191) NOT NULL,
  `modified_at` datetime NOT NULL,
  `column_name` varchar(191) NOT NULL,
  `column_type` varchar(191) NOT NULL,
  `column_value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_composite_key` (`object_type`,`object_id`,`column_name`),
  KEY `integration_object_composite_key` (`integration`,`object_type`,`object_id`,`column_name`),
  KEY `integration_object_type_modification_composite_key` (`integration`,`object_type`,`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_object_field_change_report`
--

LOCK TABLES `sync_object_field_change_report` WRITE;
/*!40000 ALTER TABLE `sync_object_field_change_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_object_field_change_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_object_mapping`
--

DROP TABLE IF EXISTS `sync_object_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_object_mapping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `integration` varchar(191) NOT NULL,
  `internal_object_name` varchar(191) NOT NULL,
  `internal_object_id` bigint(20) unsigned NOT NULL,
  `integration_object_name` varchar(191) NOT NULL,
  `integration_object_id` varchar(191) NOT NULL,
  `last_sync_date` datetime NOT NULL,
  `internal_storage` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  `is_deleted` tinyint(1) NOT NULL,
  `integration_reference_id` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `integration_object` (`integration`,`integration_object_name`,`integration_object_id`,`integration_reference_id`),
  KEY `integration_reference` (`integration`,`integration_object_name`,`integration_reference_id`,`integration_object_id`),
  KEY `integration_last_sync_date` (`integration`,`last_sync_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_object_mapping`
--

LOCK TABLES `sync_object_mapping` WRITE;
/*!40000 ALTER TABLE `sync_object_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_object_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tweet_stats`
--

DROP TABLE IF EXISTS `tweet_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tweet_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tweet_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `twitter_tweet_id` varchar(191) DEFAULT NULL,
  `handle` varchar(191) NOT NULL,
  `date_sent` datetime DEFAULT NULL,
  `is_failed` tinyint(1) DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `source` varchar(191) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  `retweet_count` int(11) DEFAULT NULL,
  `response_details` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_CB8CBAE51041E39B` (`tweet_id`),
  KEY `IDX_CB8CBAE555458D` (`lead_id`),
  KEY `stat_tweet_search` (`tweet_id`,`lead_id`),
  KEY `stat_tweet_search2` (`lead_id`,`tweet_id`),
  KEY `stat_tweet_failed_search` (`is_failed`),
  KEY `stat_tweet_source_search` (`source`,`source_id`),
  KEY `favorite_count_index` (`favorite_count`),
  KEY `retweet_count_index` (`retweet_count`),
  KEY `tweet_date_sent` (`date_sent`),
  KEY `twitter_tweet_id_index` (`twitter_tweet_id`),
  CONSTRAINT `FK_CB8CBAE51041E39B` FOREIGN KEY (`tweet_id`) REFERENCES `tweets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_CB8CBAE555458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweet_stats`
--

LOCK TABLES `tweet_stats` WRITE;
/*!40000 ALTER TABLE `tweet_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweet_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tweets`
--

DROP TABLE IF EXISTS `tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tweets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  `asset_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `media_id` varchar(191) DEFAULT NULL,
  `media_path` varchar(191) DEFAULT NULL,
  `text` varchar(191) NOT NULL,
  `sent_count` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  `retweet_count` int(11) DEFAULT NULL,
  `lang` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AA38402512469DE2` (`category_id`),
  KEY `IDX_AA384025C4663E4` (`page_id`),
  KEY `IDX_AA3840255DA1941` (`asset_id`),
  KEY `sent_count_index` (`sent_count`),
  KEY `favorite_count_index` (`favorite_count`),
  KEY `retweet_count_index` (`retweet_count`),
  CONSTRAINT `FK_AA38402512469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_AA3840255DA1941` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_AA384025C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweets`
--

LOCK TABLES `tweets` WRITE;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tokens`
--

DROP TABLE IF EXISTS `user_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `authorizator` varchar(32) NOT NULL,
  `secret` varchar(120) NOT NULL,
  `expiration` datetime DEFAULT NULL,
  `one_time_only` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CF080AB35CA2E8E5` (`secret`),
  KEY `IDX_CF080AB3A76ED395` (`user_id`),
  CONSTRAINT `FK_CF080AB3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `username` varchar(191) NOT NULL,
  `password` varchar(64) NOT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `position` varchar(191) DEFAULT NULL,
  `timezone` varchar(191) DEFAULT NULL,
  `locale` varchar(191) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_active` datetime DEFAULT NULL,
  `preferences` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `signature` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E9F85E0677` (`username`),
  UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`),
  KEY `IDX_1483A5E9D60322AC` (`role_id`),
  CONSTRAINT `FK_1483A5E9D60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'###MAUTIC_USERNAME###','$1$0mNHyfZC$fM9Y7hrhCfZ0FncCOJWzb.','###SENDER_FIRSTNAME###','###SENDER_LASTNAME###','###SENDER_EMAIL###',NULL,'','','2024-04-20 07:22:17','2024-04-20 07:22:17','a:0:{}',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_hits`
--

DROP TABLE IF EXISTS `video_hits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_hits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `ip_id` int(10) unsigned NOT NULL,
  `date_hit` datetime NOT NULL,
  `date_left` datetime DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `region` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `isp` varchar(191) DEFAULT NULL,
  `organization` varchar(191) DEFAULT NULL,
  `code` int(11) NOT NULL,
  `referer` longtext DEFAULT NULL,
  `url` longtext DEFAULT NULL,
  `user_agent` longtext DEFAULT NULL,
  `remote_host` varchar(191) DEFAULT NULL,
  `guid` varchar(191) NOT NULL,
  `page_language` varchar(191) DEFAULT NULL,
  `browser_languages` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `channel` varchar(191) DEFAULT NULL,
  `channel_id` int(11) DEFAULT NULL,
  `time_watched` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `query` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  KEY `IDX_1D1831F755458D` (`lead_id`),
  KEY `IDX_1D1831F7A03F5E9F` (`ip_id`),
  KEY `video_date_hit` (`date_hit`),
  KEY `video_channel_search` (`channel`,`channel_id`),
  KEY `video_guid_lead_search` (`guid`,`lead_id`),
  CONSTRAINT `FK_1D1831F755458D` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_1D1831F7A03F5E9F` FOREIGN KEY (`ip_id`) REFERENCES `ip_addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_hits`
--

LOCK TABLES `video_hits` WRITE;
/*!40000 ALTER TABLE `video_hits` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_hits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_events`
--

DROP TABLE IF EXISTS `webhook_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webhook_id` int(10) unsigned NOT NULL,
  `event_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7AD44E375C9BA60B` (`webhook_id`),
  CONSTRAINT `FK_7AD44E375C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_events`
--

LOCK TABLES `webhook_events` WRITE;
/*!40000 ALTER TABLE `webhook_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_logs`
--

DROP TABLE IF EXISTS `webhook_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webhook_id` int(10) unsigned NOT NULL,
  `status_code` varchar(50) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `note` varchar(191) DEFAULT NULL,
  `runtime` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_45A353475C9BA60B` (`webhook_id`),
  CONSTRAINT `FK_45A353475C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_logs`
--

LOCK TABLES `webhook_logs` WRITE;
/*!40000 ALTER TABLE `webhook_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_queue`
--

DROP TABLE IF EXISTS `webhook_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhook_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webhook_id` int(10) unsigned NOT NULL,
  `event_id` int(10) unsigned NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `payload` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F52D9A1A5C9BA60B` (`webhook_id`),
  KEY `IDX_F52D9A1A71F7E88B` (`event_id`),
  CONSTRAINT `FK_F52D9A1A5C9BA60B` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F52D9A1A71F7E88B` FOREIGN KEY (`event_id`) REFERENCES `webhook_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_queue`
--

LOCK TABLES `webhook_queue` WRITE;
/*!40000 ALTER TABLE `webhook_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhooks`
--

DROP TABLE IF EXISTS `webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webhooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `webhook_url` longtext NOT NULL,
  `secret` varchar(191) NOT NULL,
  `events_orderby_dir` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_998C4FDD12469DE2` (`category_id`),
  CONSTRAINT `FK_998C4FDD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhooks`
--

LOCK TABLES `webhooks` WRITE;
/*!40000 ALTER TABLE `webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_published` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_by_user` varchar(191) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_by_user` varchar(191) DEFAULT NULL,
  `checked_out` datetime DEFAULT NULL,
  `checked_out_by` int(11) DEFAULT NULL,
  `checked_out_by_user` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `cache_timeout` int(11) DEFAULT NULL,
  `ordering` int(11) DEFAULT NULL,
  `params` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES
(1,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Segmente TOP','top.lists',25,330,NULL,0,'a:0:{}'),
(2,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Contacte create / anonime','created.leads.in.time',25,330,NULL,1,'a:2:{s:5:\"lists\";s:21:\"identifiedVsAnonymous\";s:4:\"flag\";s:21:\"identifiedVsAnonymous\";}'),
(3,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Vizite Pagini Website','page.hits.in.time',25,330,NULL,2,'a:1:{s:4:\"flag\";s:16:\"total_and_unique\";}'),
(4,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Device Emailuri','device.granularity',25,330,NULL,3,'a:0:{}'),
(5,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fişiere populare','popular.assets',25,330,NULL,5,'a:0:{}'),
(6,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Descărcări în timp','asset.downloads.in.time',25,330,NULL,6,'a:0:{}'),
(7,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ore deschidere emailuri','emails.best.hours',50,330,NULL,7,'a:4:{s:10:\"timeFormat\";s:7:\"24-hour\";s:9:\"companyId\";s:0:\"\";s:10:\"campaignId\";N;s:9:\"segmentId\";N;}'),
(8,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Emailuri trimise, citite, eşuate','report',75,445,NULL,8,'a:5:{s:4:\"flag\";s:0:\"\";s:9:\"companyId\";s:0:\"\";s:10:\"campaignId\";N;s:9:\"segmentId\";N;s:5:\"graph\";s:31:\"4:mautic.email.graph.line.stats\";}'),
(9,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Abonări prin formulare','report',25,445,NULL,9,'a:1:{s:5:\"graph\";s:34:\"3:mautic.form.table.most.submitted\";}');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-20 13:05:26
