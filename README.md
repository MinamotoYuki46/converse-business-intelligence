# Converse OLTP-DW-ETL
Name : Muhammad Fauzan Ahsani <br>
ID: 2310817310009 <br>
Course: Business Intelligence

こんばんは。このレポは、is about OLTP, data warehouse and ETL on Converse online store. 


How to run it? Follow these step

First, run the sql script in the schema folder.

```
SOURCE schema/converse_oltp.sql;
SOURCE schema/converse_dw.sql;
```

or just copy the sql script in the SQL query directly.

Second, on root folder, run

```
npm install
```

Third, configure the `.env` file. Ive already make the template on (`.template_env`). Just configure it and rename it into `.env`. Place it on the root folder

Fourth, test the connection
```
npx ts-node src/testConnection.ts

```

Last, run the ETL

```
npx ts-node ./main.ts
```

Just, remember something. If you wanna check the db without open the DB manager. run

```
npx ts-node src/showOLTP.ts
```
for OLTP

and

```
npx ts-node src/showDW.ts
```
for DW/ELT result
