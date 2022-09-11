# 1st Solution
create or replace table `astrafydemo.bitcoincash.staging` as (
  SELECT *
    FROM `bigquery-public-data.crypto_bitcoin_cash.transactions`
    WHERE block_timestamp_month > DATE_ADD(CURRENT_DATE(), INTERVAL -3 MONTH)
)

# 2nd Solution
create or replace table `astrafydemo.bitcoincash.datamart` as (
  WITH transaction_book AS (
    -- debits
    SELECT
      ARRAY_TO_STRING(inputs.addresses, ",") AS address
    ,  inputs.type
    ,  block_timestamp
    , -inputs.value AS value
    , is_coinbase
    FROM `astrafydemo.bitcoincash.staging` JOIN UNNEST(inputs) AS inputs

    UNION ALL

    -- credits
    SELECT
      ARRAY_TO_STRING(outputs.addresses, ",") AS address
    , outputs.type
    ,  block_timestamp
    , outputs.value AS value
    , is_coinbase
    FROM `astrafydemo.bitcoincash.staging` JOIN UNNEST(outputs) AS outputs
  )
 SELECT
  address
, type
, MAX(block_timestamp) AS block_date
, COUNT(*) AS tx_count
, SUM(value) AS balance
 FROM transaction_book
 GROUP BY 1, 2
 HAVING SUM(CASE WHEN is_coinbase THEN 1 ELSE 0 END) = 0
)
