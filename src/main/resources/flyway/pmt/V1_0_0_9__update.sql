use `flyway_pmt`;

-- 给系统配置变增加key索引
alter table sys_cfg add index prop_key_index(prop_key);
update garden_users set pass='21232F297A57A5A743894A0E4A801FC3' where user_name='admin';
