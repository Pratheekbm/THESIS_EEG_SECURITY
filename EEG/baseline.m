clc;clear;
set(0, 'DefaultAxesFontSize', 16, 'DefaultAxesFontWeight', 'normal');
calc =   [100/2 80.33 87.33 94.00; 100/3 74.44 84.22 83.33; ...
  100/4 72.67 79.50 77.50; 100/5 70.27 74.40 67.60;...
  100/6 56.11 62.89 59.00; 100/7 52.76 58.78 48.57; ...
  100/8 47.83 52.00 44.08; 100/9 45.26 46.22 39.63];
breath = [100/2 63.33 71.00 73.67; 100/3 52.67 56.67 58.22; ...
  100/4 56.50 61.50 57.17; 100/5 58.13 56.53 51.73 ;...
  100/6 58.11 56.22 47.11; 100/7 53.90 52.67 41.52;...
  100/8 45.58 45.75 37.58; 100/9 38.96 43.19 34.74];
song =   [100/2 81.00 90.33 92.33; 100/3 74.44 78.44 76.67; ...
  100/4 67.00 73.17 72.00; 100/5 67.20 71.20 65.07;...
  100/6 62.00 66.11 62.56; 100/7 56.95 58.48 51.33;...
  100/8 50.58 52.92 45.42; 100/9 43.48 47.78 41.04];

all(1,:,:) = calc;
all(2,:,:) = breath;
all(3,:,:) = song;
x= 2:9;
h = figure;
bar(x, calc);
ylabel('Accuracy in %')
xlabel('Number of subjects used for classification')
title('Preformance vs number of classes for calculation task')
legend({'Baseline','Maha','NN','SVM'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('calc_base', '-dpdf');

h = figure;
bar(x, song);
ylabel('Accuracy in %')
xlabel('Number of subjects used for classification')
title('Preformance vs number of classes for song task')
legend({'Baseline','Maha','NN','SVM'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('breath_base', '-dpdf');

h = figure;
bar(x, breath);
ylabel('Accuracy in %')
xlabel('Number of subjects used for classification')
title('Preformance vs number of classes for breathing task')
legend({'Baseline','Maha','NN','SVM'},'Location','northeast')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('song_base', '-dpdf');
