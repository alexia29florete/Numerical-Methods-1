function [decoded_path] = decode_path (path, lines, cols)
	% path -> vector containing the order of the states that arrived
	% 		 to a winning position
	% lines -> numeber of lines
	% cols -> number of columns

	% decoded_path -> vector of pairs (line_index, column_index)
  %                 corresponding to path states
  % hint: decoded_path does not contain indices for the WIN state

  % TODO: decode_path implementation

  Matricea_starilor = zeros(lines, cols);
  decoded_path = [];
  %determin matricea starilor
  for i = 1:lines
    for j = 1:cols
      Matricea_starilor(1, j) = j;
      Matricea_starilor(i, j) = j + cols * (i - 1);
    endfor
  endfor

  %pentru fiecare stare din path, caut coordonatele in matricea starilor
  for k = 1:length(path)
    %daca gasesc starea de win, nu o salvez si trec mai departe
    if path(k) == lines * cols + 1
      continue;
    endif
    for i = 1:lines
      for j = 1:cols
        if path(k) == Matricea_starilor(i, j)
          decoded_path(k, :) = [i, j];
        endif
      endfor
    endfor
  endfor
end
