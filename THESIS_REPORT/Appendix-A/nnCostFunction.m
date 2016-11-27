function [J, grad] = nnCostFunction(nn_params, ...
  input_layer_size, ...
  hidden_layer_size, ...
  num_labels, ...
  X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices.
%
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
  hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
  num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
X = [ones(m,1) X];
% You need to return the following variables correctly
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
yk_base = (1:num_labels)';

for i = 1:m
  z2 = Theta1 * X(i,:)';
  a2 = sigmoid(z2);
  a2 = [1 ;a2];
  z3 = Theta2 * a2;
  a3 = sigmoid(z3);
  yk = yk_base == y(i);
  J = J + ((-1 * yk' * log(a3)) - ((1 - yk)' * log(1 - a3)));
  
  delta3 = a3 - yk;
  delta2 = Theta2' * delta3 .* sigmoidGradient([1;z2]);
  delta2 = delta2(2:end);
  Theta2_grad = Theta2_grad + delta3 * a2';
  Theta1_grad = Theta1_grad + delta2 * X(i,:);
end
J = J/m;

J = J + ((lambda/(2 * m)) * (sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2))));
Theta1_grad = (1/m) * Theta1_grad;
Theta2_grad = (1/m) * Theta2_grad;
Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + (lambda/m) * Theta1(:,2:end);
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + (lambda/m) * Theta2(:,2:end);
grad = [Theta1_grad(:) ; Theta2_grad(:)];
end