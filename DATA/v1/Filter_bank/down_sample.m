function [out] = down_sample(data, N)
% Down sample data by N times
% out   : resulting data sequence
% data  : input data sequence
% N     : Down sample by N
% The input data sequence frequency is assumed to be within pi/N to avoide
% aliazing

out = data(1, 1:N:end);
end

