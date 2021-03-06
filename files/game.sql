/*
SQLyog v10.2 
MySQL - 5.6.17 : Database - game
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`game` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `game`;

/*Table structure for table `admin_member` */

DROP TABLE IF EXISTS `admin_member`;

CREATE TABLE `admin_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `u_username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `admin_member` */

insert  into `admin_member`(`uid`,`username`,`password`) values (1,'admin','2cd20a9777fa019d63dc8e918fa8ee33799992f9');

/*Table structure for table `carrace` */

DROP TABLE IF EXISTS `carrace`;

CREATE TABLE `carrace` (
  `chip` int(3) unsigned NOT NULL,
  `multiple` varchar(255) NOT NULL,
  `exclude_prob` varchar(255) NOT NULL,
  `cont_win_num` int(3) unsigned NOT NULL,
  `force_lose_num` int(3) unsigned NOT NULL,
  `lose_num` int(3) unsigned NOT NULL,
  `lose_points` int(3) unsigned NOT NULL,
  `force_win_points` int(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `carrace` */

insert  into `carrace`(`chip`,`multiple`,`exclude_prob`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`force_win_points`) values (100,'{\"1\":\"6\",\"2\":\"3\",\"3\":\"1\"}','{\"1\":\"99\",\"2\":\"88\",\"3\":\"77\"}',3,5,50,5000,500);

/*Table structure for table `carrace_log` */

DROP TABLE IF EXISTS `carrace_log`;

CREATE TABLE `carrace_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `rank1` int(1) unsigned NOT NULL,
  `rank2` int(1) unsigned NOT NULL,
  `rank3` int(1) unsigned NOT NULL,
  `rank` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `carrace_log` */

/*Table structure for table `carrace_play` */

DROP TABLE IF EXISTS `carrace_play`;

CREATE TABLE `carrace_play` (
  `uid` varchar(100) NOT NULL,
  `cont_win_num` tinyint(1) NOT NULL,
  `force_lose_num` tinyint(1) NOT NULL,
  `lose_num` int(10) unsigned NOT NULL,
  `lose_points` int(10) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `carrace_play` */

/*Table structure for table `find` */

DROP TABLE IF EXISTS `find`;

CREATE TABLE `find` (
  `initial_time` int(3) unsigned NOT NULL,
  `free_reminder` tinyint(1) unsigned NOT NULL,
  `reminder_points` int(3) unsigned NOT NULL,
  `max_reminder` tinyint(1) unsigned NOT NULL,
  `right_add_time` tinyint(1) unsigned NOT NULL,
  `wrong_sub_time` tinyint(1) unsigned NOT NULL,
  `time_chunk` tinyint(2) unsigned NOT NULL,
  `time_chunk_points` int(3) unsigned NOT NULL,
  `max_time_chunk` tinyint(1) unsigned NOT NULL,
  `mission` varchar(255) NOT NULL,
  `description` varchar(2000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `find` */

insert  into `find`(`initial_time`,`free_reminder`,`reminder_points`,`max_reminder`,`right_add_time`,`wrong_sub_time`,`time_chunk`,`time_chunk_points`,`max_time_chunk`,`mission`,`description`) values (120,3,100,50,1,5,10,100,5,'[{\"level\":\"1\",\"points\":\"100\"},{\"level\":\"5\",\"points\":\"200\"}]','abc');

/*Table structure for table `find_consume_log` */

DROP TABLE IF EXISTS `find_consume_log`;

CREATE TABLE `find_consume_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_id` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '0:提醒 1:时间',
  `points` int(3) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `find_consume_log` */

/*Table structure for table `find_image` */

DROP TABLE IF EXISTS `find_image`;

CREATE TABLE `find_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `tags` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1:60*60;2:60*90;3:90*60;4:90*90',
  `file_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

/*Data for the table `find_image` */

insert  into `find_image`(`id`,`title`,`tags`,`type`,`file_name`) values (3,'northface','10',1,'1423306725.png'),(4,'it','15',2,'1423306815.png'),(5,'ep','2',3,'1423306827.png'),(7,'','1,2,5,8',2,'1423619043.png'),(8,'','1',2,'1423619311.png'),(9,'','8',2,'1423619318.png'),(10,'','5,8,10',2,'1423628136.png'),(11,'','4',2,'1423628143.png'),(12,'','1,2',2,'1423628151.png'),(13,'','1,2',2,'1423628163.png'),(14,'','16',2,'1423628169.png'),(15,'','16',2,'1423628175.png'),(16,'','13',2,'1423628181.png'),(17,'','13',2,'1423628187.png'),(18,'','1,2',2,'1423628194.png'),(19,'','10,11',2,'1423628202.png'),(20,'','1',2,'1423628208.png'),(21,'','1,2',2,'1423628218.png'),(22,'','1,2,5,8',2,'1423628225.png'),(23,'','1,12',2,'1423628230.png'),(24,'','4,16',2,'1423628236.png'),(25,'','1,2',2,'1423628244.png'),(26,'','1,2,16',2,'1423628251.png'),(27,'','12',2,'1423628261.png'),(28,'','2',2,'1423628266.png'),(29,'','2,8',2,'1423628276.png'),(30,'','1,2',2,'1423628283.png'),(31,'','1,2',2,'1423628290.png'),(32,'','1',2,'1423628296.png'),(33,'','2',2,'1423628302.png'),(34,'','16',2,'1423628308.png'),(35,'','17',2,'1423628313.png'),(36,'','1',2,'1423628322.png'),(37,'','16',3,'1423628328.png'),(38,'','1,2',3,'1423628334.png'),(39,'','18',3,'1423628340.png'),(40,'','19',3,'1423628345.png'),(42,'','1,2',3,'1423628357.png'),(44,'','1',3,'1423628368.png'),(45,'','10',3,'1423628377.png'),(46,'','1',3,'1423628383.png'),(47,'','2',3,'1423628389.png'),(48,'','12',3,'1423628395.png'),(49,'','20',3,'1423628400.png'),(50,'','2',3,'1423628406.png'),(51,'','21',3,'1423628413.png'),(52,'','22',3,'1423628419.png'),(53,'','12',3,'1423628426.png'),(54,'','1',3,'1423628433.png'),(55,'','1,2,5,8',3,'1423628440.png'),(61,'','1,2,4',1,'1423794232.png'),(62,'','10',1,'1423794335.png'),(63,'','1,2',1,'1423794342.png');

/*Table structure for table `find_log` */

DROP TABLE IF EXISTS `find_log`;

CREATE TABLE `find_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `award` varchar(100) NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `update_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `find_log` */

/*Table structure for table `find_tag` */

DROP TABLE IF EXISTS `find_tag`;

CREATE TABLE `find_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `update_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `find_tag` */

insert  into `find_tag`(`id`,`name`,`create_time`,`update_time`) values (1,'男装',0,0),(2,'女装',0,0),(4,'内衣',0,0),(5,'男鞋',0,0),(8,'女鞋',0,0),(9,'休闲娱乐',0,0),(10,'户外鞋服',0,0),(11,'户外装备',0,0),(12,'运动鞋服',0,0),(13,'婴儿用品',0,0),(14,'珠宝',0,0),(15,'IT',1423628645,1423628645),(16,'童装',1423629190,1423629190),(17,'烟酒',1423632830,1423632830),(18,'家居',1423632961,1423632961),(19,'玩具',0,0),(20,'手表',0,0),(21,'皮具',0,0),(22,'美容护肤',0,0);

/*Table structure for table `horserace` */

DROP TABLE IF EXISTS `horserace`;

CREATE TABLE `horserace` (
  `chip` int(3) unsigned NOT NULL,
  `multiple` varchar(255) NOT NULL,
  `exclude_prob` varchar(255) NOT NULL,
  `cont_win_num` int(3) unsigned NOT NULL,
  `force_lose_num` int(3) unsigned NOT NULL,
  `lose_num` int(3) unsigned NOT NULL,
  `lose_points` int(3) unsigned NOT NULL,
  `force_win_points` int(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `horserace` */

insert  into `horserace`(`chip`,`multiple`,`exclude_prob`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`force_win_points`) values (100,'{\"1\":\"6\",\"2\":\"3\",\"3\":\"1\"}','{\"1\":\"99\",\"2\":\"88\",\"3\":\"77\"}',3,5,50,5000,500);

/*Table structure for table `horserace_log` */

DROP TABLE IF EXISTS `horserace_log`;

CREATE TABLE `horserace_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `rank1` int(1) unsigned NOT NULL,
  `rank2` int(1) unsigned NOT NULL,
  `rank3` int(1) unsigned NOT NULL,
  `rank` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `horserace_log` */

/*Table structure for table `horserace_play` */

DROP TABLE IF EXISTS `horserace_play`;

CREATE TABLE `horserace_play` (
  `uid` varchar(100) NOT NULL,
  `cont_win_num` tinyint(1) NOT NULL,
  `force_lose_num` tinyint(1) NOT NULL,
  `lose_num` int(10) unsigned NOT NULL,
  `lose_points` int(10) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `horserace_play` */

/*Table structure for table `spot` */

DROP TABLE IF EXISTS `spot`;

CREATE TABLE `spot` (
  `initial_time` int(3) unsigned NOT NULL,
  `free_reminder` tinyint(1) unsigned NOT NULL,
  `reminder_points` int(3) unsigned NOT NULL,
  `max_reminder` tinyint(1) unsigned NOT NULL,
  `right_add_time` tinyint(1) unsigned NOT NULL,
  `wrong_sub_time` tinyint(1) unsigned NOT NULL,
  `time_chunk` tinyint(2) unsigned NOT NULL,
  `time_chunk_points` int(3) unsigned NOT NULL,
  `max_time_chunk` tinyint(1) unsigned NOT NULL,
  `mission` varchar(255) NOT NULL,
  `description` varchar(2000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `spot` */

insert  into `spot`(`initial_time`,`free_reminder`,`reminder_points`,`max_reminder`,`right_add_time`,`wrong_sub_time`,`time_chunk`,`time_chunk_points`,`max_time_chunk`,`mission`,`description`) values (120,3,100,50,1,5,10,100,5,'[{\"level\":\"1\",\"points\":\"100\"},{\"level\":\"5\",\"points\":\"200\"}]','abc');

/*Table structure for table `spot_consume_log` */

DROP TABLE IF EXISTS `spot_consume_log`;

CREATE TABLE `spot_consume_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_id` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '0:提醒 1:时间',
  `points` int(3) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `spot_consume_log` */

/*Table structure for table `spot_image` */

DROP TABLE IF EXISTS `spot_image`;

CREATE TABLE `spot_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `image_ori` varchar(255) NOT NULL,
  `image_mod` varchar(255) NOT NULL,
  `coordinate` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `spot_image` */

insert  into `spot_image`(`id`,`title`,`image_ori`,`image_mod`,`coordinate`) values (1,'test','1421893438o.jpg','1421893438m.jpg','[{\"x\":\"34\",\"y\":\"99\"},{\"x\":\"116\",\"y\":\"99\"},{\"x\":\"90\",\"y\":\"180\"},{\"x\":\"260\",\"y\":\"115\"},{\"x\":\"324\",\"y\":\"135\"}]'),(2,'test2','1421893463o.jpg','1421893463m.jpg','[{\"x\":\"36\",\"y\":\"20\"},{\"x\":\"291\",\"y\":\"25\"},{\"x\":\"107\",\"y\":\"117\"},{\"x\":\"178\",\"y\":\"191\"},{\"x\":\"325\",\"y\":\"40\"}]'),(3,'test3','1422936544o.jpg','1422936544m.jpg','[{\"x\":\"126\",\"y\":\"68\"},{\"x\":\"106\",\"y\":\"92\"},{\"x\":\"287\",\"y\":\"122\"},{\"x\":\"174\",\"y\":\"122\"},{\"x\":\"268\",\"y\":\"132\"}]'),(4,'test4','1422936623o.jpg','1422936623m.jpg','[{\"x\":\"336\",\"y\":\"10\"},{\"x\":\"62\",\"y\":\"74\"},{\"x\":\"127\",\"y\":\"167\"},{\"x\":\"197\",\"y\":\"173\"},{\"x\":\"285\",\"y\":\"163\"}]'),(5,'test5','1422936663o.jpg','1422936663m.jpg','[{\"x\":\"281\",\"y\":\"22\"},{\"x\":\"124\",\"y\":\"8\"},{\"x\":\"109\",\"y\":\"118\"},{\"x\":\"166\",\"y\":\"86\"},{\"x\":\"272\",\"y\":\"118\"}]');

/*Table structure for table `spot_log` */

DROP TABLE IF EXISTS `spot_log`;

CREATE TABLE `spot_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `award` varchar(100) NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `update_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `spot_log` */

/*Table structure for table `turntable` */

DROP TABLE IF EXISTS `turntable`;

CREATE TABLE `turntable` (
  `free_num` tinyint(1) unsigned NOT NULL,
  `consume_points` int(3) unsigned NOT NULL,
  `range` varchar(255) NOT NULL,
  `awards` varchar(255) NOT NULL,
  `prob` varchar(255) NOT NULL,
  `max` varchar(255) NOT NULL,
  `angle` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` varchar(2000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `turntable` */

insert  into `turntable`(`free_num`,`consume_points`,`range`,`awards`,`prob`,`max`,`angle`,`image`,`description`) values (3,100,'{\"1\":\"1000\",\"2\":\"100\",\"3\":\"\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"iphone6\",\"2\":\"\\u4e00\\u7b49\\u5956\",\"3\":\"\\u4e8c\\u7b49\\u5956\",\"4\":\"\\u4e09\\u7b49\\u5956\",\"5\":\"\\u56db\\u7b49\\u5956\",\"6\":\"\\u4e94\\u7b49\\u5956\",\"7\":\"\\u516d\\u7b49\\u5956\",\"8\":\"\\u4e03\\u7b49\\u5956\"}','{\"1\":\"0.1\",\"2\":\"0.9\",\"3\":\"10\",\"4\":\"1\",\"5\":\"1\",\"6\":\"1\",\"7\":\"1\",\"8\":\"30\"}','{\"1\":\"10\",\"2\":\"50\",\"3\":\"500\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"30\",\"2\":\"30\",\"3\":\"30\",\"4\":\"30\",\"5\":\"30\",\"6\":\"30\",\"7\":\"30\",\"8\":\"30\",\"0\":\"30\"}','assets/turntable/turntable91.png','测试测试测试测试测试测\r\n试测试测试测试测试测试测试\r\n试测试测试测试测试\r\nabcd\r\n1234');

/*Table structure for table `turntable_log` */

DROP TABLE IF EXISTS `turntable_log`;

CREATE TABLE `turntable_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `prize` tinyint(1) unsigned NOT NULL,
  `award` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `turntable_log` */

/*Table structure for table `turntable_play` */

DROP TABLE IF EXISTS `turntable_play`;

CREATE TABLE `turntable_play` (
  `uid` varchar(100) NOT NULL,
  `range` varchar(255) NOT NULL,
  `prize_num` varchar(255) NOT NULL,
  `today_num` int(3) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `turntable_play` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
