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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `find_image` */

insert  into `find_image`(`id`,`title`,`tags`,`type`,`file_name`) values (3,'northface','2,5',1,'1423306725.png'),(4,'it','2',2,'1423306815.png'),(5,'ep','1',3,'1423306827.png'),(6,'h','2',4,'1423306840.png');

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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `find_tag` */

insert  into `find_tag`(`id`,`name`,`create_time`,`update_time`) values (1,'服装',0,0),(2,'运动',0,0),(4,'食品',0,0),(5,'床上用品',0,0);

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

insert  into `turntable`(`free_num`,`consume_points`,`range`,`awards`,`prob`,`max`,`angle`,`image`,`description`) values (3,100,'{\"1\":\"1000\",\"2\":\"100\",\"3\":\"\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"iphone6\",\"2\":\"\\u4e00\\u7b49\\u5956\",\"3\":\"\\u4e8c\\u7b49\\u5956\",\"4\":\"\\u4e09\\u7b49\\u5956\",\"5\":\"\\u56db\\u7b49\\u5956\",\"6\":\"\\u4e94\\u7b49\\u5956\",\"7\":\"\\u516d\\u7b49\\u5956\",\"8\":\"\\u4e03\\u7b49\\u5956\"}','{\"1\":\"0.1\",\"2\":\"0.9\",\"3\":\"10\",\"4\":\"1\",\"5\":\"1\",\"6\":\"1\",\"7\":\"1\",\"8\":\"30\"}','{\"1\":\"10\",\"2\":\"50\",\"3\":\"500\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"30\",\"2\":\"30\",\"3\":\"30\",\"4\":\"30\",\"5\":\"30\",\"6\":\"30\",\"7\":\"30\",\"8\":\"30\",\"0\":\"30\"}','assets/turntable/turntable91.png','测试测试测试测试测试测试测试测试测试测试测试测\r\n试测试测试测试测试测试测试测试测试测试测试测试测\r\n试测试测试测试测试测试测试测试测试\r\nabcd\r\n1234');

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
