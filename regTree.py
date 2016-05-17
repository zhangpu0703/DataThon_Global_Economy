import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeRegressor
from IPython.display import Image
import pydot
from sklearn.externals.six import StringIO 
from sklearn import tree
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

clf=DecisionTreeRegressor(max_depth=4)
clf.fit(train_x,train_y)
pred_train=clf.predict(train_x)
rsq_train=clf.score(train_x,train_y)
rsq_test=clf.score(test_x,test_y)
#mse=mean_squared_error(train_y,pred_train)
print rsq_test,rsq_train
#print mse
trees=clf.tree_
#print trees
#dot_data = StringIO() 
#tree.export_graphviz(clf,out_file=dot_data)
#graph = pydot.graph_from_dot_data(dot_data.getvalue())
#graph.write_pdf("iris.pdf") 
#tree.export_graphviz(clf,out_file="trees.dot")