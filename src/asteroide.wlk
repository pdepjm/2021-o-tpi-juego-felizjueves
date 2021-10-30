import wollok.game.*
import objectsAndColliders.*
import configuracion.*
import avion.*
import balas.*
import sonidos.*


class Asteroide inherits MovingObject(collider = asteroideCollider)
{
	const danio
	const sonido = new Sonido(sonido = "asteroidHit.wav")
	
	const property puntaje 

	override method morir()
	{
		pointTracker.aumentarPuntaje(self.puntaje())
		super()
	}
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		sonido.play()
		objetoQueChoca.reducirVida(danio)
	}
	
	method danio() = danio
}



