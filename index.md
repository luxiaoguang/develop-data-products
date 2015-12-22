---
title       : Stock Price Forecast 
subtitle    : Developing Data Products project
author      : luxiaoguang_leon@hotmail.com
job         : Data Science 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

1. Forecasting has fascinated people for thousands of years. People never stop studying on stock price movement after the first stock was born in 1600 years in British. 
2. What can R do on stock price forecasting? In this project we will use `quantmod` package and `forecast` package in R to study the stock price movement and forecast the future price trend.  
3. We have to say, forecasting on stock price movement is not easy. There are too many factors that contribute to the price. We will never understand all of them although there is plenty of available data. And the forecast itself will affect the price. This makes the farecast even harder.   

---  

## Data Source

We will get free data from yahoo finance.   
E.g. ([S&P 500 index](http://finance.yahoo.com/q?s=^gspc)).   
This App will download 10 years `OHLC` data. And we will use monthly data.     


```
##            GSPC.Open GSPC.High GSPC.Low GSPC.Close GSPC.Volume
## 2015-07-31   2111.60   2114.24  2102.07    2103.84  3681340000
## 2015-08-31   1986.73   1986.73  1965.98    1972.18  3915100000
## 2015-09-30   1887.14   1920.53  1887.14    1920.03  4525070000
## 2015-10-30   2090.00   2094.32  2079.34    2079.36  4256200000
## 2015-11-30   2090.95   2093.81  2080.41    2080.41  4245030000
## 2015-12-21   2010.27   2022.90  2005.93    2021.15  3760280000
##            GSPC.Adjusted
## 2015-07-31       2103.84
## 2015-08-31       1972.18
## 2015-09-30       1920.03
## 2015-10-30       2079.36
## 2015-11-30       2080.41
## 2015-12-21       2021.15
```

---
## Forecast

We will use three interactive plots to forecast stock future prices.  
1. The first interactive plot shows the close price curves with a close price moving average curve in another color.   
2. The second interactive plot shows the seasonal fluctuation. It shows the price fluctuated by seasonal reason. This is extracted from `decompose` function. See `help(decompose)`.  
3. Now let's forecast. See interactive plot three. We set a model using ets(Exponential smoothing state space model) with model type MMM. see `help(ets)`. You will see a curve in blue which is the close price curve. After the blue curve there are five forecast curves. In the middle which is normal forecast curve. There are two curves above it which are positive forecast and extremely positive and two curves below it which are negetive forecast and extremely negetive.       
    

---
## Action and stop loss

1. Long term moving average curve shows the trend. Buy a stock or index with an up going trend is a good strategy. Sell it when trend goes down. When close price curve go down and cross the moving average curve, sell it. When close price curve go up and cross the moving average curve, buy it.
2. Buy a stock or index when it reaches the seasonal bottom price point. Sell a when it reaches the seasonal top point. 
3. Use the positive forecast curve when price kept going down for a long time. Use the negetive forecast curve when price kept going up for a long time. Use the normal forecast curve when price is flat. 
4. Like what was mentioned at the beginning, it is almost impossible to forecast a stock or index price highly accurately. Actually forecasting is only a small part on stock investment strategy system. A stop loss strategy has to be included into the system.       




