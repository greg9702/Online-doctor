:- dynamic(objaw/2),
   dynamic(temperatura/2),
   dynamic(wiek/2).

choroba(grypa,  [goraczka(wysoka_goraczka), bol_gardla, bol_glowy, bol_miesni, dreszcze, katar, kaszel]).

choroba(przeziebienie, [bol_glowy, bol_gardla, kichanie, katar, dreszcze]).

choroba(szkarlatyna, [bol_gardla, wysypka, goraczka(wysoka_goraczka), biegunka, obrzek_wezlow_chlonnych]).

choroba(grypa_zoladkowa, [bol_brzucha, wymioty, goraczka(stan_podgoraczkowy), bol_glowy, biegunka]).

choroba(nadcisnienie, [bol_glowy, zmeczenie, nerwowosc, dusznosci, lomotanie_serca, wiek_pacjenta(podeszly_wiek)]).

choroba(rozyczka, [bol_glowy, wysypka, goraczka(wysoka_goraczka), katar, biegunka]).

choroba(goraczka_krwotoczna, [bol_brzucha, bol_glowy, bol_miesni, obrzeki, krawienie_blon_sluzowych]).

choroba(bolerioza, [nudnosci, wymioty, uposledzenie_sluchu, padaczka]).

jest_w_liscie(H, [H|_]). 
jest_w_liscie(H, [_|T]) :- jest_w_liscie(H, T).
jest_w_liscie(_, []) :- !, fail.

jest_w_liscie(Elem, [H|T]) :-
  Elem \= H,
  !,
  jest_w_liscie(Elem, T).

% _ there because we want to return it as a list
znajdz_chroby(_, Objaw) :-
        choroba(Choroba, ListaObj),
        member(Objaw, ListaObj),
        write(Choroba).

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

