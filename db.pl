:- dynamic(objaw/2),
   dynamic(temperatura/2),
   dynamic(wiek/2).

choroba(grypa, [goraczka(wysoka_goraczka), bol_gardla, bol_glowy, bol_miesni, dreszcze, katar, kaszel]).

choroba(przeziebienie, [bol_glowy, bol_gardla, kichanie, katar, dreszcze]).

% choroba(szkarlatyna, [bol_gardla, wysypka, goraczka(wysoka_goraczka), biegunka, obrzek_wezlow_chlonnych]).

% choroba(grypa_zoladkowa, [bol_brzucha, wymioty, goraczka(stan_podgoraczkowy), bol_glowy, biegunka]).

% choroba(nadcisnienie, [bol_glowy, zmeczenie, nerwowosc, dusznosci, lomotanie_serca, wiek_pacjenta(podeszly_wiek)]).

% choroba(rozyczka, [bol_glowy, wysypka, goraczka(wysoka_goraczka), katar, biegunka]).

% choroba(goraczka_krwotoczna, [bol_brzucha, bol_glowy, bol_miesni, obrzeki, krawienie_blon_sluzowych]).

% choroba(bolerioza, [nudnosci, wymioty, uposledzenie_sluchu, padaczka]).

choroba(ch1, [a,d,b]).
choroba(ch2, [b,a]).

ocen(grypa, Wynik, ListaObjawow) :-
        sort(ListaObjawow, ListaObjawowSorted),
        sort([goraczka(wysoka_goraczka), bol_glowy], SortedLista),
        jest_sublista(SortedLista, ListaObjawowSorted), !,
        Wynik = 80.

ocen(grypa, Wynik, ListaObjawow) :-
        sort(ListaObjawow, ListaObjawowSorted),
        sort([goraczka(wysoka_goraczka)], SortedLista),
        jest_sublista(SortedLista, ListaObjawowSorted), !,
        Wynik = 60.

ocen(grypa, Wynik, _) :-
        Wynik = 30.

jest_w_liscie(H, [H|_]).

jest_w_liscie(H, [_|T]) :- jest_w_liscie(H, T).

jest_w_liscie(_, []) :- !, fail.

jest_w_liscie(Elem, [H|T]) :-
  Elem \= H,
  !,
  jest_w_liscie(Elem, T).

jest_sublista( [], _ ).

jest_sublista( [X|XS], [X|XSS] ) :- jest_sublista( XS, XSS ).

jest_sublista( [X|XS], [_|XSS] ) :- jest_sublista( [X|XS], XSS ).

sprawdz_objawy(Choroba, ListaObjawow) :-
        choroba(Choroba, ListaObjawowChoroby),
        sort(ListaObjawowChoroby, SortedListaObjawowChoroby),
        sort(ListaObjawow, SortedListaObjawow),
        jest_sublista(SortedListaObjawow, SortedListaObjawowChoroby).

sprawdz_objaw(Choroba, Objaw) :-
        choroba(Choroba, ListaObj),
        member(Objaw, ListaObj).

znajdz_choroby(L, ListaObjawow) :-
        is_list(ListaObjawow), !,
        bagof(Choroba, sprawdz_objawy(Choroba, ListaObjawow), L).

znajdz_choroby(L, Objaw) :-
        bagof(Choroba, sprawdz_objaw(Choroba, Objaw), L).

lista_objawow(L) :-
        findall(P, objaw(pacjent, P), L).

process_wiek :-
        wiek(pacjent, X),
        X > 50,
        assert(objaw(pacjent, wiek_pacjenta(podeszly_wiek))).

process_wiek.

process_goraczka :-
        wiek(pacjent, X),
        X > 38, !,
        assert(objaw(pacjent, wiek_pacjenta(wysoka_goraczka))).

process_goraczka :-
        wiek(pacjent, X),
        X > 37, !,
        assert(objaw(pacjent, goraczka(stan_podgoraczkowy))).

process_goraczka.

process_input :-
        process_wiek,
        process_goraczka.

debug_bootstrap :-
        % debug data, will get this from application
        assert(objaw(pacjent, bol_brzucha)),
        % assert(temperatura(pacjent, 38)),
        assert(wiek(pacjent, 40)),
        assert(temperatura(pacjent, 39)),

        process_input,        

        % % debug print
        lista_objawow(X),
        write('Pacjent posiada objawy: '), write(X).
        clear.


clear :-
        abolish(objaw, 2),
        abolish(wiek, 2),
        abolish(temperatura, 2).



