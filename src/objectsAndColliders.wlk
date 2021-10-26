import wollok.game.*
import configuracion.*
import direcciones.*
import asteroide.*
import avion.*
import MutablePosition.*


class GenericObject
{
	const property image
	const property collider
	var property position
	
	method seMueve()

	method impactarContra(objeto)
	{
		if (objeto.chocaContra(collider)) self.aplicarEfectoSobre(objeto)
	}

	method aplicarEfectoSobre(objeto)

	method morir() {
		game.schedule(150,{game.removeVisual(self)})
		game.schedule(160,{configuracion.posicionesNoUsadas().add(self.position())})
	}
	
	method chocaContra(unCollider) = collider.chocaContra(unCollider) 
	
}

class Collider
{
	const listColliders = []
	
	method chocaContra(colisionador) = listColliders.contains(colisionador)
}

object asteroideCollider inherits Collider(listColliders = [avionCollider,balaCollider]){}

object avionCollider inherits Collider(listColliders = [asteroideCollider,provisionCollider]){}

object provisionCollider inherits Collider(listColliders = [avionCollider,balaCollider]){}

object balaCollider inherits Collider(listColliders = [asteroideCollider]){}


class MovingObject inherits GenericObject 
{
	const velocidad
	var property vida
	method sinVida() = vida <= 0
	
	override method seMueve() = true
	
	method desplazar() 
	{
     arriba.movimientoVertical(self.position(),velocidad)
	if(position.y().abs() > (game.height() + 1) or position.y() < -1) 
     { 
     	game.removeVisual(self)
     	configuracion.posicionesNoUsadas().add(self.position())
     }
	}
	
	method reducirVida(_danio)
	{
	vida -= _danio
	if (self.sinVida()) self.morir()
	}
   override method chocaContra(unCollider) = super(unCollider) and not self.sinVida()
}



class TextObject 
{
	const collider = new Collider()
	const property tipo = "Texto"
	var property position 
	method collider() = collider
    method chocaContra(objeto) = false
    method seMueve() = false
    
    method moverHacia(direccion)
	{
	 direccion.proximaPosicion(position)
	}
    
}










