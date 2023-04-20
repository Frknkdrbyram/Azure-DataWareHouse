--CREATE trip_fact TABLE

IF OBJECT_ID('DBO.trip_fact') IS NOT NULL BEGIN DROP EXTERNAL TABLE DBO.trip_fact;

END CREATE EXTERNAL TABLE [DBO].[trip_fact] WITH (

    LOCATION = 'Star_Schema/trip_fact.csv' ,
    DATA_SOURCE = [mydatawarehousecontainer_mydatawarehousestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
       st.trip_id,
       st.rider_id,
       st.rideable_type,
       st.start_at,
       st.end_at,
       st.start_station_id,
       st.end_station_id,
       DATEDIFF(MINUTE, st.start_at, st.end_at) AS duration
       (DATEDIFF(year, sr.birthday,
    CONVERT(Datetime, SUBSTRING([start_at], 1, 19),120)) - (
        CASE WHEN MONTH(sr.birthday) > MONTH(CONVERT(Datetime, SUBSTRING([start_at], 1, 19),120))
        OR MONTH(sr.birthday) =
            MONTH(CONVERT(Datetime, SUBSTRING([start_at], 1, 19),120))
        AND DAY(sr.birthday) >
            DAY(CONVERT(Datetime, SUBSTRING([start_at], 1, 19),120))
        THEN 1 ELSE 0 END
    )) AS rider_age
    FROM 
        dbo.staging_trip AS st
        JOIN dbo.staging_rider As sr ON st.rider_id = sr.rider_id

) ;

GO

SELECT *

FROM 
    [DBO].[trip_fact]