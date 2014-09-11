use `flyway_pmt`;

-- 国际化信息 
CREATE TABLE env_language(
	id varchar(36) not null,
	lang_name varchar(50) not null,
	lang_key varchar(30) comment '语言key标识',
	lang_desc varchar(30) comment '语言描述',
	curr_use tinyint(1) default 0,
	unique key(lang_key),
	primary key(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into env_language (id,lang_name,lang_key,lang_desc,curr_use) values('1','中国(简体中文)','zh_CN','中国(简体中文)',1);
insert into env_language (id,lang_name,lang_key,lang_desc) values('2','English(US)','en_US','English(US)');