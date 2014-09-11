drop database if exists `flyway_pmt`;
drop database if exists `flyway_ap`;
drop database if exists `flyway_movision`;

create database if not exists `flyway_pmt` default character set utf8;
create database if not exists `flyway_ap` default character set utf8;
create database if not exists `flyway_movision` default character set utf8;