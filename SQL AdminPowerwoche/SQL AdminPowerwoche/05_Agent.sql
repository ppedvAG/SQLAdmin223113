/*

Agent

----------------------------------------------------
Jobs per Zeitplan
----------------------------------------------------

Jobs bestehen aus einen oder mehreren Schritten
bei Erfolg bei Fehler bei Beendigung

--Bei Jobs emfiehlt es sich Testzeitpläne zu erstellen (typ einmal)
--diese werden nach Ausführung automatisch deaktiviert



Operatoren

--------------------------------------------------
Operator
--------------------------------------------------
= Alias für eine Emailadresse oder Pager
DerChef = andreasr@ppedv.de

USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'SQLAdministrator', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'sqlservice@sql.local'
GO


-----------------------------------------------
Datenbankmail
-----------------------------------------------
notwendig ist eibn SMTP Server

--Emailsystem SMTP und SMTP Zugangsdaten
--Zugriff--> Relay-->  Nur Computer Zugriff erlauben: 127.0.0.1

--Profil = Zugriffsdaten zum SMTP 

--man kann auch per TSQL Mails senden ;-)
exec sp_sendDBmail [GMX-profile]

Öfftl Profil  (mitlgied der Rolle msdb/DatabaseMailUserRole)

--der Operator bekommt aber noch keineMail nach Abschluss eines Auftrags!

-1 Agent muss ein Mailprofil zugewiesen bekommen
--Eigeschaften des Agents--> Warnungsystem--> Mailprofil aktivieren Profil zuweisen

--2 Agent neu starten

-----------------------------------------------------------
----WARNUNGEN
-----------------------------------------------------------

Fehler werden in Kategorien eingeteilt und  bekommt eine best Fehlernummer
Ebenen = Kategorien = Secerity = Level

Ebene 16: Syntaxfehler Obejtk unbekannt
Ebene 15: Syntaxfehler falsches TSQL
Ebene 9:  bis 10 sind Erfolg
Ebene 14: Rechte
..bis Ebene 16 sind mir alle Fehler egal

ab Ebene 17 --> Admin

--max Ebene 25 Sytemausfall steht bevor

select * from sysmessages where msglangid = 1031

-------------------------------------------------------------------------
--Proxykonten
Proxykonten   Auftragsschritte mit anderen Konto ausführen  Ausführen als
-------------------------------------------------------------------------
--falls der Agent keine Rechte auf externe Systeme besitzt wie CMD PS SSAS Replikation usw

--Idee nr 1: Agent wird Dom Admin  keine gute Idee ;-)
--Idee nr2 : Ausführen als  , dann aber KOnto und Kennwort

1. zuerst unter Sicherheit --> Anmeldeinformation hinterlegen
			Name und Kennwort
2. Unter SQL Agent--> Proxykonto : Anmeldeinformation zuweisen einer best. Kategorie zuweisen
3. Einem Auftragsschritt das Proxykonto zuweisen









*/
select from test







