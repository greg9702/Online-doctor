:- dynamic(objaw/2),
   dynamic(temperatura/2),
   dynamic(wiek/2).

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


%%%%%%%%%%%%%%%%%%%%%%%% BAZA %%%%%%%%%%%%%%%%%%%%%%%%%%
% predykaty bazowe
choroba(ch1, [a(x),d,b,e]).

choroba(ch2, [b,a(x)]).

choroba(ch3, [g,a(y),c,b]).

% ocenia chrobe na podstawie listy objawow
ocen_chorobe(ch1, Wynik, ListaObjawow) :-
        % TODO move sort to jest_sublista
        sort(ListaObjawow, ListaObjawowSorted),
        sort([a(x), e], X),
        jest_sublista(X, ListaObjawowSorted), !,
        Wynik = 80.

ocen_chorobe(ch1, Wynik, ListaObjawow) :-
        sort(ListaObjawow, ListaObjawowSorted),
        sort([b, a(x)], X),
        jest_sublista(X, ListaObjawowSorted), !,
        Wynik = 60.

% wartosc domyslna dla wszystkich pozostalych przpyadkow
ocen_chorobe(_, Wynik, _) :-
        Wynik = 50.

% zwraca chorobe, ktora ma obecnie najwiecej objawow wspolnych
znajdz_chorobe(MyList, HighMatchNum, K) :-
    aggregate_all(max(N, Key),
              (   choroba(Key, List),
                  wspolne_objawy(MyList, List, N)
              ),
              max(HighMatchNum, K)).

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
        findall(P, objaw(pacjent, P), L).

% predykaty dodajace "objawy" na podstawie parametrow wejsciowych
process_wiek :-
        wiek(pacjent, X),
        X > 50,
        assert(objaw(pacjent, wiek_pacjenta(podeszly_wiek))).

process_wiek.

process_goraczka :-
        temperatura(pacjent, X),
        X > 38, !,
        assert(objaw(pacjent, goraczka(wysoka_goraczka))).

process_goraczka :-
        temperatura(pacjent, X),
        X > 37, !,
        assert(objaw(pacjent, goraczka(stan_podgoraczkowy))).

process_goraczka.

process_wejscie :-
        process_wiek,
        process_goraczka.

pierwszy_filter(X) :-
        lista_objawow_pacjenta(L),
        znajdz_choroby(X, L).

drugi_filter(X) :-
        lista_objawow_pacjenta(L),
        znajdz_dopasowane_choroby(X, L).

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

% process(H) :-
        % write(H), nl.

% trzeci_filter(_) :-
%         write('[III] TODO'), nl.

% debugowe przykladowe dane
% TODO assert -> assertz
debug_bootstrap :-
        assert(objaw(pacjent, a(x))),
        assert(objaw(pacjent, b)),
        assert(wiek(pacjent, 40)),
        assert(temperatura(pacjent, 39)).

postaw_diagnoze :-

        % debug data
        debug_bootstrap,

        % process_wejscie,   

        % % debug print
        lista_objawow_pacjenta(X),
        write('Pacjent posiada objawy: '), write(X), nl,

        % 1st filter
        pierwszy_filter(L),
        write('[I] Pacjent potencjalnie choruje na: '), write(L),

        % 2nd filter
        % drugi_filter(L).

        % 3rd filter
        % tutaj bedziemy uzywac ocen_chorobe, by znalezc ta o najwyzszym wyniku
        % TODO
        % trzeci_filter(L).

        clear.

debug_diagnose(L, X) :-
        znajdz_choroby(L, X).


clear :-
        abolish(objaw, 2),
        abolish(wiek, 2),
        abolish(temperatura, 2).



