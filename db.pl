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

ma_objaw(Val):- nl, zadaj_pytanie('Czy ma Pan/Pani ',Val).

postaw_diagnoze():-
    nl, podejrzenie(Choroba),
    !, nl,
    write('Moja diagnoza to '),
    write(Choroba), nl.

postaw_diagnoze():-
    nl, write('Niestety nie wiem co to za choroba').

zadaj_pytanie(Pytanie, Val):- known(Pytanie, Val, true),!.
zadaj_pytanie(Pytanie, Val):- known(Pytanie, Val, false),!, fail.

zadaj_pytanie(Pytanie, Val):-
    shell(clear),
    write(Pytanie),write(Val) , write('? (t/n)'), nl,
    read_line_to_codes(user_input,MenuCodes),
    string_codes(Ans,MenuCodes),
    !,
    ((Ans="t", assert(known(Pytanie, Val, true)));
    (assert(known(Pytanie, Val, false)),fail)).

start :-
        abolish(known/3),
        dynamic(known/3),
        retractall(known/3),
        postaw_diagnoze(), nl.
