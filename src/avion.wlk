import wollok.game.*
import objetoGenerico.*
import configuracion.*
import balas.*

object avion inherits GenericObject(tipo = "Avion", tiposQueChocaContra = ["Asteroide","Provision"], position = game.at(game.center().x(),0), image = "avion.png", seMueve = false)
{
	const arma = rifle
	var armadura = carcaza

 	method reducirVida(cuanto) {
   	
   	carcaza.reducirVida(cuanto)
   }

   method moverHacia(direccion)
	{
		position = direccion.proximaPosicion(position)
	}


	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.morir()
	}


   	method dispara() {arma.disparar()}

  	method cambiarMunicion() {arma.cambiarSelector()}
  	
  	method agregarVida(x) // Asi como esta no parece tener mucho sentido pero esta armado con la idea de que habria muchas carcazas y por ahi algun efecto adicional.
  	{
  		carcaza.agregarVida(x)
  	}
	
	
	
}

object rifle
{
	const cartuchos = [cartuchoDefault,cartuchoGrande]
	var property selectorCartucho = 0
	
	
	method disparar()
	{
		const cartuchoQueSeDispara = cartuchos.get(selectorCartucho)
	
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
		game.addVisual(balaADisparar)
		configuracion.configurarColision(balaADisparar)
	}
	
	
	method cambiarSelector()
	{
	selectorCartucho = (selectorCartucho + 1).rem(cartuchos.size())
	}
	
	method cartuchos() = cartuchos
	
	method agregar(cartucho)
	{}
	
	}

object carcaza
{
	var vida = 1
	method reducirVida(cuanto)
    { 
		vida  -= cuanto
        if(vida <= 0) configuracion.gameOver()
    }
    
    method vida() = vida
method agregarVida(provisionVida) {
	vida = (vida + provisionVida.cantidad()).min(5)
}
}

class Vida inherits MovingObject(tiposQueChocaContra = ["Avion", "Bala"], tipo = "Provision", image = "vida.png", velocidad = -1, vida = 1)
{
	const property vidaQueCura
	
	override method aplicarEfectoSobre(objeto)
	{
		avion.agregarVida(vidaQueCura)
	}
	
	
}





