podejrzenie(grypa) :-
        ma_goraczke(wysoka_goraczka),
        ma_objaw(bol_gardla),
        ma_objaw(bol_glowy),
        ma_objaw(bol_miesni),
        ma_objaw(dreszcze),
        ma_objaw(katar),
        ma_objaw(kaszel).

podejrzenie(rozyczka) :-
        ma_goraczke(wysoka_goraczka),
        typ(rozyczka, zakaźna), % TODO make this is optional
        ryzyko_ze_wzgledu(wiek),
        ma_objaw(bol_glowy),
        ma_objaw(wysypka),
        ma_objaw(goraczka),
        ma_objaw(katar),
        ma_objaw(biegunka).

ma_goraczke(wysoka_goraczka) :-
        zmierzona_temperatura(X),
        X > 38.

ma_objaw(Val):- 
        nl, zadaj_pytanie('Czy ma Pan/Pani ', Val).

ryzyko_ze_wzgledu(wiek):-
        wiek_pacjenta(X),
        X > 50.

typ(NazwaChoroby, zakaźna) :-
        nl, zadaj_pytanie('Czy miał/a Pan/Pani kontakt w ostanim czasie z osobą chorą ', NazwaChoroby).

pytania_ogolne() :-
        zadaj_pytanie_ogolne(wiek),
        zadaj_pytanie_ogolne(temperatura).

zadaj_pytanie_ogolne(wiek) :- 
        nl, zadaj_pytanie_o_liczbe('Proszę podać ile ma Pana/Pani ', lat, X),
        assert(wiek_pacjenta(X)).

zadaj_pytanie_ogolne(temperatura) :- 
        nl, zadaj_pytanie_o_liczbe('Proszę podać ile ma Pana/Pani ', stopni, X),
        assert(zmierzona_temperatura(X)).

zadaj_pytanie(Pytanie, Val):- 
        known(Pytanie, Val, true),!.
zadaj_pytanie(Pytanie, Val):- 
        known(Pytanie, Val, false),!, fail.

zadaj_pytanie(Pytanie, Val):-
        shell(clear),
        write(Pytanie),write(Val) , write('? (t/n)'), nl,
        read_line_to_codes(user_input, Response),
        string_codes(Answer, Response),
        !,
        ((Answer="t", assert(known(Pytanie, Val, true)));
        (assert(known(Pytanie, Val, false)),fail)).

zadaj_pytanie_o_liczbe(Pytanie, Val, X) :-
        shell(clear),
        write(Pytanie), write(Val), nl,
        read_line_to_codes(user_input, Response),
        number_codes(X, Response).

postaw_diagnoze():-
        nl, podejrzenie(Choroba),
        !, nl,
        write('Moja diagnoza to '),
        write(Choroba), nl.

postaw_diagnoze():-
        nl, write('Niestety nie wiem co to za choroba').

start :-
        abolish(known/3),
        dynamic(known/3),
        retractall(known/3),
        pytania_ogolne(),
        postaw_diagnoze(), nl,
        abolish(known,3),
        abolish(wiek_pacjenta,1),
        abolish(zmierzona_temperatura,1),
        halt.
