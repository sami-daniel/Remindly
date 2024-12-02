module database

import db.mysql
import time

type DB = mysql.DB
type Time = time.Time

@[table: 'remind']
pub struct Remind {
 	id        int    @[primary; sql: 'serial']
    message   string @[sql: 'varchar(255)']
    created_at Time
}

pub struct UnitOfWork {	
}

fn connect() DB {
	config := mysql.Config { 
		host: 'localhost',
		port: 3306,
		username: 'root',
		password: '98Sf7d4pj@', 
		dbname: 'remindlydatabase'
	}

	db := mysql.connect(config) or { 
		panic(err)
	}

	return db
}

fn close(mut connection DB) {
	connection.close()
}

fn (u UnitOfWork) get_all_reminds() []Remind {
	db := connect()

	reminds := sql db {
		select from Remind
	} or { panic(err) }

	return reminds
}

fn init() {
	db := connect()
	sql db  {
		create table Remind
	} or { panic(err) }
}