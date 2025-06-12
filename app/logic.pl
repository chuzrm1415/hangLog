% ===== logic.pl =====
:- module(logic, [mostrar_palabra/2, letra_en_palabra/2, palabra_completa/1]).
:- dynamic letra_usada/1.

% Mostrar estado actual de la palabra (con guiones)
mostrar_palabra(Palabra, Estado) :-
    atom_chars(Palabra, Letras),
    mostrar_letras(Letras, Estado).

mostrar_letras([], []).
mostrar_letras([H|T], ['_'|TR]) :-
    \+ letra_usada(H),
    mostrar_letras(T, TR).
mostrar_letras([H|T], [H|TR]) :-
    letra_usada(H),
    mostrar_letras(T, TR).

% Verifica si la letra está en la palabra
letra_en_palabra(L, P) :-
    atom_chars(P, Letras),
    member(L, Letras).

% Verifica si se ha adivinado toda la palabra
palabra_completa(Palabra) :-
    atom_chars(Palabra, Letras),
    forall(member(L, Letras), letra_usada(L)).