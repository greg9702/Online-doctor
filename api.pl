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


getAllSymptoms(Request) :-
    reply_json(json([msg="all symptoms"])).

getDiagnose(Request) :-
    reply_json(json([msg="diagnose"])).

