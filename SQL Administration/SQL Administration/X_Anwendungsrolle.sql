--Anwendungsrolle
--ersetzt die Rechte desjenigen, der in der Sessionangmeldet ist
--gilt nur für die session

select * from customers

sp_setapprole  'Gehaltsrolle', 'ppedv2019!'