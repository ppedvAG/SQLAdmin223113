/*

Setup

Binärkram

Tuning: 
HDD
--> Pfade Log von Daten trennen  (mdf und ldf)
--> tempdb sollte man auch trennen und evtl eig HDD

CPU
--> MAXDOP 4 max Anzahl der Kerne pro Abfrage   (gute Idee des Setup max 8)

RAM
-->MIN und MAX (dem OS etwas reservieren)


--Filestream  (SQL Konfiguration Manager)
\\Server\SQLINSTANZ\DB\TAB


--DB Settings


--Agent
Aufträge
Schritte (TSQL , PS, CMD, SSAS, SSIS, Replikation)
Zeitpläne  (Testzeitplan)
Email
Wartung
Warnungen
Operator

*/
select  top 10 * into #t from  sysmessages

select * from #t