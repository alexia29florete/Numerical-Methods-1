function [classes] = predict_classes(X, weights, ...
                  input_layer_size, hidden_layer_size, ...
                  output_layer_size)
  % X -> the test examples for which the classes must be predicted
  % weights -> the trained weights (after optimization)
  % [input|hidden|output]_layer_size -> the sizes of the three layers

  % classes -> a vector with labels from 1 to 10 corresponding to
  %            the test examples given as parameter

  % TODO: predict_classes implementation
  %Forward propagation
  Theta1 = reshape(weights(1:(hidden_layer_size * (input_layer_size + 1))), hidden_layer_size, (input_layer_size + 1));
  Theta2 = reshape(weights(hidden_layer_size * (input_layer_size + 1) + 1:end), output_layer_size, (hidden_layer_size + 1));

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

  % caut indexul celei mai mari probabilitati
  % https://www.mathworks.com/help/matlab/ref/double.max.html
  [~, classes] =max(a_3, [], 2);
end
