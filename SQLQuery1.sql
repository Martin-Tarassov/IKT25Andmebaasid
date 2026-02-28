-- teeme andmebaasi e db
create database IKT25tar

--andmebassi valimine
use IKT25tar

--andmebaasi kustutamine koodiga
--otsida kood ülesse
DROP DATABASE IKT25tar

--teeme uuesti anmebaasi IKT25tar
create database IKT25tar

--teeme tabeli
create table Gender
(
--Meil om muutuja Id,
--mis on täisarv andmetüüp,
--siis see veerg peab olema täidetud,
--tegemist on primaarvõtmega
Id int not null primary key,
--veeru nimi on Gender,
--10 tähemärki on max pikkus,
--anmded peavad olema sisestatud e
--ei tohi olla tühi
Gender nvarchar(10) not null
)

--andmete sisestamine
--proovige ise teha
--Id 1, Gender Male
--Id 2, Gender Female
insert into Gender (Id, Gender)
values (1, 'Male'),
(2, 'Female')

--vaatame tabeli sisu
-- * tähendab, et näita kõike seal sees olevat infot
select * from Gender
--teeme tabeli nimega Person
--veeru nimed: Id int not null primary key,
-- Name nvarchar (30)
-- Email nvarchar (30)
--Gender Id int

Create Table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)


--18.02.2026
--tund or 1
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

-- näen tabelis olevat infot
select * from Person

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestab uue rea andmeid ja ei ole sisestanud GenderId alla
-- väärtust, siis see automaatselt sisestab sellele reale väärtuse 3
-- e unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Gender (Id, Gender)
values (3, 'Unknown')

insert into Person (Id, Name, Email, GenderId)
values (7, 'Black Panther', 'b@b.com', NULL)

insert into Person (Id, Name, Email)
values (9, 'Spiderman', 'spider@man.com')

select * from Person

--piirnagu kustutamine
alter table Person 
Drop constraint DF_Persons_GenderId

--kuidas lisada veergu tabelile Person
--veeru nimi on Age nvarchar(10)
alter table Person
add Age nvarchar(10)

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 135)
-- kuidas uuendada andmeid
update Person
set Age = 151
where Id = 7

select * from Person

--soovin kutsustada ühe rea
-- kuidas seda teha????
delete from Person where Id = 8

select * from Person

--lisame uue veeru City nvarchar(50)
alter table Person
add City nvarchar(50)

--kõik, kes elavad Gothami linnas 
select * from Person where City = 'Gotham' 
-- kõik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
-- variant nr 2. kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'

--näitab teatud vanusega inimesi
--valime 151, 35, 25
select * from Person where Age in ('151', '35', '25')

--soovin näha inimesi vahemikus 22 kuni 41
select * from Person where Age between 22 and 41

--wiildcard e näitab kõik g-tähega linnad
select * from Person where City like 'G%'
--otsib emailid @-märgiga
select * from Person where Email like '%@%'

--tahan näha, kellel on emailis ees ja peale @-märki üks täht
select * from Person where Email like 'b@b%'
select * from Person where Email like '_@_.%'

--kõik, kelle nimes ei ole esimene täht W, A, S
select * from Person where Name not like 'W%' and Name not like 'A%' and Name not like 'S%'

--kõik, kes elavad Gothamis ja New Yorkis 
select * from Person where City not like 'G%' and City not like 'N%'
select * from Person where (City = 'Gotham' or City = 'New York')

--kõik, kes elavad Gothamis ja New Yorkis ning peavad olema 
--vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age > 29

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks
--Name veeru 
select * from Person
select * from Person order by Name

--võtab kolm esimet rida Person tabelist
select top 3 * from Person

--rida 131

--tund 3
