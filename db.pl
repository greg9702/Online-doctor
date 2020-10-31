:- dynamic
    xpozytywne/1,
    xnegatywne/1.

podejrzenie(grypa) :-
        ma_objaw(goraczka),
        ma_objaw(bol_gardla),
        ma_objaw(bol_glowy),
        ma_objaw(bol_miesni),
        ma_objaw(dreszcze),
        ma_objaw(katar),
        ma_objaw(kaszel).

podejrzenie(przeziebienie) :-
        ma_objaw(bol_glowy),
        ma_objaw(bol_gardla),
        ma_objaw(kichanie),
        ma_objaw(katar),
        ma_objaw(dreszcze).

podejrzenie(szkarlatyna) :-
        ma_objaw(bol_gardla),
        ma_objaw(wysypka),
        ma_objaw(goraczka),
        ma_objaw(biegunka),
        ma_objaw(obrzek_wezlow_chlonnych).

podejrzenie(grypa_zoladkowa) :-
        ma_objaw(bol_brzucha),
        ma_objaw(wymioty),
        ma_objaw(goraczka),
        ma_objaw(bol_glowy),
        ma_objaw(biegunka).

podejrzenie(nadcisnienie) :-
        ma_objaw(bol_glowy),
        ma_objaw(zmeczenie),
        ma_objaw(nerwowosc),
        ma_objaw(dusznosci),
        ma_objaw(lomotanie_serca).

podejrzenie(rozyczka) :-
        ma_objaw(bol_glowy),
        ma_objaw(wysypka),
        ma_objaw(goraczka),
        ma_objaw(katar),
        ma_objaw(biegunka).

ma_objaw(X) :- xpozytywne(X), !.
ma_objaw(X) :- \+xnegatywne(X), pytaj(X, tak).

pytaj(X, tak) :- !, format('Czy ma Pan/Pani ~w ? (t/n)~n',[X]),
                    read_line_to_codes(user_input,MenuCodes),
                    string_codes(MyString,MenuCodes),
                    atom_number(MyString, Reply),
                    pamietaj(X, Reply).

wyczysc_fakty :- write('Przycisnij cos aby wyjsc'), nl,
                    retractall(xpozytywne(_)),
                    retractall(xnegatywne(_)),
                    get_char(_).

pamietaj(X,'t') :- assertz(xpozytywne(X)).
pamietaj(X,'n') :- assertz(xnegatywne(X)).

start :- podejrzenie(X), !,
            format('~ chory na ~w', X),
            nl, wyczysc_fakty.
            
start :- write('Nie jestem w stanie odgadnac co to za choroba.'), nl,
            wyczysc_fakty.
