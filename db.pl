:- dynamic(symptom/2),
   dynamic(suspected_disease/1).

%%%%%%%%%%%%%%%%%%%%%%% GENERAL %%%%%%%%%%%%%%%%%%%%%%%%%
% Check if element is in list.
is_in_list(H, [H|_]).

is_in_list(H, [_|T]) :- is_in_list(H, T).

is_in_list(_, []) :- !, fail.

is_in_list(Elem, [H|T]) :-
  Elem \= H,
  !,
  is_in_list(Elem, T).

% Check if one list is a sublist of a given list.
is_sublist([], _ ).

is_sublist([X|XS], [X|XSS]) :- is_sublist(XS, XSS).

is_sublist([X|XS], [_|XSS]) :- is_sublist([X|XS], XSS).

iterate_list([]).
iterate_list([H|T]) :- take_action(H), iterate_list(T).


max_value(L) :-
        L = 100.

min_value(L) :-
        L = 20.

%%%%%%%%%%%%%%%%%%%%%%%% DATABASE %%%%%%%%%%%%%%%%%%%%%%%%%%
% Database predicates.

disease(grypa, [goraczka(wysoka_goraczka), bol_gardla, bol_glowy, bol_miesni, dreszcze, katar, kaszel]).

disease(przeziebienie, [bol_glowy, bol_gardla, kichanie, katar]).

disease(szkarlatyna, [bol_gardla, wysypka, goraczka(wysoka_goraczka), biegunka, obrzek_wezlow_chlonnych]).

disease(grypa_zoladkowa, [bol_brzucha, wymioty, goraczka(stan_podgoraczkowy), bol_glowy, biegunka]).

disease(rozyczka, [bol_glowy, wysypka, goraczka(wysoka_goraczka), katar, biegunka]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%% Rate the disease based on a symptoms list %%%%%%%%%%%%%%%%%%%%%%%%

% Gives max value if all of the symptoms match.
rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla, bol_glowy], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla, bol_miesni], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla, dreszcze], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla, katar], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla, kaszel], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla, katar], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_glowy, bol_miesni], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(grypa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([bol_glowy, bol_miesni, dreszcze], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 80.

rate_disease(przeziebienie, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        disease(przeziebienie, L),
        sort(L, X),
        is_sublist(X, SymptomsListSorted), !,
        max_value(Result).

rate_disease(przeziebienie, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([bol_gardla, bol_glowy], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 85.

rate_disease(przeziebienie, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([bol_gardla, kichanie], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 85.

rate_disease(przeziebienie, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([bol_gardla, katar], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 85.

rate_disease(przeziebienie, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([bol_gardla], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 85.

rate_disease(przeziebienie, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([katar, kichanie], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 85.

rate_disease(szkarlatyna, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        disease(szkarlatyna, L),
        sort(L, X),
        is_sublist(X, SymptomsListSorted), !,
        max_value(Result).

rate_disease(szkarlatyna, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        disease(szkarlatyna, L),
        sort(L, X),
        is_sublist(X, SymptomsListSorted), !,
        max_value(Result).

rate_disease(szkarlatyna, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), bol_gardla], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 70.

rate_disease(szkarlatyna, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), wysypka], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 95.

rate_disease(szkarlatyna, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), obrzek_wezlow_chlonnych], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 90.

rate_disease(szkarlatyna, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(wysoka_goraczka), biegunka], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 85.

rate_disease(szkarlatyna, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([wysypka], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 40.

rate_disease(grypa_zoladkowa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        disease(grypa_zoladkowa, L),
        sort(L, X),
        is_sublist(X, SymptomsListSorted), !,
        max_value(Result).

rate_disease(grypa_zoladkowa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([goraczka(stan_podgoraczkowy), wymioty], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 95.

rate_disease(grypa_zoladkowa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([wymioty], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 90.

rate_disease(grypa_zoladkowa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([biegunka], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 70.

rate_disease(grypa_zoladkowa, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([bol_glowy, biegunka], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 85.

rate_disease(rozyczka, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        disease(rozyczka, L),
        sort(L, X),
        is_sublist(X, SymptomsListSorted), !,
        max_value(Result).

rate_disease(rozyczka, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([bol_glowy, biegunka], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 40.

rate_disease(rozyczka, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([wysypka], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 45.

rate_disease(rozyczka, Result, SymptomsList) :-
        sort(SymptomsList, SymptomsListSorted),
        sort([wysypka, katar], X),
        is_sublist(X, SymptomsListSorted), !,
        Result = 60.

% Default value for all other predicates.
rate_disease(_, Result, _) :-
        min_value(Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

common_symptoms(MyList, List, N) :-
    intersection(MyList, List, L),
    length(L, N).

% Checks if the symptom or list of symptoms are in the disease symptoms list.
check_symptoms(Disease, SymptomsList) :-
        disease(Disease, SymptomsListDiseases),
        sort(SymptomsListDiseases, SortedSymptomsListDiseases),
        sort(SymptomsList, SortedSymptomsList),
        is_sublist(SortedSymptomsList, SortedSymptomsListDiseases).

sprawdz_objaw(Disease, Symptom) :-
        disease(Disease, SymptomsList),
        member(Symptom, SymptomsList).

% Returns a list of diseases matching the symptoms list or a given symptom.
find_diseases(L, SymptomsList) :-
        is_list(SymptomsList), !,
        bagof(Disease, check_symptoms(Disease, SymptomsList), L).

find_diseases(L, Symptom) :-
        bagof(Disease, sprawdz_objaw(Disease, Symptom), L).

% Checks if given symptom or a list of symptoms matches any disease symptoms list.
same_symptoms(Disease, SymptomsList) :-
        disease(Disease, SymptomsListDiseases),
        sort(SymptomsListDiseases, SortedSymptomsListDiseases),
        sort(SymptomsList, SortedSymptomsList),
        SortedSymptomsList = SortedSymptomsListDiseases.

% Finds diseases matching given symptoms.
find_matching_diseases(L, SymptomsList) :-
        is_list(SymptomsList), !,
        bagof(Disease, same_symptoms(Disease, SymptomsList), L).

% Returns a list of all patients symptoms.
patient_symptoms_list(L) :-
        findall(P, symptom(patient, P), L), !.

patient_symptoms_list(L) :-
        [] = L.

% Complex predicates.
process_age(X) :-
        X > 50, !,
        assertz(symptom(patient, wiek_pacjenta(podeszly_wiek))).

process_age(_).

process_fewer(X) :-
        X > 38, !,
        assertz(symptom(patient, goraczka(wysoka_goraczka))).

process_fewer(X) :-
        X >= 37, !,
        assertz(symptom(patient, goraczka(stan_podgoraczkowy))).

process_fewer(_).

take_action(X) :-
        assertz(symptom(patient, X)).

process_symptoms_list(SymptomsList) :- 
        iterate_list(SymptomsList).

second_filter(X) :-
        patient_symptoms_list(L),
        % format(user_output, "second_filter L: ~w~n" ,[L]),
        find_diseases(X, L).

third_filter(DiseaseList, Result,Disease) :-
        patient_symptoms_list(L),
        add_suspicion(DiseaseList),
        find_highest_graded_disease(L, Result, Disease),
        retractall(suspected_disease(_)).

first_filter(X) :-
        patient_symptoms_list(L),
        find_matching_diseases(X, L).

find_highest_graded_disease(PatientSymptomsList, Result, K) :-
    aggregate_all(max(N, Key),
              (   suspected_disease(Key),
                  rate_disease(Key,N,PatientSymptomsList)
              ),
              max(Result, K)).

add_suspicion([]).

add_suspicion([H|T]) :- assert(suspected_disease(H)), add_suspicion(T).

add_suspicion([]).

 add_suspicion([H|T]) :- assert(suspected_disease(H)), add_suspicion(T).


% Returns all diseases in the database.
disease_list(L) :-
        findall(P, disease(P, _), L).

% Returns all possible symptoms.
symptoms_list(X) :-
        findall(Z, disease(X,Z),L),
        flatten(L,A),
        filter_list_atomic(A,B),
        sort(B,X).

filter_list_atomic(In, Out) :-
        include(atomic(), In, Out).

process_input(Data) :-
        format(user_output, "process_input...~n" ,[]),
        maplist(atom_string, X, Data.objawy),
        number_string(Y, Data.temperatura),
        number_string(Z, Data.wiek),

        format(user_output, "X symptoms are: ~p~n" ,[X]),
        format(user_output, "Y age is: ~p~n" ,[Y]),
        format(user_output, "Z temperature is: ~p~n" ,[Z]),

        process_symptoms_list(X),
        process_fewer(Y),
        process_age(Z).

validate_input().


make_diagnosis(Input, Diagnosis) :-
        clear,
        format(user_output, "make_diagnosis...~n" ,[]),
        process_input(Input), !,
        format(user_output, "process_input done~n" ,[]),
        validate_input, !,
        format(user_output, "validate_input done~n" ,[]),
        
        patient_symptoms_list(L),
        format(user_output, "patient_symptoms_list ~w~n" ,[L]),

        format(user_output, "make_diagnosis 1st handler~n" ,[]),
        second_filter(X), !,
        format(user_output, "second_filter done ~w~n" ,[X]),
        third_filter(X, W, Y),
        Diagnosis = [Y],
        format(user_output, "Diagnosis: ~w, result ~w~n" ,[Diagnosis, W]).

make_diagnosis(_, Diagnosis) :-
        format(user_output, "make_diagnosis 3nd handler~n" ,[]),
        format(user_output, "Unable to make a diagnosis",[]),
        [] = Diagnosis.

clear :-
        abolish(symptom, 2),
        abolish(wiek, 2),
        abolish(temperatura, 2).