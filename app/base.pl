% ===== Base.pl =====
:- module(base, [palabra/1, palabra_aleatoria/1, palabra_valida/1]).

% Lista de palabras predefinidas
palabra(ahorcado).
palabra(logica).
palabra(juego).
palabra(prolog).
palabra(programar).

% Selección aleatoria de una palabra
palabra_aleatoria(P) :-
    findall(W, palabra(W), Lista),
    random_member(P, Lista).

% Validación de palabra (solo letras minúsculas)
palabra_valida(Palabra) :-
    atom_chars(Palabra, Letras),
    forall(member(L, Letras), char_type(L, lower)).





