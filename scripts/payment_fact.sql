--CREATE payment_fact TABLE

IF OBJECT_ID('DBO.payment_fact') IS NOT NULL BEGIN DROP EXTERNAL TABLE DBO.payment_fact;

END CREATE EXTERNAL TABLE [DBO].[payment_fact] WITH (

    LOCATION = 'Star_Schema/payment_fact.csv' ,
    DATA_SOURCE = [mydatawarehousecontainer_mydatawarehousestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        payment_id,
	     payment_date,
        amount,
        rider_id

    FROM 
        dbo.staging_payment

) ;

GO

SELECT *

FROM 
    [DBO].[payment_fact]