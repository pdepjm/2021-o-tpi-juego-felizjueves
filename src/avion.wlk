import wollok.game.*
import configuracion.*
import objetoVolador.*

object avion {
	const property type = "Avion"
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
	
	method bajarVida()
	{
		vidas = vidas - 1
		if (vidas  == 0) configuracion.gameOver()
	}
	
	// Se me ocurre que potencia sea como un bonificador que cambie algunos parametros de la bala.
	
	method dispara(){
		const newBala = new Municion(danio = 2, posicionEntidad = posicion.up(6).right(4),velocidad = 3,vida = 1,imagenEntidad = "pepita.png")
		game.addVisual(newBala)
		newBala.configurar()
	}
}



