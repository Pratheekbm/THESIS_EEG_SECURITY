function [J grad] = nnCostFunctionDeep(nn_params, ...
                                   theta_sizes, ...
                                   X, y, lambda)

num_labels = 0;

for item = 1 : length(theta_sizes) - 1
    if 1 == item 
        first = 1;
        last = theta_sizes(item + 1) * (theta_sizes(item) + 1);
    else
        first = 1 + theta_sizes(item) * (theta_sizes(item - 1) + 1);
        last =  - 1 + first + theta_sizes(item + 1) * (theta_sizes(item) + 1);
    end

    theta{item} = reshape(nn_params(first:last), theta_sizes(item + 1) , (theta_sizes(item) + 1));
    temp = 0 * theta{item};
    theta_grad{item} = temp;

    if length(theta_sizes) - 1 == item
        num_labels = theta_sizes(item + 1);
    end
end


% Setup some useful variables
m = size(X, 1);
X = [ones(m,1) X];
% You need to return the following variables correctly 
J = 0;

yk_base = (1:num_labels)';

for item = 1:m
    yk = yk_base == y(item);
    % Feed forward algorithm
    
    for i_ff = 1 : length(theta_sizes)
        if 1 == i_ff
            a{i_ff} =  X(item,:)';
            z{i_ff} = 0;
        elseif length(theta_sizes) == i_ff
            z{i_ff} =  theta{i_ff - 1} * a{i_ff - 1};
            a{i_ff} = sigmoid(z{i_ff});
        else
            z{i_ff} =  theta{i_ff - 1} * a{i_ff - 1};
            a{i_ff} = [1; sigmoid(z{i_ff})];
        end
    end
    
    J = J + ((-1 * yk' * log(a{i_ff})) - ((1 - yk)' * log(1 - a{i_ff})));
    
    % Backword Propagation algorithm
    for i_bp = i_ff:-1:2
        if i_bp == i_ff
            delta{i_bp} = a{i_bp} - yk;
        else
             temp_delta = theta{i_bp}' * delta{i_bp + 1} .* sigmoidGradient([1;z{i_bp}]);
             delta{i_bp} = temp_delta(2:end);
        end
        theta_grad{i_bp - 1} = theta_grad{i_bp - 1} + delta{i_bp} * a{i_bp - 1}';
    end
    
end
J = J/m;

for i = 1 : length(theta)
    tempTheta = theta{i};
    J = J + ((lambda/(2 * m)) * (sum(sum(tempTheta(:,2:end).^2))) );
    tempGrad = (1/m) * theta_grad{i};
    tempGrad(:,2:end) = tempGrad(:,2:end) + (lambda/m) * tempTheta(:,2:end);
    theta_grad{i} = tempGrad;
end


% =========================================================================
% Unroll gradients
for i = 1 : length(theta)
    temp = theta_grad{i};
    if 1 == i
        grad = temp(:);
    else
        grad = [grad ; temp(:)];
    end
end

end
