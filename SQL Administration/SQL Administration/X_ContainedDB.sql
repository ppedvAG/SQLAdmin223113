--CONTAINED DB

/*
Logins sind in Master
Jobs sind msdb
#tab sind tempdb


--was wäre wenn, einer DB alles in sich drin hätte..

abr sorry.. das gibts nur teilweise

--logins zb 

normal ist: SQL USer mit Login


Server : Eiegenständige DB aktivieren (Erweitert)
auf DB: Optionen: Eigest DB aktivieren auf Teilweise

jetzt SQL User mit Kennwort

USE [ContainedDb]
GO
CREATE USER [Tom] WITH PASSWORD=N'ppedv2019!'
GO

--der Tom hat kein !!! Login

--Tom muss sich an der DB anmelden.. Im Anmeldedialog--> Optionen
gibts Nachteile:

keine Replikation
keine Crossabfragen auf andere DBs, ausser , wenn man sie vertrauenswürdig macht
CDC CDT

Vorteile.
man kann auch  ganz normal arbeiten


http://blog.fumus.de/sql-server/contained-databasedie-eigenstndige-datenbank





