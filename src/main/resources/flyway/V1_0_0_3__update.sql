-- 初始化运营商名称
alter table recipe add column installRule varchar(50) comment '安装规则-类似升级规则';
