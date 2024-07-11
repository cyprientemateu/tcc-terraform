## RDS + Aurora + MySQL + PostgreSQL + Bastion + Terraform
- https://medium.com/@jerome.decoster/rds-aurora-mysql-postgresql-bastion-terraform-17c5a76aced8

- https://www.reddit.com/r/Terraform/comments/qukv6f/terraform_aurora_postgresql_help_read_replica/ 

## Connecting to a DB instance running the PostgreSQL database engine
```
https://www.hostinger.com/tutorials/how-to-install-postgresql-on-centos-7/
yum update -y
yum install postgresql-server postgresql-contrib
psql --version

or
https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/
sudo apt-get update
sudo apt-get install postgresql-client -y
psql --version
```

## How to install psql in aws cloudshell
sudo dnf install postgresql15

## Connect through the CLI
- The default db in postgres is `postgres`

https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/
```sh
psql -h [HOSTNAME] -p [PORT] -U [USERNAME] -W -d [DATABASENAME]
psql --host=example-cluster.cluster-cv3uwkomseya.us-east-1.rds.amazonaws.com --port=5432 --username=adminuser --password --dbname=postgres 

psql --host=example-cluster.cluster-ro-cv3uwkomseya.us-east-1.rds.amazonaws.com --port=5432 --username=adminuser --password --dbname=postgres 

psql --host=artifactory.tcclearning.cf --port=5432 --username=adminuser --password --dbname=postgres 
psql --host=artifactory.tcclearning.cf --port=5432 --username=adminuser --password --dbname=postgres

psql --host=artifactory.tcclearning.cf --port=5432 --username=adminuser --password --dbname=artifactory
```

### List databases
```
\l
```
### Quit
```
\q
```

### List table
```
\dt
```

### List users
```
\du
```

### Clear screen
```
\! cls
```

### Switching Databases
```
\c [database name]
\c sales
```

### Create a database
```sql
CREATE DATABASE [database name];
CREATE DATABASE sales;
```

### PostgreSQL DROP DATABASE
**NB:** only the supper user and the owner can drop the database
```sql
DROP DATABASE IF EXISTS  [database name];
DROP DATABASE IF EXISTS sales;
```

### How to delete users?
```sql
DROP USER  [user name];
DROP USER  tcc;
```

### Drop a table
```sql
DROP TABLE  [table name];
DROP TABLE accounts;
```

### Create a database and connect
```sql
CREATE DATABASE hr;
CREATE USER john WITH ENCRYPTED PASSWORD '12345';
GRANT ALL PRIVILEGES ON DATABASE hr TO john;

psql -h artifactory.artifactory.tcclearning.cf -p 5432 -U john -W -d hr
psql -h tcc-aurora-postgres-cluster.cluster-cqmehbekbflr.us-east-1.rds.amazonaws.com -p 5432 -U john -W -d hr  
```

## run sql script
```sh
psql -h artifactory.artifactory.tcclearning.cf -p 5432 -U john -W -d hr < /root/hr.sql
psql -h artifactory.artifactory.tcclearning.cf -p 5432 -U john -W -d hr < /root/contacts.sql

## list table
\dt
```

### Search in the table
```
SELECT * FROM [table name];
SELECT * FROM contacts_docs;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;
```

