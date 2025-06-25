function [path] = heuristic_greedy (start_position, probabilities, Adj)
	% start_position -> the starting point in the labyrinth
	% probabilities -> vector of associated probabilities: including WIN and LOSE
	% Adj -> adjacency matrix

	% path -> the states chosen by the algorithm

  % TODO: heuristic_greedy implementation

  [n, m] = size(Adj);
  visited = zeros(n,1);
  path = start_position;
  visited(start_position) = 1;
  while ~isempty(path)
    position = path(end);
    if position == length(probabilities) - 1 %care indica starea WIN
      return;
    endif
    neigh = -1;
    cea_mai_buna_prob = -1;
    %caut cel mai bun vecin nevizitat
    for i = 1:n
      if Adj(position, i) == 1 && visited(i) == 0 %daca i este vecin cu position si este nevizitat
        if probabilities(i) > cea_mai_buna_prob
          cea_mai_buna_prob = probabilities(i);
          neigh = i; %salvez indicele nodului gasit
        endif
      endif
    endfor

    if neigh == -1 %daca nu am gasit vecini
      path(end) = []; %sterg ultimul element
    endif

    visited(neigh) = 1;
    path = [path, neigh];
  endwhile

end
