--SystemDbs

/*

master
Logins
Settings
DB
Herzstück

Backup: ja 


msdb
DB für den Agent
Jobs, Zeitpläne, ProxyKonten, Verlauf der Jobs, Operatoren, Emailsystem

Backup: Ja..sicher

model
create database testdb (Kopie der model)
DB Änderungen an model haben Auswirkung auf jede neue DB

Backup der model: eigtl ja aber auch per Script ne coole Sache


tempdb
temporäre Dinge 
#Tab, Zeilenversionierung, Wartung von IX

Backup: hihihi  nö..





distribution (Replikation)

