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
	
	// Se me ocurre que potencia sea como un bonificador que cambie algunos parametros de la bala.
	
	method dispara(){
		const newBala = new Municion(danioBala = 2, posicionBala = posicion.up(1).left(3))
		newBala.salirDisparado()
		game.addVisual(newBala)
		game.schedule(2000,{game.removeVisual(newBala)})
	}
}

/* Clase general de municiones. Si se quiere crear otra municion con hacer:
 * 
 * class MunicionEspecial inherits Municion
 * {
 * }
 * 
 * Ya "heredas" todos los parametros de la clase general.
 * 
 */
class Municion
{
	const velocidad = 5
	var property danioBala 
	var posicionBala
	
    method salirDisparado()
    {
    	game.onTick(50,"pa' delante pues",{self.moverseAdelante()})
    }
	
	method moverseAdelante()
	{
		posicionBala = posicionBala.up(velocidad)
	}
	
	method position()  = posicionBala
	method image() = "nada.png"
}


 //faltarian crear la clase de basura espacial y la clase heredada de la basura espacial ( o el nombre q sea)
 
 //crear la clase municiciones en donde vamos a tener municiones de diferente tipo