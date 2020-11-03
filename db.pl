:- dynamic
    xpozytywne/2,
    xnegatywne/2.

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

podejrzenie(goraczka_krwotoczna) :-
        ma_objaw(bol_glowy),
        ma_objaw(bol_brzucha),
        ma_objaw(bol_miesni),
        ma_objaw(obrzeki),
        ma_objaw(krawienie_blon_sluzowych).

podejrzenie(goraczka_reumatyczna) :-
        ma_objaw(bol_stawow),
        ma_objaw(wysokie_OB),
        ma_objaw(leukocytoza),
        ma_objaw(wyoskie_CRP),
        ma_objaw(gozki_podskorne).

podejrzenie(bolerioza) :-
        ma_objaw(nudnosci),
        ma_objaw(wymioty),
        ma_objaw(uposledzenie_sluchu),
        ma_objaw(padaczka),
        ma_objaw(psychoza).

podejrzenie(mukowiscydoza) :-
        ma_objaw(kaszel),
        ma_objaw(dusznosci),
        ma_objaw(polipy_nosa),
        ma_objaw(obfite_stolce),
        ma_objaw(wypadanie_odbytu).

podejrzenie(kwasica_ketonowa) :-
        ma_objaw(nadmierne_pragnienie),
        ma_objaw(oddech_kwasiczy),
        ma_objaw(zaburzenia_swiadomosci),
        ma_objaw(zaczerwienienia_policzkow),
        ma_objaw(zawroty).

podejrzenie(mocznica) :-
        ma_objaw(drazliwosc),
        ma_objaw(sennosc),
        ma_objaw(pobudliwosc),
        ma_objaw(brak_laknienia),
        ma_objaw(wybroczyny).

podejrzenie(odra) :-
        ma_objaw(niezyt_nosa),
        ma_objaw(zapalenie_spojowek),
        ma_objaw(plamki_koplika),
        ma_objaw(sinica),
        ma_objaw(przyspieszenie_tetna).

podejrzenie(tezec) :-
        ma_objaw(zaburzenia_czucia),
        ma_objaw(niepokoj),
        ma_objaw(skurcze_miesni),
        ma_objaw(drgawki),
        ma_objaw(dusznosc).

podejrzenie(ptasia_grypa) :-
        ma_objaw(zapalenie_spojowek),
        ma_objaw(wymioty),
        ma_objaw(bol_gardla),
        ma_objaw(biegunka),
        ma_objaw(kaszel).

podejrzenie(polio) :-
        ma_objaw(parestezje),
        ma_objaw(porazenie_miesni),
        ma_objaw(sztywnosc_karku),
        ma_objaw(goraczka),
        ma_objaw(bol_glowy).

podejrzenie(ospa_wietrzna) :-
        ma_objaw(swedzenie),
        ma_objaw(wykwity),
        ma_objaw(bol_miesni),
        ma_objaw(goraczka),
        ma_objaw(biegunka).

podejrzenie(gruzlica) :-
        ma_objaw(poty_nocne),
        ma_objaw(stan_podgoraczkowy),
        ma_objaw(krwioplucie),
        ma_objaw(utrata_masy_ciala),
        ma_objaw(oslabienie).


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
