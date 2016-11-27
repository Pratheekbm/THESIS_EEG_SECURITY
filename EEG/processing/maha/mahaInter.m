function [accuracy, TPR, FPR] = mahaInter(path, type, num_of_sub, num_of_test_cases, class, divide_ratio)


for i = 1:num_of_sub
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, divide_ratio);
  else
    [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, divide_ratio);
    xTrain = [xTrain ; xTrainTemp];
    xTest = [xTest ; xTestTemp];
    yTrain = [yTrain; i * yTrainTemp];
    yTest = [yTest; i * yTestTemp];
  end
end

[xTrain, xTest, yTrain, yTest] = shuffleData(xTrain, xTest, yTrain, yTest);

for i = 1:num_of_sub
  [mu(:,i), Kinv(:,:,i)] = get_maha_features(xTrain, yTrain, i);
end




for i = 1 : num_of_sub
  for j = 1 : size(xTest,1)
    distance(i, j) = get_maha_dist(xTest(j,:)', mu(:,i), Kinv(:,:,i));
  end
end

[min_distance, pred] = min(distance);
accuracy = sum(pred' == yTest)/size(xTest,1) * 100;
[TPR,FPR] = performance(pred, yTest, class);
end