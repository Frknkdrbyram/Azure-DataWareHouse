--CREATE station_dim TABLE

IF OBJECT_ID('DBO.station_dim') IS NOT NULL BEGIN DROP EXTERNAL TABLE DBO.station_dim;

END CREATE EXTERNAL TABLE [DBO].[station_dim] WITH (

    LOCATION = 'Star_Schema/station_dim.csv' ,
    DATA_SOURCE = [mydatawarehousecontainer_mydatawarehousestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        station_id,
	    name,
        latitude,
        longitude

    FROM 
        dbo.staging_station

) ;

GO

SELECT *

FROM 
    [DBO].[station_dim]