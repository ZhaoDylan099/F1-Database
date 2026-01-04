-- Create Tables in F1Database
use F1Database;
Create table Team (
	tID int identity(1,1),
	name varchar(255) not null,
	fullname varchar(255) not null,
	country varchar(255) not null,
	engine varchar(255) not null,
	primary key (tID)
);

Create table Driver (
	dID int identity(1,1),
	tID int not null,
	fname varchar(255) not null,
	lname varchar(255) not null,
	dob date not null,
	nationality varchar(255) not null,
	carNum int not null,
	primary key (dID),
	foreign key (tID) references Team
);

Create table Circuit (
	cID int identity(1,1),
	name varchar(255) not null,
	country varchar(255) not null,
	city varchar(255) not null,
	length decimal (8,2) not null,
	primary key (cID)
);


Create table Race (
	rID int identity(1,1),
	cID int not null,
	season int not null,
	round int not null,
	date date not null
	primary key (rID)
);

Create table DriverRace (
	dID int,
	rID int,
	primary key (dID, rID),
	foreign key (dID) references Driver,
	foreign key (rID) references Race
);

Create table Result (
	resultID int identity(1,1),
	rID int,
	dID int,
	position int not null,
	points int not null,
	status varchar(8),
	time int,
	primary key (resultID),
	foreign key (rID) references Race,
	foreign key (dID) references Driver,
	check (status in ('finished','DNF','DNS', 'DSQ')),
);

Create table cChampionship(
	cChampID int identity(1,1),
	tID int not null,
	season int not null,
	points int not null,
	position int not null,
	primary key (cChampID),
	foreign key (tID) references Team
);

Create table dChampionship (
	dChampID int identity(1,1),
	dID int not null,
	season int not null,
	points int not null,
	position int not null,
	primary key (dChampID),
	foreign key (dID) references Driver,
);

Create table LapTime (
	lID int identity(1,1),
	rID int not null,
	dID int not null,
	lap int not null,
	time int,
	primary key (lID),
	foreign key (rID) references Race,
	foreign key (dID) references Driver
);

-- Creation of Non-Clustered Index for Driver

create nonclustered index driverLnameIndex on Driver (lname);

-- Stored Procedures
go
create procedure insertNewTeamNDS -- Insert New Team (NDS) - Dylan Zhao
@name as varchar(255),
@fullname as varchar(255),
@country as varchar(255),
@engine as varchar(255),
@fname1 as varchar(255),
@lname1 as varchar(255),
@dob1 as date,
@nationality1 as varchar(255),
@carNum1 as int,
@fname2 as varchar(255),
@lname2 as varchar(255),
@dob2 as date,
@nationality2 as varchar(255),
@carNum2 as int,
@tID as int output,
@dID1 as int output,
@dID2 as int output
as 
begin
insert into Team (name, fullname, country, engine)
values
	(@name, @fullname, @country, @engine)

select @tID = tID from Team 
where name = @name and fullname = @fullname and country = @country and engine = @engine

insert into Driver (tID, fname, lname, dob, nationality, carNum)
values
	(@tID, @fname1, @lname1, @dob1, @nationality1, @carNum1)

insert into Driver (tID, fname, lname, dob, nationality, carNum)
values
	(@tID, @fname2, @lname2, @dob2, @nationality2, @carNum2)

select @dID1 = dID from Driver
where tID = @tID and fname = @fname1 and lname = @lname1 and dob = @dob1

select @dID2 = dID from Driver
where tID = @tID and fname = @fname2 and lname = @lname2 and dob = @dob2

end;

go


create procedure CancelRace -- Cancel Race - Dylan Zhao
	@season as int,
	@round as int,
	@date as date,
	@ResChange as int output,
	@RacChange as int output
as 
begin
delete from Result
where rID in 
	(select rID from Race 
	where season = @season and round = @round and date = @date)
select @ResChange = @@rowcount

delete from Race
where rID in (select rID from Race 
	where season = @season and round = @round and date = @date)
select @RacChange = @@rowcount
end;

go

create procedure insertDriver -- Atharva Insert Driver
  @tname varchar(255),
  @fname varchar(255),
  @lname varchar(255),
  @dob date,
  @nationality varchar(255),
  @carNum int,
  @dID int output
as
begin

  if exists (
    select 1
  from driver
  where carNum = @carNum
  )
  begin
    RAISERROR('Cannnot insert: driver number already exists', 16, 1);
    return;
  end

  insert into dbo.Driver
    (tID, fname, lname, dob, nationality, carNum)
  values
    ((
      select tID
      from dbo.Team
      where name = @tname
    ),
      @fname, @lname, @dob, @nationality, @carNum);

  select @dID = SCOPE_Identity();
--insertion logic
end;

go

--use case 5: enter race result
USE F1Database;
GO

IF OBJECT_ID('dbo.enterRaceResults','P') IS NOT NULL  
    DROP PROCEDURE dbo.enterRaceResults;
GO



USE F1Database;

GO


IF OBJECT_ID('dbo.enterRaceResults','P') IS NOT NULL  

    DROP PROCEDURE dbo.enterRaceResults;

GO


CREATE PROCEDURE dbo.enterRaceResults

  @cname     VARCHAR(255),

  @fname     VARCHAR(255),

  @lname     VARCHAR(255),

  @carNum    INT,

  @position  INT,

  @points    INT,

  @status    VARCHAR(8),

  @time      INT,

  @date      DATE,

  @resultID  INT OUTPUT

AS

BEGIN

  SET NOCOUNT ON;


  DECLARE @dID INT, @rID INT;


  -- 1) Find the driver

  SELECT @dID = dID

  FROM dbo.Driver

  WHERE fname  = @fname

    AND lname  = @lname

    AND carNum = @carNum;


  IF @dID IS NULL

    BEGIN

    RAISERROR('Driver not found: %s %s (#%d)', 16, 1,

                  @fname, @lname, @carNum);

    RETURN;

  END


  -- 2) Find the race

  SELECT @rID = rID

  FROM dbo.Race

  WHERE cID   = (

               SELECT cID

    FROM dbo.Circuit

    WHERE name = @cname

             )

    AND [date] = @date;

  -- bracketed because DATE is a keyword


  IF @rID IS NULL

    BEGIN

    DECLARE @errMsg NVARCHAR(255) =

            N'Race on ' + CONVERT(CHAR(10), @date, 23)

          + N' at circuit ' + @cname + N' not found.';

    RAISERROR(@errMsg, 16, 1);

    RETURN;

  END


  -- 3) Prevent duplicate result entries

  IF EXISTS (

        SELECT 1

  FROM dbo.Result

  WHERE rID = @rID

    AND dID = @dID

    )

    BEGIN

    RAISERROR('Result already exists for this driver/race.', 16, 1);

    RETURN;

  END


  -- 4) Insert the new result

  INSERT INTO dbo.Result

    (rID, dID, position, points, status, [time])

  VALUES

    (@rID, @dID, @position, @points, @status, @time);


  -- 5) Return the new identity

  SET @resultID = SCOPE_IDENTITY();


  --6 update the dChampionship table

  UPDATE dbo.dChampionship

    SET points = points + @points

  WHERE dID = @dID;

  RETURN;


  --7 update the cChampionship table

  UPDATE dbo.cChampionship

    SET points = points + @points

  WHERE tID = (

    SELECT tID

  FROM dbo.Driver

  WHERE dID = @dID

  );

  RETURN;


END;

go
create or alter procedure AwardFastestLap -- Sean Award Fastest Lap Time
@rID int,
@tID int output,
@dID int output,
@season int output
as
begin

select top 1 @dID = Laptime.dID
from Laptime
where Laptime.rID = @rID
order by Laptime.time ASC

select @tID = Driver.tID
from Driver
where Driver.dID = @dID

select @season = Race.season
from Race
where Race.rID = @rID

update dChampionship
set dChampionship.points = dChampionship.points+1
from dChampionship
where dChampionship.dID = @dID and dChampionship.season = @season

update cChampionship
set cChampionship.points = cChampionship.points+1
from cChampionship
where cChampionship.tID = @tID and cChampionship.season = @season

end;

go

create or alter procedure AdjustResultDSQ -- Sean Adjust Results for Disqualifcation
@dID int,
@tID int output,
@rID int,
@season int output,
@OGposition int output
as
begin
select @OGposition = Result.position
from Result
where Result.dID = @dID and Result.rID = @rID

select @season = Race.season
from Race
where Race.rID = @rID

select @tID = Driver.tID
from Driver
where Driver.dID = @dID

update Result
set Result.status = 'DSQ', Result.position = 21
from Result
where Result.dID = @dID and Result.rID = @rID
end;

go

create or alter procedure FixFirstDSQ -- Sean Adjust Results for Disqualifcation
@points int,
@season int,
@dID int,
@tID int
as
begin
update dChampionship
set dChampionship.points = dChampionship.points - @points
from dChampionship
where dChampionship.dID = @dID and dChampionship.season = @season

update cChampionship
set cChampionship.points = cChampionship.points - @points
from cChampionship
where cChampionship.tID = @tID and cChampionship.season = @season
end;

go

create or alter procedure FixResultDSQ --Sean Adjust Results for Disqualifcation
@rID int,
@season int,
@position int,
@oldPoints int,
@newPoints int,
@tID int,
@dID int
as
begin
select @dID = Result.dID
from Result
where Result.rID = @rID and Result.position = @position

select @tID = Driver.tID
from Driver
where Driver.dID = @dID

update dChampionship
set dChampionship.points = dChampionship.points - @oldPoints + @newPoints
from dChampionship
where dChampionship.dID = @dID and dChampionship.season = @season

update cChampionship
set cChampionship.points = cChampionship.points - @oldPoints + @newPoints
from cChampionship
where cChampionship.tID = @tID and cChampionship.season = @season

update Result
set Result.position = @position - 1, Result.points = @newPoints
from Result
where Result.dID = @dID and Result.rID = @rID
end;


go

-- Create a New User and Grant Permissions

create login F1user
with password = '25F1Data!@#11';

use F1Database;
create user F1user for login F1user;

alter role db_owner add member F1user;
