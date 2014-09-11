use `flyway_pmt`;

-- 网络变化前的节点IP
alter table node add column oldIp varchar(50) DEFAULT NULL COMMENT '网络变化前的节点IP';
