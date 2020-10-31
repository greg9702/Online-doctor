podejrzenie(Pacjent,grypa) :-
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,bol_gardla),
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,bol_miesni),
        ma_objaw(Pacjent,dreszcze),
        ma_objaw(Pacjent,katar),
        ma_objaw(Pacjent,kaszel).

podejrzenie(Pacjent,przeziebienie) :-
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,bol_gardla),
        ma_objaw(Pacjent,kichanie),
        ma_objaw(Pacjent,katar),
        ma_objaw(Pacjent,dreszcze).

podejrzenie(Pacjent,szkarlatyna) :-
        ma_objaw(Pacjent,bol_gardla),
        ma_objaw(Pacjent,wysypka),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,biegunka),
        ma_objaw(Pacjent,obrzek_wezlow_chlonnych).

podejrzenie(Pacjent,grypa_zoladkowa) :-
        ma_objaw(Pacjent,bol_brzucha),
        ma_objaw(Pacjent,wymioty),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,biegunka).

podejrzenie(Pacjent,nadcisnienie) :-
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,zmeczenie),
        ma_objaw(Pacjent,nerwowosc),
        ma_objaw(Pacjent,dusznosci),
        ma_objaw(Pacjent,lomotanie_serca).

podejrzenie(Pacjent,rozyczka) :-
        ma_objaw(Pacjent,bol_glowy),
        ma_objaw(Pacjent,wysypka),
        ma_objaw(Pacjent,goraczka),
        ma_objaw(Pacjent,katar),
        ma_objaw(Pacjent,biegunka).