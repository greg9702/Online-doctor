:- dynamic
    xpozytywne/2,
    xnegatywne/2.

podejrzenie(grypa) :-
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,bol_gardla),
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,bol_miesni),
        ma_objaw(Pacjent,dreszcze),
        ma_objaw(Pacjent,katar),
        ma_objaw(Pacjent,kaszel).

podejrzenie(przeziebienie) :-
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,bol_gardla),
        ma_objaw(Pacjent,kichanie),
        ma_objaw(Pacjent,katar),
        ma_objaw(Pacjent,dreszcze).

podejrzenie(szkarlatyna) :-
        ma_objaw(Pacjent,bol_gardla),
        ma_objaw(Pacjent,wysypka),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,biegunka),
        ma_objaw(Pacjent,obrzek_wezlow_chlonnych).

podejrzenie(grypa_zoladkowa) :-
        ma_objaw(Pacjent,bol_brzucha),
        ma_objaw(Pacjent,wymioty),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,biegunka).

podejrzenie(nadcisnienie) :-
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,zmeczenie),
        ma_objaw(Pacjent,nerwowosc),
        ma_objaw(Pacjent,dusznosci),
        ma_objaw(Pacjent,lomotanie_serca).

podejrzenie(rozyczka) :-
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,wysypka),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,katar),
        ma_objaw(Pacjent,biegunka).

ma_objaw(X,Y) :- xpozytywne(X,Y), !.
ma_objaw(X,Y) :- \+xnegatywne(X,Y), pytaj(X,Y,tak).

pytaj(X, Y, tak) :- !, format('Czy ma Pan/Pani ~w ? (t/n)~n',[Y]),
                    read_line_to_codes(user_input,MenuCodes),
                    string_codes(MyString,MenuCodes),
                    atom_number(MyString, Reply),
                    pamietaj(X,Y,Reply).

wyczysc_fakty :- write('Przycisnij cos aby wyjsc'), nl,
                    retractall(xpozytywne(_,_)),
                    retractall(xnegatywne(_,_)),
                    get_char(_).

pamietaj(X,Y,'t') :- assertz(xpozytywne(X,Y)).
pamietaj(X,Y,'n') :- assertz(xnegatywne(X,Y)).

start :- podejrzenie(X), !,
            format('~nMozesz byc chory na ~w', X),
            nl, wyczysc_fakty.
            
start :- write('Nie jestem w stanie postawic diagnozy.'), nl,
            wyczysc_fakty.
