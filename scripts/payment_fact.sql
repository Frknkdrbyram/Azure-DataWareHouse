CREATE EXTERNAL TABLE [DBO].[payment_fact] WITH (

    LOCATION = 'Star_Schema/payment_fact',
    DATA_SOURCE = [AzureStorage],
    FILE_FORMAT = [TextFileFormat]
 )AS(
    SELECT
    payment_id,
    time_id
    


 )
