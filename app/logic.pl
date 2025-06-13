% ===== logic.pl =====
:- module(logic,[show_current_state/2, letter_in_word/2, word_complete/1, debug_letras_usadas/0, letter_used/1]).
:- dynamic letter_used/1.

% Show the current state of the word with used letters
show_current_state(Word, State) :-
    atom_chars(Word, Letters),
    show_letters(Letters, State).

show_letters([], []).
show_letters([H|T], ['_'|TR]) :-
    \+ letter_used(H),
    show_letters(T, TR).
show_letters([H|T], [H|TR]) :-
    letter_used(H),
    show_letters(T, TR).

% Check if the letter is in the word
letter_in_word(L, P) :-
    atom_chars(P, Letters),
    member(L, Letters).

% Check if the entire word has been guessed
word_complete(Word) :-
    atom_chars(Word, Letters),
    forall(member(L, Letters), letter_used(L)).

