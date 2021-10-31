import wollok.game.*
import objectsAndColliders.*
import configuracion.*
import balas.*
import MutablePosition.*
import animations.*
import sonidos.*
import carcazas.*
import provisiones.*

object avion inherits GenericObject(collider = avionCollider, position = new MutablePosition(x = game.center().x(),y = 0), image=null)
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
   
   method reset()
   {
   	position.x(game.center().x())
   	position.y(0)
   	rifle.reset()
   	ammoTracker.reset()
   	vidaTracker.reset()
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
	 ammoTracker.moverHacia(direccion)
	 vidaTracker.moverHacia(direccion)
	}
	
	method vida() = armadura.vida()


	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.morir()
	}


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
}

object ammoTracker inherits AvionCompanion
{
	method text() = "Ammo: " + avion.municionActual().toString()
		
	override method reset()
	{
		super()
		position.goUp(1)
	}
}

object vidaTracker inherits AvionCompanion
{
	method text() = "Vida: " + avion.vida().toString()
	
	override method reset() 
	{
	super()
	position.goDown(1)
	}
	
}




