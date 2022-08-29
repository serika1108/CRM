/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 8.0.22 : Database - crm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`crm` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `crm`;

/*Table structure for table `tbl_activity` */

DROP TABLE IF EXISTS `tbl_activity`;

CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_activity` */

insert  into `tbl_activity`(`id`,`owner`,`name`,`startDate`,`endDate`,`cost`,`description`,`createTime`,`createBy`,`editTime`,`editBy`) values ('36c830e650744955a659c576a5c346f6','40f6cdea0bd34aceb77492a1656d9fb3','发传单1','2021-11-22','2021-11-25','978','qws','2021-11-13 17:03:15','张三',NULL,NULL),('51fa25d437d348afb94b2e2e6f9f134c','40f6cdea0bd34aceb77492a1656d9fb3','发传单2','2021-11-14','2021-11-21','900','546','2021-11-13 16:26:46','张三','2021-11-13 17:05:56','张三'),('6b8f57f04294412eabaf84cd02508d17','40f6cdea0bd34aceb77492a1656d9fb3','发传单123456','2021-11-26','2021-11-28','45','描述123','2021-11-25 16:13:03','张三',NULL,NULL),('8115777cbb664153b30f0ee9fe60e0d0','40f6cdea0bd34aceb77492a1656d9fb3','发传单741','2021-11-26','2021-11-29','65','描述78979789','2021-11-25 17:08:29','张三','2022-05-26 17:07:55','张三'),('a00f531b3ae84dc09f9ed1f10f97e0d0','40f6cdea0bd34aceb77492a1656d9fb3','发传单3','2021-11-15','2021-11-24','500','456','2021-11-13 16:26:28','张三',NULL,NULL),('b6e2b4d5a010491a8095944a2e493a42','40f6cdea0bd34aceb77492a1656d9fb3','发传单4','2021-11-13','2021-11-18','200','abc','2021-11-12 22:05:31','张三',NULL,NULL),('b7c845a789fe4a78a085a8dd93e4a5b3','40f6cdea0bd34aceb77492a1656d9fb3','发传单123','2021-11-24','2021-11-28','15422','123','2021-11-22 16:18:00','张三',NULL,NULL),('f85851d2bf5d40ee90ac1761a333a030','06f5fc056eac41558a964f96daa7f27c','发传单5','2021-11-14','2021-11-18','500','123','2021-11-13 16:24:36','张三',NULL,NULL),('f9c7f2c60e3e48a190b8bca771c2562f','40f6cdea0bd34aceb77492a1656d9fb3','发传单6','2021-11-14','2021-11-22','900','789','2021-11-13 16:48:28','张三',NULL,NULL);

/*Table structure for table `tbl_activity_remark` */

DROP TABLE IF EXISTS `tbl_activity_remark`;

CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_activity_remark` */

insert  into `tbl_activity_remark`(`id`,`noteContent`,`createTime`,`createBy`,`editTime`,`editBy`,`editFlag`,`activityId`) values ('0a567933096148b2a13d5c3ba6e62dd7','添加备注123456789','2022-05-26 17:06:41','张三',NULL,NULL,'0','8115777cbb664153b30f0ee9fe60e0d0'),('36c830e650744955a659c576a5c34612','备注233','2021-11-13 17:03:15','张三','2021-11-14 18:44:07','张三','1','36c830e650744955a659c576a5c346f6'),('40a9d80ed84d46debf44f554bc2fe9e7','备注4','2021-11-14 17:58:25','张三',NULL,NULL,'0','36c830e650744955a659c576a5c346f6'),('b5b5b27790354626bf5d7d567ceb8def','备注678','2021-11-15 19:25:52','张三',NULL,NULL,'0','36c830e650744955a659c576a5c346f6'),('d809218617b84e51921bb67009c7342e','备注789','2021-11-15 19:26:40','张三',NULL,NULL,'0','36c830e650744955a659c576a5c346f6'),('dda59e2234d74b20b16b80443ced134a','备注5','2021-11-14 17:59:46','张三',NULL,NULL,'0','36c830e650744955a659c576a5c346f6'),('e4bc74dc76394ecd8afc6f1285f148c0','备注3','2021-11-14 17:57:21','张三',NULL,NULL,'0','36c830e650744955a659c576a5c346f6');

/*Table structure for table `tbl_clue` */

DROP TABLE IF EXISTS `tbl_clue`;

CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_clue` */

insert  into `tbl_clue`(`id`,`fullname`,`appellation`,`owner`,`company`,`job`,`email`,`phone`,`website`,`mphone`,`state`,`source`,`createBy`,`createTime`,`editBy`,`editTime`,`description`,`contactSummary`,`nextContactTime`,`address`) values ('18f4cdc3b0d74d1eb3424387fe71dbbd','王健林','先生','40f6cdea0bd34aceb77492a1656d9fb3','万达','CEO','1374@qq.com','123-7884','wanda.com','1234566','将来联系','合作伙伴','张三','2021-11-25 16:11:50',NULL,NULL,'描述123','纪要123','2021-11-29','地址789'),('3cffbe8250854863b31a5c6d1753c479','艾伯特','先生','40f6cdea0bd34aceb77492a1656d9fb3','谷歌','技术人员','google@com','123-69','google.com','147562','将来联系','推销电话','张三','2021-11-25 16:00:21',NULL,NULL,'描述123','纪要456','2021-11-29','地址789'),('56c1f5c0e40842678aac9a4b7340a3c7','小绿','女士','40f6cdea0bd34aceb77492a1656d9fb3','国家电网','技术总管','123@694','12-789','gjdw.com','123456','已联系','合作伙伴','张三','2021-11-25 17:09:41',NULL,NULL,'描述123','纪要1323','2021-11-30','地址7'),('ae4352afa9194687aa8fc345fd295836','小马','先生','40f6cdea0bd34aceb77492a1656d9fb3','五粮液','副部长','123@564','12346','wuliangye.com','984626','已联系','推销电话','张三','2022-05-26 17:35:03',NULL,NULL,'描述789456','纪要741852','2022-05-17','五粮液的地址'),('b0be4627feb843f889a70ecfd422ac5c','马化腾','先生','40f6cdea0bd34aceb77492a1656d9fb3','腾讯','CEO','123456@qq.com','123-123','tx.com','123-456','将来联系','公开媒介','张三','2021-11-24 21:56:14',NULL,NULL,'描述123','纪要123','2021-11-25','地址456'),('e0e686d14fa94a9d91198e834fa730d7','小红','女士','40f6cdea0bd34aceb77492a1656d9fb3','百度','高管','123@qq.com','123-123','baidu.com','123456789','已联系','推销电话','张三','2021-11-24 21:50:08',NULL,NULL,'描述123','纪要123','2021-11-29','地址123');

/*Table structure for table `tbl_clue_activity_relation` */

DROP TABLE IF EXISTS `tbl_clue_activity_relation`;

CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_clue_activity_relation` */

insert  into `tbl_clue_activity_relation`(`id`,`clueId`,`activityId`) values ('958fe6298a4c452cb285471783e2d659','56c1f5c0e40842678aac9a4b7340a3c7','51fa25d437d348afb94b2e2e6f9f134c'),('9c538cdeeb0d402388832fbb9dcf59cf','56c1f5c0e40842678aac9a4b7340a3c7','f85851d2bf5d40ee90ac1761a333a030');

/*Table structure for table `tbl_clue_remark` */

DROP TABLE IF EXISTS `tbl_clue_remark`;

CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_clue_remark` */

insert  into `tbl_clue_remark`(`id`,`noteContent`,`createBy`,`createTime`,`editBy`,`editTime`,`editFlag`,`clueId`) values ('b0be4627feb843f889a70ec','备注7',NULL,NULL,NULL,NULL,NULL,'b0be4627feb843f889a70ecfd422ac5c'),('udabusbuadisnidnwqdq661616asnai','备注5',NULL,NULL,NULL,NULL,NULL,'e0e686d14fa94a9d91198e834fa730d7'),('udabusbuadisnidnwqdq661616asnoo','备注6',NULL,NULL,NULL,NULL,NULL,'e0e686d14fa94a9d91198e834fa730d7');

/*Table structure for table `tbl_contacts` */

DROP TABLE IF EXISTS `tbl_contacts`;

CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_contacts` */

insert  into `tbl_contacts`(`id`,`owner`,`source`,`customerId`,`fullname`,`appellation`,`email`,`mphone`,`job`,`birth`,`createBy`,`createTime`,`editBy`,`editTime`,`description`,`contactSummary`,`nextContactTime`,`address`) values ('3878ebbb2894406591146ddf47efa7c8','40f6cdea0bd34aceb77492a1656d9fb3','合作伙伴','ffe441b6d79d4988b402f188e4a1573b','托马斯','先生','12345@163','5562626','游戏策划',NULL,'张三','2021-11-28 11:54:01',NULL,NULL,'描述123','纪要123','5562626','地址789'),('3dffcd4d548d4bfb80b50d97a74289ad','40f6cdea0bd34aceb77492a1656d9fb3','公开媒介','7922de6266ac416fbc15b3ecaf43d0b3','马云','先生','123@163.com','16226363','CEO','1978-1-6','张三','2021-11-25 22:18:52',NULL,NULL,'描述456','纪要456','16226363','地址789'),('4cc87fe343224b6e893deeb4f170a628','40f6cdea0bd34aceb77492a1656d9fb3','在线商场','67a806d318ca4f52ad18f56e2cc8802b','小张','博士','9874@qq.com','62626262','科研人员',NULL,'张三','2022-05-26 17:30:55',NULL,NULL,'描述123','纪要456','62626262','地址789'),('f2f8abbb0358451f98b5d44e4f8eff33','40f6cdea0bd34aceb77492a1656d9fb3','交易会','627196e27ea24630a81865250d542397','小明','教授','6949@qq.com','789456','科研人员','1989-10-24','张三','2021-11-24 22:05:34',NULL,NULL,'描述789','纪要789','789456','地址789'),('f2f8abbb0358451f98b5d44e4f8eff34','06f5fc056eac41558a964f96daa7f27c','公开媒介','9d150f63b75346ef99fe5a9444f9a630','小李','先生','69629@qq.com','412354','联络员','1971-9-6','张三','2021-11-25 16:08:41',NULL,NULL,'描述789','纪要789','789456','地址789');

/*Table structure for table `tbl_contacts_activity_relation` */

DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;

CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_contacts_activity_relation` */

insert  into `tbl_contacts_activity_relation`(`id`,`contactsId`,`activityId`) values ('465d5b13fab648fc9de9c932c3420086','4cc87fe343224b6e893deeb4f170a628','36c830e650744955a659c576a5c346f6');

/*Table structure for table `tbl_contacts_remark` */

DROP TABLE IF EXISTS `tbl_contacts_remark`;

CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_contacts_remark` */

/*Table structure for table `tbl_customer` */

DROP TABLE IF EXISTS `tbl_customer`;

CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_customer` */

insert  into `tbl_customer`(`id`,`owner`,`name`,`website`,`phone`,`createBy`,`createTime`,`editBy`,`editTime`,`contactSummary`,`nextContactTime`,`description`,`address`) values ('3a8b31caa0534b21b98b24b6522ce4fd','40f6cdea0bd34aceb77492a1656d9fb3','万达','wanda.com','415631','张三','2021-11-25 16:59:56',NULL,NULL,'纪要123','2021-12-14','描述46','地址777'),('429add3dcc714c65b11340066556eead','40f6cdea0bd34aceb77492a1656d9fb3','阿里','alibaba.com','5812626','张三','2021-11-25 11:35:51',NULL,NULL,'纪要123','2021-12-15','描述741','地址666'),('48e05da76b304937b243659bce5e6677','40f6cdea0bd34aceb77492a1656d9fb3','谷歌','google.com','54848','张三','2021-11-25 11:36:43',NULL,NULL,'纪要123','2021-12-22','描述78','地址6'),('627196e27ea24630a81865250d542397','40f6cdea0bd34aceb77492a1656d9fb3','阿里','alibaba.com','1213','张三','2021-11-24 22:05:34',NULL,NULL,'纪要789','2021-11-29','描述789','地址789'),('67a806d318ca4f52ad18f56e2cc8802b','40f6cdea0bd34aceb77492a1656d9fb3','中国石油','shiyou.com','74-6599','张三','2022-05-26 17:30:55',NULL,NULL,'纪要456','2021-11-30','描述123','地址789'),('7922de6266ac416fbc15b3ecaf43d0b3','40f6cdea0bd34aceb77492a1656d9fb3','阿里巴巴','alibaba.com','789-6521','张三','2021-11-25 22:18:52',NULL,NULL,'纪要456','2021-11-29','描述456','地址789'),('9d150f63b75346ef99fe5a9444f9a630','40f6cdea0bd34aceb77492a1656d9fb3','国家电网','gjdw.com','3636','张三','2021-11-25 11:34:49',NULL,NULL,'纪要123','2021-12-15','描述999','地址888'),('efd0842f1f66449aa7afdb8769f722e7','40f6cdea0bd34aceb77492a1656d9fb3','百度','baidu.com','748','张三','2021-11-25 11:39:00',NULL,NULL,'纪要123','2021-12-23','描述654','地址111'),('ffe441b6d79d4988b402f188e4a1573b','40f6cdea0bd34aceb77492a1656d9fb3','steam','steam.com','123-456','张三','2021-11-28 11:54:01',NULL,NULL,'纪要123','2021-11-30','描述123','地址789');

/*Table structure for table `tbl_customer_remark` */

DROP TABLE IF EXISTS `tbl_customer_remark`;

CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_customer_remark` */

/*Table structure for table `tbl_dic_type` */

DROP TABLE IF EXISTS `tbl_dic_type`;

CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_dic_type` */

insert  into `tbl_dic_type`(`code`,`name`,`description`) values ('appellation','称呼',''),('clueState','线索状态',''),('returnPriority','回访优先级',''),('returnState','回访状态',''),('source','来源',''),('stage','阶段',''),('transactionType','交易类型','');

/*Table structure for table `tbl_dic_value` */

DROP TABLE IF EXISTS `tbl_dic_value`;

CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_dic_value` */

insert  into `tbl_dic_value`(`id`,`value`,`text`,`orderNo`,`typeCode`) values ('06e3cbdf10a44eca8511dddfc6896c55','虚假线索','虚假线索','4','clueState'),('0fe33840c6d84bf78df55d49b169a894','销售邮件','销售邮件','8','source'),('12302fd42bd349c1bb768b19600e6b20','交易会','交易会','11','source'),('1615f0bb3e604552a86cde9a2ad45bea','最高','最高','2','returnPriority'),('176039d2a90e4b1a81c5ab8707268636','教授','教授','5','appellation'),('1e0bd307e6ee425599327447f8387285','将来联系','将来联系','2','clueState'),('2173663b40b949ce928db92607b5fe57','丢失线索','丢失线索','5','clueState'),('2876690b7e744333b7f1867102f91153','未启动','未启动','1','returnState'),('29805c804dd94974b568cfc9017b2e4c','07成交','07成交','7','stage'),('310e6a49bd8a4962b3f95a1d92eb76f4','试图联系','试图联系','1','clueState'),('31539e7ed8c848fc913e1c2c93d76fd1','博士','博士','4','appellation'),('37ef211719134b009e10b7108194cf46','01资质审查','01资质审查','1','stage'),('391807b5324d4f16bd58c882750ee632','08丢失的线索','08丢失的线索','8','stage'),('3a39605d67da48f2a3ef52e19d243953','聊天','聊天','14','source'),('474ab93e2e114816abf3ffc596b19131','低','低','3','returnPriority'),('48512bfed26145d4a38d3616e2d2cf79','广告','广告','1','source'),('4d03a42898684135809d380597ed3268','合作伙伴研讨会','合作伙伴研讨会','9','source'),('59795c49896947e1ab61b7312bd0597c','先生','先生','1','appellation'),('5c6e9e10ca414bd499c07b886f86202a','高','高','1','returnPriority'),('67165c27076e4c8599f42de57850e39c','夫人','夫人','2','appellation'),('68a1b1e814d5497a999b8f1298ace62b','09因竞争丢失关闭','09因竞争丢失关闭','9','stage'),('6b86f215e69f4dbd8a2daa22efccf0cf','web调研','web调研','13','source'),('72f13af8f5d34134b5b3f42c5d477510','合作伙伴','合作伙伴','6','source'),('7c07db3146794c60bf975749952176df','未联系','未联系','6','clueState'),('86c56aca9eef49058145ec20d5466c17','内部研讨会','内部研讨会','10','source'),('9095bda1f9c34f098d5b92fb870eba17','进行中','进行中','3','returnState'),('954b410341e7433faa468d3c4f7cf0d2','已有业务','已有业务','1','transactionType'),('966170ead6fa481284b7d21f90364984','已联系','已联系','3','clueState'),('96b03f65dec748caa3f0b6284b19ef2f','推迟','推迟','2','returnState'),('97d1128f70294f0aac49e996ced28c8a','新业务','新业务','2','transactionType'),('9ca96290352c40688de6596596565c12','完成','完成','4','returnState'),('9e6d6e15232549af853e22e703f3e015','需要条件','需要条件','7','clueState'),('9ff57750fac04f15b10ce1bbb5bb8bab','02需求分析','02需求分析','2','stage'),('a70dc4b4523040c696f4421462be8b2f','等待某人','等待某人','5','returnState'),('a83e75ced129421dbf11fab1f05cf8b4','推销电话','推销电话','2','source'),('ab8472aab5de4ae9b388b2f1409441c1','常规','常规','5','returnPriority'),('ab8c2a3dc05f4e3dbc7a0405f721b040','05提案/报价','05提案/报价','5','stage'),('b924d911426f4bc5ae3876038bc7e0ad','web下载','web下载','12','source'),('c13ad8f9e2f74d5aa84697bb243be3bb','03价值建议','03价值建议','3','stage'),('c83c0be184bc40708fd7b361b6f36345','最低','最低','4','returnPriority'),('db867ea866bc44678ac20c8a4a8bfefb','员工介绍','员工介绍','3','source'),('e44be1d99158476e8e44778ed36f4355','04确定决策者','04确定决策者','4','stage'),('e5f383d2622b4fc0959f4fe131dafc80','女士','女士','3','appellation'),('e81577d9458f4e4192a44650a3a3692b','06谈判/复审','06谈判/复审','6','stage'),('fb65d7fdb9c6483db02713e6bc05dd19','在线商场','在线商场','5','source'),('fd677cc3b5d047d994e16f6ece4d3d45','公开媒介','公开媒介','7','source'),('ff802a03ccea4ded8731427055681d48','外部介绍','外部介绍','4','source');

/*Table structure for table `tbl_tran` */

DROP TABLE IF EXISTS `tbl_tran`;

CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_tran` */

insert  into `tbl_tran`(`id`,`owner`,`money`,`name`,`expectedDate`,`customerId`,`stage`,`type`,`source`,`activityId`,`contactsId`,`createBy`,`createTime`,`editBy`,`editTime`,`description`,`contactSummary`,`nextContactTime`) values ('287d94868a0f4594b0e0d176c2730422','40f6cdea0bd34aceb77492a1656d9fb3','5000000','交易753','2021-12-08','7922de6266ac416fbc15b3ecaf43d0b3','05提案/报价',NULL,'公开媒介','51fa25d437d348afb94b2e2e6f9f134c','3dffcd4d548d4bfb80b50d97a74289ad','张三','2021-11-25 22:18:52','张三','2021-11-26 10:25:07','描述456','纪要456','2021-11-29'),('313eaadebd5442669786000a7d119744','40f6cdea0bd34aceb77492a1656d9fb3','5000','交易645','2021-12-19','efd0842f1f66449aa7afdb8769f722e7','06谈判/复审','新业务','合作伙伴','36c830e650744955a659c576a5c346f6','f2f8abbb0358451f98b5d44e4f8eff33','张三','2021-11-25 11:39:00',NULL,NULL,'描述123','纪要123','2021-12-23'),('478b31a58681407184d4dbc9e18c12c4','40f6cdea0bd34aceb77492a1656d9fb3','500000','转换活动','2022-05-30','67a806d318ca4f52ad18f56e2cc8802b','05提案/报价',NULL,'在线商场','36c830e650744955a659c576a5c346f6','4cc87fe343224b6e893deeb4f170a628','张三','2022-05-26 17:30:55','张三','2022-08-29 10:50:52','描述123','纪要456','2021-11-30'),('6738ca7ad38340eb8747e3011077663d','40f6cdea0bd34aceb77492a1656d9fb3','700000','交易21231','2021-12-02','ffe441b6d79d4988b402f188e4a1573b','03价值建议',NULL,'合作伙伴','6b8f57f04294412eabaf84cd02508d17','3878ebbb2894406591146ddf47efa7c8','张三','2021-11-28 11:54:01','张三','2022-05-29 13:21:17','描述123','纪要123','2021-11-30'),('7e463274f11540ca87107ab0360c711d','40f6cdea0bd34aceb77492a1656d9fb3','789456','交易123','2021-11-29','627196e27ea24630a81865250d542397','06谈判/复审','新业务','广告','36c830e650744955a659c576a5c346f6','f2f8abbb0358451f98b5d44e4f8eff34','张三','2021-11-24 22:07:50','张三','2021-11-24 22:14:01','描述123','纪要123','2021-11-26'),('95310c2637c54fa39855446720f9d982','40f6cdea0bd34aceb77492a1656d9fb3','987','交易741','2021-12-12','efd0842f1f66449aa7afdb8769f722e7','05提案/报价','新业务','员工介绍','36c830e650744955a659c576a5c346f6','f2f8abbb0358451f98b5d44e4f8eff33','张三','2021-11-25 11:39:33','张三','2021-11-25 16:56:43','描述123','纪要123','2021-12-20'),('9d36dbecfd44491caf05b95279cdd470','40f6cdea0bd34aceb77492a1656d9fb3','7474','交易789','2021-12-08','429add3dcc714c65b11340066556eead','03价值建议','已有业务','在线商场','36c830e650744955a659c576a5c346f6','f2f8abbb0358451f98b5d44e4f8eff33','张三','2021-11-25 11:35:51',NULL,NULL,'描述123','纪要123','2021-12-15'),('b61d051cb46145d98e05c384c8f8d92e','40f6cdea0bd34aceb77492a1656d9fb3','789456','交易486','2021-11-30','9d150f63b75346ef99fe5a9444f9a630','05提案/报价','已有业务','web调研','36c830e650744955a659c576a5c346f6','f2f8abbb0358451f98b5d44e4f8eff33','张三','2021-11-25 11:34:49',NULL,NULL,'描述123','纪要123','2021-12-15'),('d2cd86462ed8417faf04ed860c97653d','40f6cdea0bd34aceb77492a1656d9fb3','741225','交易412','2021-12-20','48e05da76b304937b243659bce5e6677','06谈判/复审','新业务','员工介绍','36c830e650744955a659c576a5c346f6','f2f8abbb0358451f98b5d44e4f8eff33','张三','2021-11-25 11:36:43',NULL,NULL,'描述123','纪要123','2021-12-22'),('f47730cc6f734cceafb1bc0e83f19866','40f6cdea0bd34aceb77492a1656d9fb3','74411111','交易1234567','2021-12-14','3a8b31caa0534b21b98b24b6522ce4fd','04确定决策者','新业务','web调研','36c830e650744955a659c576a5c346f6','f2f8abbb0358451f98b5d44e4f8eff33','张三','2021-11-25 16:59:56',NULL,NULL,'描述123','纪要123','2021-12-14');

/*Table structure for table `tbl_tran_history` */

DROP TABLE IF EXISTS `tbl_tran_history`;

CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_tran_history` */

insert  into `tbl_tran_history`(`id`,`stage`,`money`,`expectedDate`,`createTime`,`createBy`,`tranId`) values ('0a8cf62bad68469bad27c03f48a02a4c','06谈判/复审','5000','2021-12-19','2021-11-25 11:39:00','张三','313eaadebd5442669786000a7d119744'),('23998f8ed5c7495bba951e47fe82e075','05提案/报价','700000','2021-12-02','2021-11-28 11:54:01','张三','6738ca7ad38340eb8747e3011077663d'),('3a65f45074e9491aafd5b18061be53ee','04确定决策者','74411111','2021-12-14','2021-11-25 16:59:56','张三','f47730cc6f734cceafb1bc0e83f19866'),('3c29846d2d3c4948bb8fb125542d7677','05提案/报价','987','2021-12-12','2021-11-25 16:56:43','张三','95310c2637c54fa39855446720f9d982'),('4257fa511293446f8a2f758dfce08501','08丢失的线索','700000','2021-12-02','2022-05-29 13:21:15','张三','6738ca7ad38340eb8747e3011077663d'),('4d931794525844c7b148186643ae3235','05提案/报价','500000','2022-05-30','2022-05-26 17:30:55','张三','478b31a58681407184d4dbc9e18c12c4'),('589805fe51ea4338a63c76804db68fdb','03价值建议','500000','2022-05-30','2022-08-29 10:50:22','张三','478b31a58681407184d4dbc9e18c12c4'),('5e743958cbf44f528e18398d1c231a70','03价值建议','7474','2021-12-08','2021-11-25 11:35:51','张三','9d36dbecfd44491caf05b95279cdd470'),('795c9ecda7304e349b9e4abbf1810d66','06谈判/复审','500000','2022-05-30','2022-06-09 19:28:27','张三','478b31a58681407184d4dbc9e18c12c4'),('8049568061e34068b91c2fc3a01fc9eb','08丢失的线索','5000000','2021-12-08','2021-11-26 10:24:46','张三','287d94868a0f4594b0e0d176c2730422'),('83c2931f86e74be4a1b0eaf6c668abad','05提案/报价','500000','2022-05-30','2022-08-29 10:50:52','张三','478b31a58681407184d4dbc9e18c12c4'),('880262aafe3a4d88ae9ccf1f8e728d17','08丢失的线索','500000','2022-05-30','2022-08-29 10:50:29','张三','478b31a58681407184d4dbc9e18c12c4'),('89d0885c73c34895ade4faa843aa5ca0','03价值建议','700000','2021-12-02','2022-05-29 13:21:17','张三','6738ca7ad38340eb8747e3011077663d'),('97c085556f1e4318ab0c7de35124a32c','06谈判/复审','741225','2021-12-20','2021-11-25 11:36:43','张三','d2cd86462ed8417faf04ed860c97653d'),('9bb2e82350134a71985f5e8cac141e54','04确定决策者','789456','2021-11-29','2021-11-24 22:07:50','张三','7e463274f11540ca87107ab0360c711d'),('bc1fb3e19a1b453b857676ea08376085','04确定决策者','5000000','2021-12-08','2021-11-26 10:24:27','张三','287d94868a0f4594b0e0d176c2730422'),('bc4a2fae10ca48d781dd482c8e9c5d0b','09因竞争丢失关闭','500000','2022-05-30','2022-06-09 19:28:39','张三','478b31a58681407184d4dbc9e18c12c4'),('c765c2e4d01c4ea0a19c8fafafaf5c6e','03价值建议','987','2021-12-12','2021-11-25 11:39:33','张三','95310c2637c54fa39855446720f9d982'),('cda0084f32c642869be738576ca00014','05提案/报价','789456','2021-11-30','2021-11-25 11:34:49','张三','b61d051cb46145d98e05c384c8f8d92e'),('d7fdb6db5134432496df946ba7ffaf6a','06谈判/复审','5000000','2021-12-08','2021-11-25 22:18:52','张三','287d94868a0f4594b0e0d176c2730422'),('de00c64b3dfa4969964cebedc9d88541','05提案/报价','5000000','2021-12-08','2021-11-26 10:25:07','张三','287d94868a0f4594b0e0d176c2730422'),('dfa53d2002d34205915dd9f3326ee93d','04确定决策者','500000','2022-05-30','2022-06-09 19:28:24','张三','478b31a58681407184d4dbc9e18c12c4'),('e7b22872623b4d1e98d563a4f39a55df','07成交','500000','2022-05-30','2022-05-26 17:37:33','张三','478b31a58681407184d4dbc9e18c12c4'),('ea85091b314b4a5b959e660aefe20d41','06谈判/复审','789456','2021-11-29','2021-11-24 22:14:01','张三','7e463274f11540ca87107ab0360c711d'),('edffa713ab04452e82d494ce0ca6a260','05提案/报价','500000','2022-05-30','2022-06-09 19:28:43','张三','478b31a58681407184d4dbc9e18c12c4'),('f186f3d6ea464c4da459d2e247117409','03价值建议','500000','2022-05-30','2022-06-09 19:28:26','张三','478b31a58681407184d4dbc9e18c12c4');

/*Table structure for table `tbl_tran_remark` */

DROP TABLE IF EXISTS `tbl_tran_remark`;

CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_tran_remark` */

/*Table structure for table `tbl_user` */

DROP TABLE IF EXISTS `tbl_user`;

CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_user` */

insert  into `tbl_user`(`id`,`loginAct`,`name`,`loginPwd`,`email`,`expireTime`,`lockState`,`deptno`,`allowIps`,`createTime`,`createBy`,`editTime`,`editBy`) values ('06f5fc056eac41558a964f96daa7f27c','ls','李四','202cb962ac59075b964b07152d234b70','ls@163.com','2018-11-27 21:50:05','1','A001','192.168.1.1','2018-11-22 12:11:40','李四',NULL,NULL),('40f6cdea0bd34aceb77492a1656d9fb3','zs','张三','202cb962ac59075b964b07152d234b70','zs@qq.com','2022-11-30 23:50:55','1','A001','192.168.1.1,192.168.1.2,127.0.0.1','2018-11-22 11:37:34','张三',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
