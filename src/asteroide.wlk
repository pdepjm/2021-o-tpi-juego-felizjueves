import wollok.game.*
import objetoGenerico.*
import configuracion.*
import avion.*
import balas.*


class Asteroide inherits MovingObject(tipo = "Asteroide", tiposQueChocaContra = ["Bala","Avion"])
{
	const danio
	var vida
	const property puntaje 
	method sinVida() = vida <= 0
	
	override method morir()
	{
		pointTracker.aumentarPuntaje(self.puntaje())
		super()
	}
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.reducirVida(danio)
	}
	
	method reducirVida(_danio)
	{
	vida -= _danio
	if (self.sinVida()) self.morir()
	}

}

class TemplateAsteroide
{
	const property danio
	const property imagen
	const property velocidad
	const property puntaje
	const vida 
	
	method crearTemplateAsteroide() = new Asteroide(danio = danio, vida = vida, puntaje = puntaje, velocidad = velocidad, image = imagen, position = game.at(0.randomUpTo(game.width()),game.height()))

}

object lanzadorDeAsteroide
{
	const listaDeTemplates = [new TemplateAsteroide(danio =1, imagen = "asteroideChiquitin.png", velocidad = -0.3, puntaje = 100,vida = 1),
							new TemplateAsteroide(danio =1, imagen = "asteroideMediano.png", velocidad = -0.2, puntaje = 200,vida = 2),
							new TemplateAsteroide(danio =1, imagen = "asteroideGrande.png", velocidad = -0.1, puntaje = 300,vida = 3)]
	
	method lanzar()
	{
		const asteroideElegido = listaDeTemplates.anyOne().crearTemplateAsteroide()
		game.addVisual(asteroideElegido)
		configuracion.configurarColision(asteroideElegido)
	}
}