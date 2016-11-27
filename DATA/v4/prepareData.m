function [trainData, testData] = prepareData(file_name, testCases, normalize, test_percent)
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

if (test_percent == 1.0)
    trainData = data;
    testData = data;
else
    totalLength = size(data, 1);
    trainLength = floor(totalLength * test_percent);
    trainData = data(1:trainLength, :);
    testData = data(trainLength + 1: end, :);
end

end
