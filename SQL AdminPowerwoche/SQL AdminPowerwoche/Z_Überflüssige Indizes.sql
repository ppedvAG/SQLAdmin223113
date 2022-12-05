--Überflüssige Indizes identifizieren

--kosten Performance bei INSERT / DELETE

--Systemsichten
-- select * from sys.dm_db_index_physical_Stats verknüpft mikt sys.indexes
sp_blitzIndex  --Brent Ozar

EXEC dbo.sp_BlitzIndex @DatabaseName='Northwind', @SchemaName='dbo', @TableName='Kundeumsatz';



select object_name(i.object_id) as TableName
      ,i.type_desc,i.name
      ,us.user_seeks, us.user_scans
      ,us.user_lookups,us.user_updates
      ,us.last_user_scan, us.last_user_update
  from sys.indexes as i
       left outer join sys.dm_db_index_usage_stats as us
                    on i.index_id=us.index_id
                   and i.object_id=us.object_id
 where objectproperty(i.object_id, 'IsUserTable') = 1
go


--Optimierer entscheidet sich für Index-scan , wenn die der günstiger als Table-scan ist
-- user_scan, index_scan  ..nie gebrauchte Indizes evtl löschen
-- user_scan, index_scan  .. besser als table scan


-- Brent Ozar SP_blitzIndex-- First Responder Kit 0 Euro





--Wartung--> Wartungsplan: IX Rebuild IX Reorg Statistiken

--Stat:  akt nach 20% Änderung plus 500  zu spät, weil ab  ca 1% -- jeden Tag aktualisieren

--IX Reorg ab 10% 
--Rebuild ab 30%

exec sp_updatestats