%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this exercise


%% Getting parameters

path = '/Users/pbm/Google Drive/THESIS/DATA/People_data/';
type = 'calc';
num_of_sub = 2;
num_of_test_cases = 5;
                          
for i = 1:num_of_sub;
    [train(:,:,i), test(:,:,i)] = prepareData(strcat(path, int2str(i), '/', type), num_of_test_cases, 1, 0.7);
end

for i = 1:num_of_sub;
    if 1 == i
        X = train(:,:,i);
        y = i * ones(size(train(:,:,i), 1), 1);
        XTest = test(:,:,i);
        yTest = i * ones(size(test(:,:,i), 1), 1);
    else
        X = [X ; train(:,:,i)];
        y = [y ; i * ones(size(train(:,:,i), 1), 1)];
        XTest = [XTest ; test(:,:,i)];
        yTest = [yTest ; i * ones(size(test(:,:,i), 1), 1)];
    end
end


%% ================ Part 1: Initializing Pameters ================
%  In this part of the exercise, you will be starting to implment a two
%  layer neural network that classifies digits. You will start by
%  implementing a function to initialize the weights of the neural network
%  (randInitializeWeights.m)

theta_sizes = [size(X,2) 8 6 num_of_sub];

fprintf('\nInitializing Neural Network Parameters ...\n')

for i = 1 : length(theta_sizes) - 1
    initial_Theta = randInitializeWeights(theta_sizes(i), theta_sizes(i + 1));
    if 1 == i 
       initial_nn_params = initial_Theta(:); 
    else
        initial_nn_params = [initial_nn_params ; initial_Theta(:)];
    end
       
end

%% =================== Part 2: Training NN ===================
%  You have now implemented all the code necessary to train a neural 
%  network. To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 200);

%  You should also try different values of lambda
lambda = 0.1;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunctionDeep(p, ...
                                   theta_sizes, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fminunc(costFunction, initial_nn_params, options);

for item = 1 : length(theta_sizes) - 1
    if 1 == item 
        first = 1;
        last = theta_sizes(item + 1) * (theta_sizes(item) + 1);
%    elseif length(theta_sizes) - 1 == i
%        first = 1 + theta_sizes(i) * (theta_sizes(i - 1) + 1);
%        last = length(theta_sizes);
    else
        first = 1 + theta_sizes(item) * (theta_sizes(item - 1) + 1);
        last =  - 1 + first + theta_sizes(item + 1) * (theta_sizes(item) + 1);
    end

    theta{item} = reshape(nn_params(first:last), theta_sizes(item + 1) , (theta_sizes(item) + 1));

end

%% ================= Part 3: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.


pred = predictDeep(theta ,XTest);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == yTest)) * 100);


