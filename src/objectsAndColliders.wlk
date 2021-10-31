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
	const property position
	
	method seMueve()

	method impactarContra(objeto)
	{
		if (objeto.chocaContra(collider)) self.aplicarEfectoSobre(objeto)
	}

	method aplicarEfectoSobre(objeto)

	method morir() {
		game.schedule(150,{game.removeVisual(self)})
		game.schedule(300,{configuracion.posicionesNoUsadas().add(self.position())})
	}
	
	method chocaContra(unCollider) = collider.chocaContra(unCollider) 
	
	method initPos(height)
	{
		position.goToRandom(height)
	}

}

class Collider
{
	const listColliders = []
	
	method chocaContra(colisionador) = listColliders.contains(colisionador)
}

object asteroideCollider inherits Collider(listColliders = [avionCollider,balaCollider]){}

object avionCollider inherits Collider(listColliders = [asteroideCollider,provisionCollider]){}

object provisionCollider inherits Collider(listColliders = [avionCollider,balaCollider]){}

object balaCollider inherits Collider(listColliders = [asteroideCollider,pepitaCollider]){}

object pepitaCollider inherits Collider(listColliders = [balaCollider,avionCollider]){}


class MovingObject inherits GenericObject 
{
	const velocidad
	var property vida
	method sinVida() = vida <= 0
	
	override method seMueve() = true
	
	method desplazar() 
	{
     arriba.movimientoVertical(self.position(),velocidad)
	if(position.y().abs() > (game.height() + 1) or position.y() <= 0) 
     { 
     	self.morir()
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
	 
	method collider() = collider
    method chocaContra(objeto) = false
    method seMueve() = false   
}










