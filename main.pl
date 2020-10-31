:- use_module(library(dcg/basics)).
:-(clause(zawodnik(_,_),_); consult('db.pl')).

menu:-
    read_line_to_codes(user_input,MenuCodes),
    string_codes(String, MenuCodes),
    atom_number(String, Selected),
    write(Selected).
