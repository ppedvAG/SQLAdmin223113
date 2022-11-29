--Snapshot

-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO

-- Create the database snapshot
CREATE DATABASE Nwind1213 ON
( NAME = northwind, --Origdb Alias (logscher Name)
FILENAME = 'D:\_SQLDBDATA\nwind1213.mdf' )
AS SNAPSHOT OF Northwind
GO


kill 72

----Restore von Snapshot

--alle User müssen runter von beiden DB
use master;
select * from sysprocesses where spid > 50 ---= User
select db_id('northwind'),db_id('nwind1213')  --7  10

restore database northwind from database_snapshot= 'nwind1213'


---Kann ich den Snapshot sichern?  Nö

--Kann man den Snapshot restoren ? -- Hä??? Neee!

--Kann  man die OrigDB backupen? -- Hoffentlich !! Ja!!

--Kann man die OrigDBs restoren? --Nö.. nur vom Snapshot
--wenn, dann vorher alle Snapshots löschen

--Kann man mehrere Snapshots haben?
--Jo geht..


