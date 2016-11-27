clear; clc;

path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
type = 'breath';
num_of_sub = 4;
num_of_test_cases = 5;
num_of_it = 10;
normalize = 1;
for i = 1:num_of_sub
    if 1 == i
        [xTrain, xTest, yTrain, yTest] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, normalize, 1);
    else
        [xTrainTemp, xTestTemp, yTrainTemp, yTestTemp] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, normalize, 1);
        xTrain = [xTrain ; xTrainTemp];
        xTest = [xTest ; xTestTemp];
        yTrain = [yTrain; i * yTrainTemp];
        yTest = [yTest; i * yTestTemp];
    end
end

for i = 1:num_of_sub;
    [mu(:,i), Kinv(:,:,i)] = get_maha_features(xTrain, yTrain, i);
end

for i = 1:size(xTrain,1)
   for j = 1:size(xTrain,1)
        dist(i, j) = norm(xTrain(i,:) - xTrain(j,:));
   end    
end

class_size = 50;
for i = 1 : num_of_sub
    for j = 1 : size(xTest,1)
      maha_distance(i, j) = get_maha_dist(xTest(j,:)', mu(:,i), Kinv(:,:,i));
   end
end

for i = 1 : num_of_sub
    class_start = (i - 1) * class_size + 1;
    class_end = (i) * class_size;
    for j = 1 : size(xTest,1)
        min = 1000000;
        max = 0;
        for k = class_start:class_end
           if(dist(j,k) < min && dist(j,k) ~= 0 )
              min = dist(j,k); 
           end
           if(dist(j,k) > max)
              max = dist(j,k);
           end
        end
        min_matrix(i, j) = min;
        max_matrix(i, j) = max;
    end
end
x = 1 : size(xTest,1);

for i = 1:num_of_sub
   figure;
   %set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
   %subplot(3, 1, 1);
   a = mat2cell(maha_distance(i,:),1, [50 50 50 50]);
   plot(a{1});
   hold on
   plot(a{2});
   plot(a{3});
   plot(a{4});   
   %plot(maha_distance(i,:));
   %subplot(3, 1, 2);
   %plot(min_matrix(i,:));
   %subplot(3, 1, 3);
   %plot(max_matrix(i,:));
end

