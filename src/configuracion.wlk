import avion.*
import wollok.game.*
import direcciones.*
import objetoVolador.*

object configuracion {
	
	method configuracionInicial(){
		game.addVisual(avion)		
		game.boardGround("espacio.png")
		self.configurarTeclas()
		self.crearLanzadores()
	}

	method configurarTeclas(){
		keyboard.left().onPressDo({avion.moverHacia(izquierda) })
		keyboard.up().onPressDo({ avion.moverHacia(arriba) })
		keyboard.right().onPressDo({avion.moverHacia(derecha) })
		keyboard.down().onPressDo({avion.moverHacia(abajo) })
		keyboard.space().onPressDo({avion.dispara()})
	}
	
	method gameOver()
	{
		
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
	
}

class LanzadorDeObjetos{
	
	method lanzarObjeto()
}

class LanzadorDeAsteroides inherits LanzadorDeObjetos
{
	
	override method lanzarObjeto()
	{
		const posicionInicioAleatoria = game.center()
		const nuevoAsteroide = new Asteroide(vida = 1.randomUpTo(5), posicionObjeto = posicionInicioAleatoria,danio=1)
		game.addVisual(nuevoAsteroide)
		nuevoAsteroide.configurar()
	}
	
}

class LanzadorDeCorazones inherits LanzadorDeObjetos
{
	
}

