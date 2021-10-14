import wollok.game.*
import configuracion.*
import direcciones.*
import asteroide.*

object faltaAgregar
{
	
}

class GenericObject
{
	const property tipo
	const tiposQueChocaContra 
	const property image
	var property position
	
	
	const property seMueve
	
	method seMueve() = seMueve

	method impactarContra(objeto)
	{
		if (self.puedeChocarContra(objeto)) objeto.aplicarEfectoSobre(self)
	}
	

	method aplicarEfectoSobre(objeto)

	method morir() { game.schedule(200,{game.removeVisual(self)})}
	
	method puedeChocarContra(objeto) = tiposQueChocaContra.contains(objeto.tipo()) 
}


class MovingObject inherits GenericObject (seMueve = true)
{
	const velocidad
	var property vida
	method sinVida() = vida <= 0
	
	method desplazar() 
	{
	position = arriba.movimientoVertical(self.position(),velocidad)
	if(position.y().abs() > (game.height() + 1)) game.removeVisual(self)
	}
	
	method reducirVida(_danio)
	{
	vida -= _danio
	if (self.sinVida()) self.morir()
	}

}

class TextObject 
{
	const property tipo = "Texto"
    method puedeChocarContra(objeto) = false
    method seMueve() = false

}










