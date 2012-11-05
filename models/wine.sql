create table wine (
  id int not null auto_increment,
  name varchar(100) not null,
  grape varchar(32),
  color varchar(16) not null,
  buy_again varchar(8) not null,
  date_added timestamp(8) not null,
  primary key (id)
) type=innodb;
