import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
import csv
import random
import matplotlib.pyplot as plt
from sklearn import linear_model
from sklearn import preprocessing
from sklearn.metrics import mean_squared_error

train=np.genfromtxt("train.csv",delimiter=',')
test=np.genfromtxt("test.csv",delimiter=',')
train_x=np.array(train[0:,1:17])
#train_x = preprocessing.scale(train_x)
train_x = train_x.astype(np.float)
train_y=np.array(train[0:,0])
train_y = train_y.astype(np.float)
test_x=np.array(test[0:,1:17])
#test_x = preprocessing.scale(test_x)
test_x = test_x.astype(np.float)
test_y=np.array(test[0:,0])
test_y = test_y.astype(np.float)

clf = linear_model.Lasso(alpha=.5)
clf.fit(train_x,train_y)
rsq_train=clf.score(train_x,train_y)
rsq_test=clf.score(test_x,test_y)
print rsq_test,rsq_train
print clf.coef_
coef = abs(clf.coef_)
np.savetxt("coef_lasso.csv", coef, delimiter=",")
'''
c_list=c_list=np.arange(0.1,1.1,0.1)
cv_score = [0]*len(c_list)
for i,c in enumerate(c_list):
	clf = linear_model.Lasso(alpha=c)
	clf.fit(train_x,train_y)
	rsq_train=clf.score(train_x,train_y)
	cv_score[i]=rsq_train

plt.figure()
plt.plot(c_list,cv_score,'ro-')
plt.title("CV R-Square vs the Penalty Parameter for Lasso")
plt.xlabel("Value of Penalty Parameter")
plt.ylabel("R-Square")
plt.show()
'''
#pred_test=clf.predict(test_x)
#pred_train=clf.predict(train_x)
#rsq_test=clf.score(test_x,test_y)
#mse=mean_squared_error(train_y,pred_train)
#print rsq_test,rsq_train
#print clf.coef_