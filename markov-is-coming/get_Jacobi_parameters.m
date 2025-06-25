function [G, c] = get_Jacobi_parameters (Link)
	% Link -> the link matrix (edge with probabilities matrix)

  % G -> iteration matrix
	% c -> iteration vector
  % TODO: get_Jacobi_parameters
  [linii_link, coloane_link] = size(Link);
  n = linii_link - 2;
  m = coloane_link - 2;
  G = Link(1:n, 1:m); %selectez primele n linii cu primele m coloane
  c = Link(1:n, m + 1); %selectez linia 1, coloana corespunzatoare lui WIN cu primele m elemente
  G = sparse(G);
  c = sparse(c);
end
