/*
--Monitoring

/*
Tools: Reports, Datensammler, Aktivit�tsmonitor

--am Ende sind es imer Abfragen

!! Tu nie neu starten!. 

DMV  DAta Management Views

select * from sys.dm_os .... SQL Server
select * from sys.dm_db...   Irgenwas aus der Datenbank



*/

select * from sys.dm_db


CPU RAM HDD NETZ Auslastung

aus Windows Sicht und SQL Sicht

Abfragen m�ssen beobachet werden

SQL Messungen ermittlen und speichern


--Wie finde ich das Probem:

1) Taskmanager + Ressourcenmonitor andere ausschliessen
2) Aktivit�tsmonitor
3) QueryStore
4) DMVs




*/

select * from sys.dm_os_performance_counters