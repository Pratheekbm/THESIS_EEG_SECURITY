function [features] = get_features(file_name)
%% This script is used to get the frequency features of the given data stream
% We get the delta, eta, alpha, beta values form frequency domain.
% Delta             0.1Hz   to 3Hz 	Deep, dreamless sleep, non-REM sleep, unconscious 
% Theta             4Hz     to 7Hz      Intuitive, creative, recall, fantasy, imaginary, dream 
% Alpha             8Hz     to 12Hz 	Relaxed, but not drowsy, tranquil, conscious 
% Low Beta          13Hz    to 17Hz 	Formerly SMR, relaxed yet focused, integrated 
% Midrange Beta                      	Thinking, aware of self & surroundings 
% High Beta         18Hz    to 30Hz 	Alertness, agitation 

STEP_SIZE = 512;
%% Read Data from the file
data = load(file_name);
len = (floor(length(data)/STEP_SIZE) * STEP_SIZE) + 1;
data = data(1: len);
%% Filter Data so that it only has frequency content f < 32Hz
order = 256;
FS = 512;
wc = [0.1 64]/(FS/2);
h = fir1(order, wc);
fil_data = filter(h,1,data);


%% Calculating Power spectrun density for each frequency bin
k = 1;
DELTA = 1;
THETA = 2;
ALPHA = 3;
L_BETA = 4;
H_BETA = 5;
FFT_LEN_MUL = 1;

delta_range = 2: (4 * FFT_LEN_MUL);
theta_range = ((4 * FFT_LEN_MUL) + 1) : ((7 * FFT_LEN_MUL) + 1);
alpha_range = ((8 * FFT_LEN_MUL) + 1) : ((12 * FFT_LEN_MUL) + 1);
l_beta_range = ((13 * FFT_LEN_MUL) + 1) : ((17 * FFT_LEN_MUL) + 1);
h_beta_range = ((18 * FFT_LEN_MUL) + 1) : ((30 * FFT_LEN_MUL) + 1);


features = zeros(int16(length(data)/STEP_SIZE), 5);
for i = 1 : STEP_SIZE : length(fil_data) - 1
    
    fil_data_fft= abs(fft(fil_data(i:i+STEP_SIZE),STEP_SIZE * FFT_LEN_MUL));
    features(k,DELTA) = (sum(fil_data_fft(delta_range) .* fil_data_fft(delta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,THETA) = (sum(fil_data_fft(theta_range) .* fil_data_fft(theta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,ALPHA) = (sum(fil_data_fft(alpha_range) .* fil_data_fft(alpha_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,L_BETA) = (sum(fil_data_fft(l_beta_range) .* fil_data_fft(l_beta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,H_BETA) = (sum(fil_data_fft(h_beta_range) .* fil_data_fft(h_beta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    k = k + 1;
end
