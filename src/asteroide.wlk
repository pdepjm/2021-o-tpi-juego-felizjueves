import wollok.game.*
import objetoGenerico.*
import configuracion.*
import avion.*
import balas.*


class Asteroide inherits MovingObject(tipo = "Asteroide", tiposQueChocaContra = ["Bala","Avion"])
{
	const danio
	
	const property puntaje 
	
	override method morir()
	{
		pointTracker.aumentarPuntaje(self.puntaje())
		super()
	}
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.reducirVida(danio)
	}
	

}



