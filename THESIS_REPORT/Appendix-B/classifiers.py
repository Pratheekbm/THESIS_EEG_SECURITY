import numpy as np
from sklearn import svm, grid_search
from sklearn.neighbors import NearestNeighbors
#from sklearn.neural_network import MLPClassifier

def svm_classifier(x_train, y_train, x_test, y_test):
	'''
	clf = svm.SVC()
	clf.fit(x_train, y_train)
	'''
	parameters = {'kernel':('linear', 'rbf'), 'C':[1, 10]}
	svr = svm.SVC(probability=True)
	clf = grid_search.GridSearchCV(svr, parameters)
	clf.fit(x_train, y_train)
	
	dec = clf.predict_proba(x_test)
	#dec = clf.decision_function(x_test)
	print np.array(dec)
	print np.shape(np.array(dec))
	pred = clf.predict(x_test)
	return pred


def maha_classifier(x_train, y_train, x_test, y_test):
	print lol


def ann_classifier(x_train, y_train, x_test, y_test):
	print lol
	'''
	clf = MLPClassifier(algorithm='l-bfgs', alpha=1e-5, hidden_layer_sizes=(5, 2), random_state=1)
	clf.fit(x_train, y_train)
	clf.predict(x_test)	
	'''

def k_nn(x_test, y_test, number_of_neighbours):
	nbrs = NearestNeighbors(n_neighbors=number_of_neighbours, algorithm='ball_tree').fit(X)
