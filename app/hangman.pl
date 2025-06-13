% ===== hangman.pl =====
:- use_module(base).
:- use_module(logic).
:- dynamic remaining_attempts/1.

play_game :-
    retractall(letter_used(_)),
    retractall(remaining_attempts(_)),
    assert(remaining_attempts(7)),
    select_random_word(Word),
    nl, write('Bienvenido al juego del Ahorcado!'), nl,
    game_turn(Word).

game_turn(Word) :-
    remaining_attempts(I),
    I > 0,
    (   word_complete(Word)
    ->  nl, write('¡Felicidades! Adivinaste la palabra: '), write(Word), nl
    ;   write('Palabra: '), show_current_state(Word, State), print_state(State), nl,
        show_used_letters,
        write('Intentos restantes: '), write(I), nl,
        write('Ingresa una letra (con punto al final): '),
        read(LAtom),
        atom_chars(LAtom, [LChar]),
        (   letter_used(LChar)
        ->  write('Ya usaste esa letra. Intenta otra.'), nl, nl,
            game_turn(Word)
        ;   assert(letter_used(LChar)),
            (   letter_in_word(LChar, Word)
            ->  write('¡Correcto!'), nl, nl,
                game_turn(Word)
            ;   write('Incorrecto.'), nl, nl,
                I1 is I - 1,
                retractall(remaining_attempts(_)),
                assert(remaining_attempts(I1)),
                game_turn(Word)
            )
        )
    ).

game_turn(Word) :-
    remaining_attempts(0),
    write('¡Perdiste! La palabra era: '), write(Word), nl.

show_used_letters :-
    findall(L, letter_used(L), Letters),
    write('Letras usadas: '), write(Letters), nl.

print_state([]).
print_state([H|T]) :-
    write(H), write(' '),
    print_state(T).

:- initialization(play_game).
