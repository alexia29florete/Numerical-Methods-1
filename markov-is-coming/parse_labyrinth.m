function [Labyrinth] = parse_labyrinth(file_path)
	fid = fopen(file_path, 'r');
  dimensiune = fscanf(fid, '%d', 2);
  m = dimensiune(1); %numarul de linii
  n = dimensiune(2); %numarul de coloane
  Labyrinth = fscanf(fid, '%d', [n, m]);
  Labyrinth = Labyrinth';
  fclose(fid);
  %http://www.ece.northwestern.edu/local-apps/matlabhelp/techdoc/ref/fscanf.html
end
