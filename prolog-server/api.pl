:- use_module(library(http/http_server)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_log)).
:- use_module(library(http/http_client)).

:- initialization
    http_server([port(8080)]),
    consult(db).

:- http_handler(root(api/symptoms), get_all_symptoms, []).
:- http_handler(root(api/diagnose), get_diagnose, []).

:- set_setting(http:cors, [*]).

get_all_symptoms(Request) :-
    cors_enable(),
    option(method(get), Request),
    format(user_output, "==========================================~n" ,[]),
    format(user_output, "Received GET request for api/diagnose~n", []),
    symptoms_list(L),
    format(user_output, "all_symptoms ~w~n", [L]),
    reply_json(json([all_symptoms=L])).

get_diagnose(Request) :-
    option(method(options), Request), !,
    http_log('~w ',['getDiagnose options']),
    cors_enable(Request, [methods([post])]),
    format('~n').

get_diagnose(Request) :-
    format(user_output, "==========================================~n" ,[]),
    format(user_output,"Received POST request for api/diagnose~n",[]),
    cors_enable(),
    http_read_json(Request, DictIn, [json_object(dict)]),
    format(user_output,"DictIn is: ~p~n",[DictIn]),
    format(user_output, "symptoms are: ~p~n" ,[DictIn.symptoms]),
    format(user_output, "age is: ~p~n" ,[DictIn.age]),
    format(user_output, "temperature is: ~p~n" ,[DictIn.temperature]),
    make_diagnosis(DictIn, Y), !,
    format(user_output, "Diagnose is: ~p~n" ,[Y]),
    reply_json(json([diagnose=Y])).
    
get_diagnose(_) :-
    format(user_output, "get_diagnose 2nd hanlder~n" ,[]),
    [] = Y,
    reply_json(json([diagnose=Y])).