/*
Agent: eig Dienst  mit eig Konto

Jobs, Auftr�ge, Zeitpl�ne, Warnungen, Operatoren, Email

Auftrag:
	Schritten

	Schritte k�nnen in Reihenfolge gebracht werden
	Schritte k�nnen je nach Fehler oder Erfolg folgende Schritte �berspringen

Zeitpl�ne
	Tipp: einmal-Zeitplan zum Test
		keine unnotwendige Schritte definieren zb SA und So bei 5*8 Betrieb


Proxykonten
	Auftrag bzw Schritt mit "Ausf�hren als" ausf�hren

	1. Anmeldeinformation: NT Konto + Kennwort (Sicherheit)
	2. Proxys (Agent) mit Hilfe der Logininformation Subsystemen zur Verf�gung gestellt
	3. dem Schritt das Proxy Konto zuweisen

Warnungen
wir k�nnen auf Schwerwegrade und ein Fehler reagieren 
--mit Auftrag oder Mail an Operator


Operator (Kontaktliste)
	besteht aus Pager/Email und Namen
	und kann Warnugen zugewiesen werden
	und auch Auftr�gen

Emailsystem aktivieren

1.. SMTP Server der Mails versendet und die Zugriffsdaten dazu
2. im SQL Server Mailsystem aktivieren (Verwaltung)
3. Mailprofil einrichten
3a: SMTP Konto angeben
3b: �ffentliches Profil = DatabaseMailuserRole Mitglied
3c. evtl Mailanhang auf 10MB vergr��eren
----> guest rechte wurden eingerichtet
4. Testmail

Badmail: alle nicht zustellbaren Mails
Queue: alle im Versand befindl Mails
Drop: alle ankommende Mails
Pickup: Mails zum Versenden werden hier abgelegt

5. Agent soll nach Auftrag Mail versenden
5a. Eigenschaften des Agent: Warnungsystem aktivieren
							Mailprofil ausw�hlen
5b. Neustart des Agent







*/

select * t1
--Meldung 102, Ebene 15, Status 1, Zeile 28

select * from t2
--Meldung 208, Ebene 16, Status 1, Zeile 31

--Wichtig Ebene:
-
--Ebene 14 Security
--Ebene 15 falsche Syntax
--Ebene 16 Objewkt gibts nicht
--unter 10: sind Infos
--Ebene 17: kack...
--Ebene 25 ist h�chste Kategegorie

select * from sysmessages where msglangid=1031 order by 2 desc


