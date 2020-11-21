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
    option(method(get), Request),
    cors_enable(),
    lista_objawow(L),
    reply_json(json([all_symptoms=L])).

getDiagnose(Request) :-
    reply_json(json([msg="diagnose"])).

