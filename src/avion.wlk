import wollok.game.*
import objectsAndColliders.*
import configuracion.*
import balas.*
import MutablePosition.*
import animations.*
import sonidos.*
import carcazas.*
import provisiones.*

object avion inherits GenericObject(collider = avionCollider, position = new MutablePosition(x = game.center().x(),y = 2), image=null)
{
	var property arma = rifle
	var property armadura = carcazaNormal
	
	override method image() = armadura.image()
	

 	method reducirVida(cuanto) {
   	armadura.reducirVida(cuanto)
   }
   
   method cambiarArmadura(armaduraNueva)
   {
   	armadura = armaduraNueva
   }
   
   method chocaContraLaser(x) = (position.x() - x).abs() < 1
   
   method posX() = position.x()
   
   method reset()
   {
   	position.goTo(game.center().x(),2)
   	rifle.reset()
   	ammoTracker.reset()
   	vidaTracker.reset()
   	ammoTypeTracker.reset()
   	armadura = carcazaNormal
   }
   
   method usarHabilidad()
   {
   	armadura.activarHabilidad()
   }
   
   override method seMueve() = false

   method moverHacia(direccion)
	{
	 direccion.proximaPosicion(position)
	 self.moverCompanions(direccion)
	}
	
	method moverCompanions(direccion)
	{
		ammoTracker.moverHacia(direccion)
	 vidaTracker.moverHacia(direccion)
	 ammoTypeTracker.moverHacia(direccion)
	}
	
	method vida() = armadura.vida()


	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.reducirVida(100)
	}

    method tipoMunicion() = rifle.cartuchoSeleccionado().balaImage()

   	method dispara() {arma.disparar()}

  	method cambiarMunicion() {arma.cambiarSelector()}
  	
  	method agregarVida(x)
  	{
  		armadura.agregarVida(x)
  	}
  	
  	method cargarCartucho(cartucho,cantidad) 
  	{
  		arma.cargarCartucho(cartucho,cantidad)
  	}
  	
  	method municionActual() = arma.cantidadDeBalasEnCartuchoActual()
	
}

object rifle
{
	const property cartuchos = [cartuchoDefault,cartuchoGrande,cartuchoMediano]
	var property selectorCartucho = 0
	
	method cartuchoSeleccionado() = cartuchos.get(selectorCartucho)
	
	method cantidadDeBalasEnCartuchoActual() = self.cartuchoSeleccionado().cantidadDeBalas()
	
	method reset()
	{
		selectorCartucho = 0
		cartuchos.forEach({x => x.reset()})
	}

	
	method disparar()
	{
		const cartuchoQueSeDispara = self.cartuchoSeleccionado()
	
		if (cartuchoQueSeDispara.tieneBalas())
		{
		cartuchoQueSeDispara.consumirBala()
		self.lanzarProjectil(cartuchoQueSeDispara.bala())
		}
	}
	
	
	
	method lanzarProjectil(bala)
	{
		const balaADisparar = bala.crearTemplateBala()
		balaADisparar.shootSound()
		game.addVisual(balaADisparar)
		configuracion.configurarColision(balaADisparar)
	}
	
	
	method cambiarSelector()
	{
	selectorCartucho = (selectorCartucho + 1).rem(cartuchos.size())
	}
	
	
	method cargarCartucho(cartucho,cantidad)
	{
		if (cartuchos.contains(cartucho))
		{
			cartucho.cargar(cantidad)
		}
		else
		{
		cartuchos.add(cartucho)	
		}
	}
	
	}
	

class AvionCompanion inherits TextObject
{
	
	const property position = new MutablePosition()
	
	method moverHacia(direccion)
		{
			 direccion.proximaPosicion(position)
		}
		
	method reset() 
	{
		position.goTo(avion.position())
	}
	
	method textColor() = "FFFFFFF"
}

object ammoTracker inherits AvionCompanion
{
	method image() = "am" + (avion.municionActual()/10).roundUp(0).toString() + ".png"
}

object vidaTracker inherits AvionCompanion
{
	method image() = "hp" + (avion.vida().min(50).toString()) + ".png"
	

}

object ammoTypeTracker inherits AvionCompanion
{
	method image() = "s" + avion.tipoMunicion() 
}





