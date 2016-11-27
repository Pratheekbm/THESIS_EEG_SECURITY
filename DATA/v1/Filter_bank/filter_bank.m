function [delta, eta, alpha, low_beta, high_beta] = filter_bank (data_stream)
% This function assumes the data stream is frequency limited to 32Hz with
% sampling frequency of 64Hz

h0 = [-0.0106    0.0329    0.0308   -0.1870   -0.0280    0.6309    0.7148    0.2304];
h1 = [ 0.2304   -0.7148    0.6309    0.0280   -0.1870   -0.0308    0.0329    0.0106];
g0 = [ 0.2304    0.7148    0.6309   -0.0280   -0.1870    0.0308    0.0329   -0.0106];
g1 = [ 0.0106    0.0329   -0.0308   -0.1870    0.0280    0.6309   -0.7148    0.2304];

A0_16 = conv(h0, data_stream);
A0_16 = down_sample(A0_16, 2);

A0_8 = conv(h0, A0_16);
A0_8 = down_sample(A0_8, 2);

A8_16 = conv(h1, A0_16);
A8_16 = down_sample(A8_16, 2);

A16_32 = conv(h1, data_stream);
high_beta = down_sample(A16_32, 2);

delta = conv(h0, A0_8);
delta = down_sample(delta, 2);

eta = conv(h1, A0_8);
eta = down_sample(eta, 2);

alpha = conv(h0, A8_16);
alpha = down_sample(alpha, 2);

low_beta = conv(h1, A8_16);
low_beta = down_sample(low_beta, 2);

%delta = up_sample(delta, 2);
%delta = conv(g0, delta);

% delta = up_sample(delta, 2);
% delta = conv(g0, delta);
% 
% eta = up_sample(eta, 2);
% eta = conv(g1, eta);
% 
% A_D_E = delta + eta;
% 
% alpha = up_sample(alpha, 2);
% alpha = conv(g0, alpha);
% 
% low_beta = up_sample(low_beta, 2);
% low_beta = conv(g1, low_beta);
% 
% A_A_LB = alpha + low_beta;
% 
% A_D_E = up_sample(A_D_E, 2);
% A_D_E = conv(g0, A_D_E);
% 
% A_A_LB = up_sample(A_A_LB, 2);
% A_A_LB = conv(g1, A_A_LB);
% 
% A_up = A_D_E + A_A_LB;
% 
% A_up = up_sample(A_up, 2);
% A_up = conv(g0, A_up);
% 
% high_beta = up_sample(high_beta, 2);
% high_beta = conv(g1, high_beta);
% 
% x = A_up + [zeros(1,(length(A_up) - length(high_beta))/2) high_beta zeros(1,(length(A_up) - length(high_beta))/2)];



end


