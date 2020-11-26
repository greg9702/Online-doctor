:- use_module(library(http/http_server)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json_convert)).

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
    cors_enable(Request, [ methods([post])]),
    format('~n').

getDiagnose(Request) :-
    cors_enable(),
    write('getDiagnose'),
    reply_json(json([msg="diagnose"])).

