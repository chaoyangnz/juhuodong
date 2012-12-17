-- MySQL dump 10.13  Distrib 5.5.28, for Win32 (x86)
--
-- Host: localhost    Database: huodong_dev
-- ------------------------------------------------------
-- Server version	5.5.28

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
-- Table structure for table `etickets`
--

DROP TABLE IF EXISTS `etickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_no` varchar(255) NOT NULL,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etickets`
--

LOCK TABLES `etickets` WRITE;
/*!40000 ALTER TABLE `etickets` DISABLE KEYS */;
INSERT INTO `etickets` VALUES (1,'T20121215-141051',1,'issued'),(2,'T20121215-141051',1,'issued'),(3,'T20121215-141051',1,'issued');
/*!40000 ALTER TABLE `etickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `start_time` varchar(16) NOT NULL,
  `end_time` varchar(16) NOT NULL,
  `province` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `address` varchar(255) NOT NULL,
  `category` varchar(45) NOT NULL,
  `detail` text NOT NULL,
  `banner` varchar(255) NOT NULL,
  `telephone` varchar(45) DEFAULT NULL,
  `host_id` bigint(20) NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `seller_name` varchar(45) NOT NULL,
  `seller_telephone` varchar(45) NOT NULL,
  `seller_email` varchar(45) DEFAULT NULL,
  `site_url` varchar(255) DEFAULT NULL,
  `short_url` varchar(45) DEFAULT NULL,
  `notice` varchar(255) DEFAULT NULL,
  `is_publish` varchar(45) DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (4,'的负担','2012-12-07 16:33','2012-12-28 18:55','上海','卢湾','地方','聚会/派对','<p>\r\n	的负担</p>\r\n','/system/rich/rich_files/rich_files/000/000/001/thumb/z-bild.jpg',NULL,1,50,'杨超','13585621135','','','','',NULL,'published',1,'2012-12-14 16:02:12','2012-12-14 07:26:31'),(8,'五部聚会','2012-12-07 16:33','2012-12-29 18:55','上海','浦东','人民广场','聚会/派对','<p>\r\n	的负担</p>\r\n','/system/rich/rich_files/rich_files/000/000/001/thumb/z-bild.jpg',NULL,1,20,'杨超','13585621135','','','','',NULL,'draft',1,'2012-12-14 07:44:42','2012-12-14 07:44:42');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_certifications`
--

DROP TABLE IF EXISTS `host_certifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_certifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `offical_name` varchar(45) DEFAULT NULL,
  `identity_no` varchar(45) DEFAULT NULL,
  `identity_no_image` varchar(45) DEFAULT NULL,
  `account_bank` varchar(45) DEFAULT NULL,
  `account_no` varchar(45) DEFAULT NULL,
  `cart_image` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `approve_status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_certifications`
--

LOCK TABLES `host_certifications` WRITE;
/*!40000 ALTER TABLE `host_certifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_certifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `telephone` varchar(45) NOT NULL,
  `website` varchar(45) DEFAULT NULL,
  `weibo` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `msn` varchar(45) DEFAULT NULL,
  `qq` varchar(45) DEFAULT NULL,
  `province` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `address` varchar(255) NOT NULL,
  `status` varchar(45) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (1,'哈度','1','13585621135',NULL,NULL,'','','','上海','黄浦','','uncertified',1);
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `tickets` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (3,3,1,3,0.00,NULL);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL,
  `realname` varchar(45) NOT NULL,
  `mobile_phone` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `subject` varchar(45) DEFAULT NULL,
  `body` varchar(45) DEFAULT NULL,
  `show_url` varchar(45) DEFAULT NULL,
  `total_fee` decimal(10,2) NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (3,'U20121215-141050','杨超','13585621135','yangc@hadue.com',NULL,'五部聚会','[五部聚会]情侣票 3张 × 0.0元','/events/8',0.00,'paid-free');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rich_rich_files`
--

DROP TABLE IF EXISTS `rich_rich_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rich_rich_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rich_file_file_name` varchar(255) DEFAULT NULL,
  `rich_file_content_type` varchar(255) DEFAULT NULL,
  `rich_file_file_size` int(10) unsigned DEFAULT NULL,
  `rich_file_updated_at` timestamp NULL DEFAULT NULL,
  `owner_type` varchar(255) DEFAULT NULL,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `uri_cache` text,
  `simplified_type` varchar(255) DEFAULT 'file',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rich_rich_files`
--

LOCK TABLES `rich_rich_files` WRITE;
/*!40000 ALTER TABLE `rich_rich_files` DISABLE KEYS */;
INSERT INTO `rich_rich_files` VALUES (1,'2012-12-14 06:56:19','2012-12-14 06:56:19','z-bild.jpg','image/jpeg',79729,'2012-12-14 06:56:18',NULL,NULL,'{\"thumb\":\"/system/rich/rich_files/rich_files/000/000/001/thumb/z-bild.jpg\",\"rich_thumb\":\"/system/rich/rich_files/rich_files/000/000/001/rich_thumb/z-bild.jpg\",\"original\":\"/system/rich/rich_files/rich_files/000/000/001/original/z-bild.jpg\"}','image');
/*!40000 ALTER TABLE `rich_rich_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `taggable_type` varchar(45) NOT NULL,
  `taggable_id` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'聚会','Event','4');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `package` varchar(45) NOT NULL,
  `online_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `offline_price` decimal(10,2) DEFAULT NULL,
  `capacity` int(10) unsigned NOT NULL,
  `available` int(10) unsigned NOT NULL,
  `reserved` int(10) unsigned NOT NULL DEFAULT '0',
  `notice` varchar(255) DEFAULT NULL,
  `sale_start_time` varchar(45) DEFAULT NULL,
  `sale_end_time` varchar(45) DEFAULT NULL,
  `order_min` int(10) unsigned DEFAULT NULL,
  `order_max` int(10) unsigned DEFAULT NULL,
  `event_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'情侣票','FreeTicket','双人票',0.00,NULL,20,17,0,NULL,'','',NULL,NULL,8);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `encrypted_password` varchar(255) NOT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` varchar(255) DEFAULT NULL,
  `remember_created_at` varchar(255) DEFAULT NULL,
  `sign_in_count` int(10) unsigned NOT NULL DEFAULT '0',
  `current_sign_in_at` timestamp NULL DEFAULT NULL,
  `last_sign_in_at` timestamp NULL DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `roles` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jock.yang@gmail.com','$2a$10$QJV.6xVcxW/AHvbYTEOBgOZNbzsnClIFznXCVsrpYCV6Vq9ByMQXe',NULL,NULL,NULL,2,'2012-12-14 19:33:37','2012-12-14 05:18:17','127.0.0.1','127.0.0.1','2012-12-14 05:18:17','2012-12-14 19:33:37','---\n- :user\n'),(2,'yangc@hadue.com','$2a$10$nQzgXdaNUcFAxq.LAhBmteREmfYAKuQBc1BANrCUEfQNKvqwJwwki',NULL,NULL,NULL,1,'2012-12-14 08:03:57','2012-12-14 08:03:57','127.0.0.1','127.0.0.1','2012-12-14 08:03:57','2012-12-14 08:16:38','---\n- :user\n');
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

-- Dump completed on 2012-12-17 20:53:17
