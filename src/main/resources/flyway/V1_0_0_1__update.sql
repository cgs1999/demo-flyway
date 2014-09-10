-- recipe 复杂属性
CREATE TABLE `complex_property`(
	`id` int not null AUTO_INCREMENT,
	`property_id` int comment '复杂类型(grid)对应property_def的id',
	`rowIndex` int comment '复杂类型(grid)有行排序',
	primary key(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
alter table complex_property add CONSTRAINT `fk_com_bridge_pro_id` FOREIGN KEY (`property_id`) REFERENCES `property_def` (`id`) ON DELETE CASCADE;

-- 复杂属性与普通属性关系表
CREATE TABLE complex_base_bridge(
	complex_id int comment '复杂类型属性id',
	base_id int comment '普通类型属性id',
	unique key(complex_id,base_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
alter table complex_base_bridge add CONSTRAINT `fk_cp_bridge_conf_prop_id` FOREIGN KEY (`base_id`) REFERENCES `property_def` (`id`) ON DELETE CASCADE;
ALTER table complex_base_bridge add CONSTRAINT `fk_bridge_complex_pro_id` FOREIGN KEY (`complex_id`) REFERENCES `complex_property` (`id`) ON DELETE CASCADE;

-- recipe配方与 配置块conf 的表
CREATE TABLE recipe_conf_pro_bridge(
	recipe_id int not null comment '配方id',
	property_id int not null comment '属性id',
	conf varchar(15) not null comment '配置块(部署配置,应用配置,监控配置等)',
	unique key(recipe_id,property_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
alter table recipe_conf_pro_bridge add CONSTRAINT `fk_bridge_conf_prop_id` FOREIGN KEY (`property_id`) REFERENCES `property_def` (`id`) ON DELETE CASCADE;
alter table recipe_conf_pro_bridge add CONSTRAINT `fk_bridge_conf_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`) ON DELETE CASCADE;


-- sys_cfg
CREATE TABLE sys_cfg(
	id int not null AUTO_INCREMENT,
	prop_key varchar(50) not null,
	prop_value varchar(100) not null,
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into sys_cfg (prop_key,prop_value) values('server_url','/');
-- 节点扫描相关配置
insert into sys_cfg (prop_key,prop_value) values

('scanNode_supportNMVersion','4.8.0.0,4.8.0.0');
insert into sys_cfg (prop_key,prop_value) values('scanNode_port','6060');
insert into sys_cfg (prop_key,prop_value) values('scanNode_waiteTime','300000');
insert into sys_cfg (prop_key,prop_value) values

('scanNode_secretKeyPath','/root/.ssh/id_rsa.pub');
insert into sys_cfg (prop_key,prop_value) values('scanNode_everyTranSize','1048576');
insert into sys_cfg (prop_key,prop_value) values('scanNode_retryTime','20000');
insert into sys_cfg (prop_key,prop_value) values

('scanNode_crrentDmNmVersion','4.8.0.0');
-- 保留任务表的时间（天数）
insert into sys_cfg (prop_key,prop_value) values('task_cleardays','30');
insert into sys_cfg (prop_key,prop_value) values('is_open_log','1');

-- 节点
CREATE TABLE node(
	id varchar(36) not null,
	env_id varchar(36) not null comment '环境id',
	node_name varchar(50) not null,
	ip_str varchar(50) comment '节点IP',
	node_username varchar(30)  comment '节点用户名',
	node_password varchar(30)  comment '节点用户密码',
	ssh_port int default 22,
	state varchar(30) ,
	sortIndex int,
	is_dm tinyint(1) default 0 comment '是否是管理节点',
	globalCfg_taskid int comment '节点全局配置任务id',
	netcfg_taskid int comment '节点网络配置任务id',
	isImport int(1) default 0 comment '节点是否为导入',
	ip_change int(1) default 0 comment '是否节点ip发生变化',
	nodeType varchar(20) comment '节点类型:x86,ppc',
	primary key(id),
	CONSTRAINT fk_node_env_id FOREIGN KEY (env_id) REFERENCES env(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
alter table node add CONSTRAINT UNIQUE(ip_str);


-- app
CREATE TABLE app(
	id varchar(36) not null,
	node_id varchar(36) comment '节点id',
	recipe_id int comment '配方id',
	groupId varchar(50) comment '集群的组序号',
	config_state varchar(30) comment '应用配置状态',
	deploy_state varchar(30) comment '应用部署状态',
	upgrade_state varchar(30) comment '应用升级状态',
	action_state varchar(30) comment '动作状态状态',
	upgrade_version varchar(40) comment '可升级版本号',
	degrade_version varchar(40) comment '可降级版本号',
	fail_reason varchar(250) comment '失败原因', 
	sortIndex int,
	actioning varchar(30) comment 'app执行的动作',
	bak_flag int default 0 comment '应用是否是升级备份，1为升级备份应用',
-- env_id varchar(36) comment '环境id',
	guid  varchar(50),
	parentId varchar(36) comment '父应用-容器id',
	to_delete int(1) default 0 comment '是否待删除',
	commonId varchar(36) not null COMMENT 'app生命周期中唯一不变的值',
	CONSTRAINT fk_app_node_id2 FOREIGN KEY (node_id) REFERENCES node(id),
	CONSTRAINT fk_app_recipe_id2 FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 配置 配方值  关系表
CREATE TABLE app_propertyid_val(
	id int not null AUTO_INCREMENT,
	app_id varchar(36) not null comment '应用id',
	base_property_id int not null comment '配方基本属性id',
	row_index int comment '应用的属性值对应行序号,针对grid',
	property_value text,	
	exe varchar(30) comment '监控执行的shell',
	normal varchar(30) comment '监控普通告警条件，支持">","<"两种配置eg:">10200"',
	important varchar(30) comment '监控重要告警条件，支持">","<"两种配置eg:">10200"',
	critical varchar(30) comment '监控严重告警条件，支持">","<"两种配置eg:">10200"',	
	sqls varchar(100) comment 'eg:"up1.sql,up2.sql",给数据库配方使用',
	old_value text COMMENT '更新值变化前的值',
	primary key(id),
	CONSTRAINT fk_val_app_id FOREIGN KEY (app_id) REFERENCES app(id) ON DELETE CASCADE,
	CONSTRAINT fk_val_base_prop_id FOREIGN KEY (base_property_id) REFERENCES property_def(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 任务表
CREATE TABLE garden_task(
	id int not null AUTO_INCREMENT,
	parent_id int comment '父任务id',
	env_id varchar(36) not null comment 'task对应的envid',
	task_desc varchar(100),
	task_progress varchar(10) comment '任务进度,从0%~100%',
	successful tinyint(1) comment '是否成功',
	create_at varchar(50) comment '任务创建日期',
	finished_at varchar(50) comment '任务完成日期',
	fail_reason varchar(400),
	actionOrder int comment '动作执行顺序',
	app_id varchar(36) comment 'task对应的appid',
	err_code int comment '错误码',
	log_file varchar(100) comment '日志文件',
	appAction varchar(30) comment '任务执行的动作',
	name varchar(100) comment '任务名称',
	-- CONSTRAINT `fk_ta_app_id` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`),
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 环境真正执行的批动作信息
CREATE TABLE env_action(
	id varchar(36) not null,
	env_id varchar(36) not null,
	parent_taskid int comment '父任务id',
	app_action varchar(30) comment '环境中应用正在执行的动作',
	actioning tinyint(1) comment '是否在执行',
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 环境执行的批动作记录,用于方便回退
CREATE TABLE env_action_detail(
	id varchar(36) not null,
	env_id varchar(36) not null comment '关联表env 的主键',
	app_action varchar(30) comment 'app执行的动作',
	task_id int not null comment '关联表garden_task 的主键,子任务',
	action_order int comment '动作的执行序号',
	env_action_id varchar(36) not null,
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table env_action_detail add CONSTRAINT fk_env_action_id 
FOREIGN KEY (env_action_id) REFERENCES env_action(id) ON DELETE CASCADE;

-- 选择类型代码类型定义 
CREATE TABLE code_class(
	id varchar(36) not null,
	class_code varchar(30) comment '代码类别key',
	cn_name varchar(50) comment '中文名称',
	UNIQUE KEY(class_code),
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE code_def(
	id varchar(36) not null,
	codeclass_id varchar(36) not null,
	code varchar(30) comment '代码key',
	cn_name varchar(50) comment '中文名称',
	primary key(id),
	CONSTRAINT fk_code_class_id FOREIGN KEY (codeclass_id) REFERENCES code_class(id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE server_net_cfg(
	id varchar(36) not null,
	net_type varchar(36) comment '网络类型',
	node_id varchar(36) not null,
	operator_id varchar(36) comment '运营商名称对应codeId',
	ip_addr varchar(16) comment 'ip',
	net_card_id varchar(36) comment '网卡对应codeId',
	mask varchar(16),
	gateway varchar(16),
	default_gateway varchar(16),
	primary key(id),
	CONSTRAINT fk_server_node_id FOREIGN KEY (node_id) REFERENCES node(id) ON DELETE 

CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- status
CREATE TABLE app_status(
	id varchar(36) not null,
	app_id varchar(36) not null,
	status int,
	app_type int comment '应用类型0:node;1:一般的app',
	actionFlag varchar(30) comment '动作标识',
	primary key(id),
	key(app_id),
	CONSTRAINT fk_status_app_id FOREIGN KEY (app_id) REFERENCES app(id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE env_gateway(
	id varchar(36) not null,
	env_id varchar(36) not null,
	gateway varchar(36) not null comment '网关',
	default_flag tinyint default 0,
	primary key(id),
	key(env_id),
	CONSTRAINT fk_gw_env_id FOREIGN KEY (env_id) REFERENCES env(id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 用户
CREATE TABLE garden_users(
	id int not null AUTO_INCREMENT,
	user_name varchar(36) not null comment '帐号',
	pass varchar(36) not null,
	account_type VARCHAR(30),
	lastEnvId VARCHAR(36) comment '最后操作的环境id',
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into garden_users(user_name,pass) values 
('guest1','21218CCA77804D2BA1922C33E0151105'),
('admin','21218CCA77804D2BA1922C33E0151105');
-- 修改garden_user account_type字段类型
update garden_users set account_type='SYSTEM_ADMIN' where user_name='admin';
update garden_users set account_type='GENERAL_USER' where user_name !='admin';


-- 节点网卡信息
CREATE TABLE node_nic(
	id varchar(36) not null,
	node_id varchar(36) not null,
	nic varchar(50) comment '网卡',
	primary key(id),
	CONSTRAINT fk_nnic_node_id FOREIGN KEY (node_id) REFERENCES node(id) ON DELETE 

CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 环境部署方案
CREATE TABLE env_deployplan(
	id varchar(36) not null,
	status varchar(40) not null,
	planTemplateName varchar(50) comment '生成模板名称',
	errorReason varchar(400) comment '错误信息',
	validStatus tinyint(1) comment '验证状态',
	warnMsg varchar(400) comment '警告信息',
	plan_json MEDIUMTEXT COMMENT '方案json',
	primary key(id),
	CONSTRAINT fk_plan_env_id FOREIGN KEY (id) REFERENCES env(id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 方案与节点关联
CREATE TABLE plan_node(
	id varchar(36) not null,
	node_id varchar(36) COMMENT '节点id',
	env_id varchar(36) not null comment '环境id',
	primary key(id),
	CONSTRAINT fk_plan_node_id FOREIGN KEY (node_id) REFERENCES node(id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 集群实体 可以优化，添加索引
CREATE TABLE cluster_info(
	id varchar(36) not null primary key,
	env_id varchar(36) not null,
	status varchar(30) not null comment '集群状态',
	recipeKey varchar(50) not null comment '集群的配方key',
	groupId varchar(50) comment '对应app的groupId',
	clusterFilename varchar(100) comment '集群的信息保存的文件名',
	CONSTRAINT fk_cluster_info_env_id FOREIGN KEY (env_id) REFERENCES env(id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE garden_task_history (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL COMMENT '父任务id',
  env_id varchar(36) NOT NULL COMMENT 'task对应的envid',
  task_desc varchar(100) DEFAULT NULL,
  task_progress varchar(10) DEFAULT NULL COMMENT '任务进度,从0%~100%',
  successful tinyint(1) DEFAULT NULL COMMENT '是否成功',
  create_at varchar(50) DEFAULT NULL COMMENT '任务创建日期',
  finished_at varchar(50) DEFAULT NULL COMMENT '任务完成日期',
  fail_reason varchar(400) DEFAULT NULL,
  app_id varchar(36) DEFAULT NULL COMMENT 'task对应的appid',
  err_code int(11) DEFAULT NULL COMMENT '错误码',
  log_file varchar(100) DEFAULT NULL COMMENT '日志文件',
  name varchar(100) DEFAULT NULL COMMENT '任务名称',
  actionOrder int(11) DEFAULT NULL COMMENT '',
  appAction varchar(30) DEFAULT NULL COMMENT '任务执行的动作',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 应用连线数据保存
CREATE TABLE `app_drag_link` (
  `id` varchar(36) NOT NULL,
  `fromAppCommonId` varchar(36) NOT NULL COMMENT '对应的应用的commonid',
  `propKey` varchar(50) NOT NULL COMMENT '对应属性Key',
  `toAppCommonId` varchar(36) not NULL COMMENT '连线应用应用的commonid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 应用的特殊配置项(专家配置项)
CREATE TABLE `app_special_cfg` (
  `id` varchar(36) NOT NULL,
  `appCommonId` varchar(36) NOT NULL COMMENT '对应的appid',
  `propKey` varchar(50) NOT NULL COMMENT '对应属性Key',
  `expertVal` text DEFAULT NULL COMMENT '专家配置值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 上传的文件信息保存
CREATE TABLE `upload_file` (
  `id` varchar(36) NOT NULL,
  `originalName` varchar(100) NOT NULL COMMENT '原文件名',
  `uuidName` varchar(70) NOT NULL COMMENT '生成的uuid名',
  `envId` varchar(36) NOT NULL,
  `appCommonId` varchar(36) NOT NULL COMMENT '对应的appid',
  `propKey` varchar(50) NOT NULL COMMENT '对应属性Key',
  `fileSize` varchar(20) DEFAULT NULL COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE log(
id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
username varchar(50) DEFAULT NULL comment '登录名',
loginip varchar(50) DEFAULT NULL comment '登录IP',
method VARCHAR(200) comment '接口名(类.方法)',
execution_time varchar(30) DEFAULT NULL COMMENT '执行时间',
success tinyint(11) DEFAULT NULL COMMENT '是否成功：1表示成功，0表示失败',
description text COMMENT '操作结果',
operate varchar(200) COMMENT '操作说明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE recipe_prop_autofill
(
id varchar(36) not null primary key,
recipe_id int not null comment '配方的id',
recipe_key varchar(50) not null comment '配方key',
prop_id int not null comment '配方配置属性id',
prop_key varchar(50) not null comment '属性key',
prop_val varchar(100) comment '配方autofill属性值，做前缀',
prop_autofill varchar(50) not null comment '配方autofill属性',
auto_index int comment '自动增长的序号',
CONSTRAINT fk_rec_prop_auto_id FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE global_cfg(
id varchar(30) NOT NULL primary key,
AAAIpAddr varchar(30) DEFAULT NULL,
NMSIpAddr varchar(30) DEFAULT NULL,
LGSIpAddr varchar(30) DEFAULT NULL,
NTPIpAddr varchar(30) DEFAULT NULL,
SNMPIpAddr varchar(30) DEFAULT NULL,
ShellTimeout int(4) DEFAULT NULL COMMENT 'minute',
HealthCheckInterval int(4) COMMENT 'second',
IsLog int(1) NULL DEFAULT NULL,
LogRotate int(4) NULL DEFAULT NULL,
dataBackupDay varchar(10) DEFAULT NULL COMMENT '数据备份保留时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into global_cfg (id,ShellTimeout,HealthCheckInterval,LogRotate,dataBackupDay) values('1',30,3,30,30);