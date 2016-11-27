clear; clc;

path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
type = 'song';
num_of_sub = 3;
num_of_test_cases = 5;

for i = 1:num_of_sub;
    [train(:,:,i), test(:,:,i)] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 0.7);
    [mu(:,i), Kinv(:,:,i)] = get_maha_features(train(:,:,i));
end

for i = 1:num_of_sub;
    if 1 == i
        test_vec = test(:,:,i);
        y = i * ones(size(test(:,:,i), 1), 1);
    else
        test_vec = [test_vec ; test(:,:,i)];
        y = [y ; i * ones(size(test(:,:,i), 1), 1)];
    end
end

for i = 1 : num_of_sub
    for j = 1 : size(test_vec,1)
      distance(i, j) = get_maha_dist(test_vec(j,:)', mu(:,i), Kinv(:,:,i));
   end
end

[min_distance, pred] = min(distance);

accuracy = sum(pred' == y)/size(test_vec,1) * 100