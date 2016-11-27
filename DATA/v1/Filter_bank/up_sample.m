function [out] = up_sample(data, N)
% Upsample data by N times
% out   : resulting data sequence
% data  : input data sequence
% N     : Upsample by N

out = zeros(1, N * length(data));
out(1, 1:N:end) = data;
end

