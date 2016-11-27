clear;
clc;

path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
sub = '1';
type = {'calc'; 'breath'; 'song'};
num_of_type = length(type);
num_of_test_cases = 5;


for i = 1:num_of_type
  filePath = strcat(path, sub, '/', type);
  
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    mu = mean(xTrain,1);
    sig = var(xTrain,1);
  else
    [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    xTrain = [xTrain ; xTrainTemp];
    xTest = [xTest ; xTestTemp];
    yTrain = [yTrain; i * yTrainTemp];
    yTest = [yTest; i * yTestTemp];
    muTemp = mean(xTrain,1);
    sigTemp = var(xTrain,1);
    mu = [mu; muTemp];
    sig = [sig; muTemp];
    
  end
end

figure;
bar(mu');
grid on
ylabel('Mean')
xlabel('Frequency Bands, Delta to Gamma')
title('Mean Graph for Intra Subject - Sub 1')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


figure;
bar(sig');
grid on
xlabel('Frequency Bands, Delta to Gamma')
ylabel('Variance')
title('Variance Graph for Intra Subject - Sub 1')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


%-----------------------------------------------------------------------------

path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
sub = '2';
type = {'calc'; 'breath'; 'song'};
num_of_type = length(type);
num_of_test_cases = 5;


for i = 1:num_of_type;
  filePath = strcat(path, sub, '/', type);
  
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    mu = mean(xTrain,1);
    sig = var(xTrain,1);
  else
    [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    xTrain = [xTrain ; xTrainTemp];
    xTest = [xTest ; xTestTemp];
    yTrain = [yTrain; i * yTrainTemp];
    yTest = [yTest; i * yTestTemp];
    muTemp = mean(xTrain,1);
    sigTemp = var(xTrain,1);
    mu = [mu; muTemp];
    sig = [sig; muTemp];
    
  end
end

figure;
bar(mu');
grid on
ylabel('Mean')
xlabel('Frequency Bands, Delta to Gamma')
title('Mean Graph for Intra Subject - Sub 2')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


figure;
bar(sig');
grid on
xlabel('Frequency Bands, Delta to Gamma')
ylabel('Variance')
title('Variance Graph for Intra Subject - Sub 2')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


%-----------------------------------------------------------------------------

path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
sub = '3';
type = {'calc'; 'breath'; 'song'};
num_of_type = length(type);
num_of_test_cases = 5;


for i = 1:num_of_type;
  filePath = strcat(path, sub, '/', type);
  
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    mu = mean(xTrain,1);
    sig = var(xTrain,1);
  else
    [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    xTrain = [xTrain ; xTrainTemp];
    xTest = [xTest ; xTestTemp];
    yTrain = [yTrain; i * yTrainTemp];
    yTest = [yTest; i * yTestTemp];
    muTemp = mean(xTrain,1);
    sigTemp = var(xTrain,1);
    mu = [mu; muTemp];
    sig = [sig; muTemp];
    
  end
end

figure;
bar(mu');
grid on
ylabel('Mean')
xlabel('Frequency Bands, Delta to Gamma')
title('Mean Graph for Intra Subject - Sub 3')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


figure;
bar(sig');
grid on
xlabel('Frequency Bands, Delta to Gamma')
ylabel('Variance')
title('Variance Graph for Intra Subject - Sub 3')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


%-----------------------------------------------------------------------------


path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
sub = '4';
type = {'calc'; 'breath'; 'song'};
num_of_type = length(type);
num_of_test_cases = 5;


for i = 1:num_of_type;
  filePath = strcat(path, sub, '/', type);
  
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    mu = mean(xTrain,1);
    sig = var(xTrain,1);
  else
    [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(filePath{i}, num_of_test_cases, 1, 0.7);
    xTrain = [xTrain ; xTrainTemp];
    xTest = [xTest ; xTestTemp];
    yTrain = [yTrain; i * yTrainTemp];
    yTest = [yTest; i * yTestTemp];
    muTemp = mean(xTrain,1);
    sigTemp = var(xTrain,1);
    mu = [mu; muTemp];
    sig = [sig; muTemp];
    
  end
end

figure;
bar(mu');
grid on
ylabel('Mean')
xlabel('Frequency Bands, Delta to Gamma')
title('Mean Graph for Intra Subject - Sub 4')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


figure;
bar(sig');
grid on
xlabel('Frequency Bands, Delta to Gamma')
ylabel('Variance')
title('Variance Graph for Intra Subject - Sub 4')
axis([0,8,0,1])
legend({'Calc','Breath','Song'},'Location','northwest')


%-----------------------------------------------------------------------------
