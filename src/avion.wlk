import wollok.game.*
import configuracion.*

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

/* Clase general de municiones. Si se quiere crear otra municion con hacer:
 * 
 * class MunicionEspecial inherits Municion
 * {
 * }
 * 
 * Ya "heredas" todos los parametros de la clase general.
 * 
 */


class ObjetoVolador
{
    var vida
    var property danio = 0
    const property type
    var velocidad = 0
    var imagenEntidad = "default.png"
    var posicionEntidad
    
    method configurar()
    {
    	self.desplazar()
    	game.onCollideDo(self,{x => self.impacto(x)})
    }
    
    method desplazar()
  
    method impacto(x)
    
    method morir()
    {
    	game.removeVisual(self)
    }
    
    method bajarVida(_danio)
    {
    	vida = vida - danio
    	if(vida <= 0) self.morir()
    }
    
    method image() = imagenEntidad
    
    method position() = posicionEntidad 	
}


class Asteroide inherits ObjetoVolador (type = "Asteroide")
{
	override method impacto(objetoChoque)
	{
		if (objetoChoque.type() == "Bala")
		{
			self.bajarVida(objetoChoque.danioBala())
		}
		else if (objetoChoque.type() == "Avion")
		{
			objetoChoque.bajarVida()
		}
	}
	
	override method desplazar()
	{
		posicionEntidad = posicionEntidad.down(velocidad)
    	
    	if (posicionEntidad.y() < -1)
    	{
    		self.morir()
    	}
    	
    	game.schedule(100,{self.desplazar()})
	}
	
	override method configurar()
	{
		if (vida < 1)
		{
			imagenEntidad = "asteroideChiquitin.png"
			velocidad = 1
			danio = 3
		}
		else if (vida >= 1 and vida < 3) 
		{
			imagenEntidad = "asteroideMediano.png"
			velocidad = 2
			danio = 2
		}
		else 
		{
			imagenEntidad = "asteroideGrande.png"
			velocidad = 3
			danio = 1
		}
		
		self.desplazar()
	}
}

class Municion inherits ObjetoVolador (type = "Bala")
{
	
	override method desplazar()
	{
		posicionEntidad = posicionEntidad.up(velocidad)
		
		game.schedule(100,{self.desplazar()})
	}
	
	override method impacto(x)
	{
		self.bajarVida(1)
	}
	
	
}


 //faltarian crear la clase de basura espacial y la clase heredada de la basura espacial ( o el nombre q sea)
 
 //crear la clase municiciones en donde vamos a tener municiones de diferente tipo