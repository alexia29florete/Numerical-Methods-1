function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  % InitialMatrix -> the matrix that must be transformed

  % FeatureMatrix -> the matrix with all training examples

  % TODO: prepare_for_regression implementation
  [n, m] = size(InitialMatrix);
  FeatureMatrix = [];

  % furnished/semi-furnished/unfurnished, cele pe care trebuie sa le extind cu o coloana

  for i = 1:n
    k = 1;
    for j = 1:m
      if isnumeric(InitialMatrix{i, j}) %daca e un numar (isnumeric)
        FeatureMatrix(i, k) = InitialMatrix{i, j}; %stochez numarul in matricea FeatureMatrix
        k = k + 1; %avansez coloanele si pentru FeatureMatrix
      elseif strcmp(InitialMatrix{i, j}, 'yes')
        FeatureMatrix(i, k) = 1;
        k = k + 1; %avansez coloanele si pentru FeatureMatrix
      elseif strcmp(InitialMatrix{i, j}, 'no')
        FeatureMatrix(i, k) = 0;
        k = k + 1; %avansez coloanele si pentru FeatureMatrix
      elseif strcmp(InitialMatrix{i, j}, 'furnished')
        FeatureMatrix(i, k) = 0;
        FeatureMatrix(i, k + 1) = 0;
        k = k + 2; %avansez coloanele si pentru FeatureMatrix
      elseif strcmp(InitialMatrix{i, j}, 'unfurnished')
        FeatureMatrix(i, k) = 0;
        FeatureMatrix(i, k + 1) = 1;
        k = k + 2; %avansez coloanele si pentru FeatureMatrix
      elseif strcmp(InitialMatrix{i, j}, 'semi-furnished')
        FeatureMatrix(i, k) = 1;
        FeatureMatrix(i, k + 1) = 0;
        k = k + 2; %avansez coloanele si pentru FeatureMatrix
      endif
    endfor
  endfor
end
