![](imagenes/portadatcnm.png)

#  Tecnológico Nacional de México
#  Instituto Tecnológico de Tijuana
#  Subdirección Académica

#  Departamento de Sistemas y Computación
#  Ingeniería en Sistemas Computacionales
#  Lenguajes de interfaz 

#  Reumen Bloque 1

# Alumno:📝 
# Mendoza Perez Max William #17620246
   

# Profesor:
# MC. René Solis Reyes
# Semestre sep - ene 2020


-----
# Características generales de la arquitectura ARM


#### ARM es una arquitectura RISC de 32 bits, salvo la versión del core ARMv8- A que es mixta 32/64 bits . Se trata de una arquitectura licenciable, quiere decir que la empresa desarrolladora ARM Holdings diseña la arquitectura, pero son otras compañías las que fabrican y venden los chips, llevándose ARM Holdings un pequeño porcentaje por la licencia. El chip en concreto que lleva la Raspberry Pi es el BCM2835, se trata de un SoC que contiene además de la CPU otros elementos como un núcleo GPU y un núcleo DSP que es un procesador más pequeño y simple que el principal, pero especializado en el procesado y representación de señales analógicaa.

## Esquema de almacenamiento

![](imagenes/Esquema.PNG)

## Lenguaje Ensamblador

#### El ensamblador es un lenguaje de bajo nivel que permite un control directo de la CPU y todos los elementos asociados. Cada línea de un programa ensamblador consta de una instrucción del procesador y la posición que ocupan los datos de esa instrucción. Desarrollar programas en lenguaje ensamblador es un proceso laborioso. El ensamblador presenta una serie de ventajas e inconvenientes con respecto a otros lenguajes de más alto nivel.
#### En contrapartida, programar en ensamblador es laborioso puesto que los programas contienen un número elevado de líneas y la corrección y depuración de éstos se hace difícil.


## Entorno 

#### Para traducirlo a lenguaje máquina hay que utilizar un programa traductor. Éste genera un fichero con la traducción de dicho programa, pero todavía no es un programa ejecutable. Un fichero ejecutable contiene el programa traducido más una serie de códigos que debe tener todo programa que vaya a ser ejecutado en una máquina determinada. El encargado de unir el código del programa con el código de estas librerías es un programa llamado montador que genera el programa ejecutable.

#### Durante el proceso de creación de un programa se suelen producir errores. Los errores sintácticos son, por ejemplo, escribir mal una instrucción o hacer una operación entre dos tipos de datos incompatibles. Estos errores son detectados por el traductor y se deben solucionar para poder generar un ejecutable. Una vez que se tiene un programa sintácticamente correcto lo podemos ejecutar, pero esto no implica que el programa sea correcto.

#### Todas las instrucciones pueden ser correctas, pero se puede haber olvidado poner la condición de salida de un bucle o que sencillamente el programa no haga lo que queremos. Estos errores sólo se pueden detectar en tiempo de ejecución. El depurador nos permite ejecutar el programa instrucción a instrucción y ver todos los valores que se van a calcular, de manera que podemos encontrar los errores.

![](imagenes/Entorno.PNG)


![](https://images.cooltext.com/5474912.png)
<a href="http://cooltext.com" target="_top"><img src="https://cooltext.com/images/ct_pixel.gif" width="80" height="15" alt="Cool Text: Logo and Graphics Generator" border="0" /></a>


## Modos de direccionamiento del ARM

#### En la arquitectura ARM los accesos a memoria se hacen mediante instrucciones específicas ldr y El resto de instrucciones toman operandos desde registros o valores inmediatos, sin excepciones. En este caso la arquitectura nos fuerza a que trabajemos de un modo determinado: primero cargamos los registros desde memoria, luego procesamos el valor de estos registros con el amplio abanico de instrucciones del ARM, para finalmente volcar los resultados desde registros a memoria. Normalmente se opta por direccionamiento a memoria en instrucciones de procesado en arquitecturas con un número reducido de registros, donde se emplea la memoria como almacén temporal.

### Direccionamiento inmediato.
```s
   mov r0, # 1
   add r2, r3, #4
```

### Direccionamiento inmediato con desplazamiento o rotación.
```s
mov r1, r2, LSL #1 /* r1 <- (r2*2) */
mov r1, r2, LSL #2 /* r1 <- (r2*4) */
mov r1, r3, ASR #3 /* r1 <- (r3/8) */
```

## Tipos de datos
![](imagenes/Datos.PNG)

#### Punteros. Un puntero siempre ocupa 32 bits y contiene una dirección de memoria. En ensamblador no tienen tanta utilidad como en C, ya que disponemos de registros de sobra y es más costoso acceder a las variables a través de los punteros que directamente. En este ejemplo acceder a la dirección de var1 nos cuesta 2 ldrs a través del puntero, mientras que directamente se puede hacer con uno sólo.

```s
.data
var1 :                .word 3
puntero_var1 :        .word var1
.text
.global  main
main :   ldr          r0, = puntero_var1
         ldr          r1, [ r0 ]
         ldr          r2, [ r1 ]
         ldr          r3, = var1
         bx           lr

```
##  Vectores 

#### Todos los elementos de un vector se almacenan en un único bloque de memoria a partir de una dirección determinada. Los diferentes elementos se almacenan en posiciones consecutivas, de manera que el elemento i está entre los i-1 e i+1. Los vectores están definidos siempre a partir de la posición 0. El propio índice indica cuántos elementos hemos de desplazarnos respecto del comienzo del primer elemento (para acceder al elemento cero hemos de saltarnos 0 elementos, para acceder al elemento 1 hemos de saltarnos un elemento, etc.

## Matrices bidimensionales.

#### Una matriz bidimensional de N×M elementos se almacena en un único bloque de memoria. Interpretaremos una matriz de N×M como una matriz con N filas de M elementos cada una. Si cada elemento de la matriz ocupa B bytes, la matriz ocupará un bloque de M ×N ×B bytes.

## Instrucciones de salto
#### Las instrucciones de salto pueden producir saltos incondicionales (b y bx) o saltos condicionales. Cuando saltamos a una etiqueta empleamos b, mientras que si queremos saltar a un registro lo hacemos con bx. La variante de registro bx la solemos usar como instrucción de retorno de subrutina, raramente tiene otros usos.


##  Ejercicios

#### Push y pop
```s
main :   mov  r1, # 1
         mov  r2, # 2
         bl nivel1
         mov  r5, # 5 /* Siguiente instrucci ón */
       ...
nivel1 : push { lr }
         mov r3, # 3
         bl nivel2
         pop { lr }
         bx lr
nivel2 : mov r4, #4
        bx lr
        
```

## Estructuras de control de alto nivel

#### En este punto veremos cómo se traducen a ensamblador las estructuras de control de alto nivel que definen un bucle (for, while, . . . ), así como las condicionales (if-else). Para programar en ensamblador estas estructuras se utilizan instrucciones de salto condicional. Previo a la instrucción de salto es necesario evaluar la condición del bucle o de la sentencia if, mediante instrucciones aritméticas o lógicas, con el fin de actualizar los flags de estado.

## Compilación a ensamblador

####  En el caso de gcc este proceso se hace en dos fases: en una primera se pasa de C a ensamblador, y en una segunda de ensambladador a código compilado (código máquina). Lo interesante es que podemos interrumpir justo después de la compilación y ver con un editor el aspecto que tiene el código ensamblador generado a partir del código fuente en C.

```c
# include < stdio .h >
 void main ( void ){
 int i;
 for ( i= 0; i <5; i ++ ){
printf ( " %d\n " , i );
 }
}
```

#### Listado 2.7: Código del programa tipos3b.s
```s
.data
var1 :    .asciz " %d\ 012 "

.text
.global   main
main :    push { r4, lr }
          mov r4, # 0
.L2 :     mov r1, r4
          ldr r0, = var1
          add r4, r4, # 1
          bl printf
          cmp r4, # 5
          bne .L2
          pop { r4, pc }
```

#### Listado 2.7: Código del programa tipos3b.s
```s
.data
var1 :   .asciz " %d\ 012 "
.text
.global  main
main :   push { r4, lr }
         mov r1, # 0
         ldr r4, = var1
         mov r0, r4
         bl printf
         mov r0, r4
         mov r1, # 1
         bl printf
         mov r0, r4
         mov r1, # 2
         bl printf
         mov r0, r4
         mov r1, # 3
         bl printf
         mov r0, r4
         mov r1, # 4
         pop { r4, lr }
         b printf
```

## Ejercicios propuestos.
#### Suma de elementos de un vector
```c
# include < stdio .h >
   void main ( void ){
   int i , suma ;
   int vector [5]= {128 , 32 , 100 , -30 , 124};
   for ( suma = i = 0; i <5; i ++ ){
  
    suma += vector [i ];
   }
   printf (" La suma es %d \n" , suma );
}
```
#### Codigo.s
```s
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
```

#### Suma de un vector de enteros largos.
```c
 void main ( void ){
      int i;
      long long suma ;
      int vector [5]= {1600000000 , -100 , 800000000 , -50 , 200};
      for ( suma = i = 0; i <5; i ++ ){
       suma += vector [i ];
      }
      printf (" La suma es %d \n" , suma );
}

```

## Tipos de datos y sentencias de alto nivel
```s
.data
var1 :   .asciz " La suma es %lld \ n"
var2 :   .word 1600000000, - 100, 800000000, - 50, 200
.text
.global main
/* Salvamos registros */
main :   push { r4, r5, r6, lr }
/* Inicializamos variables y apuntamos r4 a var2 */
         mov r5, # 5
         mov r2, # 0
         mov r3, # 0
         ldr r4, = var2
/* Bucle que hace la suma */
bucle :  ldr r0, [ r4 ] , # 4
         mov r1, r0, ASR # 31
         adds r2, r2, r0
         adc r3, r3, r1
         subs r5, r5, #1
         bne bucle
/* Imprimimos resultado */
         ldr r0, = var1
         bl printf
/* Recuperamos registros y salimos */
         pop { r4, r5, r6, lr }
         bx lr
```
#### Matrices 
```s
matriz : .hword 0, 1, 2, 3, 4, 5
         .hword 0x10, 0x11, 0x12, 0x13, 0x14, 0x15
         .hword 0x20, 0x21, 0x22, 0x23, 0x24, 0x25
         .hword 0x30, 0x31, 0x32, 0x33, 0x34, 0x35
suma :   .hword 0
```
```c
suma = 0;
for ( i= 0; i <4; i ++ ){
 suma += mat [i ][2];
}
```
