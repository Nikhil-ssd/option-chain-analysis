# option-chain-analysis
Financial Data Analysis project in Python to analyze NIFTY50 option-chain data web-scraped from NSE.

# How did I get the required data?

I have used Web-Scraping to fetch the NIFTY option-chain data from NSE's official website (https://www.nseindia.com/option-chain) through the commonly used 
NSE API - "https://www.nseindia.com/api/option-chain-indices?symbol=NIFTY".

### I have utilised Python's Web-Scraping library requests to fetch the data in a JSON format which I later normalized and stored in a dataframe for analysis.

# Dataset Information

The web-scraped option chain data which I fetched consisted of 40 columns and 833 rows, out of which I have used only 12 columnns for my specific analysis which are 

1) CE_OI	2) CE_Change_OI	3) CE_Volume	4) CE_IV	5) CE_LTP	6) Strike_Price	7) Expiry_date	8) PE_OI	9) PE_Change_OI	10) PE_Volume	11) PE_IV	12) PE_LTP

# Steps which I followed to perform my analysis
1) Web-Scraped NIFTY50 Option Chain Data from NSE's official website using NSE's API.
2) Selected the most important columns and removed the unnecessary ones.
3) Converted data from JSON format to a DataFrame.
4) Cleaned and pre-processed the data by fixing the data types and removing outliers.
5) Created a Database and inserted the pre-processed data to a table in MySQL to perform separate analysis later using Queries in a MySQL Script.
6) Peformed Feature Engineering by adding new features including
   A] Total OI (Total Open-Interest)
   B] Put-Call Ratio (PCR)
   C] CE_OI_Change_Percentage
   D] PE_OI_Change_Percentage
7) Calculated Various metrics including
   A] Max-Pain Strike Price
   B] MAX_CE_OI 
   C] MAX_PE_OI
   D] Overall PCR
   E] TOP_CE_INCREASE
   F] TOP_CE_DECREASE
   G] MAX_IV (Maximum Implied Volatility) 
   H] MIN_IV (Minimum Implied Volatility)
   I] MOST_TRADED_CE 
   J] MOST_TRADED_PE
8) Visualized and Analyzed data by plotting various charts including
    I] OPTION CHAIN OPEN-INTEREST CHART II] OPTION CHAIN CO-RELATION HEATMAP II] CALL VS PUT OPEN INTEREST CHART
    IV] PUT-CALL RATIO ANALYSIS CHART V] PUT VS CALL OI CHANGE CHART VI] IMPLIED VOLATILITY ANALYSIS CHART
    VII] TRADING VOLUME ACROSS STRIKE PRICES
9) Exported the pre-processed data to an Excel file for visualizing the same data in Power BI later.
   

# Instructions on how to run this project code on your system
Step 1 : Download this project repository as a zip file. Step 2 : Unzip the folder to your desired location Step 3 : If you don't have Anaconda installed, go to the Anaconda website and download the installer for your operating system (Windows, macOS, or Linux) and launch it. Step 4 : Launch Jupyter Notebook Interface from Anaconda Navigator after which opens in your default browser. Step 5 : Navigate to this project folder. Step 6 : When inside navigate to  Option_Chain _Analysis.ipynb and open it Step 7 : Run the Option_Chain _Analysis.ipynb file cell by cell and then analyze the various charts.

You can also test the code for your specific custom problem statement for example, find the best batsmen in the powerplay against Mumbai Indians at Wankhede Stadium.

# Purpose of solving the problem

Analyzing NIFTY 50 Option Chain Data by scraping it serves several purposes, particularly for traders, quantitative analysts, and researchers. Here are some key reasons:

### 1. Market Sentiment Analysis
Open Interest (OI) Data: Helps identify support and resistance levels based on the accumulation of open contracts at different strike prices.

Put-Call Ratio (PCR): A high PCR indicates bearish sentiment, while a low PCR suggests bullish sentiment.

### 2. Identifying Key Support & Resistance Levels
Large OI at Call options suggests resistance levels.

Large OI at Put options suggests support levels.

### 3. Implied Volatility (IV) Analysis
Higher IV means higher uncertainty, which can impact option pricing.

Comparing IV across strikes helps determine where big moves might occur.

### 4. Option Greeks Calculation
Scraping real-time data allows for computing Delta, Gamma, Theta, Vega, and Rho, which are crucial for hedging and strategy formulation.

### 5. Arbitrage & Strategy Execution
Helps detect potential arbitrage opportunities between different option strikes or expiries.

Used in Iron Condor, Straddle, Strangle, Covered Call, etc. strategies.

### 6. Automated Trading & Backtesting
Scraped data can be used to train machine learning models for predicting price movements.

Backtesting historical trends can refine automated trading strategies.

### 7. Real-time Monitoring & Alerts
Custom alerts for OI spikes, IV surges, or unusual volume activity, which may signal big market moves.


