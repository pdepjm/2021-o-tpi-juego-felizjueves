import wollok.game.*
import objetoGenerico.*
import direcciones.*
import avion.*
import balas.*
import asteroide.*
import lanzadores.*
import MutablePosition.*
import sonidos.*

object configuracion {
	
	const  mainTheme = new Sonido(sonido = "mainTheme.mp3")
	const  gameOverSound = new Sonido(sonido = "gameOver.wav")
	
	const carcazasDisponibles = [carcazaNormal,carcazaDeMuniciones,carcazaInfinita]
	
	const property posicionesNoUsadas = #{}
	const property listaPosicionesDeBala= #{}
	
	const position = new MutablePosition()
	
	method mainTheme() {return mainTheme}
	method gameOverSound() { return gameOverSound}
	
	method configuracionDeJuego(){
		game.clear()
		mainTheme.playSound()
		avion.reset()
		carcazasDisponibles.forEach({x => x.reset()})
		game.addVisual(background)
		game.addVisual(avion)	
		game.addVisual(ammoTracker)
		game.addVisual(vidaTracker)
		game.addVisual(pointTracker)	
		pointTracker.reset()
		self.configurarColision(avion)
		self.configurarTeclas()
		game.onTick(50,"Actualizar todas las posiciones" ,{self.actualizarPosiciones()})
		game.onTick(2000, "Lanzar asteroide", {lanzadorDeAsteroide.lanzar()})
		game.onTick(9000, "Lanzar provision", {lanzadorDeProvisiones.lanzar()})
		game.onTick(3000, "Lanzar provision", {lanzadorDeLaser.disparar1()})
	}
	
	method configurarColision(objeto)
	{
		game.onCollideDo(objeto,{objetoQueChoca => objeto.impactarContra(objetoQueChoca)})
	}
	
	

	method configurarTeclas(){
		keyboard.left().onPressDo({avion.moverHacia(izquierda) })
		keyboard.up().onPressDo({ avion.moverHacia(arriba) })
		keyboard.right().onPressDo({avion.moverHacia(derecha) })
		keyboard.down().onPressDo({avion.moverHacia(abajo) })
		keyboard.space().onPressDo({avion.dispara()})
		keyboard.q().onPressDo({avion.cambiarMunicion()})
		keyboard.r().onPressDo({avion.usarHabilidad()})
		keyboard.k().onPressDo({self.gameOver()})
		keyboard.y().onPressDo({self.reventarTodo()})
		//keyboard.z().onPressDo({avion.dispara(balaTriple)})
		//keyboard.x().onPressDo({avion.dispara(balaChica)})
	}
	
	method reventarTodo()
	{
		game.allVisuals().filter({x => x.collider() == asteroideCollider}).forEach({x => game.removeVisual(x)})
	}
	

	method mainMenu()
	{
		game.clear()
	    game.boardGround("menu.png")
		keyboard.w().onPressDo({self.configuracionDeJuego()})
		keyboard.q().onPressDo({self.controles()}) 
		keyboard.s().onPressDo({game.stop()})
	} 
	
	method randomPos() {
		if (not posicionesNoUsadas.isEmpty())
		{
			 const pos = posicionesNoUsadas.anyOne()
			 posicionesNoUsadas.remove(pos)
			 pos.goTo(self.giveRandomSeed())
			 return pos
		}
		else return new MutablePosition(x =0.randomUpTo(game.width()),y=game.height())
		}
		
	
	method giveRandomSeed()
	{
		position.goToRandom(game.height())
		return position
	}
	
	method crearPositionBala()// todo: reutilizar codigo del metodo de arriba que es casi lo mismo
	{
		if (not listaPosicionesDeBala.isEmpty())
		{
			const x = listaPosicionesDeBala.anyOne()
			listaPosicionesDeBala.remove(x)
			x.goTo(avion.position().x(), avion.position().y())
			return x
		}
		else return new MutablePosition(x = avion.position().x(), y = avion.position().y())
	
	}
	method gameOver()
	{
		mainTheme.volume(0)
		gameOverSound.playSound()
		self.mainMenu()
		game.addVisual(object { method text() = "El puntaje final fue " + pointTracker.puntajeAcumulado().toString() method position() = game.center().up(1).right(5)})
	}
	
	method controles(){
		game.clear()
		game.addVisual(object { method image() = "controles.png" method position() = game.origin()})
		keyboard.w().onPressDo({self.mainMenu()})
	}
	
	
	method actualizarPosiciones()
	{
		game.allVisuals().filter({x => x.seMueve()}).forEach({x => x.desplazar()})
	}
	
	
}

object errorReporter
{
	var property position = new MutablePosition(x = game.width() + 10, y = game.height() + 10)
	var property image = "pepita.png"
}


object pointTracker inherits TextObject 
{
	
	var property puntajeAcumulado = 0
	
	method reset()
	{
		puntajeAcumulado = 0
	}
	
	
	
	method position() = new MutablePosition(x = 20,y = 20)
	
	method aumentarPuntaje(x)
	{
		puntajeAcumulado = puntajeAcumulado + x
	}
	
	
	
	method text() = puntajeAcumulado.toString()
	
	
	method textColor() = "00FF00FF"
	
}

class BackgroundElement inherits TextObject{
	const property image
	const property position = game.origin()
}

object background inherits BackgroundElement(image = "espacio.png",position = game.origin())
{
}



