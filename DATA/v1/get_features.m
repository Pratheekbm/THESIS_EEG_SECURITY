
%% This script is used to get the frequency features of the given data stream
% We get the delta, eta, alpha, beta values form frequency domain.
% Delta             0.1Hz   to 4Hz 	Deep, dreamless sleep, non-REM sleep, unconscious 
% Theta             4Hz     to 7Hz      Intuitive, creative, recall, fantasy, imaginary, dream 
% Alpha             8Hz     to 15Hz 	Relaxed, but not drowsy, tranquil, conscious 
% Low Beta          15Hz    to 20Hz 	Formerly SMR, relaxed yet focused, integrated 
% Midrange Beta                      	Thinking, aware of self & surroundings 
% High Beta         20Hz    to 30Hz 	Alertness, agitation 

%% Read Data from the file

data = VarName2';

%% Filter Data so that it only has frequency content f < 32Hz
order = 256;
wc = 64/256;
h = fir1(order, wc);
filtered_data = filter(h,1,data);

%% Downsample the data so that sampling frequency is 128Hz from 512Hz
filtered_data = down_sample(filtered_data, 4);

%% Pass the data sequence through filter banks and extract the features
%[delta, theta, alpha, low_beta, high_beta] = filter_bank (filtered_data);
order = 256;
FS = 128;
delta_wc = [0.1 4]/(FS/2);
theta_wc = [4 7]/(FS/2);
low_alpha_wc = [8 12]/(FS/2);
high_alpha_wc  = [12 15]/(FS/2);
low_beta_wc = [15 20]/(FS/2);
high_beta_wc = [20 30]/(FS/2);
low_gamma_wc = [30 60]/(FS/2);
high_gamma_wc = [60 100]/(FS/2);

% delta
h = fir1(order, delta_wc);
delta = filter(h, 1, filtered_data);

% theta
h = fir1(order, theta_wc);
theta = filter(h,1,filtered_data);

% low_alpha
h = fir1(order, low_alpha_wc);
low_alpha = filter(h,1,filtered_data);

% high_alpha
h = fir1(order, high_alpha_wc);
high_alpha = filter(h,1,filtered_data);

% low_beta
h = fir1(order, low_beta_wc);
low_beta = filter(h,1,filtered_data);

% high_beta
h = fir1(order, high_beta_wc);
high_beta = filter(h,1,filtered_data);

% low_gamma
h = fir1(order, low_gamma_wc);
low_gamma = filter(h,1,filtered_data);



%% Compare with the results given by the device


