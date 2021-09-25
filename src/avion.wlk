import wollok.game.*
import configuracion.*
import objetoVolador.*

object avion {
	const property type = "Avion"
	
	var property posicion = game.at(0,2)
	
	var municiones = [balaDefault]
	
	var carcaza = null
	
	var municionSeleccionada = 0
	
	method cambiarMunicion()
	{
		municionSeleccionada = (municionSeleccionada + 1).rem(municiones.length())
	}
	
	method danio() = carcaza.danio()
    
    method vida() = carcaza.vida()
	
	method image() {
		return "avion.png"
	} 
	method position (){
		return posicion
	}
	
	method moverHacia(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	
	method bajarVida() {carcaza.bajarVida()}
	
	
	
	method dispara(){
		municiones.get(municionSeleccionada).disparar(self)
	}
}

class TipoDeBala
{
	method disparar(avion)
}

object balaDefault inherits TipoDeBala
{
	override method disparar(avion)
	{
		const bala = new Municion(vida = 1, posicionEntidad = avion.posicion(),velocidad = 1,danio = 1,imagenEntidad = "pepita.png")
		game.addVisual(bala)
		bala.configurar()
	}
}

class Carcaza
{
	var property vida
	var property danio
	var property municiones
	
	method bajarVida()
	{
		vida = vida - 1
		if (vida  == 0) configuracion.gameOver()
	}
}



