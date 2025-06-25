function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  % X -> the loaded dataset with all training examples
  % y -> the corresponding labels
  % percent -> fraction of training examples to be put in training dataset

  % X_[train|test] -> the datasets for training and test respectively
  % y_[train|test] -> the corresponding labels

  % Example: [X, y] has 1000 training examples with labels and percent = 0.85
  %           -> X_train will have 850 examples
  %           -> X_test will have the other 150 examples

  % TODO: split_dataset implementation

  % amestec exemplele
  % https://stackoverflow.com/questions/5444248/random-order-of-rows-matlab
  % https://www.mathworks.com/help/matlab/ref/randperm.html
  perm = randperm(size(X,1));
  X_amestecat = X(perm,:);
  y_amestecat = y(perm,:);

  % calculez numarul de elemente pentru train si test
  n = size(X, 1);
  n_train = floor(percent * n);
  n_test = n - n_train;

  % construiesc X_train, y_train, X_test, y_test
  X_train = X_amestecat(1:n_train, :);
  y_train = y_amestecat(1:n_train, :);
  X_test = X_amestecat((n_train+1):end, :);
  y_test = y_amestecat((n_train+1):end, :);
end
