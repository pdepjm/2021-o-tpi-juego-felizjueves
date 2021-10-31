import wollok.game.*
import objectsAndColliders.*
import configuracion.*
import avion.*
import asteroide.*
import MutablePosition.*
import sonidos.*
import animations.*
import lanzadores.*
import templates.*

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


class Bala inherits MovingObject(collider = balaCollider,vida = 1)
{
	const danio
	const soundEffect
	const hitEffect = new Sonido(sonido = "hit.wav")
	const animation = new StaticAnimation(animationImages = ["exp1.png","exp2.png","exp3.png"], frameRate = 50)
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		hitEffect.play()
		animation.runAnimation(objetoQueChoca.position(),150)
		objetoQueChoca.reducirVida(danio)
	}
	
	method shootSound()
	{
		soundEffect.play()
	}
}


object cartuchoDefault inherits Cartucho (bala = balaDefault,cantidadDeBalas = 30, cantidadDefault = 30){}
object cartuchoGrande inherits Cartucho (bala = balaGrande,cantidadDeBalas = 10,cantidadDefault = 10) {}
object cartuchoMediano inherits Cartucho(bala = balaMediana, cantidadDeBalas = 20, cantidadDefault = 20){}

class Municion inherits MovingObject(vida = 1,velocidad = -1, collider = provisionCollider, image = "municion.png")
{
	const cartucho
	var cantidadDeBalas
	const sonido = new Sonido(sonido = "municionRec.wav")
	
	override method aplicarEfectoSobre(objeto)
	{
	sonido.play()
	avion.cargarCartucho(cartucho,cantidadDeBalas)
	}



	
	method cartucho() = cartucho
	
	method cantidadDeBalas() = cantidadDeBalas

}






