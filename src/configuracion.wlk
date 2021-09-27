import avion.*
import wollok.game.*
import direcciones.*
import objetoVolador.*

object configuracion {
	
	method configuracionDeJuego(){
		game.clear()
		game.addVisual(avion)	
		game.addVisual(avion.municiones().get(0))
		game.addVisual(pointTracker)	
		pointTracker.reset()
		game.boardGround("espacio.png")
		self.configurarTeclas()
		self.crearLanzadores()
		game.onTick(150,"Actualizar todas las posiciones" ,{self.actualizarPosiciones()})
	}

	method configurarTeclas(){
		keyboard.left().onPressDo({avion.moverHacia(izquierda) })
		keyboard.up().onPressDo({ avion.moverHacia(arriba) })
		keyboard.right().onPressDo({avion.moverHacia(derecha) })
		keyboard.down().onPressDo({avion.moverHacia(abajo) })
		keyboard.space().onPressDo({avion.dispara()})
		keyboard.q().onPressDo({avion.cambiarMunicion()})
		//keyboard.z().onPressDo({avion.dispara(balaTriple)})
		//keyboard.x().onPressDo({avion.dispara(balaChica)})
	}
	

	method mainMenu()
	{
		game.clear()
		game.boardGround("espacio.png")
		game.addVisual(object { method image() = "comenzar.png" method position() = game.at(2,13)})
		game.addVisual(object { method image() = "controles.png" method position() = game.at(2,9)})
		game.addVisual(object { method image() = "salir.png" method position() = game.at(2,5)})
		keyboard.w().onPressDo({self.configuracionDeJuego()})
		keyboard.q().onPressDo({self.controles()}) 
		keyboard.s().onPressDo({game.stop()})
	} 
	
	method gameOver()
	{
		game.clear()
		game.addVisual(object { method text() = "El puntaje final fue " + pointTracker.puntajeAcumulado().toString() method position() = game.center()})
	}
	
	method controles(){
		game.clear()
		game.boardGround("espacio.png")
		game.addVisual(object { method image() = "controles.png" method position() = game.center()})
		keyboard.w().onPressDo({self.mainMenu()})
	}
	
	method impacto(x,y)
	{
	if(x.esChocable() and y.esChocable())
	{ 
	  x.bajarVida(y.danio())
	  y.bajarVida(x.danio())
	}
	}
	
	method crearLanzadores()
	{
		const x = new LanzadorDeAsteroides()
		game.onTick(1000, "blah",{x.lanzarObjeto()})
	}
	
	method actualizarPosiciones()
	{
		game.allVisuals().filter({x => x.seMueve()}).forEach({x => x.desplazar()})
	}
	
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
object pointTracker
{
	var property esChocable = false
	var property seMueve = false
	
	var property puntajeAcumulado = 0
	
	method reset()
	{
		puntajeAcumulado = 0
	}
	
	method desplazar()
	{}
	
	method position() = game.at(20,20)
	
	method aumentarPuntaje(x)
	{
		puntajeAcumulado = puntajeAcumulado + x
	}
	
	method bajarVida()
	{}
	
	method text() = puntajeAcumulado.toString()
	
	
	method textColor() = "00FF00FF"
	
}


class LanzadorDeObjetos{
	
	method lanzarObjeto()
}

class LanzadorDeAsteroides inherits LanzadorDeObjetos
{
	
	override method lanzarObjeto()
	{
		const posicionInicioAleatoria = game.center().up(15).right((-10).randomUpTo(10))
		const nuevoAsteroide = new Asteroide(vida = 1.randomUpTo(5), posicionObjeto = posicionInicioAleatoria,danio=1)
		game.addVisual(nuevoAsteroide)
		nuevoAsteroide.configurar()
	}
	
}

class LanzadorDeCorazones inherits LanzadorDeObjetos
{
	
}

