use `flyway_pmt`;

-- 给系统配置变增加key索引
alter table property_def add column fileExt varchar(500);
