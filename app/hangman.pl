% ===== hangman.pl =====
:- use_module(base).
:- use_module(logic).
:- dynamic remaining_attempts/1.

:- initialization(menu).

menu :-
    nl, write('=== Menú del Ahorcado ==='), nl,
    write('1. Comenzar juego'), nl,
    write('2. Modificar número de intentos'), nl,
    write('3. Agregar palabra'), nl,
    write('4. Mostrar palabras disponibles'), nl,
    write('5. Salir'), nl,
    write('Seleccione una opción (con punto al final): '),
    flush_output(current_output),
    read(Op),
    menu_opcion(Op).

menu_opcion(1) :-
    play_game,
    menu.
menu_opcion(2) :-
    write('Ingrese el nuevo número de intentos (con punto al final): '),
    flush_output(current_output),
    read(N),
    integer(N), N > 0,
    retractall(remaining_attempts(_)),
    assert(remaining_attempts(N)),
    write('Número de intentos actualizado a '), write(N), nl,
    menu.
menu_opcion(3) :-
    write('Ingrese la nueva palabra en minúsculas (con punto al final): '),
    flush_output(current_output),
    read(NewWord),
    (   valid_word_lowercase(NewWord)
    ->  (hangman_word(NewWord) ->
            write('La palabra ya existe.'), nl
        ;   assertz(hangman_word(NewWord)),
            write('Palabra agregada.'), nl)
    ;   write('Palabra inválida. Solo minúsculas sin espacios.'), nl
    ),
    menu.
menu_opcion(4) :-
    print_all_words,
    menu.
menu_opcion(5) :-
    write('¡Hasta luego!'), nl.
menu_opcion(_) :-
    write('Opción inválida.'), nl,
    menu.

play_game :-
    retractall(letter_used(_)),
    (   remaining_attempts(N), N > 0
    ->  true
    ;   N = 7
    ),
    retractall(remaining_attempts(_)),
    assert(remaining_attempts(N)),
    select_random_word(Word),
    nl, write('¡Bienvenido al juego del Ahorcado!'), nl,
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
        flush_output(current_output),
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
    write('Letras usadas: '), print_state(Letters), nl.

print_state([]).
print_state([H|T]) :-
    write(H), write(' '),
    print_state(T).
