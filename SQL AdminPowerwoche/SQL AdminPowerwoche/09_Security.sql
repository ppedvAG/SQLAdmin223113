select name,* from syslogins

use Northwind


select * from sysusers

USE [master]
GO
CREATE LOGIN [Max] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


--Login scheitert , weil kein Recht auf die DB northwind vorehanden war



--ROLLE = GRUPPE
--SCHEMA = ORDNER

USE [Northwind]
GO
CREATE SCHEMA [FE] AUTHORIZATION [dbo]
GO


USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[FE] TO [Evi]
GO


USE [Northwind]
GO
ALTER USER [Max] WITH DEFAULT_SCHEMA=[IT]
GO


USE [Northwind]
GO
ALTER USER Evi WITH DEFAULT_SCHEMA=[FE]
GO


use [Northwind]
GO
GRANT CREATE TABLE TO [Evi]
GO


use [Northwind]
GO
GRANT ALTER ON SCHEMA::[FE] TO [Evi]
GO


--das ALTER Recht deckt DROP UND CREATE mit ab

use [Northwind]
GO
GRANT ALTER ON SCHEMA::[IT] TO [Max]
GO



USE [Northwind]
GO
CREATE ROLE [FERolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [FERolle] ADD MEMBER [Evi]
GO


--neuer Mitarbeiter Otto... auch das was Max kann...
--ITRolle



USE [Northwind]
GO
CREATE ROLE [ITRolle]
GO
REVOKE ALTER ON SCHEMA::[IT] TO [Max] AS [dbo]
GO
REVOKE SELECT ON SCHEMA::[IT] TO [Max] AS [dbo]
GO
GRANT ALTER ON SCHEMA::[IT] TO [ITRolle]
GO
GRANT SELECT ON SCHEMA::[IT] TO [ITRolle]
GO


USE [master]
GO
CREATE LOGIN [Otto] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Otto] FOR LOGIN [Otto]
GO
ALTER USER [Otto] WITH DEFAULT_SCHEMA=[IT]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Otto]
GO



--Anwendungsrolle
--Rolle mit Kennwort
USE [Northwind]
GO
CREATE APPLICATION ROLE [GehaltUpdateRolle] WITH PASSWORD = N'ppedv2019!'
GO

--funktioniert pro Verbindung.. man bleibt die gleiche User aber bekommt die Rechte der Rolle 
--die eig Rechte zählen gar nicht
--so ähnlich wie Ausführen als

use master

use northwind

exec sp_setapprole  'GehaltUpdateRolle', 'ppedv2019!'

use master

--Sichten Views gemerkte Abfrage , die wie Tabelle funktioniert



--Besitzer haben alle Rechte auf dsa Objekte (und die untergeordneten) .. durch Vererbung
--nach nie jemanden zum Besitzer ausser dbo



--Serverrolle


--reine Adminrolle
--max Rechte: sysadmin... jeder sysadmin ist in der DB = dbo
--was wenn: Backup eriner DB auf einen anderen Server

USE [master]

GO

CREATE SERVER ROLE [FirtsLevelSupport] AUTHORIZATION [sa]

GO

ALTER SERVER ROLE [FirtsLevelSupport] ADD MEMBER [Fritz]

GO

use [master]

GO

GRANT CONTROL ON LOGIN::[Evi] TO [FirtsLevelSupport]

GO

use [master]

GO
GRANT SHUTDOWN TO [FirtsLevelSupport]

GO




--Rechte kontrollieren -- AUDITS
--Trigger: Ereignis, das auf I U D reagieren kann--> protokollieren 
--aber wie SELECT 

--1: Logfile  --> Überwachung
--2: Überwachung auf Server (Login, Backup..)
--3. Überwachung auf DB (CREATE SELECT  INS BACKUP)



USE [master]

GO

CREATE SERVER ROLE [FirtsLevelSupport] AUTHORIZATION [sa]

GO

ALTER SERVER ROLE [FirtsLevelSupport] ADD MEMBER [Fritz]

GO

use [master]

GO

GRANT CONTROL ON LOGIN::[Evi] TO [FirtsLevelSupport]

GO

use [master]

GO

GRANT SHUTDOWN TO [FirtsLevelSupport]

GO




create view vname
as
Select..


