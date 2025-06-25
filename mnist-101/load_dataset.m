function [X, y] = load_dataset(path)
  % path -> a relative path to the .mat file that must be loaded

  % X, y -> the training examples (X) and their corresponding labels (y)

  % TODO: load_dataset implementation
  % https://www.mathworks.com/matlabcentral/answers/195549-how-to-read-data-from-a-mat-file
  S = load(path);
  X = S.X;
  y = S.y;
end
