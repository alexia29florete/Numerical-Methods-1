function [Link] = get_link_matrix (Labyrinth)
	% Labyrinth -> the matrix of all encodings

  % Link -> the link matrix associated to the given labyrinth
  % TODO: get_link_matrix implementation
  %numarul de zerouri din codificarea binara imi spune cate cai de acces am in labirint => scot usor probabilitatea
  [n, m] = size(Labyrinth);
  Matricea_starilor = zeros(n, m);
  Matrice_nr_zerouri_codificare_binara = zeros(n, m);
  %determin matricea starilor
  for i = 1:n
    for j = 1:m
      Matricea_starilor(1, j) = j;
      Matricea_starilor(i, j) = j + m * (i - 1);
    endfor
  endfor

  %salvez intr-o matrice numarul de zerouri din reprezedntarea binara a fiecarui numar
  for i = 1:n
    for j = 1:m
      num = Labyrinth(i, j);
      nr_zero = 0;
      for k = 0:3
        if bitand(num, bitshift(1, k)) == 0 %(num & (1 << k))
          Matrice_nr_zerouri_codificare_binara(i, j) = Matrice_nr_zerouri_codificare_binara(i, j) + 1;
        endif
      endfor
    endfor
  endfor

  %determin matricea legaturilor
  Link = zeros(n * m + 2);
  for i = 1:n
    for j = 1:m
      b3 = bitget(Labyrinth(i, j), 4);
      b2 = bitget(Labyrinth(i, j), 3);
      b1 = bitget(Labyrinth(i, j), 2);
      b0 = bitget(Labyrinth(i, j), 1);
      probabilitatea = 1 / Matrice_nr_zerouri_codificare_binara(i, j);

      %sus
      if (i > 1 && bitget(Labyrinth(i - 1, j), 3) == 0 && bitget(Labyrinth(i, j), 4) == 0)
        Link(Matricea_starilor(i, j), Matricea_starilor(i - 1, j) ) = probabilitatea;
      elseif (i == 1 && b3 == 0) %win pe prima linie
        Link(Matricea_starilor(i, j), n * m + 1) = probabilitatea;
      endif

      %stanga
      if (j > 1 && bitget(Labyrinth(i, j - 1), 2) == 0 && bitget(Labyrinth(i, j), 1) == 0)
        Link(Matricea_starilor(i, j), Matricea_starilor(i, j - 1) ) = probabilitatea;
      elseif (j == 1 && b0 == 0) %lose pe prima coloana
        Link(Matricea_starilor(i, j), n * m + 2) = probabilitatea;
      endif

      %jos
      if (i < n && bitget(Labyrinth(i + 1, j), 4) == 0 && bitget(Labyrinth(i, j), 3) == 0)
        Link(Matricea_starilor(i, j), Matricea_starilor(i + 1, j)) = probabilitatea;
      elseif (i == n && b2 == 0) %win pe ultima linie
        Link(Matricea_starilor(i, j), n * m + 1) = probabilitatea;
      endif

      %dreapta
      if (j < m && bitget(Labyrinth(i, j + 1), 1) == 0 && bitget(Labyrinth(i, j), 2) == 0)
        Link(Matricea_starilor(i, j), Matricea_starilor(i, j + 1)) = probabilitatea;
      elseif (j == m && b1 == 0) %lose pe ultima coloana
        Link(Matricea_starilor(i, j), n * m + 2) = probabilitatea;
      endif
    endfor
  endfor

  Link(n * m + 1, n * m + 1) = 1;
  Link(n * m + 2, n * m + 2) = 1;

  Link_temp = sparse(Link);
  Link = Link_temp;
end
