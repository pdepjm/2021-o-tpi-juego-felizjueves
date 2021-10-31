import configuracion.*
import wollok.game.*
import asteroide.*
import avion.*
import balas.*
import animations.*
import sonidos.*
import MutablePosition.*
import carcazas.*
import balas.*
import objectsAndColliders.*
import provisiones.*

class TemplateVida
{
	const property vida
	
	method crearTemplate() = new Vida(vidaQueCura = 1, position = configuracion.randomPos())
}

class TemplateAsteroide
{
	const property danio
	const property imagen
	const property velocidad
	const property puntaje
	const vida 
	
	method crearTemplate() 
	{
	const z = new Asteroide(danio = danio, vida = vida, puntaje = puntaje, velocidad = velocidad, image = imagen, position = configuracion.randomPos())
	z.initPos(game.height() - 1)	
	return z
	}
}

class TemplateBala 
{
	const property danio
	const property imagen
	const property velocidad
	const property efectoDisparo
	

	
	method crearTemplateBala() 
	{ 
		const z = new Bala(velocidad = self.velocidad(), image = self.imagen(), position = configuracion.randomPos(), danio = self.danio(),vida = 1, collider = balaCollider,soundEffect = efectoDisparo)
       z.position().goTo(avion.position())
       return z
       }
} 

class TemplateArmadura
{
	const property armor
	
	
	method crearTemplate() = new ArmaduraAgarrable(armadura = armor, image = "shipTemplate.png", position = configuracion.randomPos())
}

class TemplateMunicion
{
	
	const cartucho
	const cantidad
	method crearTemplate() = new Municion(cartucho = cartucho, cantidadDeBalas = cantidad, position =  configuracion.randomPos())
	
}


object balaDefault inherits TemplateBala(danio = 1, imagen = "misil_chico.png", velocidad = 0.5, efectoDisparo = new Sonido(sonido = "smallshoot.mp3.wav")){} // ignorar esto
object balaMediana inherits  TemplateBala(danio = 2, imagen = "misil_mediano.png", velocidad = 0.4,efectoDisparo = new Sonido(sonido = "midshoot.mp3.wav")){}
object balaGrande inherits  TemplateBala(danio = 3, imagen = "misil_grande.png", velocidad = 0.3,efectoDisparo = new Sonido(sonido = "bigshoot.mp3.wav")){}

