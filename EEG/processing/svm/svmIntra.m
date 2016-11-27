function [accuracy, TPR, FPR] = svmIntra(path, sub, type, num_of_type, ...
  num_of_test_cases, class, divide_ratio)

for i = 1:num_of_type
  filePath = strcat(path, sub, '/', type);
  
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i},...
      num_of_test_cases, 1, divide_ratio);
  else
    [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(...
      filePath{i}, num_of_test_cases, 1, divide_ratio);
    xTrain = [xTrain ; xTrainTemp];
    xTest = [xTest ; xTestTemp];
    yTrain = [yTrain; i * yTrainTemp];
    yTest = [yTest; i * yTestTemp];
  end
end

[xTrain, xTest, yTrain, yTest] = shuffleData(xTrain, xTest, yTrain, yTest);

uniqueClasses = unique(yTrain);
numClasses = length(uniqueClasses);
pred = zeros(size(yTest));

for i = 1:numClasses
  onevAll = (yTrain == uniqueClasses(i));
  trainedModels(i) = svmtrain(xTrain, onevAll);
end

for j = 1 : size(xTest,1)
  for k = 1 : numClasses
    if(svmclassify(trainedModels(k), xTest(j,:)))
      break;
    end
  end
  pred(j) = k;
end

accuracy = sum(pred == yTest)/size(xTest, 1);
accuracy = accuracy * 100;
[TPR,FPR] = performance(pred, yTest, class);
end