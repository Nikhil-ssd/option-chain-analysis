#CREATE DATABASE IF NOT EXISTS nse_option_chain;
USE nse_option_chain;

/*CREATE TABLE IF NOT EXISTS option_chain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expiry_date DATE,  -- Added Expiry Date
    CE_OI INT,
    CE_Change_OI INT,
    CE_IV FLOAT,
    CE_LTP FLOAT,
    CE_Volume INT,
    Strike_Price INT,
    PE_LTP FLOAT,
    PE_IV FLOAT,
    PE_OI INT,
    PE_Change_OI INT,
    PE_Volume INT,
    UNIQUE KEY (timestamp, expiry_date, Strike_Price)  -- Ensuring uniqueness per expiry
)*/

SELECT * FROM option_chain;

# Liquidity Analysis: Most Actively Traded Options

SELECT expiry_date, strike_price, 
       SUM(CE_Volume + PE_Volume) AS total_volume
FROM option_chain
GROUP BY expiry_date, strike_price
ORDER BY total_volume DESC
LIMIT 10;
# Find the most actively traded strike prices based on volume.


# Open Interest Change Over Time

SELECT expiry_date, strike_price, timestamp, 
       CE_OI, LAG(CE_OI) OVER (PARTITION BY expiry_date, strike_price ORDER BY timestamp) AS prev_CE_OI,
       (CE_OI - LAG(CE_OI) OVER (PARTITION BY expiry_date, strike_price ORDER BY timestamp)) AS CE_OI_Change,
       PE_OI, LAG(PE_OI) OVER (PARTITION BY expiry_date, strike_price ORDER BY timestamp) AS prev_PE_OI,
       (PE_OI - LAG(PE_OI) OVER (PARTITION BY expiry_date, strike_price ORDER BY timestamp)) AS PE_OI_Change
FROM option_chain;
# Identify trends in Open Interest to see where new positions are building up.

# Identifying Unusual Option Activity (High IV & Volume)

SELECT expiry_date, strike_price, 
       CE_IV, PE_IV, CE_Volume, PE_Volume
FROM option_chain
WHERE CE_IV > 50 OR PE_IV > 50 -- High implied volatility
ORDER BY CE_Volume + PE_Volume DESC
LIMIT 10;
# Find contracts with high implied volatility and volume, indicating potential big moves.

# Fetch Options with the Tightest Bid-Ask Spread (Liquidity Check)

SELECT expiry_date, strike_price, 
       (PE_LTP - CE_LTP) AS bid_ask_spread
FROM option_chain
WHERE CE_LTP > 0 AND PE_LTP > 0
ORDER BY bid_ask_spread ASC
LIMIT 10;
# Find contracts with low bid-ask spreads for efficient execution.

# Finding the Most Liquid Expiry Date

SELECT expiry_date, SUM(CE_Volume + PE_Volume) AS total_traded_volume
FROM option_chain
GROUP BY expiry_date
ORDER BY total_traded_volume DESC
LIMIT 1;
# Find the expiry date with the highest liquidity.


# Finding the Max Pain Strike Price

WITH open_interest AS (
    SELECT strike_price,
           SUM(CE_OI) AS total_CE_OI,
           SUM(PE_OI) AS total_PE_OI
    FROM option_chain
    GROUP BY strike_price
)
SELECT strike_price,
       (total_CE_OI + total_PE_OI) AS total_OI
FROM open_interest
ORDER BY total_OI DESC
LIMIT 1;
# This finds the strike price with the highest total Open Interest, indicating the Max Pain level.

# Identifying the At-the-Money (ATM) Strike Price

WITH ranked_strikes AS (
    SELECT strike_price,
           ABS(strike_price - (SELECT AVG(strike_price) FROM option_chain)) AS diff
    FROM option_chain
)
SELECT strike_price
FROM ranked_strikes
ORDER BY diff ASC
LIMIT 1;
# This finds the closest strike price to the current market price, marking it as the ATM option.

# Open Interest & Volume Analysis for ATM

SELECT expiry_date, strike_price, CE_OI, PE_OI, CE_Volume, PE_Volume
FROM option_chain
WHERE strike_price = (
    SELECT strike_price
    FROM option_chain
    ORDER BY ABS(strike_price - (SELECT AVG(strike_price) FROM option_chain))
    LIMIT 1
)
ORDER BY expiry_date;
# Find ATM options' Open Interest & Volume across expiry dates.

# Checking if the ATM Option is Also the Most Traded

SELECT expiry_date, strike_price, SUM(CE_Volume + PE_Volume) AS total_volume
FROM option_chain
WHERE strike_price = (
    SELECT strike_price
    FROM option_chain
    ORDER BY ABS(strike_price - (SELECT AVG(strike_price) FROM option_chain))
    LIMIT 1
)
GROUP BY expiry_date, strike_price
ORDER BY total_volume DESC
LIMIT 1;








