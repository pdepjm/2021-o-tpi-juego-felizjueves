import wollok.game.*
import configuracion.*
import direcciones.*

object faltaAgregar
{
	
}

class GenericObject
{
	const property tipo
	const tiposQueChocaContra 
	const property image
	var property position
	
	
	method seMueve()

	method impactarContra(objeto)
	{
		if (self.puedeChocarContra(objeto)) objeto.aplicarEfectoSobre(self)
	}
	

	method aplicarEfectoSobre(objeto)

	method morir() { game.schedule(200,{game.removeVisual(self)})}
	
	method puedeChocarContra(objeto) = tiposQueChocaContra.contains(objeto.tipo()) 
}


class MovingObject inherits GenericObject
{
	const velocidad
	
	override method seMueve() = true
	
	method desplazar() 
	{
	position = arriba.movimientoVertical(self.position(),velocidad)
	if(position.y().abs() > (game.height() + 1)) game.removeVisual(self)
	}

}

class TextObject 
{
	const property tipo = "Texto"
    method puedeChocarContra(objeto) = false
    method seMueve() = false

}



object lanzarDeProvisiones
{
	
}






