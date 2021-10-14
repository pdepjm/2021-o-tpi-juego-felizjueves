import wollok.game.*
import objetoGenerico.*
import configuracion.*
import avion.*
import balas.*


class Asteroide inherits MovingObject(tipo = "Asteroide", tiposQueChocaContra = ["Bala","Avion"])
{
	const danio
	
	const property puntaje 
<<<<<<< HEAD
=======
	
	method sinVida() = vida <= 0
>>>>>>> branch 'master' of https://github.com/pdepjm/2021-o-tpi-juego-felizjueves.git
	
	override method morir()
	{
		pointTracker.aumentarPuntaje(self.puntaje())
		super()
	}
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.reducirVida(danio)
	}
	
<<<<<<< HEAD
=======
	method reducirVida(_danio)
	{
	vida -= _danio
	if (self.sinVida()) self.morir()
	}
	
	method vida() = vida
>>>>>>> branch 'master' of https://github.com/pdepjm/2021-o-tpi-juego-felizjueves.git

}



