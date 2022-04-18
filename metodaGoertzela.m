% (C) Jan Skwarek
function wartosc = metodaGoertzela(wspolczynniki, t)
    x = cos(t);
    y = sin(t);
    len = length(wspolczynniki);
    % wspolczynniki w tablicy od ostatniego do zerowego
    p = 2 * x;
    q = -(x * x + y * y);
    % w matlabie literujemy od jedynki wiec a_1 bedzie naszym przed
    % ostatnim wspolczynnikiem
    if len == 0
        % lista wspolczynnikow jest pusta
        error("Lista wspolczynników wielomianu jest pusta!")
    end
    if len == 1
        % nie wchodzimy do petli, b_1 to b_n+1, a wiec zero
        wartosc = 0 * y;
        return
    end
    if len == 2
        % ponownie nie wchodzimy do petli, b_n = a_n = b_1
        wartosc = wspolczynniki(1) * y;
        return
    end
    % petla została zaprojektowana w ten sposob, ze liczymy w niej dwie
    % kolejne wartosci, a pozniej przechodzimy do ostatniej linijki, w
    % ktorej obliczamy wartosc ostateczna na podstawie tych wyliczanych w
    % petli. Oznacza to, ze nie mozemy wejsc do petli, gdy wiemy że wykona
    % się tylko raz. Powinnismy zamiast tego wczesniej zakonczyc program i
    % zwrocic poprawna wartosc. Dlatego wiec powstały dwa kolejne przypadki
    if len == 3
        wartosc = y * (wspolczynniki(2) + p * wspolczynniki(1));
        return
    end
    if len == 4
        wartoscTmp1 = wspolczynniki(2) + p * wspolczynniki(1);
        wartosc = y * (wspolczynniki(3) + p * wartoscTmp1 + q * wspolczynniki(1));
        return
    end
    % wchodzimy do petli, wykona się ona conajmniej 2 razy (moze sie
    % wykonac rowniez raz, ale nie obliczymy w niej ostatecznej wartosci)
    wartoscTmp1 = 0;
    wartoscTmp2 = wspolczynniki(1);
    % obliczamy wartosci dla kolejnych wspolczynnikow zgodnie z algorytmem
    % Goertzela
    for iterator = 2 : 2 : len - 2
        wartoscTmp1 = wspolczynniki(iterator) + p * wartoscTmp2 + q * wartoscTmp1;
        wartoscTmp2 = wspolczynniki(iterator + 1) + p * wartoscTmp1 + q * wartoscTmp2;
    end
    % z uwagi na specyfike funkcji powyzszy algorytm pomija rzeczywista
    % czesc wyniku w(z), która wyszlaby przy standardowym uzyciu algorytmu
    % Goertzele
    if mod(len, 2) == 1
        wartosc = y * (wspolczynniki(len - 1) + p * wartoscTmp2 + q * wartoscTmp1);
        return
    end
    wartosc = y * wartoscTmp2;
    