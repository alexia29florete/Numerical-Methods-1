function [J, grad] = cost_function(params, X, y, lambda, ...
                   input_layer_size, hidden_layer_size, ...
                   output_layer_size)

  % params -> vector containing the weights from the two matrices
  %           Theta1 and Theta2 in an unrolled form (as a column vector)
  % X -> the feature matrix containing the training examples
  % y -> a vector containing the labels (from 1 to 10) for each
  %      training example
  % lambda -> the regularization constant/parameter
  % [input|hidden|output]_layer_size -> the sizes of the three layers

  % J -> the cost function for the current parameters
  % grad -> a column vector with the same length as params
  % These will be used for optimization using fmincg

  % TODO: cost_function implementation

  % TODO1: get Theta1 and Theta2 (from params). Hint: reshape
  % https://www.mathworks.com/help/matlab/ref/double.reshape.html
  Theta1 = reshape(params(1:(hidden_layer_size * (input_layer_size + 1))), hidden_layer_size, (input_layer_size + 1));
  Theta2 = reshape(params((1 + hidden_layer_size * (input_layer_size + 1)):end), output_layer_size, (hidden_layer_size + 1));

  % TODO2: Forward propagation
  m = size(X, 1);
  % input layer
  a_1 = [ones(m,1), X];
  % hidden layer
  z_2 = (Theta1 * a_1')';
  a_2 = sigmoid(z_2);
  a_2 = [ones(m,1), a_2];
  % output layer
  z_3 = (Theta2 * a_2')';
  a_3 = sigmoid(z_3);

  % TODO3: Compute the error in the output layer and perform backpropagation
  delta_1 = zeros(size(Theta1));
  delta_2 = zeros(size(Theta2));

  % transform eticheta intr-un vector format doar din 0 si 1:
  % de ex pt numarul 3 un vector cu 4 elem ar putea fi: [0 0 1 0]
  y_matrix = eye(output_layer_size);
  y_matrix = y_matrix(y,:);

  eroare_layer_output = a_3 - y_matrix;
  delta_2 = eroare_layer_output' * a_2;
  sigmoid_derivat = sigmoid(z_2) .* (1 - sigmoid(z_2));
  termen_1 = eroare_layer_output * Theta2;
  eroare_layer_intermediar= termen_1(:, 2:end) .* sigmoid_derivat;
  delta_1 = eroare_layer_intermediar' * a_1;

  % TODO4: Determine the gradients
  Theta1_grad = (1 / m) * delta_1;
  Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + (lambda / m) * Theta1(:, 2:end);

  Theta2_grad = (1 / m) * delta_2;
  Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + (lambda / m) * Theta2(:, 2:end);


  % TODO5: Final J and grad
  cost = -y_matrix .* log(a_3) - (1 - y_matrix) .* log(1 - a_3);
  reg = (lambda / (2*m)) * (sum(sum(Theta1(:, 2:end).^2)) + sum(sum(Theta2(:, 2:end).^2)));
  J = (1 / m) * sum(cost(:)) + reg;

  grad = [Theta1_grad(:); Theta2_grad(:)];
end
