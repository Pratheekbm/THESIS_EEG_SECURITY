function [accuracy, TPR, FPR] = mahaIntra(path, sub, type, num_of_type, num_of_test_cases, class, divide_ratio)

for i = 1:num_of_type
  filePath = strcat(path, sub, '/', type);
  
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i}, num_of_test_cases, 1, divide_ratio);
  else
    [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(filePath{i}, num_of_test_cases, 1, divide_ratio);
    xTrain = [xTrain ; xTrainTemp];
    xTest = [xTest ; xTestTemp];
    yTrain = [yTrain; i * yTrainTemp];
    yTest = [yTest; i * yTestTemp];
  end
end

[xTrain, xTest, yTrain, yTest] = shuffleData(xTrain, xTest, yTrain, yTest);

for i = 1:num_of_type
  [mu(:,i), Kinv(:,:,i)] = get_maha_features(xTrain, yTrain, i);
end


for i = 1 : num_of_type
  for j = 1 : size(xTest,1)
    distance(i, j) = get_maha_dist(xTest(j,:)', mu(:,i), Kinv(:,:,i));
  end
end

[min_distance, pred] = min(distance);

accuracy = sum(pred' == yTest)/size(xTest,1);
accuracy = accuracy * 100;
[TPR,FPR] = performance(pred, yTest, class);
end