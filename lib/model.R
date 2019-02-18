########################################
############# Model #################
########################################

### Train, test split
train <- dt_label[1:(nrow(dt_label)*0.8),]
test <- dt_label[(nrow(dt_label)*0.8):nrow(dt_label),]

### Simple Linear Regression w/ interaction
model_linear <- glm(1/log(sales) ~ r0 + s_mean + r0*s_mean, family = "gaussian", data = train)

summary(model_linear)

train_MSE <- mean(model_linear$residuals^2)
test_MSPE <- mean((test$sales - predict.glm(model_linear,test))^2)

# Prediction for dt_pred
dt_pred$sales <- round(exp(1/predict.glm(model_linear, dt_pred)))
dt_pred_format <- dt_pred[,c("Date","app_id","sales")]
write.csv(dt_pred_format,'pred.csv')
