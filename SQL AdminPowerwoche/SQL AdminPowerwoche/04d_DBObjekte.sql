--DB Objekte


/*
DB Design --> DB Diagramm

Primärschlüssel ---> Fremdschlüssel
 --------ref Integrität--->   1:N


 Spalten --> Datentypen

 Autoinkrement  NOT NULL 

 Normalform
 1. NF: atomar .. in jeder Zelle nur ein Wert
 2. NF: Primärschlüssel auf DS
 3. NF Redundanz vermeiden  ist das Gegenteil von schnell!!!

 --so wie die Daten auf der HDD liegen, so kommen diese 1:1 in RAM

 --- OTTO Vorname
 char(50)        'Otto                                 '  50
 varchar(50)  'Otto'   4
 nchar(50)    'Otto                              ' 50 * 2  UNICODE
 nvarchar(50) 'Otto'    4 *2
 text() --nicht mehr nehmen .. seit 2005 depricated.. bis 2 GB


 --Datumswerte
 datetime (ms)  ca auf 2-3 ms genau  1.1.1998 -- 31.12.1998 23:59:59.999(=1.1.1999 00:00:00.000)
 smalldatetime (sek)
 datetime2 (ns)
 date
 time
 datetimeoffset (+ Zeitzone)



 Zahlen
 int       2,1 Mrd
 smallint   32000
 tinyint  +255
 money  8 Nachkommastellen   float
 decimal(5,2)  5 Stellen davon 2 Nachkommastellen  numeric

 XML
 geography
 geometry




 --CRM  Fax1 Fax2 Fax3 Frau1 Frau2 Frau3 Frau4  Religion
 SEITEN

 8192bytes   
 8072bytes Nutzlast
 1 DS kann bei fixen Längen nicht mehr als 8060bytes

 1DS ca 51% .. 1 MIO DS.. 8 GB---auf der HDD und auch im RAM

 dbcc 


 
a) adhoc Abfragen 
select * from tabelle...

b) Prozeduren 
exec procName 10, 'XY'      wie Windows Batchdatei

oft BI Logik
create proc procname @par1 int, @par2 vrchar(50)
as
select * from 
insert
update
delete 

schneller: weil der Plan, der einmal erstellt wird auch in Zukunft weiter verwendet wird..auch nach Neustart



c) Views / Sichten 
Sichten haben keine DAten sindern nur Abfragen..
Sichten können wie Tabellen behandelt werden: SEL  INS DEL UP Securtiy
Grund für Sicht: komplexe Abfragen, oder Security
create view vName
as
select * from tabelle 

select * from vName

select * from (select * from tabelle) t


d) Funktionen
eigtl immer mies.. seitens Performance


select fnetto(freight)  from ftab(100) 


---------------------------------->schneller
  a    d      b		c


  --faktisch:
  d          a|c               b

  --kann aber auch so sein
    b     d    a|c



 */

 use TESTDB

 dbcc showcontig('t1')
 --- Gescannte Seiten.............................: 30000  1 DS hatte 4100 
 --- Mittlere Seitendichte (voll).....................: 50.79%

set statistics io on
select * from t1 

--je weniger Seiten = IO --> weniger RAM --> weniger CPU



 create table txyz (id int, spx char(4100), spy char(4100))


 Kunde(ID)-->Bestellungen(ID)

 select * from customers

 delete from customers where customerid = 'FISSA'

