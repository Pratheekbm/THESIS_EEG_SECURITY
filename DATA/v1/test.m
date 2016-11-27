N_point_DFT = 2 ^ 16;
Fs = 2;
window_length = 48;

figure;
y = fft(delta, N_point_DFT);
plot((0 : Fs / N_point_DFT : Fs/2 - 1/N_point_DFT) ,abs(y(1:length(y)/2)));