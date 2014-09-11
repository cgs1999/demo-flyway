use `flyway_pmt`;

-- 初始化运营商名称
insert ignore into code_class(id,class_code,cn_name) values('oper1','operator','运营商');
insert ignore into code_def(id,codeclass_id,code,cn_name) 
values('os1','oper1','本地','本地'),
('os2','oper1','海外','海外'),
('os3','oper1','有线通','有线通'),
('os4','oper1','中国电信','中国电信'),
('os5','oper1','中国联通','中国联通'),
('os6','oper1','中国铁通','中国铁通'),
('os7','oper1','中国移动','中国移动');
