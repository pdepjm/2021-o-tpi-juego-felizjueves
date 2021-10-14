# 1942

## Equipo de desarrollo

BERONNE LUCAS,
CAJAL, FACUNDO ,
KANESHIRO DAIANA ,
LIFRIERI GONZALO ,
MOYANO LAUTARO,
SANCHEZ ROCIO


## Capturas

(agregar)

## Reglas de Juego / Instrucciones

*Inicialmente el avion comienza en el centro inferior
*Presionando las flechas del teclado puede moverse en las 4 direcciones
*Presionando la barra espaciadora puede disparar
*Presionando la letra "q" puede modificar las balas
*El objetivo del juego es juntar el mayor puntaje posible sin ser destruido por un asteroide
*El jugador que pilota el avion debe disparar a los asteorides para poder sumar puntos
*A su vez debe recoger las municiones que caen para poder continuar disparando

## Respuestas teóricas

Polimorfismo =>


	
 ¿Cuál es el mensaje polimórfico? ¿Qué objetos lo implementan? ¿Qué objeto se aprovecha de ello?
 
 Hay dos casos importantes de uso de polimorfismo:
 
 - Uno es en el movimiento de todos los objetos: Primero les consulta a cada uno si seMueve (mensaje al que todos los objetos deben responder) y despues a aquellos que si los mueve acorde a su velocidad.
 
 - Los templates responden polimorficamente a los lanzadores para crear el objeto en base a los valores que guardan.


Colecciones =>

¿Qué operaciones de colecciones se utilizan? ¿Usaron mensajes con y sin efecto? ¿Para qué?

Tenemos unos lanzadores de objetos que eligen de una tabla de templates para crear las instancias de los asteroides y provisiones aleatoramiente. Es sin efecto, en este caso, ya que es solo consulta.

El avion agrega municion enviando a cada cartucho que tiene dentro del rifle un mensaje para consultarle si es compatible con el tipo de bala que se va a disparar. En este caso siempre hay un efecto, ya que algun cartucho esta garantizado cargarse por diseño.

Finalmente, para ver si dos objetos pueden colisionar cada uno puede consultar si el objeto en si con el que va a chocar es del tipo compatible. Aca nuevamente es simplemente una consulta.


Clases =>

¿Usan clases? ¿Por qué?
Usamos varias clases para evitar la repeticion de codigo ya que muchas de nuestras clases/objetos compartian atributos y metodos

 ¿Dónde o cuándo se instancian los objetos?
 
 En el menu y controles hay algunos objetos de texto que se van instanciando.
 
 Los lanzadores de objetos van instanciando los asteroides y las provisiones que caen de arriba.
 El avion al disparar instancia un tipo de bala.
 
Herencia =>

 ¿Entre quiénes y por qué? ¿Qué comportamiento es común y cuál distinto?
 "GenericObject" es la clase super que comparten la clase "MovingObject" y el objeto "avion". Generic oiene metodos para impactar contra otros objetos, obtener la posicion, la imagen, su propio tipo y los tipos con los que puede chocar contra (cada clase u objeto que hereda de este tiene su propio listado de tipos con los que puede chocar). 
 Tanto MovingObject como avion comparten los atributos [tipo-tiposQueChocaContra-image-position] y los metodos [seMueve()-impactarContra()-aplicarEfectoSobre()-morir()-puedeChocarContra()] que vienen de GenericObject. 
 La clase MovingObject contiene ademas el atributo "velocidad" y el metodo desplazar. Tanto las balas, asteroides y las provisiones heredan de esta clase y utilizan este metodo para moverse automaticamente.
 Los asteroides tienen un efecto especial al morir - ademas de salir del tablero agregan puntos al avion.
 El objeto avion contiene los atributos arma y armadura, que son objetos con sus propios metodos.
 
 La herencia ocurre principalmente para evitar la repeticion de logica y ademas estructurar el codigo de manera jerarquica (queda claro quien se tiene que encargarse de que y permite generalizar algo rapido si nos damos cuenta que estamos repitiendo codigo en algun lugar)


Composición =>

¿Qué objetos interactúan? ¿Dónde se delega? ¿Por qué no herencia?
En la clase GenericObject con la constante "tipo" estoy aplicando composicion

