create database if not exists `flyway_ap` default character set utf8;
use `flyway_ap`;

CREATE TABLE `service_domain` (
  `service_domain_moid` varchar(36) NOT NULL COMMENT '服务域全局唯一ID',
  `service_domain_name` varchar(100) NOT NULL COMMENT '服务域名称',
  `xmpp_domain` varchar(128) DEFAULT NULL COMMENT 'XMPP域',
  `domain_guid` varchar(50) NOT NULL COMMENT '服务域GUID',
  `parent_id` varchar(36) DEFAULT NULL COMMENT '父服务域id',
  `full_path` varchar(1024) DEFAULT NULL COMMENT '服务域全路径',
  `enable` int(11) DEFAULT NULL COMMENT '启用禁用标识',
  `domain_level` int(11) DEFAULT NULL COMMENT '服务域级别',
  `self_built_platform` int(11) DEFAULT NULL COMMENT '是否自建平台域',
  `allowed_create_child_domain` int(11) DEFAULT NULL COMMENT '是否允许创建下级域',
  `count_allowed_child_domain` int(11) DEFAULT NULL COMMENT '允许创建下级域个数，默认为99',
  `count_allowed_child_domain_level` int(11) DEFAULT NULL COMMENT '允许创建下级域层级数，默认为16',
  `enable_sms` int(11) DEFAULT NULL COMMENT '短信权限（总权限）',
  `enable_call` int(11) DEFAULT NULL COMMENT '电话呼叫权限',
  `enable_email` int(11) DEFAULT NULL COMMENT '邮件通知权限',
  `number_segment` varchar(256) NOT NULL COMMENT '服务域具有号段',
  `exception_number` varchar(256) DEFAULT NULL COMMENT '例外的号码池',
  `expired_number_mode` int(11) DEFAULT NULL COMMENT '过期号码处理方式',
  `expired_days_for_auto_disabled` int(11) DEFAULT NULL COMMENT '过期天数后自动停用',
  `disabled_number_mode` int(11) DEFAULT NULL COMMENT '停用号码处理方式',
  `disabled_months_for_auto_recover` int(11) DEFAULT NULL COMMENT '停用多少月后回收',
  `email_remind_service_domain_admin` int(11) DEFAULT NULL COMMENT '邮件提醒（服务域管理员）',
  `email_remind_user_domain_admin` int(11) DEFAULT NULL COMMENT '邮件提醒（用户域管理员）',
  `sms_remind_service_domain_admin` int(11) DEFAULT NULL COMMENT '短信提醒（服务域管理员）',
  `sms_remind_user_domain_admin` int(11) DEFAULT NULL COMMENT '短信提醒（用户域管理员）',
  `enable_out_call` int(11) DEFAULT NULL COMMENT '出局呼叫权限',
  `enable_incoming_call` int(11) DEFAULT NULL COMMENT '入局呼叫权限',
  `enable_roam_call` int(11) DEFAULT NULL COMMENT '漫游注册权限',
  `out_call_count` int(11) DEFAULT NULL COMMENT '出局呼叫数（不填数字则不进行上限）',
  `incoming_call_count` int(11) DEFAULT NULL COMMENT '入局呼叫数（不填数字则不进行上限）',
  `roam_call_count` int(11) DEFAULT NULL COMMENT '漫游注册数（不填数字则不进行上限）',
  `enable_nm` int(11) DEFAULT NULL COMMENT '网管登录权限',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`service_domain_moid`),
  KEY `idx_service_domain_name` (`service_domain_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务域信息表';

CREATE TABLE `platform_domain` (
  `platform_domain_moid` varchar(36) NOT NULL COMMENT '平台域全局唯一ID',
  `platform_domain_name` varchar(100) NOT NULL COMMENT '平台域名称',
  `domain_guid` varchar(50) NOT NULL COMMENT '平台域GUID',
  `service_domain_moid` varchar(36) NOT NULL COMMENT '所属服务域id',
  `queue_name` varchar(100) DEFAULT NULL COMMENT '平台域队列名称',
  `number_segment` varchar(256) DEFAULT NULL COMMENT '号段',
  `network_domain` varchar(128) DEFAULT NULL COMMENT '网络地址',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`platform_domain_moid`),
  KEY `idx_platform_domain_name` (`platform_domain_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台域信息表';

CREATE TABLE `user_domain` (
  `user_domain_moid` varchar(36) NOT NULL COMMENT '用户域全局唯一ID',
  `user_domain_name` varchar(100) NOT NULL COMMENT '用户域名称',
  `domain_guid` varchar(50) NOT NULL COMMENT '用户域GUID',
  `service_domain_moid` varchar(36) NOT NULL COMMENT '所属服务域id',
  `platform_domain_moid` varchar(36) DEFAULT NULL COMMENT '平台域id（视频会议需要指定一个，不能外键关联）',
  `parent_id` varchar(36) DEFAULT NULL COMMENT '父用户域id',
  `full_path` varchar(1024) DEFAULT NULL COMMENT '用户域全路径',
  `group_name` varchar(100) DEFAULT NULL COMMENT '集团名称',
  `billing_id` varchar(50) DEFAULT NULL COMMENT '营帐编号',
  `nu_server_id` varchar(50) DEFAULT NULL COMMENT 'NU服务器ID',
  `type` int(11) NOT NULL COMMENT '用户域属性：正式、试用、体验',
  `nature` varchar(256) DEFAULT NULL COMMENT '用户域资质',
  `address` varchar(256) DEFAULT NULL COMMENT '用户域地址',
  `register_address` varchar(256) DEFAULT NULL COMMENT '用户域注册地址',
  `used_flag` int(11) DEFAULT NULL COMMENT '启用/禁用标识',
  `sms_maxnumber` int(11) DEFAULT '0' COMMENT '最大短信数',
  `sms_used` int(11) DEFAULT '0' COMMENT '已用短信数',
  `phone_conf_num` varchar(50) DEFAULT NULL COMMENT '电话会议号码',
  `concurrent_number` int(11) DEFAULT NULL COMMENT '最大会议召开数（默认99）',
  `concurrent_phone_call_count` int(11) DEFAULT NULL COMMENT '并发电话呼叫数',
  `multicast_ip` varchar(256) DEFAULT NULL COMMENT '组播地址分配',
  `satellite_meeting_max_number` int(11) DEFAULT NULL COMMENT '卫星会议最大上传路数',
  `out_call_count` int(11) DEFAULT NULL COMMENT '出局呼叫权限（不填数字则不进行上限）',
  `incoming_call_count` int(11) DEFAULT NULL COMMENT '入局呼叫（不填数字则不进行上限）',
  `roam_call_count` int(11) DEFAULT NULL COMMENT '漫游注册（不填数字则不进行上限）',
  `sales_type` int(11) DEFAULT NULL COMMENT '销售策略（默认传统销售策略）',
  `scale` int(11) DEFAULT NULL COMMENT '规模',
  `number_distribute_type` int(11) DEFAULT NULL COMMENT '号码分配策略（行业）',
  `mix_cloud` varchar(2) DEFAULT NULL COMMENT '混合云标识',
  `concurrent_call_num` int(11) DEFAULT NULL COMMENT '最大并发呼叫数',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_domain_moid`),
  KEY `idx_user_domain_name` (`user_domain_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户域信息表';

CREATE TABLE `user_domain_privilege_list` (
  `privilege_key` varchar(30) NOT NULL COMMENT '用户域权限key',
  `privilege_name` varchar(128) NOT NULL COMMENT '用户域权限名称',
  PRIMARY KEY (`privilege_key`),
  UNIQUE KEY `privilege_name` (`privilege_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_domain_privilege_data` (
  `user_domain_moid` varchar(36) NOT NULL COMMENT '用户域ID',
  `privilege_key` varchar(30) NOT NULL COMMENT '用户域权限key',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY `idx_composite_key` (`user_domain_moid`,`privilege_key`),
  KEY `fk_user_domain_privilege_privilege_key` (`privilege_key`),
  CONSTRAINT `fk_user_domain_privilege_privilege_key` FOREIGN KEY (`privilege_key`) REFERENCES `user_domain_privilege_list` (`privilege_key`),
  CONSTRAINT `fk_user_domain_privilege_moid` FOREIGN KEY (`user_domain_moid`) REFERENCES `user_domain` (`user_domain_moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user_domain_privilege_list` VALUES ('enableWeibo','开通微博');
INSERT INTO `user_domain_privilege_list` VALUES ('enableMeeting','开通会议管理');
INSERT INTO `user_domain_privilege_list` VALUES ('enableMeetingSMS','会管短信权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableCall','开通电话会议');
INSERT INTO `user_domain_privilege_list` VALUES ('enablePhoneInternational','电话国际长途呼叫权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableSatellite','卫星会议召开权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableVRS','VRS权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableDCS','DCS权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableWebConf','web conf权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableOut','开通出局权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableIncoming','开通入局权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableRoam','开通漫游权限');
INSERT INTO `user_domain_privilege_list` VALUES ('enableVenueMonitor','会场监控权限（行业模式下默认允许，租赁模式默认关闭）');

CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moid` varchar(36) NOT NULL COMMENT '帐号全局唯一ID',
  `account` varchar(64) DEFAULT NULL COMMENT '用户自定义账号，登陆账号',
  `email` varchar(64) DEFAULT NULL COMMENT '注册邮箱',
  `e164` varchar(32) DEFAULT NULL COMMENT 'E164号',
  `mobile` varchar(64) DEFAULT NULL COMMENT '手机，登陆账号',
  `ip_region` varchar(256) DEFAULT NULL COMMENT '允许登陆ip地址段(*.*.*.*.*;......)',
  `account_type` int(11) DEFAULT NULL COMMENT '帐号类型',
  `enable` int(11) DEFAULT NULL COMMENT '帐号启用禁用标识',
  `binded` int(11) DEFAULT NULL COMMENT '是否绑定标识',
  `password` varchar(32) NOT NULL COMMENT '帐号加密后密码',
  `jid` varchar(256) DEFAULT NULL COMMENT 'xmpp帐号',
  `user_domain_moid` varchar(36) DEFAULT NULL COMMENT '所属用户域Moid',
  `service_domain_moid` varchar(36) DEFAULT NULL COMMENT '服务域Moid',
  `device_guid` varchar(36) DEFAULT NULL COMMENT '终端GUID',
  `nu_server_id` varchar(36) DEFAULT NULL COMMENT '所属NU服务器ID',
  `device_type` varchar(36) DEFAULT NULL COMMENT '终端类型',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `limited` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moid`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_user_info_user_domain_moid` (`user_domain_moid`),
  KEY `idx_e164` (`e164`),
  KEY `idx_email` (`email`),
  KEY `idx_account` (`account`),
  KEY `idx_mobile` (`mobile`),
  CONSTRAINT `fk_user_info_user_domain_moid` FOREIGN KEY (`user_domain_moid`) REFERENCES `user_domain` (`user_domain_moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_profile` (
  `moid` varchar(36) NOT NULL COMMENT '帐号全局唯一ID',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `seat` varchar(150) DEFAULT NULL COMMENT '座位',
  `ext_num` varchar(100) DEFAULT NULL COMMENT '分机',
  `fax` varchar(50) DEFAULT NULL COMMENT '传真',
  `job_num` varchar(50) DEFAULT NULL COMMENT '用户编号/工号',
  `brief` varchar(512) DEFAULT NULL COMMENT '简介',
  `sex` varchar(8) DEFAULT NULL COMMENT '性别',
  `date_of_birth` date DEFAULT NULL COMMENT '出生日期',
  `office_location` varchar(512) DEFAULT NULL COMMENT '办公地址',
  `timezone` varchar(20) DEFAULT NULL COMMENT '时区',
  `full_py` varchar(512) DEFAULT NULL COMMENT '姓名全拼',
  `portrait_32` varchar(256) DEFAULT NULL,
  `portrait_40` varchar(256) DEFAULT NULL,
  `portrait_64` varchar(256) DEFAULT NULL,
  `portrait_128` varchar(256) DEFAULT NULL,
  `portrait_256` varchar(256) DEFAULT NULL,
  `validity_period` date DEFAULT NULL COMMENT 'E164号有效期',
  `restrict_used_on` varchar(256) DEFAULT NULL COMMENT 'E164号限制登录的设备类型（列表）',
  `restrict_strategy` int(11) DEFAULT NULL COMMENT 'E164号限制登录使用的策略',
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `old_e164` varchar(32) DEFAULT NULL,
  `recycle_date` date DEFAULT NULL,
  PRIMARY KEY (`moid`),
  KEY `idx_name` (`name`),
  KEY `idx_seat` (`seat`),
  KEY `idx_ext_num` (`ext_num`),
  KEY `idx_fax` (`fax`),
  KEY `idx_full_py` (`full_py`(255)),
  KEY `idx_job_num` (`job_num`),
  CONSTRAINT `fk_user_profile_user_moid` FOREIGN KEY (`moid`) REFERENCES `user_info` (`moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_privilege_list` (
  `privilege_key` varchar(30) NOT NULL COMMENT '用户帐号权限key',
  `privilege_name` varchar(128) NOT NULL COMMENT '用户帐号权限名称',
  PRIMARY KEY (`privilege_key`),
  UNIQUE KEY `privilege_name` (`privilege_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_privilege_data` (
  `moid` varchar(36) NOT NULL COMMENT '用户帐号ID',
  `privilege_key` varchar(30) NOT NULL COMMENT '用户帐号权限key',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY `idx_composite_key` (`moid`,`privilege_key`),
  KEY `fk_user_privilege_privilege_key` (`privilege_key`),
  CONSTRAINT `fk_user_privilege_privilege_key` FOREIGN KEY (`privilege_key`) REFERENCES `user_privilege_list` (`privilege_key`),
  CONSTRAINT `fk_user_privilege_user_moid` FOREIGN KEY (`moid`) REFERENCES `user_info` (`moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user_privilege_list` VALUES ('enableSatellite','卫星线路权限');
INSERT INTO `user_privilege_list` VALUES ('enableSatelliteP2P','卫星线路点对点会议权限');
INSERT INTO `user_privilege_list` VALUES ('userDomainAdmin','用户域管理员');
INSERT INTO `user_privilege_list` VALUES ('meetingAdmin','会议管理员');
INSERT INTO `user_privilege_list` VALUES ('enableMeeting','开通会议管理');
INSERT INTO `user_privilege_list` VALUES ('enableIncoming','开通入局权限');
INSERT INTO `user_privilege_list` VALUES ('enableOut','开通出局权限');
INSERT INTO `user_privilege_list` VALUES ('enableWeibo','开通微博');
INSERT INTO `user_privilege_list` VALUES ('enableRoam','开通漫游权限');
INSERT INTO `user_privilege_list` VALUES ('enableCall','开通电话会议');
INSERT INTO `user_privilege_list` VALUES ('weiboAdmin','微博管理员');
INSERT INTO `user_privilege_list` VALUES ('enableHD','支持高清视频会议');
INSERT INTO `user_privilege_list` VALUES ('enableMeetingSMS','会管短信权限');
INSERT INTO `user_privilege_list` VALUES ('enableBMC','BMC权限');
INSERT INTO `user_privilege_list` VALUES ('enableUMC','UMC权限');
INSERT INTO `user_privilege_list` VALUES ('enableDCS','DCS权限');
INSERT INTO `user_privilege_list` VALUES ('enableVRS','VRS权限');
INSERT INTO `user_privilege_list` VALUES ('enableNM','NM权限');
INSERT INTO `user_privilege_list` VALUES ('serviceDomainAdmin','服务域管理员');
INSERT INTO `user_privilege_list` VALUES ('defaultServiceDomainAdmin','默认的服务域管理员');
INSERT INTO `user_privilege_list` VALUES ('defaultUserDomainAdmin','默认的用户域管理员');

CREATE TABLE `department_info` (
  `department_moid` varchar(36) NOT NULL COMMENT '全局唯一ID',
  `department_id` int(11) NOT NULL,
  `department_name` varchar(100) DEFAULT NULL,
  `left_node` int(11) NOT NULL,
  `right_node` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `temp` char(1) NOT NULL DEFAULT '0',
  `seq` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`department_moid`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `fk_department_info_user_domain_moid` FOREIGN KEY (`user_domain_moid`) REFERENCES `user_domain` (`user_domain_moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `department_user_info` (
  `department_id` int(11) NOT NULL,
  `moid` varchar(36) NOT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  `dept_position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`department_id`,`moid`,`user_domain_moid`),
  KEY `department_id` (`department_id`),
  KEY `moid` (`moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `department_admin_info` (
  `department_id` int(11) NOT NULL,
  `moid` varchar(36) NOT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  PRIMARY KEY (`department_id`,`moid`,`user_domain_moid`),
  KEY `department_id` (`department_id`),
  KEY `moid` (`moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_domain_department_version` (
  `user_domain_moid` varchar(36) NOT NULL,
  `department_expression` int(11) DEFAULT NULL,
  `department_version` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `fk_table` (
  `fk_id` int(11) DEFAULT NULL,
  `fk_unite_id` varchar(36) DEFAULT NULL,
  `is_unite` varchar(36) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `server_info` (
  `server_moid` varchar(36) NOT NULL COMMENT '服务器ID',
  `device_guid` varchar(32) NOT NULL,
  `server_name` varchar(64) NOT NULL,
  `server_type` int(11) NOT NULL,
  `enable` int(11) DEFAULT NULL COMMENT '启用禁用标识',
  `user_domain_moid` varchar(36) DEFAULT NULL COMMENT '用户域Moid',
  `platform_domain_moid` varchar(36) NOT NULL COMMENT '平台域Moid',
  `network_domain` varchar(64) DEFAULT NULL,
  `device_ip` varchar(1024) DEFAULT NULL,
  `gk_prefix` varchar(16) DEFAULT NULL,
  `max_roam` int(11) DEFAULT '0',
  `agw_address` varchar(32) DEFAULT NULL,
  `max_out` int(11) DEFAULT '0',
  `max_in` int(11) DEFAULT '0',
  `max_call_num` int(11) DEFAULT '0',
  `oem_remark` varchar(300) DEFAULT NULL COMMENT 'OEM标识',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`server_moid`),
  UNIQUE KEY `device_guid` (`device_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_domain_address_book` (
  `moid` varchar(36) NOT NULL COMMENT '帐号全局唯一ID',
  `user_domain_moid` varchar(36) NOT NULL COMMENT '所属用户域ID',
  PRIMARY KEY (`moid`),
  KEY `fk_user_domain_address_book_user_domain_moid` (`user_domain_moid`),
  CONSTRAINT `fk_user_domain_address_book_user_domain_moid` FOREIGN KEY (`user_domain_moid`) REFERENCES `user_domain` (`user_domain_moid`),
  CONSTRAINT `fk_user_domain_address_book_user_moid` FOREIGN KEY (`moid`) REFERENCES `user_info` (`moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_domain_address_book_version` (
  `user_domain_moid` varchar(36) NOT NULL,
  `address_book_version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_domain_moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `monitor_device` (
  `device_moid` varchar(36) NOT NULL,
  `e164` varchar(32) DEFAULT NULL COMMENT 'E164号',
  `device_name` varchar(100) DEFAULT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `description` varchar(512) DEFAULT NULL COMMENT '设备描述',
  `note` varchar(512) DEFAULT NULL COMMENT '备注',
  `full_py` varchar(512) DEFAULT NULL COMMENT '名称全拼',
  PRIMARY KEY (`device_moid`),
  KEY `fk_monitor_device_user_domain_moid` (`user_domain_moid`),
  KEY `idx_e164` (`e164`),
  CONSTRAINT `fk_monitor_device_user_domain_moid` FOREIGN KEY (`user_domain_moid`) REFERENCES `user_domain` (`user_domain_moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `monitor_group` (
  `group_moid` varchar(36) NOT NULL COMMENT '全局唯一ID',
  `group_id` int(11) NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `left_node` int(11) NOT NULL,
  `right_node` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `temp` char(1) NOT NULL DEFAULT '0',
  `seq` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_moid`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `fk_monitor_group_user_domain_moid` FOREIGN KEY (`user_domain_moid`) REFERENCES `user_domain` (`user_domain_moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `monitor_group_device` (
  `group_id` int(11) NOT NULL,
  `device_moid` varchar(36) NOT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  PRIMARY KEY (`group_id`,`device_moid`,`user_domain_moid`),
  KEY `group_id` (`group_id`),
  KEY `device_moid` (`device_moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `monitor_group_admin` (
  `group_id` int(11) NOT NULL,
  `moid` varchar(36) NOT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  `admin_type` int(11) NOT NULL COMMENT '管理员类型',
  PRIMARY KEY (`group_id`,`moid`,`user_domain_moid`),
  KEY `group_id` (`group_id`),
  KEY `moid` (`moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `monitor_device_admin` (
  `device_moid` varchar(36) NOT NULL,
  `moid` varchar(36) NOT NULL,
  `user_domain_moid` varchar(36) NOT NULL,
  `admin_type` int(11) NOT NULL COMMENT '管理员类型',
  PRIMARY KEY (`device_moid`,`moid`,`user_domain_moid`),
  KEY `device_moid` (`device_moid`),
  KEY `moid` (`moid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER $$
CREATE DEFINER = 'admin'@'%' FUNCTION `queryChildrenServiceDomainInfo`(
        serviceDomainMoid VARCHAR(36)
    )
    RETURNS varchar(4000) CHARSET utf8
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN

DECLARE sTemp VARCHAR(4000);

DECLARE sTempChd VARCHAR(4000);


SET sTemp = '$';

SET sTempChd = serviceDomainMoid;


WHILE sTempChd is not NULL DO

SET sTemp = CONCAT(sTemp,',',sTempChd);

SELECT group_concat(service_domain_moid) INTO sTempChd FROM `service_domain` where FIND_IN_SET(parent_id,sTempChd)>0;

END WHILE;

return sTemp;

END $$