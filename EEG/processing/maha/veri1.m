clear;clc;
path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
sub = '4';
type = {'calc';'breath'};
num_of_type = length(type);
num_of_test_cases = 5;

for i = 1:num_of_type;
    filePath = strcat(path, sub, '/', type);
    
    if 1 == i
        [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    else
        [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
        xTrain = [xTrain ; xTrainTemp];
        xTest = [xTest ; xTestTemp];
        yTrain = [yTrain; i * yTrainTemp];
        yTest = [yTest; i * yTestTemp];
    end
end

%[xTrain, xTest, yTrain, yTest] = shuffleData(xTrain, xTest, yTrain, yTest);

for i = 1:num_of_type;
    [mu(:,i), Kinv(:,:,i)] = get_maha_features(xTrain, yTrain, i);
end

for i = 1 : num_of_type
    for j = 1 : size(xTest,1)
      distance(i, j) = get_maha_dist(xTest(j,:)', mu(:,i), Kinv(:,:,i));
   end
end

[min_distance, pred] = min(distance);

j = 1;
for i = 1 : 5 : length(pred)
    actual(j) = mode(yTest(i:i+4));
    result(j) = mode(pred(i:i+4));
    j = j + 1;
end

accuracy = sum(actual == result)/length(result);
accuracy = accuracy * 100
