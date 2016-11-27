function [mu, Kinv] = get_maha_features(data, y, subId)
% Returns mean and Kinv required for mahalanobis
a = y == subId;
mu = mean(data(a,:),1);
Kinv = inv(cov(data(a,:)));
end


