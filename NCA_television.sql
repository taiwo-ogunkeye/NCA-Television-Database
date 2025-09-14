use master;
go

if EXISTS(SELECT name FROM sys.databases WHERE name = N'nca_television_94242023')
begin
	drop database nca_television_94242023;
end
go

create database nca_television_94242023;
go

use nca_television_94242023;
go 


--------------------------------------------------------------------------------------------------------------------
                                          ----- Table creation: Main database
--------------------------------------------------------------------------------------------------------------------

create table person(
	fname varchar(10) not null,
	lname varchar(10) not null,
	sex char(1) check (sex in ('f','m')),
	dob date,
	person_id int identity(1,1) primary key 
	);

create table sponsors(
	sponsor_name varchar(30) not null,
	sponsor_type varchar(10) check (sponsor_type in ('company','individual')) not null,
	email varchar(30) unique,
	location varchar(20),
	sponsor_id int identity(1,1) primary key
	);


create table television_station (
	station_id int identity(1,1) primary key,
	station_name varchar(20) not null,
	location varchar(20),
	company_type varchar(7) check(company_type IN('private','public')) not null,
	view_type varchar(5) check(view_type IN('free','paid')) not null,
	email varchar(30) unique,
	year_established smallint, -----YEAR 
	);

create table advertisements(
	advert_id int identity(1,1)primary key,
	advert_cost money,
	advert_type varchar(9) check(advert_type in('services','goods','awareness')),
	sponsor_id int,
	foreign key  (sponsor_id) references sponsors(sponsor_id) on update cascade on delete cascade
	);


create table producer(
	salary money,
	email varchar(30) unique, 
	producer_id int primary key, 
	foreign key (producer_id) references person(person_id) on update cascade on delete cascade
	);


create table program (
	program_id int identity(1,1) primary key,
	program_name varchar(30),
	start_time time, 
	end_time time, 
	duration int, --in mins 
	station_id int,
	producer_id int,
	foreign key (station_id) references television_station(station_id) on update cascade on delete cascade,
	foreign key (producer_id) references producer(producer_id) on update cascade on delete cascade
	);

create table schedule(
	program_id int,
	schedule_id int identity(1,1) primary key,
	day_aired varchar(9) check(day_aired in('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')),
	month_aired varchar(9) check (month_aired in('january','febuary','march','april','may','june','july','august','september','october','november','december')),
	foreign key (program_id) references program(program_id) on update cascade on delete cascade,
	);

create table movie(
	movie_id int primary key, 
	director varchar(50),
	year_release smallint, ---year
	production_company varchar(50), 
	foreign key (movie_id) references program(program_id) on update cascade on delete cascade
	);

create table news(
	news_id int primary key,
	numOfPresenters int,
	streaming_resolution int,
	foreign key (news_id) references program(program_id) on update cascade on delete cascade
	);


create table presenter(
	presenter_id int primary key, 
	news_id int,
	salary money,
	email varchar(30) unique,
	foreign key (news_id) references news(news_id),
	foreign key (presenter_id) references person(person_id) on update cascade on delete cascade
	);


create table documentary(
	documentary_id int primary key,
	presenter_id int,
	subject_matter varchar(50),
	summary varchar(500),
	foreign key (documentary_id) references program(program_id) on update cascade on delete cascade,
	foreign key (presenter_id) references presenter(presenter_id) 
	);

create table program_ad(
	program_id int,
	advert_id int,
	durationOfAd smallint,
	numTimesRunPerDay tinyint, ---tinyint(5)? --set a max 
	foreign key (advert_id) references advertisements(advert_id) on update cascade on delete cascade,
	foreign key (program_id) references program(program_id) 
	);

create table telephone(
	person_id int,
	telephone_number varchar(15) unique,---to account for foreign numbers
	network varchar(10) not null,
	foreign key (person_id) references person(person_id) on update cascade on delete cascade
	);
go


-----------------------------------------------------------------------------------------------------------------------------------
                                                 -- Create Backup database
------------------------------------------------------------------------------------------------------------------------------------

use master;
go

if EXISTS(SELECT name FROM sys.databases WHERE name = N'nca_television_94242023_backup')
begin
	drop database nca_television_94242023_backup;
end
go

create database nca_television_94242023_backup;
go

use nca_television_94242023_backup;
go



create table person(
	fname varchar(10) not null,
	lname varchar(10) not null,
	sex char(1) check (sex in ('f','m')),
	dob date,
	person_id int primary key 
	);

create table sponsors(
	sponsor_name varchar(30) not null,
	sponsor_type varchar(10) check (sponsor_type in ('company','individual')) not null,
	email varchar(30) unique,
	location varchar(20),
	sponsor_id int primary key
	);


create table television_station (
	station_id int primary key,
	station_name varchar(20) not null,
	location varchar(20),
	company_type varchar(7) check(company_type IN('private','public')) not null,
	view_type varchar(5) check(view_type IN('free','paid')) not null,
	email varchar(30) unique,
	year_established smallint -----YEAR 
	);

create table advertisements(
	advert_id int primary key,
	advert_cost money,
	advert_type varchar(9) check(advert_type in('services','goods','awareness')),
	sponsor_id int
	);


create table producer(
	salary money,
	email varchar(30) unique, 
	producer_id int primary key 	
	);


create table program (
	program_id int primary key,
	program_name varchar(30),
	start_time time, 
	end_time time, 
	duration int, ---in mins
	station_id int,
	producer_id int
	);

create table schedule(
	program_id int,
	schedule_id int primary key,
	day_aired varchar(9) check(day_aired in('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')),
	month_aired varchar(9) check (month_aired in('january','febuary','march','april','may','june','july','august','september','october','november','december'))
	);

create table movie(
	movie_id int primary key, 
	director varchar(50),
	year_release smallint, ---year
	production_company varchar(50) 
	);

create table news(
	news_id int primary key,
	numOfPresenters int,
	streaming_resolution int	
	);


create table presenter(
	presenter_id int primary key, 
	news_id int,
	salary money,
	email varchar(30) unique	
	);


create table documentary(
	documentary_id int primary key,
	presenter_id int,
	documentary_name varchar(50),
	summary varchar(500)
	);

create table program_ad(
	program_id int,
	advert_id int,
	durationOfAd smallint,
	numTimesRunPerDay tinyint
	);

create table telephone(
	person_id int,
	telephone_number varchar(15) unique,---to account for foreign numbers
	network varchar(10) not null
	);
go





-----------------------------------------------------------------------------------
                                        --creating indexes
------------------------------------------------------------------------------------ 
---fname and lname will be how the data will be displayed on the frontend and, many orderbys will be used to arrange by by alphabet
create index industryIndex ON person (fname, lname ,sex, dob);  


--select stations based on public or private for emailing information to conmpanies incase of new policies implemented by the government
create index stationsIndex on television_station (company_type, station_name, email); 

---This will compile a list of all programs as well as their durations for searching for short duration and long duration shows
create index airingIndex on program(program_name, duration asc); 

 ---This is an index to easily search for advertisment information suvh as cost incurred. This information might be helpful in estimating revenue for the government
create index advertisementIndex on advertisements(advert_type, advert_cost, sponsor_id);

go  

------------------------------------------------------------------------------------
                         --create views for strong entities 
----------------------------------------------------------------------------------------
create view programInfo
as 
select p.program_name, p.duration, p.start_time, p.end_time 
from program as p;



go
create view advertisementInfo
as
select a.advert_type, a.advert_cost
from advertisements as a;

go

create view televison_stationInfo
as 
select t.station_name, t.location, t.company_type, t.email
from television_station as t; 

go

create view sponsorInfo
as
select s.sponsor_name, s.sponsor_type, s.email
from sponsors as s;


go

create view personProducer
as 
select p.fname, p.lname, pro.email
from person as p join producer as pro
on p.person_id = pro.producer_id;

go


-----------------------------------------------------------------------------------------------------
                                           ---creating triggers 
-----------------------------------------------------------------------------------------------------

use nca_television_94242023;
go 


create trigger dbo.trig_person_DML
	on person
after insert, delete, update
as
begin
	if @@ROWCOUNT = 0 return;
	set NOCOUNT on;

	-- !!! redirect delete to backup

	delete from [nca_television_94242023_backup].[dbo].[person] where "person_id" in (
		select "person_id" from deleted
	);

	insert into [nca_television_94242023_backup].[dbo].[person] select * from inserted; 



end;

go


create trigger dbo.trig_sponsors_DML
	on sponsors
after insert, delete, update
as
begin
	if @@ROWCOUNT = 0 return;
	set NOCOUNT on;

	-- !!! redirect delete to backup

	delete from [nca_television_94242023_backup].[dbo].[sponsors] where "sponsor_id" in (
		select "sponsor_id" from deleted
	);

	insert into [nca_television_94242023_backup].[dbo].[sponsors] select * from inserted; 



end;

go 
create trigger dbo.trig_television_station_DML
	on television_station
after insert, delete, update
as
begin
	if @@ROWCOUNT = 0 return;
	set NOCOUNT on;

	-- !!! redirect delete to backup

	delete from [nca_television_94242023_backup].[dbo].[television_station] where "station_id" in (
		select "station_id" from deleted
	);

	insert into [nca_television_94242023_backup].[dbo].[television_station] select * from inserted; 



end;


go 

create trigger dbo.trig_advertisements_DML
	on advertisements
after insert, delete, update
as
begin
	if @@ROWCOUNT = 0 return;
	set NOCOUNT on;

	-- !!! redirect delete to backup

	delete from [nca_television_94242023_backup].[dbo].[advertisements] where "advert_id" in (
		select "advert_id" from deleted
	);

	insert into [nca_television_94242023_backup].[dbo].[advertisements] select * from inserted; 



end;


go 
create trigger dbo.trig_program_DML
	on program
after insert, delete, update
as
begin
	if @@ROWCOUNT = 0 return;
	set NOCOUNT on;

	-- !!! redirect delete to backup

	delete from [nca_television_94242023_backup].[dbo].[program] where "program_id" in (
		select "program_id" from deleted
	);

	insert into [nca_television_94242023_backup].[dbo].[program] select * from inserted; 



end;

go 


create trigger dbo.trig_schedule_DML
	on schedule
after insert, delete, update
as
begin
	if @@ROWCOUNT = 0 return;
	set NOCOUNT on;

	-- !!! redirect delete to backup

	delete from [nca_television_94242023_backup].[dbo].[schedule] where "schedule_id" in (
		select "schedule_id" from deleted
	);
			
		


	insert into [nca_television_94242023_backup].[dbo].[schedule] select * from inserted; 


end;

go




 




-------------------------------------------------------------------------------------------------------
								---email trigger for person 
-------------------------------------------------------------------------------------------------------


-------------------------------------person------------------------------------------------------------
USE MASTER;
GO
USE msdb
GO
sp_CONFIGURE 'show advanced', 1      -- enable access to advanced settings
Go
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1  -- enables the Database Mail extended stored procedures
Go
RECONFIGURE
GO
use nca_television_94242023
go

create trigger dbo.trigger_person_emails
	on	[nca_television_94242023].[dbo].[person] 
	after insert, update 
	as 
		begin
		
			if @@ROWCOUNT = 0 return;
			set nocount on;

			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'taiwosqlserver',              -- name of the profile to send the message from
			@recipients = 'sampahd@gmail.com',                -- semicolon-delimited list of e-mail addresses to send the message to
			@copy_recipients = 'taiwotemityo02@gmail.com',           -- semicolon-delimited list of e-mail addresses to carbon copy the message to
			@subject = 'A NEW PERSON HAS BEEN ADDED TO THE NCA DATABASE',                   -- the subject of the e-mail message
			@body = 'To whom it may concern, a new person has been included in the NCA DATABASE',                      -- the body of the e-mail message
			@body_format = 'text'               -- the format of the message body (default is NULL)
		end 
go

-------------------------------------sponsors-----------------------------------------------------------------
USE MASTER;
GO
USE msdb
GO
sp_CONFIGURE 'show advanced', 1      -- enable access to advanced settings
Go
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1  -- enables the Database Mail extended stored procedures
Go
RECONFIGURE
GO
use nca_television_94242023
go
create trigger dbo.trigger_email_sponsors
	on	[nca_television_94242023].[dbo].[sponsors] 
	after insert, update 
	as 
		begin
		
			if @@ROWCOUNT = 0 return;
			set nocount on;

			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'taiwosqlserver',              -- name of the profile to send the message from
			@recipients = 'sampahd@gmail.com',                -- semicolon-delimited list of e-mail addresses to send the message to
			@copy_recipients = 'taiwotemitayo02@gmail.com',           -- semicolon-delimited list of e-mail addresses to carbon copy the message to
			@blind_copy_recipients = '',     -- semicolon-delimited list of e-mail addresses to blind carbon copy the message to
			@subject = 'A NEW SPONSOR HAS BEEN ADDED TO THE NCA DATABASE',                   -- the subject of the e-mail message
			@body = 'To whom it may concern, a new sponsor has been added to the NCA database',                      -- the body of the e-mail message
			@body_format = 'text'               -- the format of the message body (default is NULL)
		end 
go

------------------------------television station---------------------------------------
USE MASTER;
GO
USE msdb
GO
sp_CONFIGURE 'show advanced', 1      -- enable access to advanced settings
Go
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1  -- enables the Database Mail extended stored procedures
Go
RECONFIGURE
GO
use nca_television_94242023
go
create trigger dbo.trigger_email_station
	on	[nca_television_94242023].[dbo].[television_station] 
	after insert, update 
	as 
		begin
		
			if @@ROWCOUNT = 0 return;
			set nocount on;

			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'taiwosqlserver',              -- name of the profile to send the message from
			@recipients = 'sampahd@gmail.com',                -- semicolon-delimited list of e-mail addresses to send the message to
			@copy_recipients = 'taiwotemitayo02@gmail.com',           -- semicolon-delimited list of e-mail addresses to carbon copy the message to
			@blind_copy_recipients = '',     -- semicolon-delimited list of e-mail addresses to blind carbon copy the message to
			@subject = 'A NEW TELEVISION STATION HAS BEEN ADDED TO THE NCA DATABASE',                   -- the subject of the e-mail message
			@body = 'A NEW TELEVISION STATION HAS BEEN ADDED TO THE NCA DATABASE',                      -- the body of the e-mail message
			@body_format = 'text'               -- the format of the message body (default is NULL)
		end 
go


-----------------------------------advertisements----------------------------------------
USE MASTER;
GO
USE msdb
GO
sp_CONFIGURE 'show advanced', 1      -- enable access to advanced settings
Go
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1  -- enables the Database Mail extended stored procedures
Go
RECONFIGURE
GO
use nca_television_94242023
go
create trigger dbo.trigger_advert_email
	on	[nca_television_94242023].[dbo].[advertisements] 
	after insert, update 
	as 
		begin
		
			if @@ROWCOUNT = 0 return;
			set nocount on;

			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'taiwosqlserver',              -- name of the profile to send the message from
			@recipients = 'sampahd@gmail.com',                -- semicolon-delimited list of e-mail addresses to send the message to
			@copy_recipients = 'taiwotemitayo02@gmail.com',           -- semicolon-delimited list of e-mail addresses to carbon copy the message to
			@blind_copy_recipients = '',     -- semicolon-delimited list of e-mail addresses to blind carbon copy the message to
			@subject = 'a new advert added inserted',                   -- the subject of the e-mail message
			@body = 'a new advert has been added to the nca datbase',                      -- the body of the e-mail message
			@body_format = 'text'               -- the format of the message body (default is NULL)
		end 
go

------------------------program---------------------------------------------------------------------
USE MASTER;
GO
USE msdb
GO
sp_CONFIGURE 'show advanced', 1      -- enable access to advanced settings
Go
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1  -- enables the Database Mail extended stored procedures
Go
RECONFIGURE
GO
use nca_television_94242023
go
create trigger dbo.trigger_email_programs
	on	[nca_television_94242023].[dbo].[program] 
	after insert, update 
	as 
		begin
		
			if @@ROWCOUNT = 0 return;
			set nocount on;

			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'taiwosqlserver',              -- name of the profile to send the message from
			@recipients = 'sampahd@gmail.com',                -- semicolon-delimited list of e-mail addresses to send the message to
			@copy_recipients = 'taiwotemitayo02@gmail.com',           -- semicolon-delimited list of e-mail addresses to carbon copy the message to
			@blind_copy_recipients = '',     -- semicolon-delimited list of e-mail addresses to blind carbon copy the message to
			@subject = 'new program inserted',                   -- the subject of the e-mail message
			@body = 'a new program has been created in the database',                      -- the body of the e-mail message
			@body_format = 'text'               -- the format of the message body (default is NULL)
		end 
go

---------------------------------------schedule----------------------------------------------------------------
USE MASTER;
GO
USE msdb
GO
sp_CONFIGURE 'show advanced', 1      -- enable access to advanced settings
Go
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1  -- enables the Database Mail extended stored procedures
Go
RECONFIGURE
GO
use nca_television_94242023
go
create trigger dbo.trigger_email_schedule
	on	[nca_television_94242023].[dbo].[schedule] 
	after insert, update 
	as 
		begin
		
			if @@ROWCOUNT = 0 return;
			set nocount on;

			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'taiwosqlserver',              -- name of the profile to send the message from
			@recipients = 'sampahd@gmail.com',                -- semicolon-delimited list of e-mail addresses to send the message to
			@copy_recipients = 'taiwotemitayo02@gmail.com',           -- semicolon-delimited list of e-mail addresses to carbon copy the message to
			@blind_copy_recipients = '',     -- semicolon-delimited list of e-mail addresses to blind carbon copy the message to
			@subject = 'a new schedule for programs have been added',                   -- the subject of the e-mail message
			@body = 'a new schedule for programs has been added',                      -- the body of the e-mail message
			@body_format = 'text'               -- the format of the message body (default is NULL)
		end 
go




---------------------------------------------------------------------------------------------------------
									---creating stored procedures for insertion 
----------------------------------------------------------------------------------------------------------

use nca_television_94242023
go

--------------------------------------------person--------------------------------------------------------

create procedure personInsertionProc
		@fname as varchar(10),
		@lname as varchar(10),
		@sex   as char(1),
		@dob   as date
as 
begin

	set NOCOUNT ON;
	insert into person values (@fname, @lname, @sex, @dob)

	--set @numrows = @@ROWCOUNT;
end

go
exec personInsertionProc @fname = 'ian', @lname='akotey', @sex= 'm', @dob= '2002-01-20'
exec personInsertionProc @fname = 'jane', @lname='angela', @sex= 'f', @dob= '2001-01-20'
exec personInsertionProc @fname = 'adam', @lname='smith', @sex= 'm', @dob= '2000-01-20'
exec personInsertionProc @fname = 'isabella', @lname='donald', @sex= 'f', @dob= '2002-01-10'
exec personInsertionProc @fname = 'felix', @lname='lucky', @sex= 'm',  @dob= '2002-01-20'
exec personInsertionProc @fname = 'josephine', @lname='wu', @sex= 'f', @dob= '2002-01-20'
exec personInsertionProc @fname = 'vincent', @lname='donald', @sex= 'm', @dob= '2002-01-20'
exec personInsertionProc @fname = 'nikolas', @lname='lucky', @sex= 'm', @dob= '2002-01-20'
exec personInsertionProc @fname = 'janet', @lname='kane', @sex= 'f', @dob= '2001-01-20'
exec personInsertionProc @fname = 'athena', @lname='lucky', @sex= 'f', @dob= '1999-01-20'
exec personInsertionProc @fname = 'eyram', @lname='haatso', @sex= 'f', @dob= '2001-01-20'
exec personInsertionProc @fname = 'juliet', @lname='angela', @sex= 'f', @dob= '2001-01-20'
exec personInsertionProc @fname = 'adam', @lname='andoh', @sex= 'm', @dob= '2000-01-20'
exec personInsertionProc @fname = 'isabella', @lname='owusi', @sex= 'f', @dob= '2002-03-10'
exec personInsertionProc @fname = 'felicia', @lname='lucky', @sex= 'f',  @dob= '1995-01-20'
exec personInsertionProc @fname = 'josephine', @lname='bleboo', @sex= 'f', @dob= '2002-01-20'
exec personInsertionProc @fname = 'victoria', @lname='pels', @sex= 'f', @dob= '2001-01-20'
exec personInsertionProc @fname = 'nikolas', @lname='klugan', @sex= 'm', @dob= '2002-01-20'
exec personInsertionProc @fname = 'june', @lname='kane', @sex= 'f', @dob= '2001-01-20'
exec personInsertionProc @fname = 'athena', @lname='ansah', @sex= 'f', @dob= '2002-01-20'
go



-------------------------------------------sponsors-----------------------------------------------------------------------

go

create procedure sponsorsInsertionProc
		@sponsor_name as varchar(30),
		@sponsor_type as varchar(10),
		@email        as varchar(30),
		@location     as varchar(20)
		
as 
begin

	set NOCOUNT ON;
	insert into sponsors values (@sponsor_name, @sponsor_type, @email, @location)

	--set @numrows = @@ROWCOUNT;
end

go

exec sponsorsInsertionProc @sponsor_name = 'fanyogo', @sponsor_type='company', @email= 'fanyogo@gmail.com', @location = 'tema'
exec sponsorsInsertionProc @sponsor_name = 'ashesi', @sponsor_type='company', @email= 'ashesi@gmail.com', @location = 'berekuso'
exec sponsorsInsertionProc @sponsor_name = 'ministry of health', @sponsor_type='company', @email= 'min.of.health@gmail.com', @location = 'accra'
exec sponsorsInsertionProc @sponsor_name = 'blue skies', @sponsor_type='company', @email= 'blueskies@gmail.com', @location = 'accra'
exec sponsorsInsertionProc @sponsor_name = 'cocacola', @sponsor_type='company', @email= 'cocacola@gmail.com', @location = 'cantonments'

go




--------------------------------------------------televison station------------------------------------------

go

create procedure televisionStationInsertionProc
		@station_name varchar(20),
		@location varchar(20),
		@company_type varchar(7),
		@view_type varchar(5),
		@email varchar(30),
		@year_established smallint
as 
begin

	set NOCOUNT ON;
	insert into television_station values (@station_name, @location, @company_type, @view_type, @email, @year_established)

	--set @numrows = @@ROWCOUNT;
end

go
exec televisionStationInsertionProc @station_name = 'aitv',@location='tema', @company_type='private', @view_type = 'paid', @email= 'aitv@gmail.com', @year_established = 1999
exec televisionStationInsertionProc @station_name = 'nitv',@location='cantonemnts', @company_type='public', @view_type = 'free', @email= 'nitv@gmail.com', @year_established = 1981
exec televisionStationInsertionProc @station_name = 'bitv',@location='airport city', @company_type='private', @view_type = 'paid', @email= 'bitv@gmail.com', @year_established = 1989
exec televisionStationInsertionProc @station_name = 'kitv',@location='oponglo', @company_type='public', @view_type = 'free', @email= 'kitv@gmail.com', @year_established = 1999
exec televisionStationInsertionProc @station_name = 'adomtv',@location='haatso', @company_type='private', @view_type = 'paid', @email= 'adomtv@gmail.com', @year_established = 2000
exec televisionStationInsertionProc @station_name = 'litv',@location='tema', @company_type='private', @view_type = 'paid', @email= 'litv@gmail.com', @year_established = 1999


go




-------------------------------------------------advertisements---------------------------------------

go

create procedure advertismentsInsertionProc
		@advert_cost money,
		@advert_type varchar(9),
		@sponsor_id int
as 
begin

	set NOCOUNT ON;
	insert into advertisements values (@advert_cost, @advert_type, @sponsor_id)

	--set @numrows = @@ROWCOUNT;
end

go
exec advertismentsInsertionProc @advert_cost = 2000, @advert_type = 'goods', @sponsor_id = 1
exec advertismentsInsertionProc @advert_cost = 3000, @advert_type = 'services', @sponsor_id = 2
exec advertismentsInsertionProc @advert_cost = 1000, @advert_type = 'goods', @sponsor_id = 3
exec advertismentsInsertionProc @advert_cost = 5000, @advert_type = 'services', @sponsor_id = 4
exec advertismentsInsertionProc @advert_cost = 4000, @advert_type = 'goods', @sponsor_id = 5
exec advertismentsInsertionProc @advert_cost = 4000, @advert_type = 'goods', @sponsor_id = 5




go


go


---------------------------------------------------producer-------------------------------------------
create procedure producerInsertionProc
		@salary money,
		@email varchar(30),
		@producer_id int
as 
begin

	set NOCOUNT ON;
	insert into producer values (@salary, @email, @producer_id)

	--set @numrows = @@ROWCOUNT;
end

go
exec producerInsertionProc @salary = 2000, @email = 'ianakotey@gmail.com', @producer_id = 1
exec producerInsertionProc @salary = 3000, @email = 'janeangela@gmail.com', @producer_id = 2
exec producerInsertionProc @salary = 4000, @email = 'adamsmith@gmail.com', @producer_id = 3
exec producerInsertionProc @salary = 2000, @email = 'isabelladonald@gmail.com', @producer_id = 4
exec producerInsertionProc @salary = 2000, @email = 'felixlucky@gmail.com', @producer_id = 5
exec producerInsertionProc @salary = 5000, @email = 'josephinewu@gmail.com', @producer_id = 6
exec producerInsertionProc @salary = 10000, @email = 'vincentdonald@gmail.com', @producer_id = 7
exec producerInsertionProc @salary = 1000, @email = 'nikolucky@gmail.com', @producer_id = 8
exec producerInsertionProc @salary = 2000, @email = 'janetkane@gmail.com', @producer_id = 9
exec producerInsertionProc @salary = 4000, @email = 'athenalucky@gmail.com', @producer_id = 10





go

----------------------------------------------program----------------------------------------------------
create procedure programInsertionProc
		@program_name varchar(30),
		@start_time time,
		@end_time time,
		@duration int,
		@station_id int,
		@producer_id int
as 
begin

	set NOCOUNT ON;
	insert into program values (@program_name, @start_time, @end_time, @duration, @station_id, @producer_id)

	--set @numrows = @@ROWCOUNT;
end

go

------------------------------------------------news-----------------------------------------------
exec programInsertionProc @program_name = 'tea time with nana', @start_time = '11:30:00' ,@end_time='12:00:00', @duration= 30, @station_id= 1, @producer_id = 1
exec programInsertionProc @program_name = 'news @ 10', @start_time = '10:00:00' ,@end_time='11:00:00', @duration= 60, @station_id= 1, @producer_id = 1
exec programInsertionProc @program_name = 'news with adom', @start_time = '11:30:00' ,@end_time='12:00:00', @duration= 30, @station_id= 2, @producer_id = 2
exec programInsertionProc @program_name = 'celeb gist', @start_time = '22:30:00' ,@end_time='00:00:00', @duration= 180, @station_id= 2, @producer_id = 2
exec programInsertionProc @program_name = 'gossip time', @start_time = '9:30:00' ,@end_time='10:00:00', @duration= 30, @station_id= 2, @producer_id = 1
exec programInsertionProc @program_name = 'ghana today', @start_time = '11:30:00' ,@end_time='12:00:00', @duration= 30, @station_id= 3, @producer_id = 3
exec programInsertionProc @program_name = 'the world now', @start_time = '12:00:00' ,@end_time='12:30:00', @duration= 30, @station_id= 3, @producer_id = 3
exec programInsertionProc @program_name = 'international news', @start_time = '12:30:00' ,@end_time='13:00:00', @duration= 30, @station_id= 3, @producer_id = 3
exec programInsertionProc @program_name = 'accra news', @start_time = '12:00:00' ,@end_time='12:30:00', @duration= 30, @station_id= 1, @producer_id = 1
exec programInsertionProc @program_name = 'tinsel town highlights ', @start_time = '12:30:00' ,@end_time='13:00:00', @duration= 30, @station_id= 1, @producer_id = 1

-----------------------------------------documentary---------------------------------------------
exec programInsertionProc @program_name = 'ghana history', @start_time='13:00:00' ,@end_time='14:00:00', @duration= 60, @station_id= 4, @producer_id = 4
exec programInsertionProc @program_name = 'west africa: a colonial history', @start_time = '11:00:00' ,@end_time='13:00', @duration= 120, @station_id= 4, @producer_id = 4
exec programInsertionProc @program_name = 'jollof rice', @start_time = '9:00' ,@end_time='10:30', @duration= 150, @station_id= 4, @producer_id = 4
exec programInsertionProc @program_name = 'nigeria in west africa', @start_time = '13:00:00' ,@end_time='15:00:00', @duration= 180, @station_id= 4, @producer_id = 4
exec programInsertionProc @program_name = 'ashante gold', @start_time = '12:00:00' ,@end_time='13:00:00', @duration= 60, @station_id= 5, @producer_id = 5
exec programInsertionProc @program_name = 'mining in ghana', @start_time = '13:00:00' ,@end_time='18:00:00', @duration= 150, @station_id= 5, @producer_id = 5
exec programInsertionProc @program_name = 'minerals in ghana', @start_time = '18:00:00' ,@end_time='19:00:00', @duration= 60, @station_id= 5, @producer_id = 5
exec programInsertionProc @program_name = 'kente making', @start_time = '8:00:00' ,@end_time='8:30:00', @duration= 30, @station_id= 4, @producer_id = 6
exec programInsertionProc @program_name = 'ghana and fashion design', @start_time = '13:00:00' ,@end_time='14:00:00', @duration= 40, @station_id= 4, @producer_id = 6
exec programInsertionProc @program_name = 'clothing in ghana', @start_time = '9:00:00' ,@end_time='13:00:00', @duration= 30, @station_id= 5, @producer_id = 6
exec programInsertionProc @program_name = 'textiles and the future of ghana', @start_time = '12:00:00' ,@end_time='12:30:00', @duration= 30, @station_id=5, @producer_id = 6
exec programInsertionProc @program_name = 'cocoa farming', @start_time = '7:00:00' ,@end_time='10:00:00', @duration= 30, @station_id= 4, @producer_id = 7
exec programInsertionProc @program_name = 'chocolate for ghana', @start_time = '19:00:00' ,@end_time='21:00:00', @duration= 30, @station_id= 5, @producer_id = 7
exec programInsertionProc @program_name = 'switzerland and ghanaian cocoa', @start_time = '10:30:00' ,@end_time='11:00:00', @duration= 30, @station_id= 4, @producer_id = 7
exec programInsertionProc @program_name = 'choco choco', @start_time = '11:00:00' ,@end_time='12:30:00', @duration= 30, @station_id= 5, @producer_id = 7

----------------------------------movie------------------------------
exec programInsertionProc @program_name = '12 years a slave', @start_time = '13:00:00' ,@end_time='14:30:00', @duration= 150, @station_id= 1, @producer_id = 1
exec programInsertionProc @program_name = 'black panther', @start_time = '11:00:00' ,@end_time='12:00:00', @duration= 150, @station_id= 1, @producer_id = 1
exec programInsertionProc @program_name = 'hotel rwanda', @start_time = '14:00:00' ,@end_time='15:00:00', @duration= 150, @station_id= 1, @producer_id = 1
exec programInsertionProc @program_name = 'ma raineys black bottom', @start_time = '13:00:00' ,@end_time='15:00', @duration= 150, @station_id= 1, @producer_id = 1
exec programInsertionProc @program_name = 'dream girls', @start_time = '6:00:00' ,@end_time='9:00:00', @duration= 150, @station_id= 2, @producer_id = 2
exec programInsertionProc @program_name = 'obssessed', @start_time = '' ,@end_time='', @duration= 250, @station_id= 2, @producer_id = 2
exec programInsertionProc @program_name = 'ant man and the wasp', @start_time = '' ,@end_time='', @duration= 150, @station_id= 2, @producer_id = 2
exec programInsertionProc @program_name = 'antman ', @start_time = '9:00:00' ,@end_time='12:00:00', @duration= 150, @station_id= 2, @producer_id = 2
exec programInsertionProc @program_name = 'thor: love and thunder', @start_time = '14:00:00' ,@end_time='15:00:00', @duration= 150, @station_id= 4, @producer_id = 4
exec programInsertionProc @program_name = 'thor: the dark world', @start_time = '12:00:00' ,@end_time='15:00:00', @duration= 150, @station_id= 4, @producer_id = 4
exec programInsertionProc @program_name = 'spiderman: homecoming', @start_time = '2:00:00' ,@end_time='5:00:00', @duration= 150, @station_id= 5, @producer_id = 6
exec programInsertionProc @program_name = 'spiderman: far from home', @start_time = '3:00:00' ,@end_time='6:00:00', @duration= 150, @station_id= 5, @producer_id = 6
exec programInsertionProc @program_name = 'spiderman 1', @start_time = '12:00:00' ,@end_time='14:00:00', @duration= 150, @station_id= 4, @producer_id = 4
exec programInsertionProc @program_name = 'the wedding party', @start_time = '10:00:00' ,@end_time='11:00:00', @duration= 150, @station_id= 5, @producer_id = 4
exec programInsertionProc @program_name = 'omo ghetto', @start_time = '14:00:00' ,@end_time='15:00:00', @duration= 150, @station_id= 3, @producer_id = 3



go


----------------------------------------schedule--------------------------------------------------------------


create procedure scheduleInsertionProc
		@program_id int,
		@day_aired varchar(9), 
		@month_aired varchar(9)
as 
begin

	set NOCOUNT ON;
	insert into schedule values (@program_id,@day_aired, @month_aired)

	--set @numrows = @@ROWCOUNT;
end

go
exec scheduleInsertionProc @program_id =1, @day_aired = 'wednesday', @month_aired = 'january'
exec scheduleInsertionProc @program_id =2, @day_aired = 'monday', @month_aired = 'febuary'
exec scheduleInsertionProc @program_id =1, @day_aired = 'tuesday', @month_aired = 'febuary'
exec scheduleInsertionProc @program_id =2, @day_aired = 'wednesday', @month_aired = 'january'
exec scheduleInsertionProc @program_id =3, @day_aired = 'wednesday', @month_aired = 'march'


go



-----------------------------------------------------movie------------------------------------------------------

create procedure movieInsertionProc
		@movie_id int,
		@director varchar(50),
		@year_release smallint,
		@production_company varchar(50)
as 
begin

	set NOCOUNT ON;
	insert into movie values (@movie_id, @director,@year_release, @production_company)

	--set @numrows = @@ROWCOUNT;
end

go
exec movieInsertionProc @movie_id= 26, @director= 'steve mcqueen', @year_release = '2012', @production_company= 'orange house'
exec movieInsertionProc @movie_id= 27, @director= 'ryan coogler', @year_release = '2019', @production_company= 'apple house'
exec movieInsertionProc @movie_id= 28, @director= 'terry george', @year_release = '2012', @production_company= 'sony pictures'
exec movieInsertionProc @movie_id= 29, @director= 'george c wolfe', @year_release = '2013', @production_company= 'orange house'
exec movieInsertionProc @movie_id= 30, @director= 'adam smith', @year_release = '2014', @production_company= 'orange house'
exec movieInsertionProc @movie_id= 31, @director= 'great gerwig', @year_release = '2011', @production_company= 'orange house'
exec movieInsertionProc @movie_id= 32, @director= 'edna cooke', @year_release = '2011', @production_company= 'orange house'
exec movieInsertionProc @movie_id= 33, @director= 'jane austen', @year_release = '2012', @production_company= 'orange house'
exec movieInsertionProc @movie_id= 34, @director= 'louis windsor', @year_release = '2013', @production_company= 'orange house'
exec movieInsertionProc @movie_id= 35, @director= 'nellie king', @year_release = '2014', @production_company= 'orange house'






go

---------------------------------news--------------------------------------------
create procedure newsInsertionProc
		@news_id int,
		@numOfPresenters int, 
		@streaming_resolution int
as 
begin

	set NOCOUNT ON;
	insert into news values (@news_id,@numOfPresenters, @streaming_resolution)

	--set @numrows = @@ROWCOUNT;
end

go
exec newsInsertionProc @news_id =1, @numOfPresenters = 2, @streaming_resolution= 1080
exec newsInsertionProc @news_id =2, @numOfPresenters = 1, @streaming_resolution= 1080
exec newsInsertionProc @news_id =3, @numOfPresenters =3, @streaming_resolution= 1080
exec newsInsertionProc @news_id =4, @numOfPresenters = 2, @streaming_resolution= 1080
exec newsInsertionProc @news_id =5, @numOfPresenters = 4, @streaming_resolution= 1080
exec newsInsertionProc @news_id =6, @numOfPresenters = 5, @streaming_resolution= 1080
exec newsInsertionProc @news_id =7, @numOfPresenters = 3, @streaming_resolution= 1080
exec newsInsertionProc @news_id =8, @numOfPresenters = 4, @streaming_resolution= 1080
exec newsInsertionProc @news_id =9, @numOfPresenters = 1, @streaming_resolution= 1080
exec newsInsertionProc @news_id =10, @numOfPresenters = 2, @streaming_resolution= 1080



go


-----------------------------------presenter----------------------------------------


create procedure presenterInsertionProc
		@presenter_id int,
		@news_id int, 
		@salary money,
		@email varchar(30)
as 
begin

	set NOCOUNT ON;
	insert into presenter values (@presenter_id,@news_id, @salary, @email)

	--set @numrows = @@ROWCOUNT;
end

go
exec presenterInsertionProc @presenter_id = 11, @news_id= 1, @salary = 1000,  @email= 'eyramhaatso@gmail.com'
exec presenterInsertionProc @presenter_id = 12, @news_id= 2, @salary = 1000,  @email= 'julietangela@gmail.com'
exec presenterInsertionProc @presenter_id = 13, @news_id= 3, @salary = 1000,  @email= 'andoh@gmail.com'
exec presenterInsertionProc @presenter_id = 14, @news_id= 4, @salary = 1000,  @email= 'isabellaowusi@gmail.com'
exec presenterInsertionProc @presenter_id = 15, @news_id= 5, @salary = 1000,  @email= 'flucky@gmail.com'
exec presenterInsertionProc @presenter_id = 16, @news_id= 6, @salary = 1000,  @email= 'jbleboo@gmail.com'
exec presenterInsertionProc @presenter_id = 17, @news_id= 7, @salary = 1000,  @email= 'vpels@gmail.com'
exec presenterInsertionProc @presenter_id = 18, @news_id= 8, @salary = 1000,  @email= 'nklugan@gmail.com'
exec presenterInsertionProc @presenter_id = 19, @news_id= 9, @salary = 1000,  @email= 'jkane@gmail.com'
exec presenterInsertionProc @presenter_id = 20, @news_id= 10, @salary = 1000,  @email= 'aansah@gmail.com'



go


-------------------------------documentary---------------------------------------------------
create procedure documentaryInsertionProc
		@documentary_id int,
		@presenter_id int, 
		@subject_matter varchar(50),
		@summary varchar(500)

as 
begin

	set NOCOUNT ON;
	insert into documentary values (@documentary_id,@presenter_id, @subject_matter, @summary)

	--set @numrows = @@ROWCOUNT;
end

go
exec documentaryInsertionProc @documentary_id =11, @presenter_id = 11, @subject_matter ='history', @summary ='a history of ghana'
exec documentaryInsertionProc @documentary_id =12, @presenter_id = 12, @subject_matter ='history', @summary ='a history of the colonial history of west africa '
exec documentaryInsertionProc @documentary_id =13, @presenter_id = 13, @subject_matter ='food', @summary ='the origins of jollof rice'
exec documentaryInsertionProc @documentary_id =14, @presenter_id = 12, @subject_matter ='nigeria', @summary ='a history of nigeria'
exec documentaryInsertionProc @documentary_id =15, @presenter_id = 13, @subject_matter ='gold', @summary ='a deep dive into ashanti gold'
exec documentaryInsertionProc @documentary_id =16, @presenter_id = 15, @subject_matter ='mineral resources', @summary ='talks about minning in ghana'
exec documentaryInsertionProc @documentary_id =17, @presenter_id = 16, @subject_matter ='mineral resources', @summary ='talsk about minerals in ghana'
exec documentaryInsertionProc @documentary_id =18, @presenter_id = 17, @subject_matter ='textiles', @summary ='talking about kengte making in ghana'
exec documentaryInsertionProc @documentary_id =19, @presenter_id = 12, @subject_matter ='fashion', @summary ='talks about fashion design in ghana'
exec documentaryInsertionProc @documentary_id =20, @presenter_id = 11, @subject_matter ='textiles', @summary ='talks about clothing in ghana'

go


-----------------------------------------------------------program_ad---------------------------------------------

create procedure programAdInsertionProc
		@program_id int,
		@advert_id int, 
		@durationOfAd smallint, 
		@numTimesRunPerDay tinyint
as 
begin

	set NOCOUNT ON;
	insert into program_ad values (@program_id,@advert_id, @durationOfAd, @numTimesRunPerDay)

	--set @numrows = @@ROWCOUNT;
end

go
exec programAdInsertionProc @program_id =1,@advert_id = 1, @durationOfAd = 30 , @numTimesRunPerDay = 5
exec programAdInsertionProc @program_id =3,@advert_id = 2, @durationOfAd = 30 , @numTimesRunPerDay = 10
exec programAdInsertionProc @program_id =2,@advert_id = 3, @durationOfAd = 30 , @numTimesRunPerDay = 6
exec programAdInsertionProc @program_id =4,@advert_id = 2, @durationOfAd = 30 , @numTimesRunPerDay = 8
exec programAdInsertionProc @program_id =4,@advert_id = 4, @durationOfAd = 30 , @numTimesRunPerDay = 9
exec programAdInsertionProc @program_id =5,@advert_id = 4, @durationOfAd = 30 , @numTimesRunPerDay = 10
exec programAdInsertionProc @program_id =6,@advert_id = 5, @durationOfAd = 30 , @numTimesRunPerDay = 20
exec programAdInsertionProc @program_id =8,@advert_id = 5, @durationOfAd = 30 , @numTimesRunPerDay = 2
exec programAdInsertionProc @program_id =6,@advert_id = 2, @durationOfAd = 30 , @numTimesRunPerDay = 4
exec programAdInsertionProc @program_id =1,@advert_id = 1, @durationOfAd = 30 , @numTimesRunPerDay = 4



go


----------------------------------------------------telephone-------------------------------------------
create procedure telephoneInsertionProc
		@person_id int,
		@telephone_number varchar(15), 
		@network varchar(10)
as 
begin

	set NOCOUNT ON;
	insert into telephone values (@person_id ,@telephone_number , @network)

	--set @numrows = @@ROWCOUNT;
end

go
exec telephoneInsertionProc @person_id = 1,  @telephone_number='0765765098', @network='mtn'
exec telephoneInsertionProc @person_id = 1,  @telephone_number='0565768566', @network='vodafone'
exec telephoneInsertionProc @person_id = 2,  @telephone_number='0735755097', @network='mtn'
exec telephoneInsertionProc @person_id = 2,  @telephone_number='0765576384', @network='airtel'
exec telephoneInsertionProc @person_id = 3,  @telephone_number='0788736334', @network='mtn'
exec telephoneInsertionProc @person_id = 3,  @telephone_number='+2334569843', @network='airtel'
exec telephoneInsertionProc @person_id = 6,  @telephone_number='0765768902', @network='mtn'
exec telephoneInsertionProc @person_id = 6,  @telephone_number='0734565098', @network='vodafone'
exec telephoneInsertionProc @person_id = 7,  @telephone_number='0750989840', @network='mtn'
exec telephoneInsertionProc @person_id = 7,  @telephone_number='07657984025', @network='airtel'



go




------------------------------------------------------------------------------------------
									 ----functional queries-----
------------------------------------------------------------------------------------------


---a stored procedure to generate the personal data of the presenters that work in the industry
---could be used for sending mass emails to presenters
create procedure personPresenter
as
begin
	set nocount on;
		select p.fname, p.lname, pre.email
		from person as p
		inner join presenter as pre
		on p.person_id = pre.presenter_id
		order by p.person_id asc;
	
end
go  

exec personPresenter; 
----------------------------------------------
--------------------------------------------------
go 

--- a query that selects information about the sponsor of an ad as well as ads run all ministries in ghana
---could be used to estimate the amount of funding used in ghana for ads by government isntitutions
create procedure sponsorAdvert
as
begin
	set nocount on;
		select s.sponsor_name, s.sponsor_type, ad.advert_type
		from sponsors as s
		full outer join advertisements as ad
		on s.sponsor_id = ad.sponsor_id
		where s.sponsor_name like 'ministry %';
	
end
go  

exec sponsorAdvert;

-----------------------------------------
-----------------------------------------

-----a query that selects the number of stations as and the count of the programs they air
go
create procedure stationProgramCount
as
begin
	set nocount on;
		select pro.program_name,pro.end_time, pro.start_time, st.station_name, count(*) TotalPrograms
		from program as pro, television_station as st
		where pro.station_id = st.station_id
		group by pro.program_name,pro.end_time, pro.start_time, st.station_name
		order by TotalPrograms desc;
	
	
end
go  

exec stationProgramCount; 



-------------------------------
----------------------------------
go
------a query that computes the advertisements cost incurred by sponsors of ads

create procedure advertisementCosts
as
begin
	set nocount on;
		select s.sponsor_name, s.sponsor_type, ad.advert_cost, ad.advert_type, sum(ad.advert_cost) as CostIncurredByCompany
		from sponsors as s, advertisements as ad
		where s.sponsor_id = ad.sponsor_id
		group by s.sponsor_name, s.sponsor_type, ad.advert_cost, ad.advert_type
		order by s.sponsor_name, s.sponsor_type, ad.advert_cost, ad.advert_type;
	
	
end
go  

exec advertisementCosts; 



---------------------------------
----------------------------------
go

---------a query that selects the airing times of documentaries 
create procedure documentaryWithSetTimesForAiring
as
begin
	set nocount on;
		select p.program_name, p.duration, d.summary, d.subject_matter
		from program as p, documentary as d
		where p.program_id = d.documentary_id AND p.duration IS NOT NULL;

		
	
end
go  

exec documentaryWithSetTimesForAiring;


------a query that generates the news airing times 
go
create procedure newsAiringTimes
as
begin
	set nocount on;
		SELECT p.program_name, p.duration, p.start_time, p.end_time
			FROM program as p
			WHERE p.program_id =
				(SELECT n.news_id
				 FROM news as n
				 where n.news_id =1 );
		
	
end
go  

exec newsAiringTimes;

go 


----------------------------------------
----------------------------------------

---------a query that calculates adverts costs that is greater than 200ghc
go

create procedure advertisementCTE
as
begin
	set nocount on;
		with myAdvertCost(advert_id, advert_cost, advert_type) as
		(select advert_id, advert_cost, advert_type from advertisements where
		advert_cost >2000)

		select advert_id, (advert_cost) as TotalAdvertCost, advert_type
		from myAdvertCost;
	
end


exec advertisementCTE;
go














