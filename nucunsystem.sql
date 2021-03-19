-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	8.0.18


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema nucunsystem
--

CREATE DATABASE IF NOT EXISTS nucunsystem;
USE nucunsystem;

--
-- Definition of table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_group`
--

/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;


--
-- Definition of table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_group_permissions`
--

/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;


--
-- Definition of table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_permission`
--

/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` (`id`,`name`,`content_type_id`,`codename`) VALUES 
 (1,'Can add certificates',1,'add_certificates'),
 (2,'Can change certificates',1,'change_certificates'),
 (3,'Can delete certificates',1,'delete_certificates'),
 (4,'Can view certificates',1,'view_certificates'),
 (5,'Can add courses',2,'add_courses'),
 (6,'Can change courses',2,'change_courses'),
 (7,'Can delete courses',2,'delete_courses'),
 (8,'Can view courses',2,'view_courses'),
 (9,'Can add departments',3,'add_departments'),
 (10,'Can change departments',3,'change_departments'),
 (11,'Can delete departments',3,'delete_departments'),
 (12,'Can view departments',3,'view_departments'),
 (13,'Can add faculties',4,'add_faculties'),
 (14,'Can change faculties',4,'change_faculties'),
 (15,'Can delete faculties',4,'delete_faculties'),
 (16,'Can view faculties',4,'view_faculties'),
 (17,'Can add otps',5,'add_otps'),
 (18,'Can change otps',5,'change_otps'),
 (19,'Can delete otps',5,'delete_otps'),
 (20,'Can view otps',5,'view_otps'),
 (21,'Can add students',6,'add_students'),
 (22,'Can change students',6,'change_students'),
 (23,'Can delete students',6,'delete_students'),
 (24,'Can view students',6,'view_students'),
 (25,'Can add universities',7,'add_universities'),
 (26,'Can change universities',7,'change_universities'),
 (27,'Can delete universities',7,'delete_universities'),
 (28,'Can view universities',7,'view_universities'),
 (29,'Can add users',8,'add_users'),
 (30,'Can change users',8,'change_users'),
 (31,'Can delete users',8,'delete_users'),
 (32,'Can view users',8,'view_users'),
 (33,'Can add log entry',9,'add_logentry'),
 (34,'Can change log entry',9,'change_logentry'),
 (35,'Can delete log entry',9,'delete_logentry'),
 (36,'Can view log entry',9,'view_logentry'),
 (37,'Can add permission',10,'add_permission'),
 (38,'Can change permission',10,'change_permission'),
 (39,'Can delete permission',10,'delete_permission'),
 (40,'Can view permission',10,'view_permission'),
 (41,'Can add group',11,'add_group'),
 (42,'Can change group',11,'change_group'),
 (43,'Can delete group',11,'delete_group'),
 (44,'Can view group',11,'view_group'),
 (45,'Can add user',12,'add_user'),
 (46,'Can change user',12,'change_user'),
 (47,'Can delete user',12,'delete_user'),
 (48,'Can view user',12,'view_user'),
 (49,'Can add content type',13,'add_contenttype'),
 (50,'Can change content type',13,'change_contenttype'),
 (51,'Can delete content type',13,'delete_contenttype'),
 (52,'Can view content type',13,'view_contenttype'),
 (53,'Can add session',14,'add_session'),
 (54,'Can change session',14,'change_session'),
 (55,'Can delete session',14,'delete_session'),
 (56,'Can view session',14,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;


--
-- Definition of table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user`
--

/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;


--
-- Definition of table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user_groups`
--

/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;


--
-- Definition of table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user_user_permissions`
--

/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;


--
-- Definition of table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_admin_log`
--

/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;


--
-- Definition of table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_content_type`
--

/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`,`app_label`,`model`) VALUES 
 (1,'myapp','certificates'),
 (2,'myapp','courses'),
 (3,'myapp','departments'),
 (4,'myapp','faculties'),
 (5,'myapp','otps'),
 (6,'myapp','students'),
 (7,'myapp','universities'),
 (8,'myapp','users'),
 (9,'admin','logentry'),
 (10,'auth','permission'),
 (11,'auth','group'),
 (12,'auth','user'),
 (13,'contenttypes','contenttype'),
 (14,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;


--
-- Definition of table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_migrations`
--

/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`,`app`,`name`,`applied`) VALUES 
 (1,'myapp','0001_initial','2021-03-01 15:12:30.958389'),
 (2,'myapp','0002_auto_20210301_1558','2021-03-01 15:12:39.755200'),
 (3,'contenttypes','0001_initial','2021-03-01 15:55:03.976360'),
 (4,'auth','0001_initial','2021-03-01 15:55:04.996771'),
 (5,'admin','0001_initial','2021-03-01 15:55:15.284931'),
 (6,'admin','0002_logentry_remove_auto_add','2021-03-01 15:55:17.757506'),
 (7,'admin','0003_logentry_add_action_flag_choices','2021-03-01 15:55:17.770497'),
 (8,'contenttypes','0002_remove_content_type_name','2021-03-01 15:55:18.699978'),
 (9,'auth','0002_alter_permission_name_max_length','2021-03-01 15:55:19.188681'),
 (10,'auth','0003_alter_user_email_max_length','2021-03-01 15:55:19.568459'),
 (11,'auth','0004_alter_user_username_opts','2021-03-01 15:55:19.578455'),
 (12,'auth','0005_alter_user_last_login_null','2021-03-01 15:55:20.145127'),
 (13,'auth','0006_require_contenttypes_0002','2021-03-01 15:55:20.148126'),
 (14,'auth','0007_alter_validators_add_error_messages','2021-03-01 15:55:20.162118'),
 (15,'auth','0008_alter_user_username_max_length','2021-03-01 15:55:20.768767'),
 (16,'auth','0009_alter_user_last_name_max_length','2021-03-01 15:55:21.379416'),
 (17,'auth','0010_alter_group_name_max_length','2021-03-01 15:55:21.788179'),
 (18,'auth','0011_update_proxy_permissions','2021-03-01 15:55:21.812165'),
 (19,'sessions','0001_initial','2021-03-01 15:55:21.930097'),
 (20,'myapp','0003_universities_nucstatus','2021-03-01 20:21:01.018621'),
 (21,'myapp','0004_auto_20210301_2254','2021-03-01 21:54:29.238896'),
 (22,'myapp','0005_universities_created_at','2021-03-02 07:34:03.556168'),
 (23,'myapp','0006_auto_20210303_1845','2021-03-03 17:45:31.023209');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;


--
-- Definition of table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_session`
--

/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`,`session_data`,`expire_date`) VALUES 
 ('kzxuyk0ym3uyoo8xtyqr38yfnlzako2x','NzUxZmZmNDEzNjBlYTcxNGI4MDEzNTVjYjNhYWUzMDY2NmM1MmIyZDp7InVpZCI6Im5hIiwicm9sZSI6Im51Y2FkbWluIiwic3RhdHVzIjoiYWN0aXZlIiwiZnVsbG5hbWUiOiJBZG1pbmlzdHJhdG9yIiwiZHJvcG5hbWUiOiJBZG1pbiIsInBpYyI6ImltZy1hZG1pbi5qcGcifQ==','2021-03-17 10:31:09.624669');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;


--
-- Definition of table `myapp_certificates`
--

DROP TABLE IF EXISTS `myapp_certificates`;
CREATE TABLE `myapp_certificates` (
  `matno` varchar(25) NOT NULL,
  `fullyear` varchar(15) NOT NULL,
  `certificateno` varchar(20) NOT NULL,
  `certimageurl` varchar(100) NOT NULL,
  PRIMARY KEY (`matno`),
  UNIQUE KEY `myapp_certificates_matno_27381564_uniq` (`matno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_certificates`
--

/*!40000 ALTER TABLE `myapp_certificates` DISABLE KEYS */;
INSERT INTO `myapp_certificates` (`matno`,`fullyear`,`certificateno`,`certimageurl`) VALUES 
 ('bsu/sc/06/2025','2021-03-03','sdjkjsdjkjs','20210303102814.jpg');
/*!40000 ALTER TABLE `myapp_certificates` ENABLE KEYS */;


--
-- Definition of table `myapp_courses`
--

DROP TABLE IF EXISTS `myapp_courses`;
CREATE TABLE `myapp_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coursecode` varchar(20) NOT NULL,
  `coursename` varchar(60) NOT NULL,
  `deptcode` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_courses`
--

/*!40000 ALTER TABLE `myapp_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_courses` ENABLE KEYS */;


--
-- Definition of table `myapp_departments`
--

DROP TABLE IF EXISTS `myapp_departments`;
CREATE TABLE `myapp_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptcode` varchar(20) NOT NULL,
  `deptname` varchar(60) NOT NULL,
  `facid_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_departments_facid_id_681357e2` (`facid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_departments`
--

/*!40000 ALTER TABLE `myapp_departments` DISABLE KEYS */;
INSERT INTO `myapp_departments` (`id`,`deptcode`,`deptname`,`facid_id`) VALUES 
 (1,'d20210302095153','MBBS',1),
 (2,'d20210302104709','Mathematics',3),
 (3,'d20210303200029','Computer Science',3);
/*!40000 ALTER TABLE `myapp_departments` ENABLE KEYS */;


--
-- Definition of table `myapp_faculties`
--

DROP TABLE IF EXISTS `myapp_faculties`;
CREATE TABLE `myapp_faculties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facid` varchar(30) NOT NULL,
  `facname` varchar(60) NOT NULL,
  `univcode` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_faculties`
--

/*!40000 ALTER TABLE `myapp_faculties` DISABLE KEYS */;
INSERT INTO `myapp_faculties` (`id`,`facid`,`facname`,`univcode`) VALUES 
 (1,'fac20210302093513','Medicine and Surgery','bsu@gmail.com'),
 (2,'fac20210302093529','Law','bsu@gmail.com'),
 (3,'fac20210302093536','Sciences','bsu@gmail.com');
/*!40000 ALTER TABLE `myapp_faculties` ENABLE KEYS */;


--
-- Definition of table `myapp_otps`
--

DROP TABLE IF EXISTS `myapp_otps`;
CREATE TABLE `myapp_otps` (
  `otpid` varchar(25) NOT NULL,
  `userid` varchar(25) NOT NULL,
  `otpvalue` varchar(10) NOT NULL,
  `expirydate` varchar(30) NOT NULL,
  PRIMARY KEY (`otpid`),
  UNIQUE KEY `myapp_otps_otpid_d275ccad_uniq` (`otpid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_otps`
--

/*!40000 ALTER TABLE `myapp_otps` DISABLE KEYS */;
/*!40000 ALTER TABLE `myapp_otps` ENABLE KEYS */;


--
-- Definition of table `myapp_students`
--

DROP TABLE IF EXISTS `myapp_students`;
CREATE TABLE `myapp_students` (
  `nucno` varchar(50) NOT NULL,
  `matno` varchar(25) NOT NULL,
  `surname` varchar(20) NOT NULL,
  `othernames` varchar(50) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `univcode` varchar(30) NOT NULL,
  `facid` varchar(30) NOT NULL,
  `deptcode` varchar(30) NOT NULL,
  `courseofstudy` varchar(20) NOT NULL,
  `yearofgrade` varchar(4) NOT NULL,
  `fullyear` varchar(15) NOT NULL,
  `photourl` varchar(100) NOT NULL,
  PRIMARY KEY (`nucno`),
  UNIQUE KEY `myapp_students_matno_7fc3d94a_uniq` (`matno`),
  UNIQUE KEY `myapp_students_nucno_0186a8c6_uniq` (`nucno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_students`
--

/*!40000 ALTER TABLE `myapp_students` DISABLE KEYS */;
INSERT INTO `myapp_students` (`nucno`,`matno`,`surname`,`othernames`,`gender`,`phone`,`email`,`univcode`,`facid`,`deptcode`,`courseofstudy`,`yearofgrade`,`fullyear`,`photourl`) VALUES 
 ('NUC/BSU/MTH/2021/fSB0LU','bsu/sc/06/2025','Doe','Richard','Male','+2348069504309','richard.emoche@gmail.com','bsu@gmail.com','3','d20210302104709','Mathematics','2021','2021-03-03','20210303102814.jpg');
/*!40000 ALTER TABLE `myapp_students` ENABLE KEYS */;


--
-- Definition of table `myapp_universities`
--

DROP TABLE IF EXISTS `myapp_universities`;
CREATE TABLE `myapp_universities` (
  `univemail` varchar(30) NOT NULL,
  `uniname` varchar(150) NOT NULL,
  `abbr` varchar(5) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(200) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `nucstatus` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`univemail`),
  UNIQUE KEY `myapp_universities_univcode_73ddf9b6_uniq` (`univemail`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_universities`
--

/*!40000 ALTER TABLE `myapp_universities` DISABLE KEYS */;
INSERT INTO `myapp_universities` (`univemail`,`uniname`,`abbr`,`phone`,`address`,`logo`,`nucstatus`,`created_at`) VALUES 
 ('bsu@gmail.com','Benue State University','BSU','64545676','Makurdi','20210301225602.jpg','approved','2021-03-02 00:00:00.000000');
/*!40000 ALTER TABLE `myapp_universities` ENABLE KEYS */;


--
-- Definition of table `myapp_users`
--

DROP TABLE IF EXISTS `myapp_users`;
CREATE TABLE `myapp_users` (
  `userid` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,
  `role` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `myapp_users_userid_ad7755df_uniq` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `myapp_users`
--

/*!40000 ALTER TABLE `myapp_users` DISABLE KEYS */;
INSERT INTO `myapp_users` (`userid`,`password`,`role`,`status`) VALUES 
 ('na','a','nucadmin','active'),
 ('bsu@gmail.com','bsu@gmail.com','uniadmin','active'),
 ('bsu/sc/06/2025','bsu/sc/06/2025','student','active');
/*!40000 ALTER TABLE `myapp_users` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
