function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
  % FeatureMatrix -> the matrix with all training examples
  % Y -> the vector with all actual values
  % tol -> the learning rate
  % iter -> the number of iterations
  % tol -> the tolerance level for convergence of the conjugate gradient method
  % Theta -> the vector of weights

  % TODO: normal_equation implementation
  % https://mathworld.wolfram.com/ConjugateGradientMethodontheNormalEquations.html#:~:text=The%20conjugate%20gradient%20method%20can%20be%20applied%20on,the%20simplest%20methods%20for%20nonsymmetric%20or%20indefinite%20systems.
  [m, n] = size(FeatureMatrix);
  Theta = zeros(n, 1);
  A = FeatureMatrix' * FeatureMatrix;
  b = FeatureMatrix' * Y;

  % de la curs stim ca daca o matrice este pozitiv definita, are toate valorile proprii pozitive
  % https://www.mathworks.com/help/matlab/math/determine-whether-matrix-is-positive-definite.html
  valori_proprii = eig(A);
  isposdef = all(valori_proprii > 0);
  if ~isposdef
    Theta = zeros(n, 1);
    return;
  endif

  x = Theta;
  r = b - A * x;
  v = r;
  tol_squared = tol^2;
  k = 1;
  while (k <= iter && r'*r > tol_squared)
    tk = (r' * r) / (v' * A * v);
    x = x + tk * v;
    r_actual = r - tk * A * v;
    sk = (r_actual' * r_actual) / (r' * r);
    v_actual = r_actual + sk * v;
    r = r_actual;
    v = v_actual;
    k = k + 1;
    Theta = [0; x];
  endwhile
end
