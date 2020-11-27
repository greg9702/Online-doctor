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

:- http_handler(root(api/symptoms), getAllSymptoms, []).
:- http_handler(root(api/diagnose), getDiagnose, []).

:- set_setting(http:cors, [*]).

getAllSymptoms(Request) :-
    cors_enable(),
    option(method(get), Request),
    write('getAllSymptoms'),
    lista_objawow(L),
    reply_json(json([all_symptoms=L])).

getDiagnose(Request) :-
    option(method(options), Request), !,
    http_log('~w ',['getDiagnose options']),
    cors_enable(Request, [methods([post])]),
    format('~n').

getDiagnose(Request) :-
    http_log('~w\n', ['======= getDiagnose post =======']),
    cors_enable(),
    http_read_data(Request, Data, []),
    http_log('Data: ~w\n', [Data]),

    debug_diagnose(L, [e]),
    reply_json(json([diagnose=L])).

