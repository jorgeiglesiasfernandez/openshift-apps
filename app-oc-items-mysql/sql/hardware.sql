# create table
create table Hardware (id int(11) NOT NULL, name varchar(255) DEFAULT NULL, code varchar(255) DEFAULT NULL, PRIMARY KEY (id));

# insert data
insert into Hardware (id, name, code) values (1,'Disk','P1010');
insert into Hardware (id, name, code) values (2,'Keyboard','P2020');
insert into Hardware (id, name, code) values (3,'Screen','P2030');
insert into Hardware (id, name, code) values (4,'Mouse','P2040');
