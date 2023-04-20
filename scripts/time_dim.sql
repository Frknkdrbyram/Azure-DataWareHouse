--Create time_dim table

CREATE TABLE time_dim (
    time_id int,
    date datetime,
    day_of_week int,
    day_of_month int,
    week_of_year int,
    quarter int,
    month int,
    year int
)
DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = (SELECT MIN(TRY_CONVERT(datetime, left(start_at, 19))) FROM staging_trip)
SET @EndDate = DATEADD(year, 5, (SELECT MAX(TRY_CONVERT(datetime, left(start_at, 19))) FROM staging_trip))

WHILE @StartDate <= @EndDate
      BEGIN
             INSERT INTO [time_dim]
             SELECT
                   @StartDate,
                   DATEPART(WEEKDAY, @StartDate),
                   DATEPART(DAY, @StartDate),
                   DATEPART(WEEK, @StartDate),
                   DATEPART(QUARTER, @StartDate),
                   DATEPART(MONTH, @StartDate),
                   DATEPART(YEAR, @StartDate)

             SET @StartDate = DATEADD(dd, 1, @StartDate)
      END