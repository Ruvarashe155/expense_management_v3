-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: gzu2
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add custom user',6,'add_customuser'),(22,'Can change custom user',6,'change_customuser'),(23,'Can delete custom user',6,'delete_customuser'),(24,'Can view custom user',6,'view_customuser'),(25,'Can add department',7,'add_department'),(26,'Can change department',7,'change_department'),(27,'Can delete department',7,'delete_department'),(28,'Can view department',7,'view_department'),(29,'Can add expense',8,'add_expense'),(30,'Can change expense',8,'change_expense'),(31,'Can delete expense',8,'delete_expense'),(32,'Can view expense',8,'view_expense'),(33,'Can add expense category',9,'add_expensecategory'),(34,'Can change expense category',9,'change_expensecategory'),(35,'Can delete expense category',9,'delete_expensecategory'),(36,'Can view expense category',9,'view_expensecategory'),(37,'Can add expense disbursement',10,'add_expensedisbursement'),(38,'Can change expense disbursement',10,'change_expensedisbursement'),(39,'Can delete expense disbursement',10,'delete_expensedisbursement'),(40,'Can view expense disbursement',10,'view_expensedisbursement'),(41,'Can add payment method',11,'add_paymentmethod'),(42,'Can change payment method',11,'change_paymentmethod'),(43,'Can delete payment method',11,'delete_paymentmethod'),(44,'Can view payment method',11,'view_paymentmethod'),(45,'Can add recurring expense',12,'add_recurringexpense'),(46,'Can change recurring expense',12,'change_recurringexpense'),(47,'Can delete recurring expense',12,'delete_recurringexpense'),(48,'Can view recurring expense',12,'view_recurringexpense'),(49,'Can add notification',13,'add_notification'),(50,'Can change notification',13,'change_notification'),(51,'Can delete notification',13,'delete_notification'),(52,'Can view notification',13,'view_notification'),(53,'Can add expense request',14,'add_expenserequest'),(54,'Can change expense request',14,'change_expenserequest'),(55,'Can delete expense request',14,'delete_expenserequest'),(56,'Can view expense request',14,'view_expenserequest'),(57,'Can add expense report',15,'add_expensereport'),(58,'Can change expense report',15,'change_expensereport'),(59,'Can delete expense report',15,'delete_expensereport'),(60,'Can view expense report',15,'view_expensereport'),(61,'Can add expense receipt',16,'add_expensereceipt'),(62,'Can change expense receipt',16,'change_expensereceipt'),(63,'Can delete expense receipt',16,'delete_expensereceipt'),(64,'Can view expense receipt',16,'view_expensereceipt'),(65,'Can add expense item',17,'add_expenseitem'),(66,'Can change expense item',17,'change_expenseitem'),(67,'Can delete expense item',17,'delete_expenseitem'),(68,'Can view expense item',17,'view_expenseitem'),(69,'Can add department expense request history',18,'add_departmentexpenserequesthistory'),(70,'Can change department expense request history',18,'change_departmentexpenserequesthistory'),(71,'Can delete department expense request history',18,'delete_departmentexpenserequesthistory'),(72,'Can view department expense request history',18,'view_departmentexpenserequesthistory'),(73,'Can add department budget',19,'add_departmentbudget'),(74,'Can change department budget',19,'change_departmentbudget'),(75,'Can delete department budget',19,'delete_departmentbudget'),(76,'Can view department budget',19,'view_departmentbudget'),(77,'Can add audit log',20,'add_auditlog'),(78,'Can change audit log',20,'change_auditlog'),(79,'Can delete audit log',20,'delete_auditlog'),(80,'Can view audit log',20,'view_auditlog');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_expenses_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_expenses_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(20,'expenses','auditlog'),(6,'expenses','customuser'),(7,'expenses','department'),(19,'expenses','departmentbudget'),(18,'expenses','departmentexpenserequesthistory'),(8,'expenses','expense'),(9,'expenses','expensecategory'),(10,'expenses','expensedisbursement'),(17,'expenses','expenseitem'),(16,'expenses','expensereceipt'),(15,'expenses','expensereport'),(14,'expenses','expenserequest'),(13,'expenses','notification'),(11,'expenses','paymentmethod'),(12,'expenses','recurringexpense'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'expenses','0001_initial','2026-03-03 15:37:32.229104'),(2,'contenttypes','0001_initial','2026-03-03 15:37:32.284196'),(3,'admin','0001_initial','2026-03-03 15:37:32.547165'),(4,'admin','0002_logentry_remove_auto_add','2026-03-03 15:37:32.585768'),(5,'admin','0003_logentry_add_action_flag_choices','2026-03-03 15:37:32.635505'),(6,'contenttypes','0002_remove_content_type_name','2026-03-03 15:37:32.773578'),(7,'auth','0001_initial','2026-03-03 15:37:33.172769'),(8,'auth','0002_alter_permission_name_max_length','2026-03-03 15:37:33.289948'),(9,'auth','0003_alter_user_email_max_length','2026-03-03 15:37:33.314525'),(10,'auth','0004_alter_user_username_opts','2026-03-03 15:37:33.339337'),(11,'auth','0005_alter_user_last_login_null','2026-03-03 15:37:33.376656'),(12,'auth','0006_require_contenttypes_0002','2026-03-03 15:37:33.393733'),(13,'auth','0007_alter_validators_add_error_messages','2026-03-03 15:37:33.433768'),(14,'auth','0008_alter_user_username_max_length','2026-03-03 15:37:33.477714'),(15,'auth','0009_alter_user_last_name_max_length','2026-03-03 15:37:33.519850'),(16,'auth','0010_alter_group_name_max_length','2026-03-03 15:37:33.647247'),(17,'auth','0011_update_proxy_permissions','2026-03-03 15:37:33.726465'),(18,'auth','0012_alter_user_first_name_max_length','2026-03-03 15:37:33.762659'),(19,'expenses','0002_remove_expenserequest_created_at_and_more','2026-03-03 15:37:35.021608'),(20,'expenses','0003_expenseitem_and_more','2026-03-03 15:37:35.801160'),(21,'expenses','0004_alter_departmentexpenserequesthistory_status_and_more','2026-03-03 15:37:36.081912'),(22,'expenses','0005_expensereceipt','2026-03-03 15:37:36.239116'),(23,'expenses','0006_customuser_groups_customuser_is_active_and_more','2026-03-03 15:37:37.041165'),(24,'expenses','0007_customuser_role','2026-03-03 15:37:37.122299'),(25,'expenses','0008_expenserequest_user_alter_expenserequest_approved_at_and_more','2026-03-03 15:37:37.400383'),(26,'expenses','0009_alter_customuser_fullname','2026-03-03 15:37:37.485496'),(27,'expenses','0010_alter_customuser_fullname','2026-03-03 15:37:38.031370'),(28,'expenses','0011_alter_expenserequest_approved_at_and_more','2026-03-03 15:37:38.200063'),(29,'sessions','0001_initial','2026-03-03 15:48:22.222265'),(30,'expenses','0002_remove_expense_amount_remove_expense_date_and_more','2026-03-03 17:58:09.157912');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('i34v9zr1ji67gynryupm5f7watiobw9v','.eJxVjMsOwiAQRf-FtSF0Ojx06b7fQIaBStVAUtqV8d-VpAvdnnPufQlP-5b93tLqlyguAsXplwXiRypdxDuVW5Vcy7YuQfZEHrbJqcb0vB7t30Gmlr9rgkFZIjA66mEkYGWUhrNGxw7NzAToOgFFgZMywIhMcbbBjcYFK94fvSw3Jw:1w2Dh2:qvfi_Uif178Db1Bp9BgOok0o4z2wHlX1oGUp5IfyJcc','2026-03-30 19:33:36.682068'),('l53ozzjhxx7a1y3vw28xbzyy9tbmdp9v','.eJxVjEEOwiAQRe_C2hBbYACX7j0DmRlAqgaS0q6Md7dNutDte-__twi4LiWsPc1hiuIiRnH6ZYT8THUX8YH13iS3uswTyT2Rh-3y1mJ6XY_276BgL9vacuY0Dip5Zm08uuSzIxiUyhG8dwwGgFzWgHpD5pytBlZgsyFrCMXnC_aaODE:1w2Axt:V68YRw9YXCjN6KYkY6hYaaeE2LvT-Y7cW3S1njcza-c','2026-03-30 16:38:49.478802'),('thp834w9jgds3ne6qkaq0xi3ldzb4tpy','.eJxVjEEOwiAQRe_C2hBbYACX7j0DmRlAqgaS0q6Md7dNutDte-__twi4LiWsPc1hiuIiRnH6ZYT8THUX8YH13iS3uswTyT2Rh-3y1mJ6XY_276BgL9vacuY0Dip5Zm08uuSzIxiUyhG8dwwGgFzWgHpD5pytBlZgsyFrCMXnC_aaODE:1vxlJe:HeVHDqMpQ6z1H9xoGPi80ubA6mP8SLFzdOM3OQPRxko','2026-03-18 12:27:02.640439'),('xk09nhggtx3pg04x1o7z0reklzng3ed8','.eJxVjMsOwiAQRf-FtSF0Ojx06b7fQIaBStVAUtqV8d-VpAvdnnPufQlP-5b93tLqlyguAsXplwXiRypdxDuVW5Vcy7YuQfZEHrbJqcb0vB7t30Gmlr9rgkFZIjA66mEkYGWUhrNGxw7NzAToOgFFgZMywIhMcbbBjcYFK94fvSw3Jw:1w2ZTy:8mcr9l8vjySX2NMJt6zSSkJ-d2J2t68YHQ9Jdygr4N8','2026-03-31 18:49:34.575324');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_auditlog`
--

DROP TABLE IF EXISTS `expenses_auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_auditlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) NOT NULL,
  `model_name` varchar(255) NOT NULL,
  `record_id` int(10) unsigned NOT NULL CHECK (`record_id` >= 0),
  `timestamp` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_auditlog_user_id_52265dce_fk_expenses_customuser_id` (`user_id`),
  CONSTRAINT `expenses_auditlog_user_id_52265dce_fk_expenses_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_auditlog`
--

LOCK TABLES `expenses_auditlog` WRITE;
/*!40000 ALTER TABLE `expenses_auditlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_customuser`
--

DROP TABLE IF EXISTS `expenses_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_customuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(50) NOT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  `username` varchar(150) NOT NULL,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `expenses_customuser_department_id_151dbf16_fk_expenses_` (`department_id`),
  CONSTRAINT `expenses_customuser_department_id_151dbf16_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_customuser`
--

LOCK TABLES `expenses_customuser` WRITE;
/*!40000 ALTER TABLE `expenses_customuser` DISABLE KEYS */;
INSERT INTO `expenses_customuser` VALUES (1,'Ruvarashe Shoko',5,1,1,1,'2026-03-17 18:46:22.502835','pbkdf2_sha256$600000$tnS0ilGppktQFJcJCkk6ry$pWQnJxfZPXNTvej7yk7YFedowPrqfS2VC9KEeBEoCBI=','Ruva','Head'),(2,'Richard Shoko',1,1,0,0,'2026-03-17 18:32:41.364779','pbkdf2_sha256$600000$5yrQWH12iptGkQh5O3g1J8$Rw2uj36qhI1d9cR3bei4OrZLYmhGUlbnkwQdoJAQ04Y=','richardshoko','Dean'),(3,'Erick Tofa',5,1,0,0,'2026-03-03 18:17:25.928204','pbkdf2_sha256$600000$yLpsq07cN8bEbbKmobrH29$kB2/Uyea8wDtjaHG20Uhi1ensRIC9aNlQVKgmV3dCDg=','ericktofa','Dean'),(4,'Nothando Moyo',5,1,0,0,'2026-03-17 18:49:34.564688','pbkdf2_sha256$600000$lcu811Fz85a8VIVKIQHHnk$DJCZq5F1/BC83GZnhyBaoc7tNvTJ6ZsMc7rcA9mB40s=','nothandomoyo','Staff'),(5,'Admire Moyo',1,1,1,1,'2026-03-17 18:34:48.517784','pbkdf2_sha256$600000$pIkDMSQuy6NBEBgULjY2A2$nyTOcvpGH1R8hcSQ9KTj22p2lUzVmmx0GJVTrMv4W2U=','Admin','Admin');
/*!40000 ALTER TABLE `expenses_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_customuser_groups`
--

DROP TABLE IF EXISTS `expenses_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_customuser_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expenses_customuser_groups_customuser_id_group_id_a1c8f241_uniq` (`customuser_id`,`group_id`),
  KEY `expenses_customuser_groups_group_id_e3c46b3b_fk_auth_group_id` (`group_id`),
  CONSTRAINT `expenses_customuser__customuser_id_7f2c11b6_fk_expenses_` FOREIGN KEY (`customuser_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_customuser_groups_group_id_e3c46b3b_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_customuser_groups`
--

LOCK TABLES `expenses_customuser_groups` WRITE;
/*!40000 ALTER TABLE `expenses_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_customuser_user_permissions`
--

DROP TABLE IF EXISTS `expenses_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_customuser_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expenses_customuser_user_customuser_id_permission_4865d7c9_uniq` (`customuser_id`,`permission_id`),
  KEY `expenses_customuser__permission_id_bd139b07_fk_auth_perm` (`permission_id`),
  CONSTRAINT `expenses_customuser__customuser_id_b80424f1_fk_expenses_` FOREIGN KEY (`customuser_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_customuser__permission_id_bd139b07_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_customuser_user_permissions`
--

LOCK TABLES `expenses_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `expenses_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_department`
--

DROP TABLE IF EXISTS `expenses_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `head_of_department` varchar(255) DEFAULT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_department`
--

LOCK TABLES `expenses_department` WRITE;
/*!40000 ALTER TABLE `expenses_department` DISABLE KEYS */;
INSERT INTO `expenses_department` VALUES (1,'Faculty of Commerce','Faculty of Commerce','R.Shoko','DEP001'),(2,'Faculty of Education','Faculty of Education','R.Shoko','DEP002'),(3,'Faculty of Humanities','Faculty of Humanities','R.Shoko','DEP003'),(4,'Faculty of Law','Faculty of Law','T.Shumba','DEP004'),(5,'Faculty of Pharmacy','Faculty of Pharmacy','T. S.Shumba','DEP005'),(6,'Faculty of Science','Faculty of Science','S .Moyo','DEP006');
/*!40000 ALTER TABLE `expenses_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_departmentbudget`
--

DROP TABLE IF EXISTS `expenses_departmentbudget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_departmentbudget` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `budget_amount` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `department_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_departmentb_department_id_6f07d3d2_fk_expenses_` (`department_id`),
  CONSTRAINT `expenses_departmentb_department_id_6f07d3d2_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_departmentbudget`
--

LOCK TABLES `expenses_departmentbudget` WRITE;
/*!40000 ALTER TABLE `expenses_departmentbudget` DISABLE KEYS */;
INSERT INTO `expenses_departmentbudget` VALUES (1,10000.00,'2026-03-01','2026-03-30',1),(2,12000.00,'2026-03-01','2026-03-31',5);
/*!40000 ALTER TABLE `expenses_departmentbudget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_departmentexpenserequesthistory`
--

DROP TABLE IF EXISTS `expenses_departmentexpenserequesthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_departmentexpenserequesthistory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  `action_date` datetime(6) NOT NULL,
  `action_taken_by_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) NOT NULL,
  `expense_request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_departmente_action_taken_by_id_fdd608a0_fk_expenses_` (`action_taken_by_id`),
  KEY `expenses_departmente_department_id_d7142298_fk_expenses_` (`department_id`),
  KEY `expenses_departmente_expense_request_id_eb0e72a4_fk_expenses_` (`expense_request_id`),
  CONSTRAINT `expenses_departmente_action_taken_by_id_fdd608a0_fk_expenses_` FOREIGN KEY (`action_taken_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_departmente_department_id_d7142298_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`),
  CONSTRAINT `expenses_departmente_expense_request_id_eb0e72a4_fk_expenses_` FOREIGN KEY (`expense_request_id`) REFERENCES `expenses_expenserequest` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_departmentexpenserequesthistory`
--

LOCK TABLES `expenses_departmentexpenserequesthistory` WRITE;
/*!40000 ALTER TABLE `expenses_departmentexpenserequesthistory` DISABLE KEYS */;
INSERT INTO `expenses_departmentexpenserequesthistory` VALUES (1,'Approved','2026-03-03 18:17:39.187464',3,5,1),(2,'Approved','2026-03-17 18:48:20.776572',1,5,3);
/*!40000 ALTER TABLE `expenses_departmentexpenserequesthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expense`
--

DROP TABLE IF EXISTS `expenses_expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expense` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expense_category_id_aa33bbdd_fk_expenses_` (`category_id`),
  CONSTRAINT `expenses_expense_category_id_aa33bbdd_fk_expenses_` FOREIGN KEY (`category_id`) REFERENCES `expenses_expensecategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expense`
--

LOCK TABLES `expenses_expense` WRITE;
/*!40000 ALTER TABLE `expenses_expense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensecategory`
--

DROP TABLE IF EXISTS `expenses_expensecategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensecategory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensecategory`
--

LOCK TABLES `expenses_expensecategory` WRITE;
/*!40000 ALTER TABLE `expenses_expensecategory` DISABLE KEYS */;
INSERT INTO `expenses_expensecategory` VALUES (1,'Utilities','Utilities'),(2,'Transportation','Transportation');
/*!40000 ALTER TABLE `expenses_expensecategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensedisbursement`
--

DROP TABLE IF EXISTS `expenses_expensedisbursement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensedisbursement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `disbursed_at` datetime(6) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `reference_number` varchar(255) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `disbursed_by_id` bigint(20) DEFAULT NULL,
  `expense_request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expense_request_id` (`expense_request_id`),
  KEY `expenses_expensedisb_disbursed_by_id_609f5376_fk_expenses_` (`disbursed_by_id`),
  CONSTRAINT `expenses_expensedisb_disbursed_by_id_609f5376_fk_expenses_` FOREIGN KEY (`disbursed_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_expensedisb_expense_request_id_7d276e38_fk_expenses_` FOREIGN KEY (`expense_request_id`) REFERENCES `expenses_expenserequest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensedisbursement`
--

LOCK TABLES `expenses_expensedisbursement` WRITE;
/*!40000 ALTER TABLE `expenses_expensedisbursement` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_expensedisbursement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expenseitem`
--

DROP TABLE IF EXISTS `expenses_expenseitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expenseitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenseitem_request_id_f3c33c8c_fk_expenses_` (`request_id`),
  CONSTRAINT `expenses_expenseitem_request_id_f3c33c8c_fk_expenses_` FOREIGN KEY (`request_id`) REFERENCES `expenses_expenserequest` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expenseitem`
--

LOCK TABLES `expenses_expenseitem` WRITE;
/*!40000 ALTER TABLE `expenses_expenseitem` DISABLE KEYS */;
INSERT INTO `expenses_expenseitem` VALUES (1,'Electricity Bill For March',100.00,1),(2,'Water Bill for March 2026',230.00,1),(3,' nov bill ',300.00,2),(4,'dec bill',250.00,2),(5,'nov bill',230.00,3),(6,'Jan Bills',300.00,3);
/*!40000 ALTER TABLE `expenses_expenseitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensereceipt`
--

DROP TABLE IF EXISTS `expenses_expensereceipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensereceipt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `disbursement_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenserece_disbursement_id_2b9c9030_fk_expenses_` (`disbursement_id`),
  CONSTRAINT `expenses_expenserece_disbursement_id_2b9c9030_fk_expenses_` FOREIGN KEY (`disbursement_id`) REFERENCES `expenses_expensedisbursement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensereceipt`
--

LOCK TABLES `expenses_expensereceipt` WRITE;
/*!40000 ALTER TABLE `expenses_expensereceipt` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_expensereceipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensereport`
--

DROP TABLE IF EXISTS `expenses_expensereport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensereport` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_expense` decimal(12,2) NOT NULL,
  `category_summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`category_summary`)),
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenserepo_user_id_61085961_fk_expenses_` (`user_id`),
  CONSTRAINT `expenses_expenserepo_user_id_61085961_fk_expenses_` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensereport`
--

LOCK TABLES `expenses_expensereport` WRITE;
/*!40000 ALTER TABLE `expenses_expensereport` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_expensereport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expenserequest`
--

DROP TABLE IF EXISTS `expenses_expenserequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expenserequest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(10) NOT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `rejected_at` datetime(6) DEFAULT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `rejected_by_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenserequ_approved_by_id_5f7aab9c_fk_expenses_` (`approved_by_id`),
  KEY `expenses_expenserequ_category_id_7d405fc3_fk_expenses_` (`category_id`),
  KEY `expenses_expenserequ_rejected_by_id_7c2303d9_fk_expenses_` (`rejected_by_id`),
  KEY `expenses_expenserequ_department_id_04f1fad0_fk_expenses_` (`department_id`),
  KEY `expenses_expenserequ_user_id_38baacdd_fk_expenses_` (`user_id`),
  CONSTRAINT `expenses_expenserequ_approved_by_id_5f7aab9c_fk_expenses_` FOREIGN KEY (`approved_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_expenserequ_category_id_7d405fc3_fk_expenses_` FOREIGN KEY (`category_id`) REFERENCES `expenses_expensecategory` (`id`),
  CONSTRAINT `expenses_expenserequ_department_id_04f1fad0_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`),
  CONSTRAINT `expenses_expenserequ_rejected_by_id_7c2303d9_fk_expenses_` FOREIGN KEY (`rejected_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_expenserequ_user_id_38baacdd_fk_expenses_` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expenserequest`
--

LOCK TABLES `expenses_expenserequest` WRITE;
/*!40000 ALTER TABLE `expenses_expenserequest` DISABLE KEYS */;
INSERT INTO `expenses_expenserequest` VALUES (1,'Utilities',330.00,'2026-03-03','Utilities','Approved','2026-03-03 18:17:39.147333',NULL,3,1,NULL,5,1),(2,'bills',550.00,'2026-03-17','bills','Pending',NULL,NULL,NULL,1,NULL,1,5),(3,'Bills',530.00,'2026-03-17','Bills','Approved','2026-03-17 18:48:20.739943',NULL,1,1,NULL,5,4);
/*!40000 ALTER TABLE `expenses_expenserequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_notification`
--

DROP TABLE IF EXISTS `expenses_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `read` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_notification_user_id_09a29418_fk_expenses_customuser_id` (`user_id`),
  CONSTRAINT `expenses_notification_user_id_09a29418_fk_expenses_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_notification`
--

LOCK TABLES `expenses_notification` WRITE;
/*!40000 ALTER TABLE `expenses_notification` DISABLE KEYS */;
INSERT INTO `expenses_notification` VALUES (1,'Your expense request \'Utilities\' has been approved.','2026-03-03 18:17:39.195148',0,1),(2,'Your expense request \'Bills\' has been approved.','2026-03-17 18:48:20.787361',0,4);
/*!40000 ALTER TABLE `expenses_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_paymentmethod`
--

DROP TABLE IF EXISTS `expenses_paymentmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_paymentmethod` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_paymentmethod`
--

LOCK TABLES `expenses_paymentmethod` WRITE;
/*!40000 ALTER TABLE `expenses_paymentmethod` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_paymentmethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_recurringexpense`
--

DROP TABLE IF EXISTS `expenses_recurringexpense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_recurringexpense` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recurrence_interval` varchar(100) NOT NULL,
  `next_due_date` date NOT NULL,
  `expense_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_recurringex_expense_id_61326d2c_fk_expenses_` (`expense_id`),
  CONSTRAINT `expenses_recurringex_expense_id_61326d2c_fk_expenses_` FOREIGN KEY (`expense_id`) REFERENCES `expenses_expense` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_recurringexpense`
--

LOCK TABLES `expenses_recurringexpense` WRITE;
/*!40000 ALTER TABLE `expenses_recurringexpense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_recurringexpense` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-18  4:54:08
