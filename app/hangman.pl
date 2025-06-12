% ===== hangman.pl =====
:- use_module(base).
:- use_module(logic).
:- dynamic intentos_restantes/1.

jugar :-
    retractall(letra_usada(_)),
    retractall(intentos_restantes(_)),
    assert(intentos_restantes(7)),
    palabra_aleatoria(Palabra),
    nl, write('Bienvenido al juego del Ahorcado!'), nl,
    jugar_turno(Palabra).

jugar_turno(Palabra) :-
    intentos_restantes(I),
    I > 0,
    (   palabra_completa(Palabra)
    ->  nl, write('¡Felicidades! Adivinaste la palabra: '), write(Palabra), nl
    ;   mostrar_palabra(Palabra, Estado),
        write('Palabra: '), write(Estado), nl,
        mostrar_letras_usadas,
        write('Intentos restantes: '), write(I), nl,
        write('Ingresa una letra (con punto al final): '),
        read(L),
        (   letra_usada(L)
        ->  write('Ya usaste esa letra. Intenta otra.'), nl,
            jugar_turno(Palabra)
        ;   assert(letra_usada(L)),
            (   letra_en_palabra(L, Palabra)
            ->  write('¡Correcto!'), nl,
                jugar_turno(Palabra)
            ;   write('Incorrecto.'), nl,
                I1 is I - 1,
                retractall(intentos_restantes(_)),
                assert(intentos_restantes(I1)),
                jugar_turno(Palabra)
            )
        )
    ).

jugar_turno(Palabra) :-
    intentos_restantes(0),
    write('¡Perdiste! La palabra era: '), write(Palabra), nl.

mostrar_letras_usadas :-
    findall(L, letra_usada(L), Letras),
    write('Letras usadas: '), write(Letras), nl.
