import wollok.game.*
import objectsAndColliders.*
import configuracion.*
import balas.*
import MutablePosition.*
import animations.*
import sonidos.*
import carcazas.*
import avion.*

class Vida inherits MovingObject(collider = provisionCollider, image = "vida.png", velocidad = -0.6, vida = 1)
{
	const property vidaQueCura
	const sound = new Sonido(sonido = "recover.wav")
	
	override method aplicarEfectoSobre(objeto)
	{
		sound.play()
		avion.agregarVida(vidaQueCura)
	}
}

class ArmaduraAgarrable inherits MovingObject(collider = provisionCollider, velocidad = -1, vida = 3)
{
	const armadura
	const sound = new Sonido(sonido = "armadura.wav")
	
	override method aplicarEfectoSobre(objeto)
	{
		sound.play()
		avion.cambiarArmadura(armadura)
	}
	
	method armadura() = armadura
}
