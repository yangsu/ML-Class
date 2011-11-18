function [error_train, error_val] = ...
    learningCurveRandom(X, y, Xval, yval, lambda, repeats)
%LEARNINGCURVE Generates the train and cross validation set errors needed 
%to plot a learning curve
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) returns the train and
%       cross validation set errors for a learning curve. In particular, 
%       it returns two vectors of the same length - error_train and 
%       error_val. Then, error_train(i) contains the training error for
%       i examples (and similarly for error_val(i)).
%
%   In this function, you will compute the train and test errors for
%   dataset sizes from 1 up to m. In practice, when working with larger
%   datasets, you might want to do this in larger intervals.
%

% Number of training examples
m = size(X, 1);

% Number of validation examples
n = size(Xval, 1);

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return training errors in 
%               error_train and the cross validation errors in error_val. 
%               The vector numex_vec contains the number of training 
%               examples to use for each calculation of training error and 
%               cross validation error, i.e, error_train(i) and 
%               error_val(i) should give you the errors
%               obtained after training on i examples.
%
% Note: You should evaluate the training error on the first i training
%       examples (i.e., X(1:i, :) and y(1:i)).
%
%       For the cross-validation error, you should instead evaluate on
%       the _entire_ cross validation set (Xval and yval).
%
% Note: If you are using your cost function (linearRegCostFunction)
%       to compute the training and cross validation error, you should 
%       call the function with the lambda argument set to 0. 
%       Do note that you will still need to use lambda when running
%       the training to obtain the theta parameters.
%

% Compute train/cross validation errors using training examples 
for i = 1:m
  errval = 0;
  errtrain = 0;
  for j=1:repeats
    % Randomly select i numbers from the training set
    indices = randperm(m)(1:i);
    tx = X(indices, :);
    ty = y(indices);
    
    theta = trainLinearReg(tx, ty, lambda);
    errtrain += linearRegCostFunction(tx, ty, theta, 0);

    % Randomly select i numbers from the validation set
    indices = randperm(n)(1:i);
    txval = Xval(indices, :);
    tyval = yval(indices);
    
    errval += linearRegCostFunction(txval, tyval, theta, 0);
  end
  error_train(i) = errtrain/repeats;
  error_val(i) = errval/repeats;
end

% -------------------------------------------------------------

% =========================================================================

end
