Task 1 - Markov is coming
 function [Labyrinth] = parse_labyrinth(file_path)
    La aceasta functie am citit dintr-un fisier liniile si coloanele, fiind primele doua elemente din fisier.
    Dupa aceea, cu ajutorul informatiilor oferite de acest link http://www.ece.northwestern.edu/local-apps/matlabhelp/techdoc/ref/fscanf.html
    am reusit sa realizez citirea labirintului.

 function [Adj] = get_adjacency_matrix(Labyrinth)
    Cu ajutorul acestei functii am obtinut matricea de adiacenta. Primul pas a fost sa determin matricea starilor.
    Am observat ca pe prima linie in matricea starilor am numarul corepsunzator coloanei pe care se gaseste, iar 
    pe celelate linii adun numarul de linii al matricei la fiecare element de pe linia anterioare, de deasupra elementului curent.
    De exemplu daca pe pozitia (1, 2) am 2, pe pozitia (2, 2) am 2 + 3, iar pe pozitia (3, 2) am (2 + 3) + 3. De asemena, se 
    observa ca matricea de adiacenta este o matrice patratica de dimensiune (n * m + 2)x(n * m + 2), unde acel 2 reprezinta starea
    de WIN si cea de LOSE. Am luat pentru fiecare element din matricea Labyrinth, din reprezentarea binara, bitii b0, b1, b2 si b3,
    folosindu-ma de informatii de la acest link: https://www.mathworks.com/help/matlab/matlab_prog/bit-wise-operations.html. Am 
    observat ca daca pe aceeasi linie elementul din dreapta are b0 = 0 si elementul din stanga are b1 = 0, atunci am drum. Daca
    pe aceeasi coloana elementul de sus are b2 = 0 si elementul de jos are b3 = 0, atunci exista un drum. O alta observatie pe 
    care m-am bazat in implementare a fost aceea ca daca pe prima linie, in reprezentare binara unul dintre elemente are b3 = 0, 
    acesta va indica starea WIN, daca pe prima coloana b0 = 0, atunci o sa am LOSE, daca pe ultima linie b2 = 0, atunci voi avea
    starea WIN si daca pe ultima coloana exista elemente cu b1 = 0, exista starea LOSE. La final am adaugat pe pozitiile win-win
    si lose-lose din matricea de adiacenta, valoarea 1. Dupa ce am terminat de realizat matricea de adiacenta, am salvat-o sub 
    forma unei matrici rare.

 function [Link] = get_link_matrix(Labyrinth)
    La aceasta functie, ideea de implementare a fost aceeasi ca la cea de adiacenta (cea prezentata mai sus), cu o singura 
    diferenta. Am constat ca prin numarul de zerouri din reprezentare binara putem determina numarul de iesiri posibile,
    implicit si probabilitatea pentru fiecare caseta. Am salvat intr-o matrice numarul de zerouri din reprezentarea binara
    a fiecarui numar pentru a putea afla astfel probabilitatea. Ideea este aceeasi ca la functia de adiacenta, dar aici in
    loc sa adaug 1 pentru fiecare pozitie unde am drum, voi adauga 1 / numarul de zerouri din reprezentarea binara a fiecarui
    numar din matrice. La final am adaugat pe pozitiile win-win si lose-lose valoarea 1. Dupa ce am terminat de realizat matricea 
    Link, am salvat-o sub forma unei matrici rare.

 function [G, c] = get_Jacobi_parameters(Link)
    Am observat ca din matricea de la pagina 7 din document (matricea legaturilor), primele m linii si primele n coloane reprezinta
    matricea G scrisa desfasurat la pagina 8 din document. Am remarcat si faptul ca primele m elemente din coloana WIN din matricea
    de legaturi este vectorul coloana c. Din matricea legaturilor am determainat care sunt dimensiunile acesteia si pentru a determina
    n - numarul de linii si m - numarul de coloane, am scazut din numarul de linii, respectiv numarul de coloane ale matricei de leg
    valoarea 2 corespunzatoare acelor 2 stari adaugate in plus pentru WIN si LOSE. Am selectat din matricea Link, G si c asa cum am 
    explicat si dupa aceea le-am salvat sub forma unor matrici rare.

 function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)
    In aceasta functie am preluat din implementarea de la laborator a algoritmului Jacobi, doar partea in care folosesc matricea si
    vectorul de iteratie, avand in vedere ca pe acestea le primesc drept parametru si nu A si b asa cum era in algoritmul clasic. Am
    initializat x cu x0, eroarea este norm(x - x0), iar steps este i la pasul curent.

 function [path] = heuristic_greedy(start_position, probabilities, Adj) 
    Pentru aceasta functie am respectat pseudocodul oferit in document. Iau ultimul element din vectorul path si verific daca
    acesta corespunda starii WIN (n - 1). Daca da, returnez calea, altfel continui si caut vecinii nevizitati. Daca nu exista vecini nevizitati,
    sterg ultimul element din vectorul path. Mai departe salvez index-ul cele mai mari probabilitati de a fi nevizitata si aleg acest vecin.
    La final, adaug acest vecin la path.

 function [decoded_path] = decode_path(path, lines, cols)
    Prima oara mi-am construit matricea starilor (pe acelasi principiu prezentat la matricea de adiacenta). Dupa aceea am cautat pentru
    fiecare element din vectorul path sa il compar cu elementele matricii starilor. Daca gasesc un element din matrice in vectorul path, salvez 
    in decoded_path pozitia pe care se afla acesta. Daca gasesc valoarea starii WIN (lines * cols + 1) in path, trec mai departe.

Task 2 - Linear Regression
 function [Y, InitialMatrix] = parse_data_set_file(file_path)
    Am citit numarul de linii si numarul de coloane din fisier, fiind primele 2 elemente din fisier, asa cum am procedat si la task-ul antrior. 
    Initializez Y cu zeros(m, 1) pentru ca acesta va contine doar date numerice, nu si stringuri ca in cazul lui InitialMatrix care va fi initializat
    cu cell(m, n+1) (dimensiunea m, n+1 pentru ca citesc toata matricea din fiser si dupa aceea voi extrage prima coloana coresunzatoare lui Y si o voi
    sterge din matricea InitialMatrix). Parcurg matricea si citesc element cu element ca un string. Dupa aceea, convertesc string-urile in numere cu 
    ajutorul functiei str2double (iar in momentul in care incerc sa convertesc un cuvant cu ajutorul functiei str2double, functia va retuna NaN).
    Mai departe, cu ajutorul functiei isnan (is not a number) verific daca in urma convertirii cu str2double am un numar sau nu. Daca am un numar,
    atunci voi salva in matrice un numar, altfel voi salva string-ul corespunzator pozitiei. La aceasta functie a fost o problema si anume ca daca
    eu nu faceam verificarea sa vad unde am string si unde am numar, nu mai functiona corect.

 function [Y, InitialMatrix] = parse_csv_file(file_path)
    Aici prima oara am citit prima linie in care aveam headerele. Cu ajutorul headerului, pe care il obtin in urma eliminarii tokenului (virgula
    in cazul meu), vad cate elemente de header sunt pentru a determina numarul de coloane. Pentru ca am citit deja prima linie a fisierului care
    continea doar headers, pot continua sa citesc linie cu linie pana la final ca sa vad cate linii am. Astfel, am ajuns la sfarsitul fisierului
    si trebuie sa ajung din nou la inceput pentru a face citirea matricei. Cu ajutorul functiei frewind (https://www.mathworks.com/help/matlab/ref/frewind.html)
    reusesc sa ma reintorc la prima linie, pe care de altfel o voi citi ca sa pot ajunge la linia de unde incepe matricea. Initializez InitialMatrix
    tot cu tipul cell de dimensiunile determinate anterior. Citesc linie cu linie si despart elementele folosindu-ma de vigula ca delimitator. Pentru
    fiecare element verific la fel ca la cealalta functie daca este numar sau string si le adaug in matrice. La final, extrag vectorul coloana
    din matricea InitialMatrix (https://www.mathworks.com/help/matlab/ref/cell2mat.html) si sterg prima coloana din matrice.

 function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
    Aceasta functie transforma string-urile in 0 sau 1, conform cerintei. Am folosit in cadrul implementarii InitialMatrix{i, j} deoarece a fost
    initializat cu cell si astfel pot accesa elementele. Parcurg elementele matricii si pentru fiecare element verific:
        Daca este numar, il voi lasa asa.
        Daca este 'yes', voi stoca in matricea FeatureMatrix valoarea 1.
        Daca este 'no', voi stoca in matricea FeatureMatrix valoarea 0.
        Daca este 'furnished', voi stoca in matricea FeatureMatrix valorile 0 si 0.
        Daca este 'unfurnished', voi stoca in matricea FeatureMatrix valorile 0 si 1.
        Daca este 'semi-furnished', voi stoca in matricea FeatureMatrix valorile 1 si 0.
    Pentru fiecare schimbare, voi actualiza si coloana pentru FeatureMatrix.

 function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
    Pentru aceasta functie am utilizat formulele prezentate la pagina 15 in document. Pentru vectorul Theta a trebuit sa elimin primul element, 
    care oricum in cerinta ni se garanteaza ca este 0 si dimensiunea lui Theta este (n+2, 1), dar fara theta_0 care oricum este 0 ar trebui sa 
    aiba dimensiunea (n+1, 1) si astfel as putea face inmultirea pentru ca FeatureMatrix are m linii si n+1 coloane. Prima oara am incercat la suma
    sa fac o varianta cu for, dar nu dadea punctajul, astfel am decis sa merg pe o varianta vectorizata.
    Acest link a fost utiliza pentru a ma mai informa: https://www.mathworks.com/matlabcentral/answers/468415-how-to-compute-cost-function-for-linear-regression

 function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
    Pentru aceasta functie am utilizat formulele prezentate la pagina 16 in document. Initializez Theta cu dimensiunea de (n+1, 1) pentru ca 
    FeatureMatrix are n+1 coloane si asa pot face inmultirea corect si pentru Theta am eliminat primul element care oricum este egal zero,
    deci nu mi-ar fi afectat calculele, iar formulele din document sunt scrise in varianta vectorizata.
 
 function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
    Cu ajutorul acestui link: https://mathworld.wolfram.com/ConjugateGradientMethodontheNormalEquations.html#:~:text=The%20conjugate%20gradient%20method%20can%20be%20applied%20on,the%20simplest%20methods%20for%20nonsymmetric%20or%20indefinite%20systems. mi-am dat seama de faptul ca A = FeatureMatrix' * FeatureMatrix 
    si b = FeatureMatrix' * Y. Aceasta functie a fost implementata cu ajutorul algoritmului prezentat in pseudocod de la pagina 16. Dar inainte
    de a ma apuca sa implementez tema trebuia sa verific daca matricea A este sau nu pozitiv definita. De la curs stim ca daca o matrice este pozitiv 
    definita, are toate valorile proprii pozitive (https://www.mathworks.com/help/matlab/math/determine-whether-matrix-is-positive-definite.html).
    Astfel ca am determinat val proprii ale lui A si verific daca sunt sau nu toate valorile pozitive. In cazul in care nu sunt, deci daca matricea
    nu este pozitiv definita Theta o să stocheze doar valori de 0. Mai departe este implementat algortimul prezentat in pseudocod (metoda Gradientului
    Conjugat, metoda de altfel studiata si la curs). La final, Theta = [0; x] si am adaugat valoarea corespunzatoare lui theta_0 = 0.

 function [Error] = lasso_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
    Implementarea acestei functii se bazeaza pe formulele prezentate la pagina 18 din document. Implementarea este similara cu cea de la linear_regression_cost_function
    doar ca la calcularea erorii, am adaugat si termenul specific regularizarii L1, si anume norma L1, despre care am gasit mai multe informatii la acest link:
    https://www.mathworks.com/matlabcentral/answers/388316-l1-and-l2-norms, si anume ca este egala cu norm(Theta, 1) in cazul meu.

 function [Error] = ridge_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
    Implementarea acestei functii se bazeaza pe formulele prezentate la pagina 18 din document. Implementarea este similara cu cea de la lasso_regression_cost_function
    doar ca la calcularea erorii, am adaugat si termenul specific regularizarii L2, si anume suma patratelor elementelor din Theta: sum(Theta.^2).

Task 3 - MNIST 101

 function [X, y] = load_dataset(path)
    https://www.mathworks.com/matlabcentral/answers/195549-how-to-read-data-from-a-mat-file cu ajutorul acestui link am descoperit cum sa face citirea pentru un fisier 
    de tipul .mat. O problema a fost ca initial incercam asa cum am facut la celelalte citiri, cu fopen si fclose, lucru care impiedica citirea sa se realizeze corect.
    Am mai incercat si varianta load(path, 'X') doar ca aceasta imi returna o structura, nu direct variabila X, iar solutia corecta este cea din implementare.

 function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
    Pentru aceasta functie prima oara am amestecat variabilele cu ajutorul functiei randperm https://www.mathworks.com/help/matlab/ref/randperm.html. Am facut aceasta
    amestecare doar pentru X si dupa aceea am aplicat aceeasi permutare si lui y, pentru ca nu trebuia sa le fac disctincte. Dupa aceea am calulat numarul de linii
    pentru train care o sa reprezeinta numarul de linii din n * procentajul. Acestei inmultiri i-am aplicat functia floor pentru ca eu aveam nevoie de un numar intreg,
    nu aveam nevoie de tot numarul cu tot cu ce era dupa virgula. La final, selectez din X amestecat si y amestecat numarul de linii corespunzatorul variabilelor de
    train (n_train linii), respectiv numarul de linii corespunzator celor de test (n - n_train linii), restul ramase.

 function [matrix] = initialize_weights(L_prev, L_next)
    La aceasta functie am utilizat formula de la initializarea parametrilor de la pagina 28 din document pentru a defini acel epsilon. Am creat o matrice matrix care 
    are cu o linie mai mult ca sa acopere termenul de bias si am inmultit rezultatul acelui rand de 0 si 1 cu epsilon.

 function [J, grad] = cost_function(params, X, y, lambda, input_layer_size, hidden_layer_size, output_layer_size)
    Aceasta functie este formata din mai multe bucatele. Prima oara, cu ajutorul functiei reshape, asa cum era oferit in hint (https://www.mathworks.com/help/matlab/ref/double.reshape.html) am initializat Theta1 si Theta2, tinand cont de dimensiunile precizate in document la pagina 26. Dupa aceea, am implementat partea de Forward propagation
    cu ajutorul formulelor de la paginile 25-26 din document. Totusi a fost o problema pentru ca nu am putut respecta intocmai indicatiile din formule deoarece daca
    faceam Theta1 * a_1 sau Theta2 * a_2 imi dadea eroare, zicand ca dimensiunile nu sunt compatibile, solutia fiind sa le scriu a_1 * Theta1', respectiv a_2 * Theta2'. 
    In continuare am implementat backpropagation si am aflat eroarea de la output layer, folosindu-ma de informatiile de la pagina 27. Inainte de a ma apuca sa implementez
    formulele date, am initializat ∆(1) - notat cu delta_1 si ∆(2) - notat cu delta_2. De asemenea, acolo unde intalnesc y in formule nu l-am putut prelucra sub forma in care
    era si a trebuit sa il transform pe y intr-un vector de 0 si 1 astfel: de ex pt numarul 3 un vector cu 4 elem ar putea fi: [0 0 1 0] (element al bazei canonice asa cum este
    specificat in cadrul sectiunii de restrictii si precizari). Calculul pentru ∆(1) si ∆(2) nu a putut respecta intocmai formula data in document tot din cauza dimensiunilor 
    si in loc de eroare_layer_output * a_2' si eroare_layer_intermediar * a_1' am fos nevoita sa scriu: eroare_layer_output' * a_2, respectiv eroare_layer_intermediar' * a_1. 
    Pentru determinarea gradietului, a calculat direct pentru cazul j > 1 pentru ca oricum daca j = 1, m-ar duce automat catre formula corespunzatoare. Pentru calculul lui J 
    m-am folosit de formula prezentata la pagina 26 si am eliminat si aici acel termen corespunzator bias si am calculat J aplicand acea formula cu vectorizari. Vectorul grad 
    reprezinta concatenarea gradientilor pentru Theta1 si Theta2 dispusi pe coloane.

 function [classes] = predict_classes(X, weights, input_layer_size, hidden_layer_size, output_layer_size)
    Pentru acesta functie am implementat foward propagation exact ca la functia anterioara avand in vedere considerentele mentionate anterior. La final am cautat index-ul 
    celei mai mari probabilitati in vectorul a_3 care reprezinta vectorul activarilor. (https://www.mathworks.com/help/matlab/ref/double.max.html)
