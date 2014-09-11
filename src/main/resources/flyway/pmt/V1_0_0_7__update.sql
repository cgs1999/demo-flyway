use `flyway_pmt`;

-- 增加 "是否需要自动扫描内网","内网IP范围"
--insert into sys_cfg (prop_key,prop_value) values('is_auto_scan_inner_net','0');
--insert into sys_cfg (prop_key,prop_value) values('inner_net_section','');

alter table recipe add column nodeType varchar(20) DEFAULT NULL COMMENT '配方支持的节点类型';
alter table global_cfg add column taskExeMaxMin int COMMENT '系统任务执行最大等待时间';
alter table global_cfg add column is_auto_scan_inner_net tinyint COMMENT '是否自动扫描(0 或 1)';
alter table global_cfg add column inner_net_section varchar(50) COMMENT '内网区间';
alter table global_cfg drop column isLog;
alter table env_deployplan add column changeReason text COMMENT '方案变更原因';

