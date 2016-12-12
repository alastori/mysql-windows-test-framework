
MySQL Windows Test Framework
=====================================

This is a simple framework to benchmark the Query Response Time between MySQL versions in a Windows environment. The current version works with MySQL 5.6 and MySQL 5.7, but can be adapted to work with other versions.



## Motivation

Sometimes you want to compare the response time of some queries between MySQL versions and confirm there are no performance regressions, for example, before an upgrade. This framework automates a good portion of this process.



## How to use

1. Download [mysql-5.6](http://dev.mysql.com/downloads/mysql/5.6.html#downloads) and [mysql-5.7](http://dev.mysql.com/downloads/mysql/5.7.html#downloads) binaries for windows 64-bit (zip) and unzip in convenient folders (ex: ```D:\win-mysql\mysql-advanced-5.6.34-winx64``` and ```D:\win-mysql\mysql-advanced-5.7.16-winx64```);
2. Download [this repo](https://github.com/alastori/mysql-windows-test-framework/archive/master.zip) in another convenient folder;
3. Edit ```setenv-mysql56.bat``` and ```setenv-mysql57.bat``` files with your correct paths; optionally edit ```my_5.6.ini``` and ```my_5.7.ini``` files with your own options;
4. In command line, run ```prepare.bat``` - this will take some time, but will create the MySQL sandbox instances for you (aka initialize the datadir);
5. Replace the files ```create-user.sql```,  ```dump.sql``` and ```query.sql``` files with the data and query(ies) you want to benchmark;
6. Run the tests with ```run.bat```;
7. See the results will be in ```mysql-win-test.txt``` file;
8. Run any number of test cycles you want and, at the end, you can run cleanup.bat to erase the MySQL Sandboxes.

