import configuracion.*
import wollok.game.*
import asteroide.*
import avion.*
import balas.*

class TemplateMunicion
{
	
	const cartucho
	const cantidad
	method crearTemplate() = new Municion(cartucho = cartucho, cantidadDeBalas = cantidad, position =  configuracion.randomPos())
	
}

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
	
	method crearTemplate() = new Asteroide(danio = danio, vida = vida, puntaje = puntaje, velocidad = velocidad, image = imagen, position = configuracion.randomPos())
}

class TemplateArmadura
{
	const property armor
	
	
	method crearTemplate() = new ArmaduraAgarrable(armadura = armor, image = "shipTemplate.png", position = configuracion.randomPos())
}



class Lanzador
{
	const listaDeTemplates
	method lanzar()
	{
		const asteroideElegido = listaDeTemplates.anyOne().crearTemplate()
		game.addVisual(asteroideElegido)
		configuracion.configurarColision(asteroideElegido)
	}
}

object lanzadorDeAsteroide inherits Lanzador(listaDeTemplates = [new TemplateAsteroide(danio =1, imagen = "asteroideChiquitin.png", velocidad = -0.3, puntaje = 100,vida = 1),
							new TemplateAsteroide(danio =1, imagen = "asteroideMediano.png", velocidad = -0.2, puntaje = 200,vida = 2),
							new TemplateAsteroide(danio =1, imagen = "asteroideGrande.png", velocidad = -0.1, puntaje = 300,vida = 3)])
{}

object lanzadorDeProvisiones inherits  Lanzador(listaDeTemplates = [new TemplateVida(vida = 1), new TemplateVida(vida = 3), new TemplateMunicion(cartucho = cartuchoDefault,cantidad = 10), new TemplateMunicion(cartucho = cartuchoGrande, cantidad = 5), new TemplateMunicion(cartucho = cartuchoMediano,cantidad = 4), new TemplateArmadura(armor = carcazaInfinita), new TemplateArmadura(armor = carcazaNormal), new TemplateArmadura(armor = carcazaDeMuniciones)])
{}

