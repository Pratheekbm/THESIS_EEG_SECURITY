clear; clc;

path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
sub = '4';
type = {'calc', 'breath', 'song'};
num_of_type = length(type);
num_of_test_cases = 5;
num_of_it = 10;
maha_accuracy = zeros(num_of_it,1);
nn_accuracy =  zeros(num_of_it, 1);
svm_accuracy =  zeros(num_of_it, 1);
class = 3;
divide_ratio = 0.7;

for i = 1:num_of_it
  [am, bm, cm] = mahaIntra(path, sub, type, num_of_type, num_of_test_cases, class, divide_ratio);
  maha_accuracy(i) = am;
  maha_TPR(i) = bm;
  maha_FPR(i) = cm;
  [am, bm, cm] = nnIntra(path, sub, type, num_of_type, num_of_test_cases, class, divide_ratio);
  nn_accuracy(i) = am;
  nn_TPR(i) = bm;
  nn_FPR(i) = cm;
  [am, bm, cm] = svmIntra(path, sub, type, num_of_type, num_of_test_cases, class, divide_ratio);
  svm_accuracy(i) = am;
  svm_TPR(i) = bm;
  svm_FPR(i) = cm;
  fprintf('Iteration %d\n', i);
end

maha_accuracy_min = min(maha_accuracy);
maha_accuracy_max = max(maha_accuracy);
maha_accuracy_avg = mean(maha_accuracy);

maha_TPR_min = min(maha_TPR);
maha_TPR_max = max(maha_TPR);
maha_TPR_avg = mean(maha_TPR);

maha_FPR_min = min(maha_FPR);
maha_FPR_max = max(maha_FPR);
maha_FPR_avg = mean(maha_FPR);


nn_accuracy_min = min(nn_accuracy);
nn_accuracy_max = max(nn_accuracy);
nn_accuracy_avg = mean(nn_accuracy);

nn_TPR_min = min(nn_TPR);
nn_TPR_max = max(nn_TPR);
nn_TPR_avg = mean(nn_TPR);

nn_FPR_min = min(nn_FPR);
nn_FPR_max = max(nn_FPR);
nn_FPR_avg = mean(nn_FPR);

svm_accuracy_min = min(svm_accuracy);
svm_accuracy_max = max(svm_accuracy);
svm_accuracy_avg = mean(svm_accuracy);

svm_TPR_min = min(svm_TPR);
svm_TPR_max = max(svm_TPR);
svm_TPR_avg = mean(svm_TPR);

svm_FPR_min = min(svm_FPR);
svm_FPR_max = max(svm_FPR);
svm_FPR_avg = mean(svm_FPR);

fprintf('%s &%.2f &%.2f &%.2f \n', sub, maha_accuracy_min, maha_accuracy_max, maha_accuracy_avg);
fprintf('%s &%.2f &%.2f &%.2f \n', sub, maha_TPR_min, maha_TPR_max, maha_TPR_avg);
fprintf('%s &%.2f &%.2f &%.2f \n', sub, maha_FPR_min, maha_FPR_max, maha_FPR_avg);
fprintf('---------------\n');
fprintf('%s &%.2f &%.2f &%.2f \n', sub, nn_accuracy_min, nn_accuracy_max, nn_accuracy_avg);
fprintf('%s &%.2f &%.2f &%.2f \n', sub, nn_TPR_min, nn_TPR_max, nn_TPR_avg);
fprintf('%s &%.2f &%.2f &%.2f \n', sub, nn_FPR_min, nn_FPR_max, nn_FPR_avg);
fprintf('---------------\n');
fprintf('%s &%.2f &%.2f &%.2f \n', sub, svm_accuracy_min, svm_accuracy_max, svm_accuracy_avg);
fprintf('%s &%.2f &%.2f &%.2f \n', sub, svm_TPR_min, svm_TPR_max, svm_TPR_avg);
fprintf('%s &%.2f &%.2f &%.2f \n', sub, svm_FPR_min, svm_FPR_max, svm_FPR_avg);