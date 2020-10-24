
/*
Instituto Tecnologico de Tijuana Depto de Sistemas y Computación 
Ing. En Sistemas Computacionales 
Practica enlenguaje S para la materia de lengiterfaz:


Autor :Mendoza Perez Max William
max.mendoza201@tectijuana.edu.mx
Repositorio:https://github.com/william9w/interfaz
*/

.data
var1 :   .asciz   " La suma es %d \n"
var2 :   .word    128, 32, 100, - 30, 124
.text
.global   main
/* Salvamos registros */
main :   push     { r4, lr }
/* Inicializamos variables y apuntamos r2 a var2 */
         mov      r0, # 5
         mov      r1, # 0
         ldr      r2, = var2
/* Bucle que hace la suma */
bucle :  ldr      r3, [ r2 ] , # 4
         add      r1, r1, r3
         sub      s r0, r0, #1
         bne      bucle
/* Imprimimos resultado */
         ldr      r0, = var1
         bl       printf
/* Recuperamos registros y salimos */
         pop      { r4, lr }
         bx       lr
