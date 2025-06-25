function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  % FeatureMatrix -> the matrix with all training examples
  % Y -> the vector with all actual values
  % n -> the number of predictors
  % m -> the number of trainings
  % alpha -> the learning rate
  % iter -> the number of iterations

  % Theta -> the vector of weights

  % TODO: gradient_descent implementation

  % initializez Theta cu dimensiunea de (n+1, 1) pentru ca FeatureMatrix are n+1 coloane
  Theta = zeros(n+1, 1);

  for k = 1:iter
    h_theta = FeatureMatrix * Theta(2:end);
    eroarea = h_theta - Y;
    derivate_partiale = (FeatureMatrix' * eroarea) / m;
    Theta(2:end) = Theta(2:end) - alpha * derivate_partiale;
  endfor
end
