import avion.*
import wollok.game.*
import direcciones.*
import objetoVolador.*

object configuracion {
	
	method configuracionDeJuego(){
		game.clear()
		game.addVisual(avion)		
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
	}
	
	method mainMenu()
	{
		game.clear()
		game.boardGround("fondo_menu.png")
		game.addVisual(object { method image() = "play.png" method position() = game.at(2,3)})
		game.addVisual(object { method image() = "controles.png" method position() = game.at(3,5)})
		game.addVisual(object { method image() = "salir.png" method position() = game.at(5,8)})
		
		keyboard.enter().onPressDo({self.configuracionDeJuego()})
		keyboard.w().onPressDo({self.controles()}) 
		keyboard.s().onPressDo({game.stop()})
		
	}
	
	method impacto(x,y)
	{
		x.bajarVida(y.danio())
		y.bajarVida(x.danio())
	}
	
	method crearLanzadores()
	{
		const x = new LanzadorDeAsteroides()
		game.onTick(10000, "blah",{x.lanzarObjeto()})
	}
	
	method actualizarPosiciones()
	{
		game.allVisuals().forEach({x => x.desplazar()})
	}
	
	
}


class LanzadorDeObjetos{
	
	method lanzarObjeto()
}

class LanzadorDeAsteroides inherits LanzadorDeObjetos
{
	
	override method lanzarObjeto()
	{
		const posicionInicioAleatoria = game.center().up(40).right((-20).randomUpto(20))
		const nuevoAsteroide = new Asteroide(vida = 1.randomUpTo(5), posicionObjeto = posicionInicioAleatoria,danio=1)
		game.addVisual(nuevoAsteroide)
		nuevoAsteroide.configurar()
	}
	
}

class LanzadorDeCorazones inherits LanzadorDeObjetos
{
	
}

