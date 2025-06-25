function [Y, InitialMatrix] = parse_data_set_file(file_path)
  % path -> a relative path to the .txt file

  % Y -> the vector with all actual values
  % InitialMatrix -> the matrix that must be transformed

  % TODO: parse_data_set_file implementation
  fid = fopen(file_path, 'r');
  dimensiune = fscanf(fid, '%d', 2);
  m = dimensiune(1); %numarul de linii
  n = dimensiune(2); %numarul de coloane
  Y = zeros(m, 1); %initializez Y ca vector coloana
  InitialMatrix = cell(m, n+1);

  for i = 1:m
    for j = 1:(n + 1)
      %verific daca urmatorul element este un numar sau un string
      string = fscanf(fid, '%s', 1);
      number = str2double(string); % convertesc din string in double
      if isnan(number) %daca nu este un numar
          InitialMatrix(i, j) = string; %salvez un string
      else
          InitialMatrix(i, j) = number; %salvez un numar
      endif
    endfor
  endfor

  % extrag vectorul coloana
  for i = 1:m
    Y(i) = InitialMatrix{i, 1};
  endfor

  InitialMatrix(:, 1) = []; %elimin prima coloana din InitialMatrix
  fclose(fid);
  %http://www.ece.northwestern.edu/local-apps/matlabhelp/techdoc/ref/fscanf.html
  %https://www.mathworks.com/help/matlab/ref/str2double.html
  %https://www.mathworks.com/help/matlab/ref/double.isnan.html
end
