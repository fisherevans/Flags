@ECHO OFF
mysql -u root < create.sql
mysql -u root < import_data.sql