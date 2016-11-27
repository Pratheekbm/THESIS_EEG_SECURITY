function [distance] = get_maha_sit(data, mu, Kinv)
% data and mu are column vectors
distance = (data - mu)' * Kinv * (data - mu);
end