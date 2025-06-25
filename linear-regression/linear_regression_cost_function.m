function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  % Theta -> the vector of weights
  % Y -> the vector with all actual values
  % FeatureMatrix -> the matrix with all training examples
  % https://www.mathworks.com/matlabcentral/answers/468415-how-to-compute-cost-function-for-linear-regression
  % Error -> the error of the regularized cost function

  % TODO: linear_regression_cost_function implementation

  % dimensiunea lui Theta ar trebui sa fie (n+2, 1) => fara theta_0 ar trebui sa fie (n+1, 1)
  % FeatureMatrix are m linii si n+1 coloane
  % nu am nevoie de theta0 pentru ca oricum e 0 si theta ar avea n+2 elemente cu theta_0
  Theta = Theta(2:end);

  h_theta = FeatureMatrix * Theta;
  m = size(Y, 1);
  suma = (h_theta - Y).^2;
  Error = sum(suma) / (2 * m);
end
