
CREATE TABLE users (
user_id varchar(100) NOT NULL,
user_name varchar(100) DEFAULT NULL,
password varchar(100) DEFAULT NULL,
birthday date DEFAULT NULL,
sex varchar(10) DEFAULT NULL,
phone_number varchar(20) DEFAULT NULL,
address varchar(200) DEFAULT NULL,
nick_name varchar(50) DEFAULT NULL,
auth int NOT NULL,
PRIMARY KEY (user_id),
UNIQUE KEY nick_name (nick_name)
);

CREATE TABLE stocks(
Symbol VARCHAR(50) NOT NULL PRIMARY KEY
,Market VARCHAR(60) NOT NULL
,Name VARCHAR(50) NOT NULL
,Sector VARCHAR(37)
,Industry VARCHAR(112)
,ListingDate DATE
,SettleMonth VARCHAR(30)
,Representative VARCHAR(58)
,HomePage VARCHAR(48)
);

CREATE TABLE stocks_comment (
seq INT PRIMARY KEY AUTO_INCREMENT,
symbol varchar(8) NOT NULL,
user_id VARCHAR(100) NOT NULL,
content VARCHAR(1500) NOT NULL,
write_date timestamp,
ref INT,
step INT,
depth INT,
del INT
);

CREATE TABLE stocks_like (
seq INT PRIMARY KEY AUTO_INCREMENT,
Symbol VARCHAR(8) NOT NULL,
user_id VARCHAR(100) NOT NULL
);

CREATE TABLE news (
  seq INT PRIMARY KEY AUTO_INCREMENT,
  write_id VARCHAR(100) NOT NULL,
  source VARCHAR(500),
  title VARCHAR(255) NOT NULL,
  views INT,
  content LONGTEXT NOT NULL,
  del INT,
  publication_date VARCHAR(100),
  image LONGBLOB,
  user_id VARCHAR(100)
);

CREATE TABLE news_comment (
  seq INT PRIMARY KEY AUTO_INCREMENT,
  user_id VARCHAR(100) NOT NULL,
  post_num varchar(8) NOT NULL,
  content VARCHAR(1500) NOT NULL,
  write_date timestamp,
  ref INT,
  step INT,
  depth INT,
  del INT
);

alter table stocks_comment
add foreign key(Symbol) references stocks(Symbol);

alter table stocks_like 
add foreign key(user_id) references users(user_id);

alter table news
add foreign key(user_id) references users(user_id);

alter table news_comment 
add foreign key(user_id) references users(user_id);

alter table news_comment 
add foreign key(post_num) references news(seq);

ALTER TABLE stocks_comment 
ADD FOREIGN KEY(user_id) REFERENCES users(user_id);

alter table stocks_comment
add foreign key(post_num) references stocks(Symbol);

alter table stocks_comment
add foreign key(Symbol) references stocks(Symbol);






