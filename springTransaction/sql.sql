drop database javaee;
create database javaee DEFAULT CHARACTER SET utf8 ;
use javaee;

create table news_inf
(
 news_id int primary key auto_increment,
 news_title varchar(255) unique,
 news_content varchar(255)
);
