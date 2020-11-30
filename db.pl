:- dynamic(objaw/2).

%%%%%%%%%%%%%%%%%%%%%%% OGOLNE %%%%%%%%%%%%%%%%%%%%%%%%%
% sprawdza czy dany element jest w liscie
jest_w_liscie(H, [H|_]).

jest_w_liscie(H, [_|T]) :- jest_w_liscie(H, T).

jest_w_liscie(_, []) :- !, fail.

jest_w_liscie(Elem, [H|T]) :-
  Elem \= H,
  !,
  jest_w_liscie(Elem, T).

% sprawdza czy lista jest sublista drugiej listy
jest_sublista([], _ ).

jest_sublista([X|XS], [X|XSS]) :- jest_sublista(XS, XSS).

jest_sublista([X|XS], [_|XSS]) :- jest_sublista([X|XS], XSS).

przejdz_po_liscie([]).
przejdz_po_liscie([H|T]) :- wykonaj_akcje(H), przejdz_po_liscie(T).

%%%%%%%%%%%%%%%%%%%%%%%% BAZA %%%%%%%%%%%%%%%%%%%%%%%%%%
% predykaty bazowe

choroba(grypa, [goraczka(wysoka_goraczka), bol_gardla, bol_glowy, bol_miesni, dreszcze, katar, kaszel]).

choroba(przeziebienie, [bol_glowy, bol_gardla, kichanie, katar, dreszcze]).

choroba(szkarlatyna, [bol_gardla, wysypka, goraczka(wysoka_goraczka), biegunka, obrzek_wezlow_chlonnych]).

choroba(grypa_zoladkowa, [bol_brzucha, wymioty, goraczka(stan_podgoraczkowy), bol_glowy, biegunka]).

choroba(rozyczka, [bol_glowy, wysypka, goraczka(wysoka_goraczka), katar, biegunka]).

% ocenia chrobe na podstawie listy objawow
ocen_chorobe(grypa, Wynik, ListaObjawow) :-
        sort(ListaObjawow, ListaObjawowSorted),
        sort([goraczka(wysoka_goraczka), bol_glowy, bol_miesni, dreszcze], X),
        jest_sublista(X, ListaObjawowSorted), !,
        Wynik = 100.
% itd...

% wartosc domyslna dla wszystkich pozostalych przpyadkow
ocen_chorobe(_, Wynik, _) :-
        Wynik = 50.


wspolne_objawy(MyList, List, N) :-
    intersection(MyList, List, L),
    length(L, N).

% sprawdza czy podany objaw lub list objawow znajduje sie w liscie choroby
sprawdz_objawy(Choroba, ListaObjawow) :-
        choroba(Choroba, ListaObjawowChoroby),
        sort(ListaObjawowChoroby, SortedListaObjawowChoroby),
        sort(ListaObjawow, SortedListaObjawow),
        jest_sublista(SortedListaObjawow, SortedListaObjawowChoroby).

sprawdz_objaw(Choroba, Objaw) :-
        choroba(Choroba, ListaObj),
        member(Objaw, ListaObj).

% zwraca list chorob ktora pasuje do podanego pojedynczego objawu lub listy 
znajdz_choroby(L, ListaObjawow) :-
        is_list(ListaObjawow), !,
        bagof(Choroba, sprawdz_objawy(Choroba, ListaObjawow), L).

znajdz_choroby(L, Objaw) :-
        bagof(Choroba, sprawdz_objaw(Choroba, Objaw), L).

% sprawdza czy podany objaw lub lista objawow pasuje dokladnie do listy objawow ktorejs choroby
takie_same_objawy(Choroba, ListaObjawow) :-
        choroba(Choroba, ListaObjawowChoroby),
        sort(ListaObjawowChoroby, SortedListaObjawowChoroby),
        sort(ListaObjawow, SortedListaObjawow),
        SortedListaObjawow = SortedListaObjawowChoroby.

% wykorzystujac takie_same_objawy znajduje choroby dokladnie pasujace do objawow
znajdz_dopasowane_choroby(L, ListaObjawow) :-
        is_list(ListaObjawow), !,
        bagof(Choroba, takie_same_objawy(Choroba, ListaObjawow), L).

% zwraca liste wszystkich objawow jakie ma pacjent
lista_objawow_pacjenta(L) :-
        findall(P, objaw(pacjent, P), L), !.

lista_objawow_pacjenta(L) :-
        [] = L.

% predykaty dodajace "objawy" na podstawie parametrow wejsciowych
process_wiek(Wiek) :-
        Wiek > 50, !,
        assertz(objaw(pacjent, wiek_pacjenta(podeszly_wiek))).

process_wiek(_).

process_goraczka(Temperatura) :-
        Temperatura > 38, !,
        assertz(objaw(pacjent, goraczka(wysoka_goraczka))).

process_goraczka(Temperatura) :-
        Temperatura >= 37, !,
        assertz(objaw(pacjent, goraczka(stan_podgoraczkowy))).

process_goraczka(_).

wykonaj_akcje(X) :-
        assertz(objaw(pacjent, X)).

process_liste_objawow(ListaObjawow) :- 
        przejdz_po_liscie(ListaObjawow).

drugi_filter(X) :-
        lista_objawow_pacjenta(L),
        % format(user_output, "drugi_filter L: ~w~n" ,[L]),
        znajdz_choroby(X, L).

trzeci_filter(ListaChorob, Wynik,Choroba) :-
        lista_objawow_pacjenta(L),
        dodaj_podejrzenie(ListaChorob),
        znajdz_najwyzej_oceniana_chorobe(L, Wynik, Choroba),
        retractall(podejrzana_choroba(Y)).


pierwszy_filter(X) :-
        lista_objawow_pacjenta(L),
        znajdz_dopasowane_choroby(X, L).

znajdz_najwyzej_oceniana_chorobe(ListaObjawowPacjenta, Wynik, K) :-
    aggregate_all(max(N, Key),
              (   podejrzana_choroba(Key),
                  ocen_chorobe(Key,N,ListaObjawowPacjenta)
              ),
              max(Wynik, K)).

 dodaj_podejrzenie([]).

 dodaj_podejrzenie([H|T]) :- assert(podejrzana_choroba(H)), dodaj_podejrzenie(T).

dodaj_podejrzenie([]).

 dodaj_podejrzenie([H|T]) :- assert(podejrzana_choroba(H)), dodaj_podejrzenie(T).


% zwrca liste wszystkich chorob
lista_chorob(L) :-
        findall(P, choroba(P, _), L).

% zwraca wszystkie mozliwe objawy
lista_objawow(X) :-
        findall(Z, choroba(X,Z),L),
        flatten(L,A),
        filter_list_atomic(A,B),
        sort(B,X).

filter_list_atomic(In, Out) :-
        include(atomic(), In, Out).

przetworz_dane_wejsciowe(Dane) :-
        format(user_output, "przetworz_dane_wejsciowe...~n" ,[]),
        maplist(atom_string, X, Dane.objawy),
        number_string(Y, Dane.temperatura),
        number_string(Z, Dane.wiek),

        format(user_output, "X objawy  is: ~p~n" ,[X]),
        format(user_output, "Y wiek is: ~p~n" ,[Y]),
        format(user_output, "Z temperatura is: ~p~n" ,[Z]),

        process_liste_objawow(X),
        process_goraczka(Y),
        process_wiek(Z).

% TODO
walidacja_danych_wejsciowych().

postaw_diagnoze(DaneWejsciowe, Diagnoza) :-
        clear,
        format(user_output, "postaw_diagnoze...~n" ,[]),
        przetworz_dane_wejsciowe(DaneWejsciowe), !,
        format(user_output, "przetworz_dane_wejsciowe done~n" ,[]),
        walidacja_danych_wejsciowych, !,
        format(user_output, "walidacja_danych_wejsciowych done~n" ,[]),
        
        lista_objawow_pacjenta(L),
        format(user_output, "lista_objawow_pacjenta ~w~n" ,[L]),

        % for now
        format(user_output, "postaw_diagnoze 1st handler~n" ,[]),
        pierwszy_filter(Diagnoza), !,
        format(user_output, "Diagnoza: ~w~n" ,[Diagnoza]).

postaw_diagnoze(_) :-
        format(user_output, "postaw_diagnoze 2nd handler~n" ,[]),
        drugi_filter(X),
        not(member(_,X)), !,
        trzeci_filter(X, Wynik, Diagnoza),
        format(user_output, "Diagnoza: ~w~n" ,[Diagnoza]).


postaw_diagnoze(_) :-
        format(user_output, "postaw_diagnoze 3nd handler~n" ,[]),
        format(user_output, "Nie udalo sie postawic diagnozy",[]).

clear :-
        abolish(objaw, 2),
        abolish(wiek, 2),
        abolish(temperatura, 2).