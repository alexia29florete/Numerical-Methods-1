function [Y, InitialMatrix] = parse_csv_file(file_path)
  % path -> a relative path to the .csv file
  % Y -> the vector with all actual values from the first column
  % InitialMatrix -> the matrix containing all data (without headers)
  % https://youtu.be/cLo2UOBU5yY
  % https://www.mathworks.com/help/matlab/ref/frewind.html
  % https://www.mathworks.com/help/matlab/ref/cell2mat.html
  fid = fopen(file_path, 'r');
  header_line = fgetl(fid);
  headers =strsplit(header_line, ',');
  numar_coloane = length(headers);

  numar_linii = 0;
  while ~feof(fid)
    fgetl(fid); % citesc linia curenta
    numar_linii = numar_linii + 1;  % incrementez numarul de linii
  endwhile

  frewind(fid); %ma reintorc la prima linie
  fgetl(fid); %citesc prima linie unde se afla headerul

  InitialMatrix = cell(numar_linii,numar_coloane); % initializez InitialMatrix cu cell
  for i = 1:numar_linii
    line = fgetl(fid);
    valori = strsplit(line, ','); % desparte elementele folosindu-se de , ca delimitator

    for j = 1:numar_coloane
      val = valori{j};
      number = str2double(val);
      if isnan(number) %daca nu este un numar
          InitialMatrix(i, j) = val; %salvez un string
      else
          InitialMatrix(i, j) = number; %salvez un numar
      endif
    endfor
  endfor

  % extrag vectorul coloana
  Y = cell2mat(InitialMatrix(:, 1));

  InitialMatrix(:, 1) = []; %elimin prima coloana din InitialMatrix
  fclose(fid);
end

