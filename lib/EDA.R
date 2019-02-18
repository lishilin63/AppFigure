########################################
############# EDA #################
########################################
library('plyr')

ranks <- read.csv("/Users/shilinli/Documents/GitHub/AppFigures/data/ranks.csv",header = T)
sales <- read.csv("/Users/shilinli/Documents/GitHub/AppFigures/data/sales.csv",header = T)

### join ranks and sales w/ date and app_id
dt <- join(ranks, sales, by = c("app_id","Date"))

dt_label <- dt[is.na(dt$sales) == F,]
dt_label$s_mean <- (dt_label$s1 + dt_label$s2 * 2 + dt_label$s3 * 3 + dt_label$s4 * 4 + dt_label$s5 * 5) / (dt_label$s1 + dt_label$s2 + dt_label$s3 + dt_label$s4 + dt_label$s5)
dt_label <- dt_label[is.na(dt_label$r0) == F & is.na(dt_label$s_mean) == F,]
dt_label <- dt_label[,c("Date","app_id","r0","s_mean","sales")]

#### NEED RUN
dt_pred <- dt[is.na(dt$sales) == T,]
dt_pred$s_mean <- (dt_pred$s1 + dt_pred$s2 * 2 + dt_pred$s3 * 3 + dt_pred$s4 * 4 + dt_pred$s5 * 5) / (dt_pred$s1 + dt_pred$s2 + dt_pred$s3 + dt_pred$s4 + dt_pred$s5)
dt_pred <- dt_pred[is.na(dt_pred$r0) == F & is.na(dt_pred$s_mean) == F,]
dt_pred <- dt_pred[,c("Date","app_id","r0","s_mean","sales")]
#######


### unbalanced frequency by app_id
id <- unique(dt_label$app_id)
id_length <- length(unique(dt_label$app_id))
#hist(dt_label$app_id, breaks = id_length)

### 
hist(dt_label$sales)
plot(x = dt_label$app_id, y = dt_label$sales)
plot(x = dt_label$app_id, y = dt_label$r0)
plot(x = dt_label$app_id, y = dt_label$s_mean)
plot(x = dt_label$r0, y = dt_label$s_mean)

### sales vs s
plot(x = dt_label$s_mean, y = dt_label$sales)

### app-level sales vs s
t = ftable(dt_label$app_id) # contingency table with app_id and counts
plot(x = dt_label[dt_label$app_id==320,]$s_mean, y = dt_label[dt_label$app_id==320,]$sales)
plot(x = dt_label[dt_label$app_id==1490,]$s_mean, y = dt_label[dt_label$app_id==1490,]$sales)
plot(x = dt_label[dt_label$app_id==406,]$s_mean, y = dt_label[dt_label$app_id==406,]$sales)

### sales vs r0
plot(x = dt_label$r0, y = dt_label$sales)


### Create app-level data (26 rows without NA)
dt_app <- as.data.frame(matrix(data = NA,nrow = id_length,ncol = 4))
colnames(dt_app) <- c("app_id","r_avg","s_avg","sales")
dt_app$app_id <- id

for (i in 1:nrow(dt_app)) {
  dt_app[dt_app$app_id==id[i],]$r_avg = mean(dt_label[dt_label$app_id==id[i],]$r0,na.rm = T)
  dt_app[dt_app$app_id==id[i],]$s_avg = mean(dt_label[dt_label$app_id==id[i],]$s_mean,na.rm = T)
  dt_app[dt_app$app_id==id[i],]$sales = mean(dt_label[dt_label$app_id==id[i],]$sales,na.rm = T)
}

### correlation test - app level
cor.test(dt_app$r_avg, dt_app$sales, method=c("pearson", "kendall", "spearman"))
cor.test(dt_app$s_avg, dt_app$sales, method=c("pearson", "kendall", "spearman"))
cor.test(dt_app$r_avg, dt_app$s_avg, method=c("pearson", "kendall", "spearman"))

### correlation test - dt_label
cor.test(dt_label$r0, dt_label$sales, method=c("pearson", "kendall", "spearman"))
cor.test(dt_label$s_mean, dt_label$sales, method=c("pearson", "kendall", "spearman"))
cor.test(dt_label$r0, dt_label$s_mean, method=c("pearson", "kendall", "spearman"))

### Outlier 
source("../lib/model.R")
boxplot(dt_label$sales)
cooksd <- cooks.distance(model_linear)
plot(cooksd)
abline(h = 4*mean(cooksd, na.rm=T), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")  # add labels


### app-level time series
acf(dt_label[dt_label$app_id==320,]$sales)
acf(dt_label[dt_label$app_id==1490,]$sales)

pacf(dt_label$sales)
plot(x = dt_label$Date, y = dt_label$sales)


