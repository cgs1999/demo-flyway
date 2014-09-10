use `demo-flyway`;
-- 环境 方案 
CREATE TABLE env(
	id varchar(36) not null,
	env_name varchar(50) not null,
	env_username varchar(30) comment '环境用户名',
	env_password varchar(30) comment '环境用户密码',
	ssh_port int default 22,
	state varchar(30) ,
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--  --Recipe 
CREATE TABLE recipe(
	id int not null AUTO_INCREMENT,
	name varchar(50),
	recipe_key varchar(50) not null comment '配方key',
	version varchar(40) not null,
	app_type varchar(20) not null,
	is_node tinyint(1),
	is_manager tinyint(1) comment '是否是manager配方',
	port varchar(80),
	icon varchar(50),
	stateful tinyint(1),
	init_sql varchar(30),
	install_path varchar(30),
	install_shell varchar(30),
	uninstall_shell varchar(30),
	update_shell varchar(30),
	rollback_shell varchar(30),
	deployConf_shell varchar(30),
	appConf_shell varchar(30),
	start_shell varchar(30),
	stop_shell varchar(30),
	status_shell varchar(30),
	packageSize varchar(20) comment '配方包大小',
	recipePackage_url varchar(100) comment '配方包下载地址', 
	upload_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP comment '配方上传日期',
	state varchar(30) comment '配方状态',
	delete_flag int default 0 comment '是否删除，1为删除',
	fail_reason varchar(250) comment '配方解析失败原因',
	pause_shell varchar(30),
	resume_shell varchar(30),
	update_desc varchar(500) comment '升级说明',
	visualType varchar(50) comment '业务类型',
	needGuid varchar(50) comment '非空时生成非必填GUID配置项',
	containerServiceName varchar(50) comment '只在配方是web容器或数据库容器时必填,是key值',
	minInstanceNum int comment '配方实例数目最少个数',
	maxInstanceNum int comment '配方实例数目最大个数',
	extendRule varchar(50) comment '配方实例扩展规则',
	updateRule varchar(50) comment '配方实例升级规则',
	clusterConf varchar(50) comment '部署前自动计算某些自定义配置项值的shell',
	doCluster varchar(50) comment '部署后执行集群脚本shell',
	needGroupName tinyint(1) comment 'associate groupName',
	sourceFrom varchar(50) COMMENT '配方来源',
	netCfgEnable tinyint(1) comment '是否允许网络配置',
	primary key (id),
	key(recipe_key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--  Recipe depends
CREATE TABLE recipe_depends(
	id int not null AUTO_INCREMENT,
	recipe_id int not null comment '配方id',
	depend_recipe_key varchar(50) not null comment '依赖配方key',
	depend_recipe_version varchar(40) comment '依赖配方version,可以为空，空则依赖环境生效的任意版本',
	depend_type varchar(30) comment '配方依赖的类型，安装依赖&更新依赖',
	primary key (id),
	key(depend_recipe_key),
	CONSTRAINT fk_app_recipe_id FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE property_def(
	id int not null AUTO_INCREMENT,
	text varchar(50) not null comment '属性名称',
	property_key varchar(50) not null comment '属性key',
	pro_type varchar(15) not null comment '属性类型(bool, num, str, grid...)',
	single_line tinyint(1) comment '如果是grid,判断是否为单行',
	pro_desc varchar(100) comment '属性描述',
	required tinyint(1) not null comment '是否必填',
	regValid varchar(100),
	sortIndex int comment '普通类型只有列排序',
	pro_value text COMMENT'普通类型的默认值,复杂类型值不生效',
	defaultValue varchar(200) COMMENT'属性的默认值',
	exe varchar(30) comment '监控执行的shell',
	normal varchar(30) comment '监控普通告警条件，支持">","<"两种配置eg:">10200"',
	important varchar(30) comment '监控重要告警条件，支持">","<"两种配置eg:">10200"',
	critical varchar(30) comment '监控严重告警条件，支持">","<"两种配置eg:">10200"',
	
	sqls varchar(100) comment 'eg:"up1.sql,up2.sql",给数据库配方使用',
	requireKey varchar(50) comment '依赖的主属性',
	requireValue varchar(50) comment '依赖的主属性值',
	requireReg varchar(50) comment '是否必须表达式',
	displayReg varchar(50) comment '是否显示表达式',
	display tinyint(1) comment '是否显示',
	editable tinyint(1) comment '是否可编辑',
	autoSyn tinyint(1) comment '是否需要同步',
	referTo varchar(50) comment '根据关键字自动填充此配置项',
	autoFill varchar(50) comment '根据关键字自动填充此配置项',
	dragTo varchar(100) COMMENT '可以拖拽的key',
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
