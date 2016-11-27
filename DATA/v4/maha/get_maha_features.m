function [mu, Kinv] = get_maha_features(data)
% Returns mean and Kinv required for mahalanobis

mu = mean(data,1);
Kinv = inv(cov(data));
end


