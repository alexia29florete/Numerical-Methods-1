function [Adj] = get_adjacency_matrix (Labyrinth)
	% Labyrinth -> the matrix of all encodings
  % Adj -> the adjacency matrix associated to the given labyrinth
  % TODO: get_adjacency_matrix implementation

  [n, m] = size(Labyrinth);
  Matricea_starilor = zeros(n, m);
  %determin matricea starilor
  for i = 1:n
    for j = 1:m
      Matricea_starilor(1, j) = j;
      Matricea_starilor(i, j) = j + m * (i - 1);
    endfor
  endfor

  %https://www.mathworks.com/help/matlab/matlab_prog/bit-wise-operations.html
  %determin matricea de adiacenta
  Adj = zeros(n * m + 2);
  for i = 1:n
    for j = 1:m
      b3 = bitget(Labyrinth(i, j), 4);
      b2 = bitget(Labyrinth(i, j), 3);
      b1 = bitget(Labyrinth(i, j), 2);
      b0 = bitget(Labyrinth(i, j), 1);

      %sus
      if (i > 1 && bitget(Labyrinth(i - 1, j), 3) == 0 && bitget(Labyrinth(i, j), 4) == 0)
        Adj(Matricea_starilor(i - 1, j), Matricea_starilor(i, j) ) = 1;
        Adj(Matricea_starilor(i, j), Matricea_starilor(i - 1, j) ) = 1;
      elseif (i == 1 && b3 == 0) %win pe prima linie
        Adj(Matricea_starilor(i, j), n * m + 1) = 1;
      endif

      %stanga
      if (j > 1 && bitget(Labyrinth(i, j - 1), 2) == 0 && bitget(Labyrinth(i, j), 1) == 0)
        Adj(Matricea_starilor(i, j - 1), Matricea_starilor(i, j) ) = 1;
        Adj(Matricea_starilor(i, j), Matricea_starilor(i, j - 1) ) = 1;
      elseif (j == 1 && b0 == 0) %lose pe prima coloana
        Adj(Matricea_starilor(i, j), n * m + 2) = 1;
      endif

      %jos
      if (i < n && bitget(Labyrinth(i + 1, j), 4) == 0 && bitget(Labyrinth(i, j), 3) == 0)
        Adj(Matricea_starilor(i + 1, j), Matricea_starilor(i, j)) = 1;
        Adj(Matricea_starilor(i, j), Matricea_starilor(i + 1, j)) = 1;
      elseif (i == n && b2 == 0) %win pe ultima linie
        Adj(Matricea_starilor(i, j), n * m + 1) = 1;
      endif

      %dreapta
      if (j < m && bitget(Labyrinth(i, j + 1), 1) == 0 && bitget(Labyrinth(i, j), 2) == 0)
        Adj(Matricea_starilor(i, j + 1), Matricea_starilor(i, j)) = 1;
        Adj(Matricea_starilor(i, j), Matricea_starilor(i, j + 1)) = 1;
      elseif (j == m && b1 == 0) %lose pe ultima coloana
        Adj(Matricea_starilor(i, j), n * m + 2) = 1;
      endif
    endfor
  endfor
  Adj(n * m + 1, n * m + 1) = 1;
  Adj(n * m + 2, n * m + 2) = 1;

  Adj_temp = sparse(Adj);
  Adj = Adj_temp;
end
