import wollok.game.*
import objetoGenerico.*
import configuracion.*
import avion.*
import asteroide.*
import MutablePosition.*
import sonidos.*
import animations.*

class Cartucho
{
	var property bala
	
	const cantidadDefault 
	
	var property cantidadDeBalas
	
	method consumirBala() {cantidadDeBalas -= 1}
	
	method tieneBalas() = cantidadDeBalas > 0
	
	method reset()
	{
		cantidadDeBalas = cantidadDefault
	}
	
	method cargar(x)
	{
		cantidadDeBalas += x
	}
}

class TemplateBala 
{
	const property danio
	const property imagen
	const property velocidad
	const property efectoDisparo
	method crearTemplateBala() = new Bala(velocidad = self.velocidad(), image = self.imagen(), position = new MutablePosition(x = avion.position().x(), y = avion.position().y()), danio = self.danio(),vida = 1, collider = balaCollider,soundEffect = efectoDisparo)
	
}

class Bala inherits MovingObject(collider = balaCollider,vida = 1)
{
	const danio
	const soundEffect
	const hitEffect = new Sonido(sonido = "hit.wav")
	const animation = new StaticAnimation(animationImages = ["exp1.png","exp2.png","exp3.png"], frameRate = 50)
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		hitEffect.playSound()
		animation.runAnimation(objetoQueChoca.position(),150)
		objetoQueChoca.reducirVida(danio)
	}
	
	method shootSound()
	{
		soundEffect.playSound()
	}
}


object cartuchoDefault inherits Cartucho (bala = balaDefault,cantidadDeBalas = 30, cantidadDefault = 30){}
object cartuchoGrande inherits Cartucho (bala = balaGrande,cantidadDeBalas = 10,cantidadDefault = 10) {}
object cartuchoMediano inherits Cartucho(bala = balaMediana, cantidadDeBalas = 20, cantidadDefault = 20){}

object balaDefault inherits TemplateBala(danio = 1, imagen = "misil_chico.png", velocidad = 0.6, efectoDisparo = new Sonido(sonido = "smallshoot.mp3.wav")){} // ignorar esto
object balaMediana inherits  TemplateBala(danio = 2, imagen = "misil_mediano.png", velocidad = 0.4,efectoDisparo = new Sonido(sonido = "midshoot.mp3.wav")){}
object balaGrande inherits  TemplateBala(danio = 3, imagen = "misil_grande.png", velocidad = 0.3,efectoDisparo = new Sonido(sonido = "bigshoot.mp3.wav")){}


class Municion inherits MovingObject(vida = 1,velocidad = -1, collider = provisionCollider, image = "municion.png")
{
	const cartucho
	var cantidadDeBalas
	const sonido = new Sonido(sonido = "municionRec.wav")
	override method aplicarEfectoSobre(objeto)
	{
	sonido.playSound()
	avion.cargarCartucho(cartucho,cantidadDeBalas)
	}
}






