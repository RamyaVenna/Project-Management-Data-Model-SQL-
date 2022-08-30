-- Creating Project Management Database System
create database PMDS;

use pmds;

-- creating tables for app/website users and employees
create table user_account(
id int not null, 
username varchar(64) not null, 
password varchar(64) not null, 
email varchar(255) unique,
first_name varchar(64),
last_name varchar(64),
is_project_manager bool,
registration_time timestamp, 
primary key (id)
);

-- slight changes in above table
Alter table user_account
modify first_name varchar(64) not null;

Alter table user_account
modify last_name varchar(64) not null;

create table employee(
id int not null primary key,
employee_code varchar(128) not null,
employee_name varchar(128) not null,
user_account_id int not null,
foreign key (user_account_id) references user_account(id)
);

desc employee;

create table team(
id int primary key,
team_name varchar(150) not null
);

create table role(
id int primary key,
role_name varchar(150) not null
);


create table team_member(
id int primary key,
team_id int,
employee_id int, 
role_id int,
foreign key(team_id) references team(id),
foreign key(employee_id) references employee(id),
foreign key(role_id) references role(id)
);

-- Creating tables for Projects
create table project(
id int primary key,
project_name varchar(150) not null,
planned_start_date date not null,
planned_end_date date not null,
actual_start_date date,
actual_end_date date, 
project_description text(10000)
);


create table client_partner(
id int primary key,
cp_name varchar(255),
cp_address varchar(255),
cp_details text
);

create table project_manager(
id int primary key,
project_id int, 
user_account_id int,
foreign key(project_id) references project(id),
foreign key (user_account_id) references user_account(id)
);

create table on_project(
id int primary key,
project_id int,
client_partner_id int,
date_start date not null,
date_end date,
is_client bool,
is_partner bool,
pjt_description text,
foreign key(project_id) references project(id),
foreign key(client_partner_id) references client_partner(id)
);

-- Creating tables for tasks and activities
create table task(
id int primary key,
task_name varchar(255) not null,
project_id int,
priority int not null,
task_description text,
planned_start_date date not null,
planned_end_date date not null,
planned_budget decimal(10,2),
actual_start_date date,
actual_end_date date,
actual_budget decimal(10,2),
index(priority)
);

-- Updated the foreign key (project_id) manually through sql-workbench

describe task;

create table activity(
id  int primary key,		
activity_name varchar(255) not null,
task_id int,
priority int not null,
act_description text,
planned_start_date date not null,
planned_end_date date not null,
planned_budget decimal(10,2),
actual_start_time decimal(10,2),
index(priority),
foreign key(task_id) references task(id)
); 


create table assigned(
id int primary key,
activity_id int not null,
employee_id int not null,
role_id int not null,
foreign key (activity_id) references activity(id),
foreign key (employee_id) references employee(id),
foreign key (role_id) references role(id)	
);



