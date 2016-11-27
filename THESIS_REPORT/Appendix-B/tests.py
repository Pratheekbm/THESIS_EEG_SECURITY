import numpy as np
from classifiers import svm_classifier, ann_classifier, maha_classifier

def intra_sub_tests(test_sub, features):
	intra_features = features[test_sub - 1]
	x_train = []
	x_test = []
	y_train = []
	y_test = []
	i = 0
	for test_type in intra_features:
		for case_num in test_type:
			x_train.append(case_num)
			x_test.append(case_num)
			y_train.append(i)
			y_test.append(i)
		i = i + 1

	pred = svm_classifier(x_train, y_train, x_test, y_test)
	np_acc = np.array(np.array(pred) == np.array(y_test))
	print float(np_acc.sum())/float(len(y_test))

def inter_sub_tests(type, features):
	x_train = []
	x_test = []
	y_train = []
	y_test = []

	if 'calc' == type:
		type_num = 0
	elif 'breath' == type:
		type_num = 1
	elif 'song' == type:
		type_num = 2
	else:
		print 'Type Error'
	i = 0
	for sub in features:
		case = sub[type_num]
		for item in case:
			x_train.append(item)
			x_test.append(item)
			y_train.append(i)
			y_test.append(i)
		i = i + 1
	pred = svm_classifier(x_train, y_train, x_test, y_test)
	np_acc = np.array(np.array(pred) == np.array(y_test))
	print float(np_acc.sum())/float(len(y_test))		

def verify(type, features, data, sub_id):
	x_train = []
	x_test = []
	y_train = []
	y_test = []

	if 'calc' == type:
		type_num = 0
	elif 'breath' == type:
		type_num = 1
	elif 'song' == type:
		type_num = 2
	else:
		print 'Type Error'
	i = 0
	for sub in features:
		case = sub[type_num]
		for item in case:
			x_train.append(item)
			y_train.append(i)
		i = i + 1
	x_test = data
	for i in range(0, len(x_test)):
		y_test.append(sub_id)

	pred = svm_classifier(x_train, y_train, x_test, y_test)
	np_acc = np.array(np.array(pred) == np.array(y_test))
	print pred, y_test
	print float(np_acc.sum())/float(len(y_test))
	if .6 < float(np_acc.sum())/float(len(y_test)):
		print 'Verified Used'
	else:
		print 'Verification failed'


