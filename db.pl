podejrzenie(grypa) :-
        ma_objaw(goraczka),
        ma_objaw(bol_gardla),
        ma_objaw(bol_glowy),
        ma_objaw(bol_miesni),
        ma_objaw(dreszcze),
        ma_objaw(katar),
        ma_objaw(kaszel).

podejrzenie(rozyczka) :-
        jest_w(grupie_ryzyka),
        ma_objaw(bol_glowy),
        ma_objaw(wysypka),
        ma_objaw(goraczka),
        ma_objaw(katar),
        ma_objaw(biegunka).


ma_objaw(Val):- 
        nl, zadaj_pytanie('Czy ma Pan/Pani ', Val).

jest_w(Val):-
        nl, zadaj_pytanie_o_wiek('Ile ma Pan/Pani lat', Val).


postaw_diagnoze():-
        nl, podejrzenie(Choroba),
        !, nl,
        write('Moja diagnoza to '),
        write(Choroba), nl.

postaw_diagnoze():-
        nl, write('Niestety nie wiem co to za choroba').

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

zadaj_pytanie_o_wiek(Pytanie, Val) :-
        shell(clear),
        write(Pytanie), nl,
        read_line_to_codes(user_input, Response),
        string_codes(Answer, Response),
        number_codes(Wiek, Answer),
        !,
        ((Wiek > 50, assert(known(Pytanie, Val, true)));
        (assert(known(Pytanie, Val, false)),fail)).

start :-
        abolish(known/3),
        dynamic(known/3),
        retractall(known/3),
        postaw_diagnoze(), nl.
