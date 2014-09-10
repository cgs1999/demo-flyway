-- 增加 自定义属性str类型长度检查
alter table property_def add column maxLength int COMMENT '字符串的最大字节数';
alter table property_def drop column exe;
alter table property_def drop column normal;
alter table property_def drop column important;
alter table property_def drop column critical;
alter table property_def drop column sqls;

