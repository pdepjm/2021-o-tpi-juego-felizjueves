import wollok.game.*
import objetoGenerico.*
import configuracion.*
import balas.*
import MutablePosition.*
import animations.*
import sonidos.*

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
   
   method chocaContraLaser(x) = position.xValueIs(x)
   
   method reset()
   {
   	position.x(game.center().x())
   	position.y(game.center().y())
   	rifle.reset()
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
	}
	
	method vida() = armadura.vida()


	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.morir()
	}


   	method dispara() {arma.disparar()}

  	method cambiarMunicion() {arma.cambiarSelector()}
  	
  	method agregarVida(x) // Asi como esta no parece tener mucho sentido pero esta armado con la idea de que habria muchas carcazas y por ahi algun efecto adicional.
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
	
	//object contadorDeMunicion inherits TextObject{}
	
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
	
class Carcaza
{
	var vida
	const vidaDefault
	const delayHabilidad
	var puedeUsarHabilidad = true
	
	const property image
	
	method reset()
	{
		vida = vidaDefault
		puedeUsarHabilidad = true
	}
	
	method reducirVida(cuanto)
    { 
		vida  -= cuanto
        if(vida <= 0) configuracion.gameOver()
    }
    
    method vida() = vida

method agregarVida(provisionVida) {
	vida = (vida + provisionVida).min(5)
}

method permitirHabilidad()
{
	puedeUsarHabilidad = true
}

method habilidadEspecial()

method activarHabilidad()
{
	if (puedeUsarHabilidad)
	{
		self.habilidadEspecial()
		game.schedule(delayHabilidad * 1000,{self.permitirHabilidad()})
		puedeUsarHabilidad = false
	}
}


	
}	

object carcazaNormal inherits Carcaza(vida = 3, image = "avion.png",delayHabilidad = 20, vidaDefault = 3)
{
	const sound = new Sonido(sonido = "electric.wav")
    const animation = new DynamicAnimation(animationImages = ["elec1.png", "elec2.png", "elec3.png"], frameRate = 90)
   
    method resetearVida(x)
    {
    	vida  = x
    }
    
	override method habilidadEspecial()
	{
		const vidaActual = vida
		vida = 100
		sound.playSound()
		animation.runAnimation(avion,2000)
		game.schedule(2000,{self.resetearVida(vidaActual)})
	}
	
}

object carcazaDeMuniciones inherits Carcaza(vida = 2, image = "armaduraMuniciones.png", delayHabilidad = 35, vidaDefault = 3)
{
	override method habilidadEspecial()
	{
		avion.cargarCartucho(avion.arma().cartuchoSeleccionado(),10)
		10.times({x => game.schedule(x * x * 10,{avion.dispara()})})
	}
}

object carcazaInfinita inherits Carcaza(vida = 5, image = "armaduraInfinita.png", delayHabilidad = 50, vidaDefault = 5)
{
	const soundEffect = new Sonido(sonido = "bigOOF.mp3")
	
	override method habilidadEspecial()
	{
		
		const firstLayer = new BackgroundElement(image = "firstlayer.png")
		const secondLayer = new BackgroundElement(image = "secondlayer.png")
		configuracion.mainTheme().volume(0)
		soundEffect.playSound()
		game.schedule(400, {game.addVisual(firstLayer)})
		game.schedule(900,{game.addVisual(secondLayer)})
		game.schedule(1700,{game.removeVisual(firstLayer)})
		game.schedule(1900, {game.removeVisual(secondLayer)})
		game.schedule(1600, {configuracion.reventarTodo()})
		game.schedule(2000,{configuracion.mainTheme().volume(0.8)})
		
	}
	
}

class Vida inherits MovingObject(collider = provisionCollider, image = "vida.png", velocidad = -0.6, vida = 1)
{
	const property vidaQueCura
	const sound = new Sonido(sonido = "recover.wav")
	
	override method aplicarEfectoSobre(objeto)
	{
		sound.playSound()
		avion.agregarVida(vidaQueCura)
	}
}

class ArmaduraAgarrable inherits MovingObject(collider = provisionCollider, velocidad = -1, vida = 3)
{
	const armadura
	const sound = new Sonido(sonido = "armadura.wav")
	
	override method aplicarEfectoSobre(objeto)
	{
		sound.playSound()
		avion.cambiarArmadura(armadura)
	}
}



