-------------------------------------------------------------
---Query Store Problemsuche ----------------------------------
-------------------------------------------------------------



--Query Store kann helfen besten Kompromiss zu finden
--oder auch schlecht performende Abfragen zu finden

--muss pro DB zuerst aktiviert werden
--dann DB aktualisieren
--Abfragespeicher...> Bericht auswählen


--KU2 als reiner HEAP ohne  IX

set statistics io, time on

--KU2: IX auf ID Spalten.. alle anderen Inidzes löschen

--TAB SCAN
select * from ku2 where id < 300000

--mit Proc
create proc gpSuchID @par int
as
select * from ku2 where id < @par
GO


--IX SEEK.. passt
exec gpSuchID 2
--Plan wird jetzt auf IX Seek festgelegt


--auch hier IX SEEK!!! krass
exec gpSuchID 300000 --huch!!! 304388 Seiten , obwohl die tab nur 56000

--CACHE Leeren
dbcc freeproccache

--Plan wird nun neu erstellt..mit Table Scan
exec gpSuchID 300000 

--aber auch hier...
exec gpSuchID 2
--TAB SCAN...


dbcc freeproccache

select * from ku2 where id < 1000000 --44442

exec gpSuchID 1000000 --Proz verwendet den gleichen Plan wie beim ersten Aufruf

