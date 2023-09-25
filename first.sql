create table bikes(id integer primary key, model text, quantity integer, price integer, quality text);
insert into bikes values(1, "A", 10, 150, "good");
insert into bikes values(2, "B", 15, 250, "good");
insert into bikes values(3, "C", 25, 100, "good");
insert into bikes values(4, "D", 5, 350, "good");
insert into bikes values(5, "E", 10, 200, "good");
insert into bikes values(6, "A", 20, 100, "bad");
insert into bikes values(7, "B", 10, 150, "bad");
insert into bikes values(8, "C", 30, 75, "bad");
insert into bikes values(9, "D", 5, 250, "bad");
insert into bikes values(10, "E", 5, 150, "bad");
insert into bikes values(11, "A", 5, 100, "normal");
insert into bikes values(12, "B", 20, 100, "normal");
insert into bikes values(13, "C", 15, 100, "normal");
insert into bikes values(14, "D", 20, 300, "normal");
insert into bikes values(15, "E", 10, 150, "normal");


create table country(model text primary key, country text);
insert into country values("A", "Belgium");
insert into country values("B", "China");
insert into country values("C", "Japan");
insert into country values("D", "Germany");
insert into country values("E", "USA");

SELECT * FROM bikes
order by price desc;
SELECT * FROM country;