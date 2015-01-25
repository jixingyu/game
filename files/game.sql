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
  `uid` int(10) unsigned NOT NULL,
  `rank1` int(1) unsigned NOT NULL,
  `rank2` int(1) unsigned NOT NULL,
  `rank3` int(1) unsigned NOT NULL,
  `rank` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

/*Data for the table `carrace_log` */

insert  into `carrace_log`(`id`,`uid`,`rank1`,`rank2`,`rank3`,`rank`,`create_time`,`is_random`) values (1,1,3,0,5,'[2,5,7,1,6,8,4,3]',1422167565,1),(2,1,0,0,6,'[2,5,3,7,6,4,1,8]',1422167588,1),(3,1,0,0,1,'[2,5,4,6,7,8,3,1]',1422167618,1),(4,1,0,0,1,'[8,4,2,1,3,6,7,5]',1422167649,1),(5,1,0,0,3,'[2,8,4,7,5,1,3,6]',1422167669,1),(6,1,0,0,1,'[1,3,5,8,6,7,4,2]',1422167686,1),(7,1,0,0,1,'[5,8,6,2,3,1,4,7]',1422167792,1),(8,1,0,0,1,'[6,1,7,4,3,2,8,5]',1422167807,1),(9,1,0,0,1,'[6,1,4,2,8,7,3,5]',1422167839,1),(10,1,0,0,1,'[8,5,3,4,6,1,2,7]',1422167876,1),(11,1,0,0,1,'[4,1,7,3,2,8,6,5]',1422167907,1),(12,1,0,0,2,'[1,4,3,6,7,2,5,8]',1422167947,1),(13,1,0,0,3,'[2,1,5,3,4,6,8,7]',1422167979,1),(14,1,0,0,0,'[6,7,4,1,8,3,5,2]',1422167989,1),(15,1,0,0,0,'[6,7,4,8,5,1,2,3]',1422167997,1),(16,1,0,0,3,'[8,3,6,7,4,1,2,5]',1422168046,1),(17,1,0,0,3,'[6,7,5,1,2,3,4,8]',1422168077,1),(18,1,0,0,0,'[7,5,4,2,8,3,1,6]',1422168088,1),(19,1,0,0,0,'[3,7,2,8,4,5,1,6]',1422168153,1),(20,1,0,0,0,'[3,6,7,5,8,4,1,2]',1422168173,1),(21,1,0,0,0,'[8,5,1,7,6,4,3,2]',1422168190,1),(22,1,0,0,1,'[3,2,7,6,1,5,8,4]',1422168208,1),(23,1,3,0,0,'[4,6,7,2,3,1,8,5]',1422168231,1),(24,1,0,0,2,'[4,6,5,8,2,7,1,3]',1422168297,1),(25,1,0,0,1,'[5,1,4,3,6,2,8,7]',1422168658,1),(26,1,0,0,3,'[5,2,1,8,6,3,7,4]',1422168674,1),(27,1,0,0,0,'[7,6,4,8,5,2,1,3]',1422168693,1),(28,1,0,0,3,'[2,5,7,1,8,4,3,6]',1422168704,1),(29,1,0,0,1,'[3,8,6,4,5,1,7,2]',1422168714,1),(30,1,0,0,1,'[8,5,7,4,2,1,6,3]',1422168739,1),(31,1,3,0,0,'[1,5,3,4,2,6,8,7]',1422168757,1),(32,1,0,0,0,'[2,7,5,3,4,6,8,1]',1422168775,1),(33,1,0,0,1,'[8,3,4,2,5,7,6,1]',1422168793,1),(34,1,0,0,2,'[1,7,6,3,2,4,8,5]',1422168811,1),(35,1,0,0,4,'[1,6,5,2,7,3,4,8]',1422168828,1),(36,1,0,0,0,'[2,1,4,3,6,7,5,8]',1422168873,1),(37,1,0,0,1,'[3,4,7,5,1,8,2,6]',1422168964,1),(38,1,0,0,3,'[1,2,4,5,3,8,6,7]',1422168993,1),(39,1,0,0,1,'[5,1,2,8,4,7,3,6]',1422169012,1),(40,1,0,0,1,'[1,3,5,7,8,6,4,2]',1422169024,1),(41,1,0,0,1,'[3,7,2,8,1,4,6,5]',1422169043,1),(42,1,0,0,1,'[6,8,7,3,5,2,4,1]',1422169072,1),(43,1,0,0,1,'[8,7,3,1,5,4,2,6]',1422169120,1),(44,1,0,0,1,'[4,1,8,5,3,7,2,6]',1422169141,1),(45,1,0,0,4,'[8,3,1,4,5,6,2,7]',1422169156,1),(46,1,0,0,1,'[8,3,4,5,6,2,7,1]',1422169366,1),(47,1,0,0,2,'[7,3,6,5,8,4,2,1]',1422169416,1),(48,1,0,0,0,'[7,2,4,8,1,6,3,5]',1422169432,1),(49,1,0,0,0,'[3,7,1,6,2,4,5,8]',1422169557,1),(50,1,0,0,1,'[3,8,5,2,4,7,6,1]',1422169579,1),(51,1,3,0,0,'[5,0,2,7,6,3,1,4,8]',1422169596,0),(52,1,3,0,0,'[1,6,5,2,4,8,3,7]',1422169618,1),(53,1,1,0,0,'[7,2,6,4,3,8,5,1]',1422169635,1),(54,1,3,0,0,'[4,1,5,3,8,2,6,7]',1422169652,1),(55,1,0,0,4,'[4,2,3,7,5,8,6,1]',1422169668,1),(56,1,0,0,3,'[2,4,6,8,5,3,1,7]',1422169686,1),(57,1,0,0,3,'[3,8,7,4,6,1,5,2]',1422169729,1),(58,1,0,0,0,'[7,2,8,4,5,3,1,6]',1422169735,1),(59,1,3,0,0,'[4,5,1,2,8,6,3,7]',1422169751,1),(60,1,0,0,3,'[6,3,5,8,1,2,4,7]',1422169768,1);

/*Table structure for table `carrace_play` */

DROP TABLE IF EXISTS `carrace_play`;

CREATE TABLE `carrace_play` (
  `uid` int(10) unsigned NOT NULL,
  `cont_win_num` tinyint(1) NOT NULL,
  `force_lose_num` tinyint(1) NOT NULL,
  `lose_num` int(10) unsigned NOT NULL,
  `lose_points` int(10) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `carrace_play` */

insert  into `carrace_play`(`uid`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`create_time`,`update_time`) values (1,0,0,9,8,1422167565,1422169768);

/*Table structure for table `find` */

DROP TABLE IF EXISTS `find`;

CREATE TABLE `find` (
  `time_right` tinyint(1) unsigned NOT NULL,
  `time_finish_mission` tinyint(1) unsigned NOT NULL,
  `time_prop_min` tinyint(1) unsigned NOT NULL,
  `time_prop_max` tinyint(1) unsigned NOT NULL,
  `time_wrong` tinyint(1) unsigned NOT NULL,
  `quick_points` int(1) unsigned NOT NULL,
  `quick_free` tinyint(1) unsigned NOT NULL,
  `quick_max` tinyint(1) unsigned NOT NULL,
  `time_points` int(1) unsigned NOT NULL,
  `time_seconds` tinyint(1) unsigned NOT NULL,
  `time_max` tinyint(1) unsigned NOT NULL,
  `mission` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `find` */

/*Table structure for table `game_log` */

DROP TABLE IF EXISTS `game_log`;

CREATE TABLE `game_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL COMMENT '游戏类型：1：转盘，2：赛马，3：赛车，4：找茬，5：找东西',
  `prize` tinyint(1) unsigned NOT NULL,
  `consume_points` int(3) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1255 DEFAULT CHARSET=utf8;

/*Data for the table `game_log` */

insert  into `game_log`(`id`,`uid`,`type`,`prize`,`consume_points`,`create_time`) values (1254,1,'1',0,100,1418055164),(1253,1,'1',0,100,1418055164),(1252,1,'1',0,100,1418055163),(1251,1,'1',0,100,1418055163),(1250,1,'1',3,100,1418055163),(1249,1,'1',0,100,1418055163),(1248,1,'1',0,100,1418055163),(1247,1,'1',0,100,1418055163),(1246,1,'1',0,100,1418055162),(1245,1,'1',0,100,1418055162),(1244,1,'1',0,100,1418055162),(1243,1,'1',0,100,1418055162),(1242,1,'1',0,100,1418055162),(1241,1,'1',0,100,1418055162),(1240,1,'1',0,100,1418055161),(1239,1,'1',0,100,1418055161),(1238,1,'1',0,100,1418055161),(1237,1,'1',0,100,1418055161),(1236,1,'1',0,100,1418055161),(1235,1,'1',0,100,1418055161),(1234,1,'1',0,100,1418055160),(1233,1,'1',0,100,1418055160),(1232,1,'1',0,100,1418055160),(1231,1,'1',0,100,1418055160),(1230,1,'1',0,100,1418055160),(1229,1,'1',0,100,1418055160),(1228,1,'1',0,100,1418055159),(1227,1,'1',0,100,1418055159),(1226,1,'1',0,100,1418055159),(1225,1,'1',0,100,1418055159),(1224,1,'1',3,100,1418055159),(1223,1,'1',0,100,1418055159),(1222,1,'1',3,100,1418055158),(1221,1,'1',0,100,1418055158),(1220,1,'1',0,100,1418055158),(1219,1,'1',0,100,1418055158),(1218,1,'1',0,100,1418055158),(1217,1,'1',0,100,1418055157),(1216,1,'1',0,100,1418055157),(1215,1,'1',3,100,1418055157),(1214,1,'1',0,100,1418055157),(1213,1,'1',0,100,1418055157),(1212,1,'1',0,100,1418055157),(1211,1,'1',0,100,1418055156),(1210,1,'1',3,100,1418055156),(1209,1,'1',3,100,1418055156),(1208,1,'1',0,100,1418055156),(1207,1,'1',0,100,1418055156),(1206,1,'1',0,100,1418055156),(1205,1,'1',0,100,1418055155),(1204,1,'1',0,100,1418055155),(1203,1,'1',0,100,1418055155),(1202,1,'1',3,100,1418055155),(1201,1,'1',2,100,1418055155),(1200,1,'1',0,100,1418055155),(1199,1,'1',3,100,1418055154),(1198,1,'1',0,100,1418055154),(1197,1,'1',3,100,1418055154),(1196,1,'1',0,100,1418055154),(1195,1,'1',0,100,1418055154),(1194,1,'1',0,100,1418055154),(1193,1,'1',0,100,1418055153),(1192,1,'1',0,100,1418055153),(1191,1,'1',0,100,1418055153),(1190,1,'1',0,100,1418055153),(1189,1,'1',0,100,1418055153),(1188,1,'1',0,100,1418055153),(1187,1,'1',0,100,1418055152),(1186,1,'1',3,100,1418055152),(1185,1,'1',0,100,1418055152),(1184,1,'1',0,100,1418055152),(1183,1,'1',0,100,1418055152),(1182,1,'1',0,100,1418055151),(1181,1,'1',0,100,1418055151),(1180,1,'1',0,100,1418055151),(1179,1,'1',0,100,1418055151),(1178,1,'1',0,100,1418055151),(1177,1,'1',0,100,1418055151),(1176,1,'1',0,100,1418055151),(1175,1,'1',0,100,1418055150),(1174,1,'1',0,100,1418055150),(1173,1,'1',0,100,1418055150),(1172,1,'1',0,100,1418055150),(1171,1,'1',3,100,1418055150),(1170,1,'1',0,100,1418055150),(1169,1,'1',0,100,1418055149),(1168,1,'1',0,100,1418055149),(1167,1,'1',0,100,1418055149),(1166,1,'1',0,100,1418055149),(1165,1,'1',0,100,1418055149),(1164,1,'1',0,100,1418055149),(1163,1,'1',0,100,1418055148),(1162,1,'1',0,100,1418055148),(1161,1,'1',0,100,1418055148),(1160,1,'1',0,100,1418055148),(1159,1,'1',0,100,1418055148),(1158,1,'1',0,100,1418055148),(1157,1,'1',0,100,1418055147),(1156,1,'1',0,100,1418055147),(1155,1,'1',0,100,1418055147),(1154,1,'1',0,100,1418055147),(1153,1,'1',0,100,1418055147),(1152,1,'1',0,100,1418055147),(1151,1,'1',0,100,1418055147),(1150,1,'1',0,100,1418055146),(1149,1,'1',0,100,1418055146),(1148,1,'1',0,100,1418055146),(1147,1,'1',0,100,1418055146),(1146,1,'1',3,100,1418055146),(1145,1,'1',0,100,1418055146),(1144,1,'1',0,100,1418055145),(1143,1,'1',0,100,1418055145),(1142,1,'1',0,100,1418055145),(1141,1,'1',0,100,1418055145),(1140,1,'1',0,100,1418055145),(1139,1,'1',0,100,1418055145),(1138,1,'1',0,100,1418055144),(1137,1,'1',0,100,1418055144),(1136,1,'1',0,100,1418055144),(1135,1,'1',0,100,1418055144),(1134,1,'1',0,100,1418055144),(1133,1,'1',0,100,1418055144),(1132,1,'1',0,100,1418055144),(1131,1,'1',0,100,1418055143),(1130,1,'1',0,100,1418055143),(1129,1,'1',0,100,1418055143),(1128,1,'1',0,100,1418055143),(1127,1,'1',0,100,1418055143),(1126,1,'1',3,100,1418055143),(1125,1,'1',0,100,1418055143),(1124,1,'1',0,100,1418055142),(1123,1,'1',0,100,1418055142),(1122,1,'1',0,100,1418055142),(1121,1,'1',3,100,1418055142),(1120,1,'1',0,100,1418055142),(1119,1,'1',0,100,1418055142),(1118,1,'1',0,100,1418055141),(1117,1,'1',0,100,1418055141),(1116,1,'1',0,100,1418055141),(1115,1,'1',0,100,1418055141),(1114,1,'1',0,100,1418055140),(1113,1,'1',0,100,1418055140),(1112,1,'1',0,100,1418055140),(1111,1,'1',0,100,1418055140),(1110,1,'1',0,100,1418055140),(1109,1,'1',0,100,1418055140),(1108,1,'1',0,100,1418055139);

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
  `uid` int(10) unsigned NOT NULL,
  `rank1` int(1) unsigned NOT NULL,
  `rank2` int(1) unsigned NOT NULL,
  `rank3` int(1) unsigned NOT NULL,
  `rank` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `horserace_log` */

insert  into `horserace_log`(`id`,`uid`,`rank1`,`rank2`,`rank3`,`rank`,`create_time`,`is_random`) values (1,1,0,0,6,'[2,3,7,4,8,6,1,5]',1422163734,1),(2,1,0,0,1,'[1,8,5,2,7,6,3,4]',1422168324,1),(3,1,1,0,0,'[5,2,3,1,6,7,4,8]',1422168502,1),(4,1,1,0,0,'[7,8,6,4,5,1,2,3]',1422168538,1),(5,1,0,0,1,'[4,8,5,1,3,6,2,7]',1422168549,1),(6,1,1,0,0,'[8,6,1,5,2,7,4,3]',1422168562,1),(7,1,1,0,0,'[2,8,4,5,6,1,7,3]',1422168576,1),(8,1,0,0,1,'[7,4,3,5,6,8,1,2]',1422168594,1),(9,1,1,0,0,'[2,7,1,4,5,3,8,6]',1422168603,1),(10,1,0,0,1,'[7,6,4,3,8,5,1,2]',1422168611,1),(11,1,0,0,1,'[6,7,8,5,1,2,3,4]',1422169264,1),(12,1,0,0,3,'[7,5,2,3,6,8,1,4]',1422169285,1);

/*Table structure for table `horserace_play` */

DROP TABLE IF EXISTS `horserace_play`;

CREATE TABLE `horserace_play` (
  `uid` int(10) unsigned NOT NULL,
  `cont_win_num` tinyint(1) NOT NULL,
  `force_lose_num` tinyint(1) NOT NULL,
  `lose_num` int(10) unsigned NOT NULL,
  `lose_points` int(10) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `horserace_play` */

insert  into `horserace_play`(`uid`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`create_time`,`update_time`) values (1,0,0,12,12,1422163734,1422169285);

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

insert  into `spot`(`initial_time`,`free_reminder`,`reminder_points`,`max_reminder`,`right_add_time`,`wrong_sub_time`,`time_chunk`,`time_chunk_points`,`max_time_chunk`,`mission`,`description`) values (120,3,100,5,1,5,10,100,5,'[{\"level\":\"10\",\"points\":\"500\"}]','abc');

/*Table structure for table `spot_image` */

DROP TABLE IF EXISTS `spot_image`;

CREATE TABLE `spot_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `image_ori` varchar(255) NOT NULL,
  `image_mod` varchar(255) NOT NULL,
  `coordinate` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `spot_image` */

insert  into `spot_image`(`id`,`title`,`image_ori`,`image_mod`,`coordinate`) values (1,'test','1421893438o.jpg','1421893438m.jpg','[{\"x\":\"65\",\"y\":\"199\"},{\"x\":\"234\",\"y\":\"200\"},{\"x\":\"181\",\"y\":\"359\"},{\"x\":\"519\",\"y\":\"229\"},{\"x\":\"648\",\"y\":\"269\"}]'),(2,'test2','1421893463o.jpg','1421893463m.jpg','[{\"x\":\"72\",\"y\":\"39\"},{\"x\":\"583\",\"y\":\"51\"},{\"x\":\"214\",\"y\":\"234\"},{\"x\":\"357\",\"y\":\"382\"},{\"x\":\"650\",\"y\":\"81\"}]');

/*Table structure for table `spot_log` */

DROP TABLE IF EXISTS `spot_log`;

CREATE TABLE `spot_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `reminder_times` int(1) unsigned NOT NULL,
  `added_time` int(1) unsigned NOT NULL,
  `consume_points` int(3) unsigned NOT NULL,
  `award` varchar(100) NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `update_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

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

insert  into `turntable`(`free_num`,`consume_points`,`range`,`awards`,`prob`,`max`,`angle`,`image`,`description`) values (3,100,'{\"1\":\"1000\",\"2\":\"100\",\"3\":\"\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"iphone6\",\"2\":\"\\u4e00\\u7b49\\u5956\",\"3\":\"\\u4e8c\\u7b49\\u5956\",\"4\":\"\\u4e09\\u7b49\\u5956\",\"5\":\"\\u56db\\u7b49\\u5956\",\"6\":\"\\u4e94\\u7b49\\u5956\",\"7\":\"\\u516d\\u7b49\\u5956\",\"8\":\"\\u4e03\\u7b49\\u5956\"}','{\"1\":\"0.1\",\"2\":\"0.9\",\"3\":\"10\",\"4\":\"1\",\"5\":\"1\",\"6\":\"1\",\"7\":\"1\",\"8\":\"30\"}','{\"1\":\"10\",\"2\":\"50\",\"3\":\"500\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"30\",\"2\":\"30\",\"3\":\"30\",\"4\":\"30\",\"5\":\"30\",\"6\":\"30\",\"7\":\"30\",\"8\":\"30\",\"0\":\"30\"}','assets/turntable/turntable91.png','测试测试测试测试测试测试测试测试测试测试测试测\r\n试测试测试测试测试测试测试测试测试测试测试测试测\r\n试测试测试测试测试测试测试测试测试\r\nabcd\r\n1234');

/*Table structure for table `turntable_log` */

DROP TABLE IF EXISTS `turntable_log`;

CREATE TABLE `turntable_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
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
  `uid` int(10) unsigned NOT NULL,
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
