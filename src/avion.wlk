import wollok.game.*
import objetoGenerico.*
import configuracion.*
import balas.*

object avion inherits GenericObject(tipo = "Avion", tiposQueChocaContra = ["Asteroide","Provision"], position = game.at(game.center().x(),0), image = "avion.png")
{
	const arma = rifle
	var armadura = carcaza
	
	
	method seMueve() = false // No se mueve automaticamente

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
	
	method agregarMunicion(cartucho){}
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
}





