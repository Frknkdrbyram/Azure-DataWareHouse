--CREATE rider_dim TABLE

IF OBJECT_ID('DBO.rider_dim') IS NOT NULL BEGIN DROP EXTERNAL TABLE DBO.rider_dim;

END CREATE EXTERNAL TABLE [DBO].[rider_dim] WITH (

    LOCATION = 'Star_Schema/rider_dim.csv' ,
    DATA_SOURCE = [mydatawarehousecontainer_mydatawarehousestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        rider_id,
	    first_name AS first,
        last_name AS last,
        address,
        birthday,
        account_start_date,
        account_end_date,
        is_Member

    FROM 
        dbo.staging_rider

) ;

GO

SELECT *

FROM 
    [DBO].[rider_dim]