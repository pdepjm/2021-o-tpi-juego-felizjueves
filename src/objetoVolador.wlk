import wollok.game.*
import configuracion.*
import avion.*


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
    	game.onCollideDo(self,{x => configuracion.impacto(x,self)})
    }
    
    method desplazar()
  
    
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
