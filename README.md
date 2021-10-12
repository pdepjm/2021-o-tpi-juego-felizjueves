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


Colecciones =>

¿Qué operaciones de colecciones se utilizan? ¿Usaron mensajes con y sin efecto? ¿Para qué?


Clases =>

¿Usan clases? ¿Por qué?
Usamos varias clases para evitar la repeticion de codigo ya que muchas de nuestras clases/objetos compartian atributos y metodos

 ¿Dónde o cuándo se instancian los objetos?
 
Herencia =>

 ¿Entre quiénes y por qué? ¿Qué comportamiento es común y cuál distinto?
 "GenericObject" es la clase super que comparten la clase "MovingObject" y el objeto "avion". 
 Tanto MovingObject como avion comparten los atributos [tipo-tiposQueChocaContra-image-position] y los metodos [seMueve()-impactarContra()-aplicarEfectoSobre()-morir()-puedeChocarContra()]
 La clase MovingObject contiene ademas el atributo "velocidad" 
 El objeto avion contiene los atributos arma y armadura


Composición =>

¿Qué objetos interactúan? ¿Dónde se delega? ¿Por qué no herencia?
En la clase GenericObject con la constante "tipo" estoy aplicando composicion

