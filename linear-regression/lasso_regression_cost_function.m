function [Error] = lasso_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
  % Theta -> the vector of weights
  % Y -> the vector with all actual values
  % FeatureMatrix -> the matrix with all training examples
  % lambda -> regularization parameter that controls the amount of
  %           shrinkage applied to the regression coefficients

  % Error -> the error of the regularized cost function

  % TODO: lasso_regression_cost_function implementation
  % https://www.mathworks.com/matlabcentral/answers/388316-l1-and-l2-norms
  Theta = Theta(2:end);

  h_theta = FeatureMatrix * Theta;
  m = size(Y, 1);
  suma = (h_theta - Y).^2;
  Error = sum(suma) / m + lambda * norm(Theta, 1);
end
