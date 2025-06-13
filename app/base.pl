% =============== Base.pl ===============
:- module(base, [hangman_word/1, select_random_word/1, valid_word_lowercase/1, print_all_words/0]).
:- dynamic hangman_word/1.

% List of predefined words
hangman_word(ahorcado).
hangman_word(logica).
hangman_word(juego).
hangman_word(casa).
hangman_word(programar).

% Select a random word from the list
select_random_word(P) :-
    findall(W, hangman_word(W), Lista),
    random_member(P, Lista).

% Valid the word to ensure it contains only lowercase letters
valid_word_lowercase(Word) :-
    atom_chars(Word, Letters),
    forall(member(L, Letters), char_type(L, lower)).

print_all_words :-
    write('Palabras disponibles:'), nl,
    forall(hangman_word(W), (write('- '), write(W), nl)).





