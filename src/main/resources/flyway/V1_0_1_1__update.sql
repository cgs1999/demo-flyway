-- 修改应用附件文件的表名
rename table upload_file to app_upload_file;

--删除历史国际化表
drop table env_language;

--新的国际化表，包括上传
CREATE TABLE lang_upload_file (
  `id` varchar(36) NOT NULL,
  `originalName` varchar(100) NOT NULL COMMENT '原文件名',
  `realName` varchar(50) NOT NULL COMMENT '重命名后的名称,实际保存文件',
  `appName` varchar(50) COMMENT '应用名,如:dm',
  `langName` varchar(100) COMMENT '用户设置的语言名称',
  `langKey` varchar(36) NOT NULL COMMENT '语言key,eg:zh_cn',
   currUse tinyint(1) default 0 COMMENT '当前真正使用的语言',
   enabled tinyint(1) default 0 COMMENT '上传默认是不可用的',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
