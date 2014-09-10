-- 应用最后修改时间
alter table app add column update_date timestamp NOT NULL 
DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间';
