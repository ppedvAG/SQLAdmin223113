/*
Fälle: Was kann denn so alles passieren....?

1) Userfehler: Daten versehentlich verändert oder gelöscht --> war falsch


2)  Patch/Update/SPs... mach vorher eine Sicherung


3) HDD defekt... entweder beide (LOG/DATEN)  oder nur eine HDD 


4) DB ist defekt


5) Server tot, aber HDDs leben..alle DB Dateien sind noch voll funktionsfähig



Wichtig für Backup: Wann und wie oft muss ich was sichern.... geregekt durch:
Firmenpolicy:
Aufalldauer einer DB (inkl Reaktionszeit)--> evtl sogar Hochverfügbarkeit
Max Datenverlust in Zeit... am besten mit geringst möglichen Datenverlust oder ga gar keinem--> Hochverfügbarkeitsgruppen bzw Spiegelung



Sicherungsarten

Vollsicherung   V
differentiell   D
Transaktionsprotokollsicherung T


V   6:00       !
	T
	T
	T defekt
x 
	T
	T
	T
x        !
	 T            !  Tlog alle 30min
	 T            !
	 T  15:00 !




	 Vollsicherung: 
	 sichert Pfade , Dateiname, Größe, und Inhalte
	 zu einem Zeitpunkt


	 Diff
	 sichert alle Seiten und Blöcke seit des letzten V
	 zu einem Zeitpunkt

	 TLog
	 sichert alle Anweisungen weg
	 restore spielt die Anweisungen wieder zurück

	 schnellster Restore:  das V, wenn es also schnell sein soll, dann sollte man das V so häufig wie möglich 

	 wie lange dauert der Restore des 2 letzten Ts
	 solange wie die TX im Orig auch dauerten.. in unserem Fall bis zu 30min 
	 daher: Logfiles sollten keinen großen zeitlichen Umfang haben und alle paar TSicherung ein D einstreuen
	 und das D macht auch den Restire sicherer


	 ---Ausschlaggebened: RecoveryModel

	 Einfach
	 INS UP DEL , Bulk (rudimentär)--> ist einen TX fertig, dann wird sie autom aus dem Tlog gelöscht
	 ==> keine Sicherung des Logfiles
	 --Einsatzgebiet: schneller, weil weniger schreiben, aber kein Restore üer Tlog , wartungsfrei--> TestDb, Datenverlust kann theor. sehr hoch sein (4h)

	 Massenprotokoliert
	 INS UP DE BULK (rudimentär), aber es wird nichts gelöscht.Nur die Sicherung des Tlog entfernt Eintrage aus dem Tlog
	 Logfile muss regelm. gesichert werden, damit es auch wieder gleert wird
	 Restore per Logfile möglich und evtl auch auf Sekunde genau, aber nur dann , wenn nur wenn kein Bulk

	 
	 Voll
	 INS UP DEL Bulk vollständig (auch IX) ... auf Sekunde restore machbar
	 Logfile wächst schneller und ist auch evtl langsamer beim Schreiben


	 --Was passiert mit dem Logfile, wenn man das Model von Full auf Einfach wechselt?
	 es wird geleert.. und per Logfile kein Restore mehr

	*/
	--Vollsicherung
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH NOFORMAT, NOINIT,  
	 NAME = N'Nwind Full', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Diff
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'Nwind Diff', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Tlog
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH NOFORMAT, NOINIT,  
NAME = N'Nwind Log', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--- V TTT D TTT D TTT       D   TTT    2022-09-06T11:04:31.3721112+02:00

--Ist ein T defekt, sins alle nachfolgenden Ts wertlos, ausser man hat noch ein D gemacht...

--Restore: Das Letzte V , dann das letzte D , und dann alle nach dem D folgenden Ts


-- Tipp: Kopiere das Backup an den Ort, an dem SQL Server auch das Backup  erstellt
-- Kein Problem mit Rechten

--Fall1 : falsche Daten Userfehler
--in unsererm Falk ... kopieren von \\hv-sql2\c$    --> c:\_backup
---T 11 Uhr-- 11:30 nächste Sicherung
-- 11:17 --> 11:10!!

--wir wissen, was er ausfgefressen hat

--Idee: workaround: Tabelle restoren

------------------------------------------------------
--Fall logischer Fehler
--Restore der DB unter anderern Namen, 
--dann per TSQL die Daten in der OrigDb wieder update mit den Daten aus der 11 Uhr DB-- sofern an das exakt sagen kann
---aufpassen: Pfade und Dateinamen evtl korrigieren.. Fragmentsicherung ausschalten
------------------------------------------------------

------------------------------------------------------
-- Fall Server tot
---DB auf anderen Server restoren
---Bak auf den Server HV-SQL2 kopieren --> ins SQL Backup Verzeichnis
------------------------------------------------------

------------------------------------------------------
--Fall : Restore der DB auf gleichem Server
--mit geringst möglichen Datenverlust --> Fragmentsicherung ;-)
------------------------------------------------------

---V D TTT 11:04               nächste Tlog 11:30
--aktuell 11:17:13 --Problem!!!

--- um 11:18 V D  TTT bis 11:04:00   13min
--- warten auf 11:30 T -- V  D TTTT restore von 11:17:12  ...........  alles bis 11:30 weg --keine gute Idee


--wenn wir weniger faul wären:
--T Sicherung um 11:18 (jedes Backup ist Online.. T Sicherung dauert ca 5 min)
--restore von 11:17:12  ---  >ca gut 5 Min Verlust --bessere Idee, aber nicht die beste

--Besser: Wähle einfach den Zeitpunkt , den du restoren möchtest. SQL erstellt automatisch eine Fragemtnsicherung, damit keine Daten verloren gehen
--und restore bis zum gewünschten Zetpunkt
--Allerdings: Datenbank erstzen und Benutzerverbidungen trennen angeben.. Per Script sieht das so aus:



--alle user runterkicken...

--theroetisch
--alle Leute runterwerfen und sollen wegbleiben
--Sicherung des Tlog
--Restore auf gewünschte Zeit



USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-09-06_11-52-34.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2022-09-06_11-52-34', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 13,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 14,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 15,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 16,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-09-06_11-52-34.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2022-09-06T11:17:12'
ALTER DATABASE [Northwind] SET MULTI_USER

GO

------------------------------------------------------
--Fall: Server tot, aber HDDS sind in Ordnung
-- DB anfügen und trennen
-- DB Offline, dann ist die DB zwar noch regstriert aber nicht mehrim SQL Prozess 
--DB trennen: DB ist auch aus der master Regsitrierung entfernt worden
------------------------------------------------------


--Anfügen: 
--man braucht mind die mdf Datei
--eine ldf kann wieder neu erstellt werden







----Fall 4: Einspielen SP UP ... mach vorher ne Sicherung
--Momentaufnahme oder Snapshot-- siehe eig. Skript: 08_Snapshot.sql


--Wie sieht der Plan für Backup aus (Backups sind immer online, Rstore offline)

--Zuerst das V festlegen: so häufig wie möglich (evtl Platzbedarf ein Probem oder die Dauer)
--Der max Datenverlust wird mit dem T erledigt
--Das D wird zwischen den Ts gestreut , um den Restore zu sichern  und zu verkürzen..
-
--Tipp: Nicht jeder muss T Sichern: zB  wenn die Datenverlustzeit 4 Stunden beträgt


---Größe der DB: 100 GB --> V mit kompresion: 20GB
--ArbZeiten:  Mo bis So  24*7
--Ausfallzeit der DB:  4 Std
--Datenverlust: max 15min


--V: täglich  wann: 22 Uhr wie lange: 1GB / min
--T: alle 15min
--D: TTTT D TTTTTD  TTTTT D TTTT D TTT D TTTT


---Größe der DB: 100 GB --> V mit kompresion: 20GB  --- HADR
--ArbZeiten:  Mo bis So  24*7
--Ausfallzeit der DB:  30min
--Datenverlust: max 15min






kill 63

use nw_1400
















 













*/