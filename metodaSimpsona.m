% (C) Jan Skwarek
function wynik = metodaSimpsona(wspolczynniki, a, b, n)
    % wszystkie "trudne" przypadki zwiazane z iloscia wspolczynnikow
    % rozpatrujemy juz w funkcji metodaGoertzela
    wynik = 0;
    % s_t to suma wartosci funkcji w punktach srodkowych, s_t \in R
    s_t = 0;
    % dx to odleglosc miedzy dwoma sasiednimi punktami podzialowymi, dx \in
    % R
    dx = (b - a) / n;
    % standardowa iteracyjna implementacja metody Simpsona
    % iterator to licznik punktow podzialowych, iterator \in N
    for iterator = 1 : n
        % x to pozycja punktu podzialowego, x \in R
        x = a + iterator * dx;
        s_t = s_t + metodaGoertzela(wspolczynniki, x - (dx / 2));
        if iterator < n
            wynik = wynik + metodaGoertzela(wspolczynniki, x);
        end
    end
    % wyznaczamy wartosc calki zgodnie z zaproponowanym wzorem
    wynik = (dx / 6) * (metodaGoertzela(wspolczynniki, a) + metodaGoertzela(wspolczynniki, b) + 2 * wynik + 4 * s_t);
