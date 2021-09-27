import wollok.game.*
import configuracion.*
import avion.*


class ObjetoVolador
{
    var vida
    var property danio 
    const property type
    var velocidad = 0
    var imagenObjeto = "default.png"
    var posicionObjeto
    var property esChocable = true
    var property seMueve = true
    
    method configurar()
    {
    	self.desplazar()
    	game.onCollideDo(self,{x => configuracion.impacto(x,self)})
    }
    
    method desplazar()
  
    
    method bajarVida(_danio)
    {
    	vida = vida - _danio
    	if(vida <= 0)
    	{ 
    		self.morir()
    	}
    }
    
    method morir()
    {
    	game.removeVisual(self)
    }
    
    method image() = imagenObjeto
    
    method position() = posicionObjeto 	
}


class Asteroide inherits ObjetoVolador (type = "Asteroide")
{
	
	var puntaje = 0
	
	override method morir()
	{
		super()
		pointTracker.aumentarPuntaje(puntaje)
	}
	
	override method desplazar()
	{
		posicionObjeto = posicionObjeto.down(velocidad)
		
    	if (posicionObjeto.y() < -1)
    	{
    		game.removeVisual(self)
    	}
	}
	
	override method configurar()
	{
		
		super()
		if (vida < 2)
		{
			imagenObjeto = "asteroideChiquitin.png"
			velocidad = 0.2
			danio = 1
			puntaje = 10
		}
		else if (vida >= 2 and vida < 4) 
		{
			imagenObjeto = "asteroideMediano.png"
			velocidad = 0.15
			danio = 2
			puntaje = 15
		}
		else 
		{
			imagenObjeto = "asteroideGrande.png"
			velocidad = 0.1
			danio = 3
			puntaje = 20
		}
		
		self.desplazar()
	}
}

class Municion inherits ObjetoVolador (type = "Bala")
{
	
	override method desplazar()
	{
		posicionObjeto = posicionObjeto.up(velocidad)
		
		if (posicionObjeto.y() > 17)
    	{
    		game.removeVisual(self)				
    	}		
	}
	
	
	
}


