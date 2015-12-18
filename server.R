library(shiny)
library(quantmod)
library(dplyr)
library(lubridate)
library(forecast)
library(rCharts)
library(TTR)
# specify to and from dates
to.dat <- Sys.Date()
from.dat <- as.Date(paste(year(to.dat)-10,month(to.dat),day(to.dat),sep="-"))

shinyServer(
        function(input,output){
                output$ocode<-renderPrint({input$code})
                
                output$chart1 <- renderChart2({
                        
                        setSymbolLookup(share.index=list(name=input$code,src="yahoo"))
                        getSymbols("share.index",from = from.dat, to = to.dat)
                        # use monthly data
                        stock.monthly <- SHARE.INDEX[endpoints(SHARE.INDEX, on ="months")]
                        stock.Cl.monthly<-Cl(stock.monthly)
                        ma<-SMA(stock.Cl.monthly,order=20,centre = FALSE)
                        data<-cbind(stock.Cl.monthly,ma)
                        data.df<-data.frame(index(data),coredata(data),stringsAsFactors = FALSE)
                        colnames(data.df) <- c( "date", "Cl","ma" )
                        data.df$date <- format(data.df$date, "%Y-%m-%d")
                        data.df$Cl<-round(data.df$Cl)
                        data.df$ma<-round(data.df$ma)
                        m1<-mPlot(x="date",y=c("Cl","ma"),data=data.df,type="Line")
                        m1$set(pointSize=0,lineWidth=1)
                        return(m1)   
                        
                })
                
                output$chart2 <- renderChart2({
                        
                        setSymbolLookup(share.index=list(name=input$code,src="yahoo"))
                        getSymbols("share.index",from = from.dat, to = to.dat)
                        # use monthly data
                        stock.monthly <- SHARE.INDEX[endpoints(SHARE.INDEX, on ="months")]
                        stock.Cl.monthly<-Cl(stock.monthly)
                        ts <- ts(stock.Cl.monthly,frequency=12)
                        # plot the decomposed parts of the time series
                        decompose<-decompose(ts)
                        # plot(decompose,xlab="Years")
                        data1<-decompose$trend
                        data2<-decompose$seasonal
                        data3<-decompose$random
                        data4<-decompose$x
                        index<-index(stock.Cl.monthly)
                        data1.df<-data.frame(index,coredata(data1),stringsAsFactors = FALSE)
                        data2.df<-data.frame(index,coredata(data2),stringsAsFactors = FALSE)
                        data3.df<-data.frame(index,coredata(data3),stringsAsFactors = FALSE)
                        data4.df<-data.frame(index,coredata(data4),stringsAsFactors = FALSE)
                        data.df<-cbind(data1.df,data2.df,data3.df,data4.df)
                        data.df<-data.df[,c(1,2,4,6,8)]
                        colnames(data.df) <- c( "date", "trend", "seasonal", "random", "close" )
                        data.df$date <- format(data.df$date, "%Y-%m-%d")
                        data.df$seasonal<-round(data.df$seasonal,digits = 4)
                        #data.df$random<-round(data.df$random)
                        m2<-mPlot(x="date",y=c("seasonal"),data=data.df,type="Line")
                        m2$set(pointSize=0,lineWidth=1)
                        return(m2)
                        
                })
                
                output$chart3 <- renderChart2({
                        
                        setSymbolLookup(share.index=list(name=input$code,src="yahoo"))
                        getSymbols("share.index",from = from.dat, to = to.dat)
                        # use monthly data
                        stock.monthly <- SHARE.INDEX[endpoints(SHARE.INDEX, on ="months")]
                        stock.Cl.monthly<-Cl(stock.monthly)
                        ts <- ts(stock.Cl.monthly,frequency=12)
                        index<-index(stock.Cl.monthly)
                        index<-format(index,"%Y-%m")
                        
                        s <- as.Date(Sys.Date())
                        indexf<-seq(from=s, by="month", length=25) 
                        indexf<-format(indexf,"%Y-%m")
                        indexf<-indexf[2:25]
                        
                        etsnow <- ets(ts,model="MMM")
                        # construct a forecasting model using the exponential smoothing function
                        fcastnow <- forecast(etsnow)
                        data2<-fcastnow$x
                        data2.df<-data.frame(index,coredata(data2),stringsAsFactors = FALSE)
                        colnames(data2.df) <- c( "index", "close")
                        data1<-fcastnow
                        data1.df<-data.frame(indexf,data1,row.names = NULL)
                        colnames(data1.df) <- c( "index", "normal", "negetive", "positive", "extnegetive", "extpositive" )
                        a<-data.frame(index)
                        b<-data.frame(indexf)
                        colnames(b)<-c("index")
                        indexall<-rbind(a,b)
                        data<-merge(indexall,data2.df,all = TRUE)
                        data<-merge(data,data1.df,all = TRUE)
                        data$close<-round(data$close)
                        data$normal<-round(data$normal)
                        data$negetive<-round(data$negetive)
                        data$positive<-round(data$positive)
                        data$extnegetive<-round(data$extnegetive)
                        data$extpositive<-round(data$extpositive)
                        m3<-mPlot(x="index",y=c("close","normal","negetive","positive","extnegetive","extpositive"),data=data,type="Line")
                        m3$set(pointSize=0,lineWidth=1)
                        return(m3)
                        
                })
                
        }
)