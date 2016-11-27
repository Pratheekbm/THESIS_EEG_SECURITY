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
L_ALPHA = 3;
H_ALPHA = 4;
L_BETA = 5;
H_BETA = 6;
L_GAMMA = 7;
H_GAMMA = 8;

FFT_LEN_MUL = 1;
DELTA_START = 1 + 1;
DELTA_END = 3;
THETA_START = 4;
THETA_END = 7;
LOW_ALPHA_START = 8;
LOW_ALPHA_END = 9;
HIGH_ALPHA_START = 10;
HIGH_ALPHA_END = 12;
LOW_BETA_START = 13;
LOW_BETA_END = 17;
HIGH_BETA_START = 18;
HIGH_BETA_END = 30;
LOW_GAMMA_START = 31;
LOW_GAMMA_END = 40;
HIGH_GAMMA_START = 41;
HIGH_GAMMA_END = 48;

delta_range = DELTA_START: (DELTA_END * FFT_LEN_MUL) + 1;
theta_range = ((THETA_START * FFT_LEN_MUL) + 1) : ((THETA_END * FFT_LEN_MUL) + 1);
l_alpha_range = ((LOW_ALPHA_START * FFT_LEN_MUL) + 1) : ((LOW_ALPHA_END * FFT_LEN_MUL) + 1);
h_alpha_range = ((HIGH_ALPHA_START * FFT_LEN_MUL) + 1) : ((HIGH_ALPHA_END * FFT_LEN_MUL) + 1);
l_beta_range = ((LOW_BETA_START * FFT_LEN_MUL) + 1) : ((LOW_BETA_END * FFT_LEN_MUL) + 1);
h_beta_range = ((HIGH_BETA_START * FFT_LEN_MUL) + 1) : ((HIGH_BETA_END * FFT_LEN_MUL) + 1);
l_gamma_range = ((LOW_GAMMA_START * FFT_LEN_MUL) + 1) : ((LOW_GAMMA_END * FFT_LEN_MUL) + 1);
h_gamma_range = ((HIGH_GAMMA_START * FFT_LEN_MUL) + 1) : ((HIGH_GAMMA_END * FFT_LEN_MUL) + 1);


features = zeros(int16(length(data)/STEP_SIZE), 5);
for i = 1 : STEP_SIZE : length(fil_data) - 1
    
    fil_data_fft= abs(fft(fil_data(i:i+STEP_SIZE),STEP_SIZE * FFT_LEN_MUL));
    features(k,DELTA) = (sum(fil_data_fft(delta_range) .* fil_data_fft(delta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,THETA) = (sum(fil_data_fft(theta_range) .* fil_data_fft(theta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,L_ALPHA) = (sum(fil_data_fft(l_alpha_range) .* fil_data_fft(l_alpha_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,H_ALPHA) = (sum(fil_data_fft(h_alpha_range) .* fil_data_fft(h_alpha_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,L_BETA) = (sum(fil_data_fft(l_beta_range) .* fil_data_fft(l_beta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,H_BETA) = (sum(fil_data_fft(h_beta_range) .* fil_data_fft(h_beta_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,L_GAMMA) = (sum(fil_data_fft(l_gamma_range) .* fil_data_fft(l_gamma_range)))/(STEP_SIZE * FFT_LEN_MUL);
    features(k,H_GAMMA) = (sum(fil_data_fft(h_gamma_range) .* fil_data_fft(h_gamma_range)))/(STEP_SIZE * FFT_LEN_MUL);
    k = k + 1;
end
