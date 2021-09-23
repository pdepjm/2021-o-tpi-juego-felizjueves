import wollok.game.*
import configuracion.*

object avion {
	var posicion = game.at(50,2)
	var municiones = []
	var potencia = null
	var vidas = 3 // si pierde 3 veces termina el juego
	
	method image() {
		return "avion.png"
	} 
	method position (){
		return posicion
	}
	method moverHacia(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	method dispara(){
		//aca vamos a hacer uso del POLIMORFISMO segun quien reciba el disparo..si es la basura grande o chica
	}
}

object espacio { //solo queria poner una imagen de fondo pero no logre subirla
	method image(){
		return "espacio.png"
	}
}

 //faltarian crear la clase de basura espacial y la clase heredada de la basura espacial ( o el nombre q sea)
 
 //crear la clase municiciones en donde vamos a tener municiones de diferente tipo