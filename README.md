📜This is my small human resource management personal project (backend API).

🖥Dev with PostgreSQL + nodejs ( express, mssql, bcryppt, jsonwebtoken, dotenv, cors, body-parser, nodemon )

🕹Function:
	
	💿Nodejs:
 	
		🧑🏻‍💼Employees: CRUD ( create, read, update, delete ) + some other functions
		🧑🏻‍💼Positions: CRUD ( create, read, update, delete ) + some other functions
		🧑🏻‍💼Department: CRUD ( create, read, update, delete ) + some other functions
	 	🧑🏻‍💼Accounts: CRUD ( create, read, update, delete ) + json web token ( create token, auth token, renew token ) + login + change password
    	
    💿Mssql:
		🧑🏻‍💼DDL script + DML script.
    	🧑🏻‍💼Employees: store procedure ( create, read, update, delete ) + some functions to get employee information
		🧑🏻‍💼Positions: store procedure ( create, read, update, delete ) + some functions to get positions of employees
		🧑🏻‍💼Department: store procedure ( create, read, update, delete ) + some functions to get departments of employees
	 	🧑🏻‍💼Accounts: store procedure ( create, read, update, delete ) + some functions to get account information
   
📝Description:

		1.folder mssqlConfigure: Contains database connection configuration information.
  		2.folder mssqlOperation: Contains CRUD for each module (employees, positions, accounts).
      	3.folder mssql_script: Contains DDL + DML script ( create database, schema, table, type, store procedure, function,... ).
        	4.router: Contains all API router ( CRUD for each module ).
	 	5.tokenOperations: Contains CRUD for json web token ( create token, auth token, renew token ).
   		6.file index.js: Contains server configuration information.

♻️How to use:

		⚫️Step 1: make sure git is installed on your computer.
  		⚫️Step 2: use git to download this project to your computer (use fork first).
    	⚫️Step 3: use npm install to download all dependencies in package.json 
      	⚫️Step 4: test server use index.js ( run syntax "nodemon" or "npx nodemon").
		⚫️Step 5: copy all the scripts in mssql_script folder and past on your sql tool ( use master database first ), then run it DDL => DML ( for auto data ) => CRUD.
       	⚫️Step 6: done !!! ( you can use postman to test those APIs )

📠If you have any questions about my project, you can contact me 🧔🏻‍♂️
