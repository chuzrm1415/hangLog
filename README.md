# HangLog - Juego del Ahorcado en Prolog

## Descripción

**HangLog** es un sencillo juego del ahorcado implementado en Prolog. Permite jugar adivinando palabras, agregar nuevas palabras, modificar el número de intentos y ver todas las palabras disponibles. El proyecto está organizado en módulos para facilitar su mantenimiento y extensión.

## Estructura de archivos

- `app/base.pl`: Maneja la base de palabras y utilidades relacionadas.
- `app/logic.pl`: Contiene la lógica principal del juego (verificación de letras, estado de la palabra, etc).
- `app/hangman.pl`: Implementa el menú, la interacción con el usuario y el ciclo principal del juego.

## Requisitos

- [SWI-Prolog](https://www.swi-prolog.org/) (recomendado)

## Cómo ejecutar

1. Clona este repositorio o descarga los archivos.
2. Abre una terminal y navega a la carpeta del proyecto.
3. Inicia SWI-Prolog y carga el archivo principal:

   ```
   swipl app/hangman.pl
   ```

   El menú del juego aparecerá automáticamente.

## Opciones del menú

1. **Comenzar juego**: Inicia una nueva partida del ahorcado con una palabra aleatoria.
2. **Modificar número de intentos**: Permite cambiar la cantidad de intentos permitidos para adivinar la palabra.
3. **Agregar palabra**: Puedes añadir una nueva palabra (en minúsculas y sin espacios) a la base de datos.
4. **Mostrar palabras disponibles**: Muestra todas las palabras que pueden salir en el juego.
5. **Salir**: Termina el programa.

## Cómo jugar

- Selecciona la opción "Comenzar juego".
- El programa mostrará la palabra oculta con guiones bajos y te pedirá que ingreses letras (una por turno, seguidas de un punto, por ejemplo: `a.`).
- Si adivinas una letra, se mostrará en su posición correspondiente.
- Si fallas, perderás un intento.
- El juego termina cuando adivinas toda la palabra o te quedas sin intentos.

## Notas

- Para agregar palabras, deben estar en minúsculas y no contener espacios ni caracteres especiales.
- Las palabras agregadas solo estarán disponibles durante la sesión actual, a menos que edites el archivo `base.pl` para agregarlas permanentemente.

## Créditos

Desarrollado como proyecto de ejemplo para la materia de Lenguajes de Programación.

---