import configuracion.*
import wollok.game.*
import sonidos.*
import animations.*
import avion.*

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
		sound.play()
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
	
	override method habilidadEspecial()
	{
		configuracion.reventarAsteroides()
	}
	
}