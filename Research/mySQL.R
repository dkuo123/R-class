library(RMySQL)
library(dplyr)
install.packages("gplots")
library(gplots)

rfqDB= dbConnect(MySQL(), user = "trident_rw", password = "PmKFwLkC", host = "waketdstudy1.skae", dbname = "TridentDB")
dbListTables(rfqDB)

magenta <- "select TradeDate, sum(qty1) as QTY, count(*) as CNT, avg(qty1) as AVG from RfqExecutions where isFirm = 'true' and TradeDate < '2016-01-01' group by TradeDate"
query <- dbSendQuery(rfqDB, magenta)
result <- fetch(query)
#plot(result) # failed due to no-number field of TradeDate
result$TradeDate <- as.Date(result$TradeDate, "%Y-%m-%d")
with(result, plot(TradeDate, QTY))
with(result, plot(TradeDate, CNT))
with(result, plot(TradeDate, AVG))

magenta <- "select customer_id, TradeDate, qty1 as QTY from RfqExecutions where isFirm = 'true' and TradeDate < '2016-01-01' "
query <- dbSendQuery(rfqDB, magenta)
result <- fetch(query)
result$TradeDate <- as.Date(result$TradeDate, "%Y-%m-%d")
result$QTY <- as.numeric(result$QTY)
cc <- table(result$customer_id)

x <- result
grouped <- group_by(x, customer_id)
summarise(grouped, mean=mean(QTY), n = n())
y <- x %>% group_by(customer_id) %>% summarise(mean=mean(QTY), sum = sum(QTY),n = n()) %>% ungroup() %>% arrange(desc(n))
h <- head(y)$customer_id
r <- subset(result, customer_id %in% h)
#boxplot(split(r$QTY, r$customer_id), main = 'Qty by Customer', varwidth=T)
#boxplot(QTY ~ customer_id, data = r, cex.axis = 0.8 , main = 'Qty by Customer', varwidth=T)

png("customer-by-trade-num.png")
boxplot2(QTY ~ customer_id, data = r, main = 'Top Customer By Trade Number', varwidth=T, shrink = 0.8)
dev.off()

y <- x %>% group_by(customer_id) %>% summarise(mean=mean(QTY), sum = sum(QTY),n = n()) %>% ungroup() %>% arrange(desc(sum))
h <- head(y)$customer_id
r <- subset(result, customer_id %in% h)
#boxplot(split(r$QTY, r$customer_id), main = 'Qty by Customer', varwidth=T)
#boxplot(QTY ~ customer_id, data = r, cex.axis = 0.8 , main = 'Qty by Customer', varwidth=T)

png("customer-by-trade-qty.png")
boxplot2(QTY ~ customer_id, data = r, main = 'Top Customer By Trade Qty', varwidth=T, shrink = 0.8)
dev.off()


# DV01 adjusted
DV01 <- "select customer_id, TradeDate, qty1*dv01/1000000 as risk from RfqExecutions r, DV01 d where isFirm = 'true' and TradeDate < '2016-01-01' and r.tag1 = d.tag "
query <- dbSendQuery(rfqDB, DV01)
result <- fetch(query)
result$TradeDate <- as.Date(result$TradeDate, "%Y-%m-%d")
result$risk <- as.numeric(result$risk)

x <- result
grouped <- group_by(x, customer_id)
summarise(grouped, mean=mean(risk), n = n())
y <- x %>% group_by(customer_id) %>% summarise(mean=mean(risk), sum=sum(risk), n = n()) %>% ungroup() %>% arrange(desc(n))
h <- head(y)$customer_id
r <- subset(result, customer_id %in% h)
#boxplot(split(r$QTY, r$customer_id), main = 'Qty by Customer', varwidth=T)
#boxplot(QTY ~ customer_id, data = r, cex.axis = 0.8 , main = 'Qty by Customer', varwidth=T)
#install.packages("gplots")
#library(gplots)
png("risk-customer-by-trade-num.png")
boxplot2(risk ~ customer_id, data = r, main = 'Risk of Top Customer By Trade Number', varwidth=T, shrink = 0.8)
dev.off()

y <- x %>% group_by(customer_id) %>% summarise(mean=mean(risk),sum=sum(risk), n = n()) %>% ungroup() %>% arrange(desc(sum))
h <- head(y)$customer_id
r <- subset(result, customer_id %in% h)

png("most-risk-customer.png")
boxplot2(risk ~ customer_id, data = r, main = 'Most Risk Customer', varwidth=T, shrink = 0.8)
dev.off()


dbDisconnect(rfqDB)


