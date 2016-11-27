clear;
clc;
set(0, 'DefaultAxesFontSize', 16, 'DefaultAxesFontWeight', 'normal');
path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
type = 'calc';
num_of_sub = 4;
num_of_test_cases = 5;


for i = 1:num_of_sub
    if 1 == i
        [xTrain, xTest, yTrain, yTest] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 1);
        mu = mean(xTrain,1);
        sig = var(xTrain,1);
    else
        [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 1);
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

h = figure;
bar(mu');
grid on
ylabel('Mean')
xlabel('Frequency Bands, Delta to Gamma')
title('Mean Graph for Inter Subject - Calc')
axis([0,9,0,1])
legend({'Sub 1','Sub 2','Sub 3','Sub 4'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('1', '-dpdf');

h = figure;
bar(sig');
grid on
xlabel('Frequency Bands, Delta to Gamma')
ylabel('Variance')
title('Variance Graph for Inter Subject - Calc')
axis([0,9,0,1])
legend({'Sub 1','Sub 2','Sub 3','Sub 4'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('2', '-dpdf');

%-----------------------------------------------------------------------
path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
type = 'breath';
num_of_sub = 4;
num_of_test_cases = 5;


for i = 1:num_of_sub
    if 1 == i
        [xTrain, xTest, yTrain, yTest] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 1);
        mu = mean(xTrain,1);
        sig = var(xTrain,1);
    else
        [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 1);
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

h = figure;
bar(mu');
grid on
ylabel('Mean')
xlabel('Frequency Bands, Delta to Gamma')
title('Mean Graph for Inter Subject - Breath')
axis([0,9,0,1])
legend({'Sub 1','Sub 2','Sub 3','Sub 4'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('3', '-dpdf');

h = figure;
bar(sig');
grid on
xlabel('Frequency Bands, Delta to Gamma')
ylabel('Variance')
title('Variance Graph for Inter Subject - Breath')
axis([0,9,0,1])
legend({'Sub 1','Sub 2','Sub 3','Sub 4'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('4', '-dpdf');
%-----------------------------------------------------------------------


path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
type = 'song';
num_of_sub = 4;
num_of_test_cases = 5;


for i = 1:num_of_sub
    if 1 == i
        [xTrain, xTest, yTrain, yTest] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 1);
        mu = mean(xTrain,1);
        sig = var(xTrain,1);
    else
        [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 1);
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

h = figure;
bar(mu');
grid on
ylabel('Mean')
xlabel('Frequency Bands, Delta to Gamma')
title('Mean Graph for Inter Subject - Song')
axis([0,9,0,1])
legend({'Sub 1','Sub 2','Sub 3','Sub 4'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('5', '-dpdf');

h = figure;
bar(sig');
grid on
xlabel('Frequency Bands, Delta to Gamma')
ylabel('Variance')
title('Variance Graph for Inter Subject - Song')
axis([0,9,0,1])
legend({'Sub 1','Sub 2','Sub 3','Sub 4'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('6', '-dpdf');