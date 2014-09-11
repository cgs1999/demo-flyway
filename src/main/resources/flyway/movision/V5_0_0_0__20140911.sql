create database if not exists `flyway_movision` default character set utf8;
use `flyway_movision`;

DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `level` int(11),
  `type` varchar(20),
  `remark` varchar(250),
  `create_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00',
  `update_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11),
  `name` varchar(50) NOT NULL,
  `url` varchar(250),
  `order_index` int(11) DEFAULT 0,
  `create_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00',
  `update_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_moid` varchar(36) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY  (`user_moid`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sys_param_config`;
CREATE TABLE `sys_param_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_name` varchar(50) NOT NULL DEFAULT '',
  `config_type` varchar(50) DEFAULT NULL,
  `config_key` varchar(50) NOT NULL DEFAULT '',
  `config_value` varchar(500) NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sys_language`;
CREATE TABLE `sys_language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `i18n_tag` varchar(50) NOT NULL,
  `order_index` int(11) DEFAULT 0,
  `enable` int(11) DEFAULT NULL COMMENT '启用禁用标识',
  `remark` varchar(250) DEFAULT NULL,
  `create_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00',
  `update_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `i18n_tag` (`i18n_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `domain_device`;
CREATE TABLE `domain_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type_id` varchar(20) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT '',
  `order_index` int(2) DEFAULT NULL COMMENT '排序号',
  `terminal_type` varchar(2) DEFAULT NULL COMMENT '终端类型',
  `device_class` varchar(2) DEFAULT NULL COMMENT '设备类别，0:普通类别，1:H323类别',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `domain_change_log`;
CREATE TABLE `domain_change_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_type` varchar(20) DEFAULT NULL COMMENT '变更类型，如1——服务域变更、2——平台域变更、4——用户域变更以及相关的组合',
  `domain_moid` varchar(40) DEFAULT NULL COMMENT '变更域moid',
  `service_domain_moid` varchar(40) DEFAULT NULL COMMENT '服务域moid',
  `service_domain_name` varchar(100) DEFAULT NULL COMMENT '服务域名称',
  `platform_domain_moid` varchar(40) DEFAULT NULL COMMENT '平台域moid',
  `platform_domain_name` varchar(100) DEFAULT NULL COMMENT '平台域名称',
  `user_domain_moid` varchar(40) DEFAULT NULL COMMENT '用户域moid',
  `user_domain_name` varchar(100) DEFAULT NULL COMMENT '用户域名称',
  `update_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 初始化语言包
INSERT INTO `sys_language`(id, name, i18n_tag, remark, create_time, update_time, order_index, enable) VALUES 
(65,'英文(美国)','en_US',NULL,'2014-03-24 11:26:57','2014-03-24 11:26:57',8000,1),
(253,'中文(中国)','zh_CN',NULL,'2014-03-24 11:26:57','2014-03-24 11:26:57',9000,1);


-- 初始化菜单
INSERT INTO `sys_menu`(id, parent_id, name, url, order_index, create_time, update_time) VALUES 
(1,-1,'权限管理','',800,'2014-03-24 23:06:31','2014-04-16 07:47:40'),
(3,1,'用户管理','/system/user/list',950,'2014-03-24 23:14:26','2014-03-25 23:38:11'),
(5,1,'菜单管理','/system/menu/list',940,'2014-03-24 23:14:34','2014-03-25 23:38:19'),
(7,1,'角色管理','/system/role/list',930,'2014-03-24 23:14:43','2014-03-25 23:37:56'),
(9,29,'参数配置','/system/paramConfig/list',920,'2014-03-24 23:14:52','2014-04-16 07:46:17'),
(11,29,'语言包配置','/system/language/list',910,'2014-03-24 23:15:03','2014-04-16 07:46:24'),
(12,-1,'域管理','',700,'2014-04-10 01:30:14','2014-04-18 02:14:06'),
(13,12,'设备管理','/domain/device/list',100,'2014-03-26 00:07:33','2014-04-18 02:15:38'),
(14,12,'号段管理','/domain/numberSegment/list',300,'2014-03-26 00:07:33','2014-04-18 02:16:04'),
(15,12,'服务域管理','/domain/serviceDomain/list',900,'2014-04-11 05:33:11','2014-04-18 02:15:46'),
(17,27,'订单管理','/domain/order/list',1010,'2014-04-14 01:14:45','2014-04-18 02:42:11'),
(23,12,'平台域管理','/domain/platformDomain/list',800,'2014-04-16 03:12:35','2014-04-18 02:15:52'),
(25,12,'用户域管理','/domain/userDomain/list',700,'2014-04-16 05:43:58','2014-04-18 02:15:58'),
(27,-1,'号码入网','',500,'2014-04-16 07:33:28','2014-04-16 07:46:04'),
(29,-1,'基础配置','',900,'2014-04-16 07:45:49','2014-04-16 07:47:32'),
(30,27,'号码管理','/domain/number/list',505,'2014-04-14 01:14:45','2014-04-18 02:42:11');


-- 初始化角色
INSERT INTO `sys_role`(id, name, level, type, remark, create_time, update_time) VALUES 
(1,'BMC超级管理员',1,'1','','2014-03-24 13:07:30','2014-04-09 05:25:59'),
(3,'服务域管理员',1,'2','','2014-03-24 13:07:52','2014-03-24 13:07:52'),
(5,'服务域操作员',2,'1','','2014-03-24 13:14:55','2014-03-27 06:01:30'),
(7,'企业（用户）管理员',1,'1','','2014-03-24 13:15:16','2014-03-27 06:02:01'),
(9,'企业（用户）分组管理员',1,'1','','2014-03-24 13:15:27','2014-03-27 06:02:34'),
(15,'企业（用户）分组成员',2,'1','','2014-03-27 06:02:50','2014-03-27 06:02:50'),
(17,'BMC开发人员',1,'1','','2014-03-27 06:03:19','2014-04-09 05:39:51');


-- 初始化角色菜单
INSERT INTO `sys_role_menu`(role_id, menu_id) VALUES 
(1,1),(1,3),(1,5),(1,7),(1,9),(1,11),(1,12),(1,13),(1,14),(1,15),(1,17),(1,23),(1,25),(1,27),(1,29),(1,30),
(17,1),(17,3),(17,5),(17,7),(17,9),(17,11),(17,12),(17,29);


-- 初始化默认管理员角色
INSERT INTO `sys_user_role`(user_moid, role_id) VALUES 
('mooooooo-oooo-oooo-oooo-defaultadmin',1);


-- 初始化设备类型
INSERT INTO `domain_device`(id, name, type_id, status, order_index, terminal_type, device_class) VALUES 
(1,'HD100','522','1',9000,'1', '0'),
(2,'HD100S','523','1',8000,'1', '0'),
(3,'TS6610','513','1',7000,'1', '0'),
(4,'TS5610','517','1',6000,'1', '0'),
(5,'TrueLink','514','1',5000,'0', '0'),
(6,'iPad','515','1',4000,'0', '0'),
(7,'Android_Phone','527','1',3500,'0', '0'),
(8,'监控授权终端','530','1',3000,'1', '1'),
(9,'第三方授权终端','531','1',3000,'1', '1'),
(10,'HD1000','521','1',7500,'1', '0'),
(11,'WD1000','525','1',7200,'1', '0');



-- Quartz框架升级到1.8.4
DROP TABLE IF EXISTS QRTZ_JOB_LISTENERS;
DROP TABLE IF EXISTS QRTZ_TRIGGER_LISTENERS;
DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
DROP TABLE IF EXISTS QRTZ_LOCKS;
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;
DROP TABLE IF EXISTS QRTZ_CALENDARS;

CREATE TABLE QRTZ_JOB_DETAILS
  (
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    IS_STATEFUL VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_JOB_LISTENERS
  (
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    JOB_LISTENER VARCHAR(200) NOT NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP,JOB_LISTENER),
    FOREIGN KEY (JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(10) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CRON_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_BLOB_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_TRIGGER_LISTENERS
  (
    TRIGGER_NAME  VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    TRIGGER_LISTENER VARCHAR(200) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_LISTENER),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
);


CREATE TABLE QRTZ_CALENDARS
  (
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (CALENDAR_NAME)
);



CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
  (
    TRIGGER_GROUP  VARCHAR(200) NOT NULL, 
    PRIMARY KEY (TRIGGER_GROUP)
);

CREATE TABLE QRTZ_FIRED_TRIGGERS
  (
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_STATEFUL VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (ENTRY_ID)
);

CREATE TABLE QRTZ_SCHEDULER_STATE
  (
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (INSTANCE_NAME)
);

CREATE TABLE QRTZ_LOCKS
  (
    LOCK_NAME  VARCHAR(40) NOT NULL, 
    PRIMARY KEY (LOCK_NAME)
);


INSERT INTO QRTZ_LOCKS values('TRIGGER_ACCESS');
INSERT INTO QRTZ_LOCKS values('JOB_ACCESS');
INSERT INTO QRTZ_LOCKS values('CALENDAR_ACCESS');
INSERT INTO QRTZ_LOCKS values('STATE_ACCESS');
INSERT INTO QRTZ_LOCKS values('MISFIRE_ACCESS');


-- 号段表
CREATE TABLE `domain_number_segment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_domain_moid` varchar(50) DEFAULT '' COMMENT '所属服务域moid',
  `platform_domain_moid` varchar(50) DEFAULT '' COMMENT '所属平台域moid',
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '所属用户域moid',
  `prefix` varchar(15) DEFAULT '' COMMENT '号段前缀',
  `start_segment` varchar(15) DEFAULT '' COMMENT '号段开始范围',
  `end_segment` varchar(15) DEFAULT '' COMMENT '号段结束范围',
  `segment` varchar(30) DEFAULT '' COMMENT '号段字符串',
  `segment_class` varchar(2) DEFAULT '' COMMENT '号段类型：会议号段和终端号段',
  `segment_type` varchar(2) DEFAULT '' COMMENT '号段类型：正式/免费体验（默认正式）',
  `pas_server_id` varchar(50) DEFAULT '' COMMENT '所属NU',
  `create_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 订单相关表
CREATE TABLE `domain_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(50) NOT NULL COMMENT '订单id，唯一标示',
  `service_domain_moid` varchar(50) NOT NULL COMMENT '服务域moid',
  `new_service_domain_moid` varchar(50) DEFAULT '' COMMENT '变更服务域moid',
  `old_service_domain_moid` varchar(50) DEFAULT '' COMMENT '原服务域moid',
  `new_platform_domain_moid` varchar(50) DEFAULT '' COMMENT '变更平台域moid',
  `old_platform_domain_moid` varchar(50) DEFAULT '' COMMENT '原平台域moid',
  `user_domain_moid` varchar(50) NOT NULL COMMENT '所属用户域moid',
  `sign_time` varchar(50) DEFAULT '' COMMENT '签订时间',
  `sales` varchar(50) DEFAULT '' COMMENT '销售人员',
  `area` varchar(50) DEFAULT '' COMMENT '区域',
  `contract_num` varchar(100) DEFAULT '' COMMENT '合同号码',
  `contract_type` varchar(2) DEFAULT '' COMMENT '合同类型',
  `sales_type` varchar(2) DEFAULT '' COMMENT '销售策略',
  `number_type` varchar(2) DEFAULT '' COMMENT '号码类型（正式、试用）',
  `try_start_date` timestamp COMMENT '试用号码开始日期',
  `remark` varchar(500) DEFAULT '' COMMENT '订单备注',
  `linker` varchar(50) DEFAULT '' COMMENT '联系人',
  `telephone` varchar(50) DEFAULT '' COMMENT '电话号码',
  `tracer` varchar(50) DEFAULT '' COMMENT '追踪人',
  `email` varchar(50) DEFAULT '' COMMENT '邮箱',
  `total` varchar(50) DEFAULT '' COMMENT '订单总额',
  `create_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 订单项表
CREATE TABLE `domain_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(50) DEFAULT '' COMMENT '订单id，唯一标示',
  `device_id` int(11) COMMENT '产品id',
  `device_name` varchar(50) DEFAULT '' COMMENT '产品名称',
  `price` varchar(20) DEFAULT '' COMMENT '单价',
  `count` varchar(10) DEFAULT '' COMMENT '个数',
  `end_date` varchar(50) DEFAULT '' COMMENT '到期日期',
  `enable_satellite` varchar(2) DEFAULT '' COMMENT '卫星线路（0/1，没有/有）',
  `enable_satelliteP2P` varchar(2) DEFAULT '' COMMENT '卫星线路 点对点会议（0/1，没有/有）',
  `restrict_used_on` varchar(300) DEFAULT '' COMMENT '可登录设备',
  `pas_guid` varchar(36) DEFAULT '' COMMENT 'pasGuid',
  `address` varchar(200) DEFAULT '' COMMENT '收获地址',
  `order_item_total` varchar(30) DEFAULT '' COMMENT '订单项合计金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 订单项中号码表
CREATE TABLE `domain_order_item_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT '' COMMENT 'E164号码',
  `prefix` varchar(20) DEFAULT '' COMMENT '号段前缀',
  `start_segment` varchar(20) DEFAULT '' COMMENT '号段开始',
  `end_segment` varchar(20) DEFAULT '' COMMENT '号段结束',
  `order_id` varchar(50) DEFAULT '' COMMENT '订单id',
  `order_item_id` int(11) COMMENT '订单项id',
  `valid_start_date` timestamp COMMENT '有效期开始日期',
  `valid_end_date` timestamp COMMENT '有效期结束日期',
  `state` varchar(2) DEFAULT '' COMMENT '号码状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 业务流水号表
CREATE TABLE `serial_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key_name` varchar(20) DEFAULT '' COMMENT 'key',
  `cur_value` varchar(50) DEFAULT '' COMMENT 'value',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `serial_number` VALUES (1, 'domain', '00000000000000000000');
INSERT INTO `serial_number` VALUES (2, 'order', '00000000000000000000');
INSERT INTO `serial_number` VALUES (3, 'DomainCode', '');
INSERT INTO `serial_number` VALUES (4, 'TerminalCode', '');
INSERT INTO `serial_number` VALUES (5, 'ServerCode', '');


-- 业务加锁表
CREATE TABLE `sys_locks` (
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sys_locks` VALUES ('insert_order');
INSERT INTO `sys_locks` VALUES ('insert_user_domain');
INSERT INTO `sys_locks` VALUES ('generate_number');

-- 用户域表（冗余用户域数据，提供历史数据查询:如订单、报表中等）
CREATE TABLE `domain_user_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '用户域moid',
  `user_domain_name` varchar(100) DEFAULT '' COMMENT '用户域名称',
  `domain_guid` varchar(50) DEFAULT '' COMMENT '用户域GUID',
  `service_domain_moid` varchar(50) DEFAULT '' COMMENT '所属服务域moid',
  `platform_domain_moid` varchar(50) DEFAULT '' COMMENT '平台域moid',
  `parent_id` varchar(50) DEFAULT '' COMMENT '父用户域moid',
  `group_name` varchar(100) DEFAULT '' COMMENT '集团名称',
  `user_domain_type` int(11) DEFAULT NULL COMMENT '用户域属性：正式、试用、体验',
  `used_flag` int(11) DEFAULT NULL COMMENT '企业启用/禁用标识 (1表示启用,0表示禁用)',
  `is_deleted` tinyint(1) default 0 COMMENT '是否删除状态:0为未删除,1为删除',
  `create_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 用户域发票表
CREATE TABLE `domain_user_domain_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '用户域moid',
  `tax_id` varchar(32) DEFAULT '' COMMENT '税务登记号',
  `bank_name` varchar(100) DEFAULT '' COMMENT '开户银行',
  `account_name` varchar(50) DEFAULT '' COMMENT '账号名称',
  `account_num` varchar(20) DEFAULT '' COMMENT '账号',
  `invoice_address` varchar(100) DEFAULT '' COMMENT '发票地址',
  `linker` varchar(20) DEFAULT '' COMMENT '财务联系人',
  `invoice_ext_num` varchar(30) DEFAULT '' COMMENT '固定电话',
  `invoice_mobile` varchar(20) DEFAULT '' COMMENT '手机',
  `fax` varchar(20) DEFAULT '' COMMENT '传真',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 用户域销售模式变更记录
CREATE TABLE `domain_user_domain_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '用户域moid',
  `scale` varchar(20) DEFAULT '' COMMENT '企业规模',
  `concurrent_number` varchar(20) DEFAULT '' COMMENT '最大会议召开数',
  `concurrent_call_num` varchar(20) DEFAULT '' COMMENT '最大并发呼叫数',
  `update_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 用户域所属域变更记录
CREATE TABLE `domain_user_domain_belongs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '用户域moid',
  `service_domain_moid` varchar(50) DEFAULT '' COMMENT '所属服务域moid',
  `service_domain_name` varchar(50) DEFAULT '' COMMENT '所属服务域名称',
  `platform_domain_moid` varchar(50) DEFAULT '' COMMENT '所属平台域moid',
  `platform_domain_name` varchar(50) DEFAULT '' COMMENT '所属平台域名称',
  `update_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 生成号码临时表
CREATE TABLE `domain_number_generate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '用户域moid',
  `prefix` varchar(20) DEFAULT '' COMMENT '号段前缀',
  `start_segment` varchar(20) DEFAULT '' COMMENT '号段开始',
  `end_segment` varchar(20) DEFAULT '' COMMENT '号段结束',
  `number` varchar(20) DEFAULT '' COMMENT '号码',
  `create_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 并发模式下号码分配表
CREATE TABLE `domain_number_assign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '用户域moid',
  `order_id` varchar(50) DEFAULT '' COMMENT '所属订单id',
  `order_item_id` int(11) COMMENT '订单项id',
  `device_type` int(11) DEFAULT 0 COMMENT '终端编号',
  `count` int(11) DEFAULT 0 COMMENT '分配的个数',
  `assigned_count` int(11) DEFAULT 0 COMMENT '已入网的个数',
  `valid_end_date` timestamp COMMENT '有效期结束日期',
  `enableSatellite` varchar(2) DEFAULT '' COMMENT '卫星线路',
  `enableSatelliteP2P` varchar(2) DEFAULT '' COMMENT '卫星线路 点对点会议',
  `restrict_used_on` varchar(300) DEFAULT '' COMMENT '可登录设备',
  `pas_guid` varchar(36) DEFAULT '' COMMENT 'pasGuid',
  `number_type` varchar(2) DEFAULT '' COMMENT '号码类型',
  `try_start_date` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '试用号码开始日期',
  `create_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- 号码表
CREATE TABLE `domain_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_domain_moid` varchar(50) DEFAULT '' COMMENT '服务域moid',
  `user_domain_moid` varchar(50) DEFAULT '' COMMENT '用户域moid',
  `number` varchar(20) DEFAULT '' COMMENT 'E164号码',
  `moid` varchar(50) DEFAULT '' COMMENT '号码moid',
  `account` varchar(64) DEFAULT '' COMMENT '用户名',
  `name` varchar(50) DEFAULT '' COMMENT '号码别名',
  `password` varchar(30) DEFAULT '' COMMENT '号码密码',
  `terminal_guid` varchar(35) DEFAULT '' COMMENT '号码终端guid',
  `pas_guid` varchar(36) DEFAULT '' COMMENT 'pasGuid',
  `prefix` varchar(20) DEFAULT '' COMMENT '号段前缀',
  `start_segment` varchar(20) DEFAULT '' COMMENT '号段开始',
  `end_segment` varchar(20) DEFAULT '' COMMENT '号段结束',
  `number_type` varchar(2) DEFAULT '' COMMENT '号码类型',
  `show_number` varchar(2) DEFAULT '' COMMENT '演示专用号码',
  `number_class` varchar(2) DEFAULT '' COMMENT '号码分类',
  `device_type` varchar(10) DEFAULT '' COMMENT '终端编号',
  `restrict_used_on` varchar(300) DEFAULT '' COMMENT '可登录设备',
  `limited` varchar(2) DEFAULT '' COMMENT '受限标识',
  `enable` varchar(2) DEFAULT '' COMMENT '启停标志',
  `enableCall` varchar(2) DEFAULT '' COMMENT '电话呼叫',
  `enableRoam` varchar(2) DEFAULT '' COMMENT '漫游',
  `enableOut` varchar(2) DEFAULT '' COMMENT '出局',
  `enableIncoming` varchar(2) DEFAULT '' COMMENT '入局',
  `enableSatellite` varchar(2) DEFAULT '' COMMENT '卫星线路',
  `enableSatelliteP2P` varchar(2) DEFAULT '' COMMENT '卫星线路 点对点会议',
  `valid_start_date` timestamp COMMENT '有效期开始日期',
  `valid_end_date` timestamp COMMENT '有效期结束日期',
  `note` varchar(100) DEFAULT '' COMMENT '备注',
  `create_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

