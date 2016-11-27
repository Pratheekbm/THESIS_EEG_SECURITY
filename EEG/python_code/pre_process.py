import math
import numpy as np
import pickle
from scipy.fftpack import fft


def encode_features(base_filename, feature_filename, num_sub, type, test_cases, normalize_flag):
	features = []
	for i in range(1,num_sub + 1):
		features_per_sub = []
		for item in type:
			filename = base_filename + str(i) + '/' + item
			features_per_sub.append(prepare_data(filename, test_cases, normalize_flag)) 
		features.append(features_per_sub)

	with open(feature_filename, 'wb') as f:
	    pickle.dump(features, f)

def decode_features(feature_filename):
	with open(feature_filename, 'rb') as f:
		features = pickle.load(f)
	return features

def prepare_data(filename, test_cases, normalize_flag):
	"""
		Takes in filename, number of test cases associated with the filename,
		and a flag to whether to normalize or not as input and
		returns feature vector with all the data associated with that filename
		combined
	"""
	features = []
	for i in range(1, test_cases + 1):
		temp_filename = filename + str(i) + '.dat'
		fp = open(temp_filename, 'r')
		raw_str = fp.readlines()
		raw = []
		raw = [float(i) for i in raw_str ]
		features.extend(get_features(raw))

	if normalize:
		features = normalize(features)

	return features

def normalize(features):
	"""
		Normalizes the feature vectors to make them unit vectors
	"""
	np_features = np.array(features)

	features_norm = []
	for i in range(0, np_features.shape[0]):
		features_norm.append(np_features[i,:]/np.sqrt(np.sum(np_features[i,:] * np_features[i,:])))

	return features_norm


def get_features(raw):
	"""
		get_features()
		Used to get the frequency features of the given data stream
		We get the delta, eta, alpha, beta values form frequency domain.
		Delta             0.1Hz   to 3Hz 	Deep, dreamless sleep, non-REM sleep, unconscious 
		Theta             4Hz     to 7Hz    Intuitive, creative, recall, fantasy, imaginary, dream 
		Alpha             8Hz     to 12Hz 	Relaxed, but not drowsy, tranquil, conscious 
		Low Beta          13Hz    to 17Hz 	Formerly SMR, relaxed yet focused, integrated 
		Midrange Beta                      	Thinking, aware of self & surroundings 
		High Beta         18Hz    to 30Hz 	Alertness, agitation 
	"""

	STEP_SIZE = 512
	length = int(math.floor(len(raw)/STEP_SIZE) * STEP_SIZE)
	raw = raw[0:length]

	data = []
	for i in range(0, len(raw) - 2, STEP_SIZE):
		data.append(raw[i:i+STEP_SIZE])

	data_fft = []
	for item in data:
		data_fft.append(np.absolute(fft(item)))

	np_data_fft = np.array(data_fft)

	# Since the indexing python is from 0
	FFT_LEN_MUL = 1
	DELTA_START = 1
	DELTA_END = 3
	THETA_START = 4
	THETA_END = 7
	LOW_ALPHA_START = 8
	LOW_ALPHA_END = 9
	HIGH_ALPHA_START = 10
	HIGH_ALPHA_END = 12
	LOW_BETA_START = 13
	LOW_BETA_END = 17
	HIGH_BETA_START = 18
	HIGH_BETA_END = 30
	LOW_GAMMA_START = 31
	LOW_GAMMA_END = 40
	HIGH_GAMMA_START = 41
	HIGH_GAMMA_END = 48

	# +1 to the end range because range() does not consider last element
	delta_range = range(DELTA_START, (DELTA_END * FFT_LEN_MUL + 1))
	theta_range = range((THETA_START * FFT_LEN_MUL) , (THETA_END * FFT_LEN_MUL + 1))
	l_alpha_range = range((LOW_ALPHA_START * FFT_LEN_MUL) , (LOW_ALPHA_END * FFT_LEN_MUL + 1))
	h_alpha_range = range((HIGH_ALPHA_START * FFT_LEN_MUL) , (HIGH_ALPHA_END * FFT_LEN_MUL + 1))
	l_beta_range = range((LOW_BETA_START * FFT_LEN_MUL) , (LOW_BETA_END * FFT_LEN_MUL + 1))
	h_beta_range = range((HIGH_BETA_START * FFT_LEN_MUL) , (HIGH_BETA_END * FFT_LEN_MUL + 1))
	l_gamma_range = range((LOW_GAMMA_START * FFT_LEN_MUL) , (LOW_GAMMA_END * FFT_LEN_MUL + 1))
	h_gamma_range = range((HIGH_GAMMA_START * FFT_LEN_MUL) , (HIGH_GAMMA_END * FFT_LEN_MUL + 1))

	features = []
	for item in np_data_fft:
		item_sq = np.array(item * item)
		delta = np.sum(item_sq[delta_range])/(STEP_SIZE * FFT_LEN_MUL)
		theta = np.sum(item_sq[theta_range])/(STEP_SIZE * FFT_LEN_MUL)
		l_alpha = np.sum(item_sq[l_alpha_range])/(STEP_SIZE * FFT_LEN_MUL)
		h_alpha = np.sum(item_sq[h_alpha_range])/(STEP_SIZE * FFT_LEN_MUL)
		l_beta = np.sum(item_sq[l_beta_range])/(STEP_SIZE * FFT_LEN_MUL)
		h_beta = np.sum(item_sq[h_beta_range])/(STEP_SIZE * FFT_LEN_MUL)
		l_gamma = np.sum(item_sq[l_gamma_range])/(STEP_SIZE * FFT_LEN_MUL)
		h_gamma = np.sum(item_sq[h_gamma_range])/(STEP_SIZE * FFT_LEN_MUL)
		features.append([delta, theta, l_alpha, h_alpha, l_beta, h_beta, l_gamma, h_gamma])

	return features

