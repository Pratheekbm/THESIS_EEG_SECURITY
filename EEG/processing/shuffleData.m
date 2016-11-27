function [xTrain, xTest, yTrain, yTest] = shuffleData(ixTrain, ixTest, iyTrain, iyTest)

ranLoc = randperm(size(ixTrain, 1));
xTrain = ixTrain(ranLoc,:);
yTrain = iyTrain(ranLoc);

ranLoc = randperm(size(ixTest, 1));
xTest = ixTest(ranLoc,:);
yTest = iyTest(ranLoc);
end