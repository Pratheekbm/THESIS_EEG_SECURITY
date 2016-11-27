function [accuracy, TPR, FPR] = nnIntra(path, sub, type, num_of_type, num_of_test_cases, class, divide_ratio)
input_layer_size  = 8;
hidden_layer_size = 8;
num_labels = num_of_type;

for i = 1:num_of_type;
  filePath = strcat(path, sub, '/', type);
  
  if 1 == i
    [xTrain, xTest, yTrain, yTest] = prepareData(filePath{i}, ...
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


initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

options = optimset('MaxIter', 200);

%  You should also try different values of lambda
lambda = 0.2;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
  input_layer_size, ...
  hidden_layer_size, ...
  num_labels, xTrain, yTrain, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
  hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
  num_labels, (hidden_layer_size + 1));


pred = predict(Theta1, Theta2, xTest);
accuracy =  mean(double(pred == yTest)) * 100;
[TPR,FPR] = performance(pred, yTest, class);
end