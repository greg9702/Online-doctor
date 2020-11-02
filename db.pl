:- dynamic
    xpozytywne/2,
    xnegatywne/2.

podejrzenie(grypa) :-
        ma_objaw(pacjent,goraczka),
        ma_objaw(pacjent,bol_gardla),
        ma_objaw(pacjent,bol_glowy),
        ma_objaw(pacjent,bol_miesni),
        ma_objaw(pacjent,dreszcze),
        ma_objaw(pacjent,katar),
        ma_objaw(pacjent,kaszel).

podejrzenie(przeziebienie) :-
        ma_objaw(pacjent,bol_glowy),
        ma_objaw(pacjent,bol_gardla),
        ma_objaw(pacjent,kichanie),
        ma_objaw(pacjent,katar),
        ma_objaw(pacjent,dreszcze).

podejrzenie(szkarlatyna) :-
        ma_objaw(pacjent,bol_gardla),
        ma_objaw(pacjent,wysypka),
        ma_objaw(pacjent,goraczka),
        ma_objaw(pacjent,biegunka),
        ma_objaw(pacjent,obrzek_wezlow_chlonnych).

podejrzenie(grypa_zoladkowa) :-
        ma_objaw(pacjent,bol_brzucha),
        ma_objaw(pacjent,wymioty),
        ma_objaw(pacjent,goraczka),
        ma_objaw(pacjent,bol_glowy),
        ma_objaw(pacjent,biegunka).

podejrzenie(nadcisnienie) :-
        ma_objaw(pacjent,bol_glowy),
        ma_objaw(pacjent,zmeczenie),
        ma_objaw(pacjent,nerwowosc),
        ma_objaw(pacjent,dusznosci),
        ma_objaw(pacjent,lomotanie_serca).

podejrzenie(rozyczka) :-
        ma_objaw(pacjent,bol_glowy),
        ma_objaw(pacjent,wysypka),
        ma_objaw(pacjent,goraczka),
        ma_objaw(pacjent,katar),
        ma_objaw(pacjent,biegunka).

podejrzenie(goraczka_krwotoczna) :-
        ma_objaw(pacjent,bol_glowy),
        ma_objaw(pacjent,bol_brzucha),
        ma_objaw(pacjent,bol_miesni),
        ma_objaw(pacjent,obrzeki),
        ma_objaw(pacjent,krawienie_blon_sluzowych).

podejrzenie(goraczka_reumatyczna) :-
        ma_objaw(pacjent,bol_stawow),
        ma_objaw(pacjent,wysokie_OB),
        ma_objaw(pacjent,leukocytoza),
        ma_objaw(pacjent,wyoskie_CRP),
        ma_objaw(pacjent,gozki_podskorne).

podejrzenie(bolerioza) :-
        ma_objaw(pacjent,nudnosci),
        ma_objaw(pacjent,wymioty),
        ma_objaw(pacjent,uposledzenie_sluchu),
        ma_objaw(pacjent,padaczka),
        ma_objaw(pacjent,psychoza).

podejrzenie(mukowiscydoza) :-
        ma_objaw(pacjent,kaszel),
        ma_objaw(pacjent,dusznosci),
        ma_objaw(pacjent,polipy_nosa),
        ma_objaw(pacjent,obfite_stolce),
        ma_objaw(pacjent,wypadanie_odbytu).

podejrzenie(kwasica_ketonowa) :-
        ma_objaw(pacjent,nadmierne_pragnienie),
        ma_objaw(pacjent,oddech_kwasiczy),
        ma_objaw(pacjent,zaburzenia_swiadomosci),
        ma_objaw(pacjent,zaczerwienienia_policzkow),
        ma_objaw(pacjent,zawroty).

podejrzenie(mocznica) :-
        ma_objaw(pacjent,drazliwosc),
        ma_objaw(pacjent,sennosc),
        ma_objaw(pacjent,pobudliwosc),
        ma_objaw(pacjent,brak_laknienia),
        ma_objaw(pacjent,wybroczyny).

podejrzenie(odra) :-
        ma_objaw(pacjent,niezyt_nosa),
        ma_objaw(pacjent,zapalenie_spojowek),
        ma_objaw(pacjent,plamki_koplika),
        ma_objaw(pacjent,sinica),
        ma_objaw(pacjent,przyspieszenie_tetna).

podejrzenie(tezec) :-
        ma_objaw(pacjent,zaburzenia_czucia),
        ma_objaw(pacjent,niepokoj),
        ma_objaw(pacjent,skurcze_miesni),
        ma_objaw(pacjent,drgawki),
        ma_objaw(pacjent,dusznosc).

podejrzenie(ptasia_grypa) :-
        ma_objaw(pacjent,zapalenie_spojowek),
        ma_objaw(pacjent,wymioty),
        ma_objaw(pacjent,bol_gardla),
        ma_objaw(pacjent,biegunka),
        ma_objaw(pacjent,kaszel).

podejrzenie(polio) :-
        ma_objaw(pacjent,parestezje),
        ma_objaw(pacjent,porazenie_miesni),
        ma_objaw(pacjent,sztywnosc_karku),
        ma_objaw(pacjent,goraczka),
        ma_objaw(pacjent,bol_glowy).

podejrzenie(ospa_wietrzna) :-
        ma_objaw(pacjent,swedzenie),
        ma_objaw(pacjent,wykwity),
        ma_objaw(pacjent,bol_miesni),
        ma_objaw(pacjent,goraczka),
        ma_objaw(pacjent,biegunka).

podejrzenie(gruzlica) :-
        ma_objaw(pacjent,poty_nocne),
        ma_objaw(pacjent,stan_podgoraczkowy),
        ma_objaw(pacjent,krwioplucie),
        ma_objaw(pacjent,utrata_masy_ciala),
        ma_objaw(pacjent,oslabienie).


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
