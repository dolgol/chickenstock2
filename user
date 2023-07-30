CREATE TABLE users (
  user_id VARCHAR(100) PRIMARY KEY,
  user_name VARCHAR(100) NOT NULL,
  password VARCHAR(100) NOT NULL,
  birthday DATE,
  sex VARCHAR(10),
  phone_number VARCHAR(20) NOT NULL,
  address VARCHAR(200),
  nick_name VARCHAR(50) UNIQUE NOT NULL,
  auth TINYINT NOT NULL
);

CREATE TABLE stocks (
  stock_number int PRIMARY KEY,
  stock_name LONGTEXT NOT NULL,
  market_cap int NOT NULL,
  price int NOT NULL,
  tr_count int NOT NULL,
  per decimal(5, 2),
  pbr decimal(5, 2),
  roe decimal(5, 2),
  sales int,
  alloper decimal(5, 2),
  allo int,
  ebit int,
  ebitper decimal(5, 2)
);

CREATE TABLE stocks_comment (
  seq INT PRIMARY KEY AUTO_INCREMENT,
  post_num INT NOT NULL,
  user_id VARCHAR(100) UNIQUE NOT NULL,
  content VARCHAR(1500) NOT NULL,
  write_date timestamp,
  ref INT,
  step INT,
  depth INT,
  del INT
);

CREATE TABLE news (
  seq INT PRIMARY KEY AUTO_INCREMENT,
  write_id VARCHAR(100) NOT NULL,
  source VARCHAR(500) NOT NULL,
  title VARCHAR(255) NOT NULL,
  views INT,
  content LONGTEXT NOT NULL,
  del INT,
  publication_date DATE,
  image LONGBLOB
);

CREATE TABLE news_comment (
  seq INT PRIMARY KEY AUTO_INCREMENT,
  post_num INT NOT NULL,
  user_id VARCHAR(100) UNIQUE NOT NULL,
  content VARCHAR(1500) NOT NULL,
  write_date timestamp,
  ref INT,
  step INT,
  depth INT,
  del INT
);

drop table if exists users;
drop table if exists stocks;
drop table if exists stocks_comment;
drop table if exists news;
drop table if exists news_comment;

alter table news_comment 
add foreign key(user_id) references users(user_id);

ALTER TABLE stocks_comment 
ADD FOREIGN KEY(user_id) REFERENCES users(user_id);

