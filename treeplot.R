library("Rgraphviz")
library("rpart")

trees=read.dot("C:/Users/Zhang/Desktop/2016Spring/DataThon/trees.dot")

train_y=train[,1]
train_x=train[,2:17]

test_y=test[,1]
test_x=test[,2:17]
train=data.frame(train)
test=data.frame(test)
names(train)=c("GDPpercapita","ControlofCorruption", "GovernmentEffectiveness",	"PoliticalStabilityandAbsenceofViolence", "RegulatoryQuality",	"RuleofLaw",	"VoiceandAccountability",	"ArableLand",	"LaborFemale", "LaborMale",	"LifeFemale",	"LifeMale",	"PopGrowth","PopTotal",	"Adolescent", "SeatsWomen",	"UrbanRate")
names(test)=c("GDPpercapita","ControlofCorruption", "GovernmentEffectiveness",  "PoliticalStabilityandAbsenceofViolence", "RegulatoryQuality",	"RuleofLaw",	"VoiceandAccountability",	"ArableLand",	"LaborFemale", "LaborMale",	"LifeFemale",	"LifeMale",	"PopGrowth","PopTotal",	"Adolescent", "SeatsWomen",	"UrbanRate")
clf=rpart(GDPpercapita~ ., data=train,method="anova",control=rpart.control(minsplit=50, cp=0.001))

printcp(clf) 
plotcp(clf) 
summary(clf) 

# plot tree 
png("C:/Users/Zhang/Desktop/2016Spring/DataThon/tree5.png", res=80, height=800, width=1600) 
pfit<- prune(clf, cp=clf$cptable[which.min(clf$cptable[,"xerror"]),"CP"])
plot(pfit, uniform=TRUE, main="GDP Regression Tree")
text(pfit, use.n=TRUE, all=F, cex=1.2)
dev.off()
plot(clf, uniform=TRUE, main="GDP Regression Tree")
text(clf, use.n=F, all=F, cex=.6)
pfit<- prune(clf, cp=clf$cptable[which.min(clf$cptable[,"xerror"]),"CP"])
plot(pfit, uniform=TRUE, main="GDP Regression Tree")
text(pfit, use.n=TRUE, all=F, cex=.6)



means <- rep(mean(test[,1]), 499)
ctree.model <- ctree(GDPpercapita ~., data = train, controls = ctree_control(maxdepth = 3))
plot(ctree.model)

ctree.predictions <- predict(ctree.model, test[,predictors])
ctree.r.squared <- sum((ctree.predictions-means)^2)/sum((test[,target]-means)^2)

cforest.model <- cforest(GDPpercapita ~ ., data = train,
                         control = cforest_unbiased(ntree = 500))
cforest.predictions <- predict(cforest.model, newdata = test[,2:17])
cforest.r.squared <- sum((cforest.predictions-means)^2)/sum((test[,1]-means)^2)

varimp(cforest.model)

gdp_time=GDPprediction
gdp_time[,1]=seq(1981,2014,1)
noYear=11
future=matrix(0,12,noYear)
for (i in 2:13){
  fit=arima(gdp_time[,i],order = c(0,2,2))
  future[i-1,]=c(predict(fit, n.ahead = noYear)$pred)
}
gdp=GDPtotal
noYear=11
future2=matrix(0,12,noYear)
for (i in 2:13){
  fit=arima(gdp[,i],order = c(0,2,2))
  future2[i-1,]=c(predict(fit, n.ahead = noYear)$pred)
}
write.csv(future2,"C:/Users/Zhang/Desktop/2016Spring/DataThon/future2.csv")

mlr = lm(femaleScore ~ .,data=female)
summary(mlr)

govtime=lm(govScore~time,data=female)
summary(govtime)