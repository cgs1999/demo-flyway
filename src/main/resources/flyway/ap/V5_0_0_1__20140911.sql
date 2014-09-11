use `flyway_ap`;

--初始化顶级域
INSERT INTO service_domain(service_domain_moid,service_domain_name,xmpp_domain,domain_guid,parent_id,full_path,enable,domain_level,self_built_platform,allowed_create_child_domain,count_allowed_child_domain,count_allowed_child_domain_level,enable_sms,enable_call,enable_email,number_segment,exception_number,expired_number_mode,expired_days_for_auto_disabled,disabled_number_mode,disabled_months_for_auto_recover,email_remind_service_domain_admin,email_remind_user_domain_admin,sms_remind_service_domain_admin,sms_remind_user_domain_admin,enable_out_call,enable_incoming_call,enable_roam_call,out_call_count,incoming_call_count,roam_call_count,enable_nm) VALUES
('mooooooo-oooo-oooo-oooo-topdoooomain','kedacom',NULL,'20100000000000000000000000000000',NULL,'mooooooo-oooo-oooo-oooo-topdoooomain','1','0','0','1','99999999','99999','1','1','1','',NULL,'0','180','2','12','1','1','1','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--初始化管理帐号
INSERT INTO `user_info`(moid,account,email,e164,mobile,ip_region,account_type,enable,binded,password,jid,service_domain_moid,device_guid,nu_server_id,device_type,created_at,update_at,limited) VALUES 
('mooooooo-oooo-oooo-oooo-defaultadmin','admin','service@movision.com.cn',NULL,'',NULL,0,1,0,'21218cca77804d2ba1922c33e0151105',NULL,'mooooooo-oooo-oooo-oooo-topdoooomain',NULL,NULL,NULL,'2014-03-28 12:02:33','2014-04-11 08:09:59',1);

--初始化管理账号的profile
INSERT INTO user_profile(moid, name, office_location, full_py) VALUES 
('mooooooo-oooo-oooo-oooo-defaultadmin','admin','上海','admin');

--初始化超级管理员权限
INSERT INTO user_privilege_data(moid,privilege_key) VALUES
('mooooooo-oooo-oooo-oooo-defaultadmin', 'defaultServiceDomainAdmin');