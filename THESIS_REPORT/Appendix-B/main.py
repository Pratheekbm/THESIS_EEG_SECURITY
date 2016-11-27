import numpy as np
from pre_process import prepare_data, encode_features, decode_features
from tests import intra_sub_tests, inter_sub_tests, verify
import mindwave, time
from pre_process import get_features, normalize


def on_raw(headset, raw):
	#print on_raw.count
	global done
	global count
	global data
	if 0 == count:
		print time.time()
	elif (512 * 5) >= count:
		count += 1
		return
	elif (512* 15 + 2) <= count:
		#print count
		done = 1
	else:
		data.append(raw)
	count += 1

if __name__ == '__main__':
	global done
	global count
	global data
	done = 0
	count = 0
	data = []

	feature_filename = 'features.dat'
	base_filename = '/Users/pbm/Google Drive/THESIS/DATA/People_data/'
	num_sub = 4
	type = ['calc', 'breath', 'song']
	test_cases = 5
	normalize_flag = True
	encode_features(base_filename, feature_filename, num_sub, type, test_cases, normalize_flag)
	features = decode_features(feature_filename)
	#intra_sub_tests(1, features)
	#inter_sub_tests('song', features)
	
	headset = mindwave.Headset('/dev/tty.MindWaveMobile-DevA')
	time.sleep(2)

	headset.connect()
	print "Connecting..."
	time.sleep(2)
	headset.raw_value_handlers.append(on_raw)
	while True:
		time.sleep(0.1)
		if 1 == done:
			break
	print len(data)

	feature_data = get_features(data)
	feature_data = normalize(feature_data)
	print np.shape(np.array(feature_data))
	sub_id = 3
	verify('breath', features, feature_data, sub_id)
	

