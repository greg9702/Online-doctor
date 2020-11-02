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

podejrzenie(goraczka_krwotoczna) :-
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,bol_brzucha),
        ma_objaw(Pacjent,bol_miesni),
        ma_objaw(Pacjent,obrzeki),
        ma_objaw(Pacjent,krawienie_blon_sluzowych).

podejrzenie(goraczka_reumatyczna) :-
        ma_objaw(Pacjent,bol_stawow),
        ma_objaw(Pacjent,wysokie_OB),
        ma_objaw(Pacjent,leukocytoza),
        ma_objaw(Pacjent,wyoskie_CRP),
        ma_objaw(Pacjent,gozki_podskorne).

podejrzenie(bolerioza) :-
        ma_objaw(Pacjent,nudnosci),
        ma_objaw(Pacjent,wymioty),
        ma_objaw(Pacjent,uposledzenie_sluchu),
        ma_objaw(Pacjent,padaczka),
        ma_objaw(Pacjent,psychoza).

podejrzenie(mukowiscydoza) :-
        ma_objaw(Pacjent,kaszel),
        ma_objaw(Pacjent,dusznosci),
        ma_objaw(Pacjent,polipy_nosa),
        ma_objaw(Pacjent,obfite_stolce),
        ma_objaw(Pacjent,wypadanie_odbytu).

podejrzenie(kwasica_ketonowa) :-
        ma_objaw(Pacjent,nadmierne_pragnienie),
        ma_objaw(Pacjent,oddech_kwasiczy),
        ma_objaw(Pacjent,zaburzenia_swiadomosci),
        ma_objaw(Pacjent,zaczerwienienia_policzkow),
        ma_objaw(Pacjent,zawroty).

podejrzenie(mocznica) :-
        ma_objaw(Pacjent,drazliwosc),
        ma_objaw(Pacjent,sennosc),
        ma_objaw(Pacjent,pobudliwosc),
        ma_objaw(Pacjent,brak_laknienia),
        ma_objaw(Pacjent,wybroczyny).

podejrzenie(odra) :-
        ma_objaw(Pacjent,niezyt_nosa),
        ma_objaw(Pacjent,zapalenie_spojowek),
        ma_objaw(Pacjent,plamki_koplika),
        ma_objaw(Pacjent,sinica),
        ma_objaw(Pacjent,przyspieszenie_tetna).

podejrzenie(tezec) :-
        ma_objaw(Pacjent,zaburzenia_czucia),
        ma_objaw(Pacjent,niepokoj),
        ma_objaw(Pacjent,skurcze_miesni),
        ma_objaw(Pacjent,drgawki),
        ma_objaw(Pacjent,dusznosc).

podejrzenie(ptasia_grypa) :-
        ma_objaw(Pacjent,zapalenie_spojowek),
        ma_objaw(Pacjent,wymioty),
        ma_objaw(Pacjent,bol_gardla),
        ma_objaw(Pacjent,biegunka),
        ma_objaw(Pacjent,kaszel).

podejrzenie(polio) :-
        ma_objaw(Pacjent,parestezje),
        ma_objaw(Pacjent,porazenie_miesni),
        ma_objaw(Pacjent,sztywnosc_karku),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,bol_glowy).

podejrzenie(ospa_wietrzna) :-
        ma_objaw(Pacjent,swedzenie),
        ma_objaw(Pacjent,wykwity),
        ma_objaw(Pacjent,bol_miesni),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,biegunka).

podejrzenie(gruzlica) :-
        ma_objaw(Pacjent,poty_nocne),
        ma_objaw(Pacjent,stan_podgoraczkowy),
        ma_objaw(Pacjent,krwioplucie),
        ma_objaw(Pacjent,utrata_masy_ciala),
        ma_objaw(Pacjent,oslabienie).


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
