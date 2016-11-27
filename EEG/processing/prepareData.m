function [xTrain, xTest, yTrain, yTest] = prepareData(file_name, ...
  testCases, normalize, divideRatio)
% Takes in filename, number of test cases with that filename,
% and a flag to wheather to normalize of not as input and
% returns feature vector with all the data with that filename
% combined


for i = 1:testCases
  name = strcat(file_name, int2str(i), '.dat');
  if 1 == i
    features = getFeatures(name);
  else
    features = [features ; getFeatures(name)];
  end
end

if 1 == normalize
  mag =  sqrt(sum(abs(features).^2,2));
  data = bsxfun(@rdivide, features, mag);
else
  data = features;
end

ranLoc = randperm(size(data, 1));
data = data(ranLoc,:);
y = ones(size(data, 1), 1);

if (divideRatio == 1.0)
  xTrain = data;
  xTest = data;
  yTrain = y;
  yTest = y;
else
  totalLength = size(data, 1);
  trainLength = floor(totalLength * divideRatio);
  xTrain = data(1:trainLength, :);
  xTest = data(trainLength + 1: end, :);
  yTrain = y(1:trainLength);
  yTest = y(trainLength + 1: end);
end
end
