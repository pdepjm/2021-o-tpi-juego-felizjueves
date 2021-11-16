import wollok.game.*
import objectsAndColliders.*
import direcciones.*
import avion.*
import balas.*
import asteroide.*
import lanzadores.*
import MutablePosition.*
import sonidos.*
import carcazas.*
import animations.*
import pepita.*

object configuracion {
	
	const  mainTheme = new Sonido(sonido = "mainTheme.mp3")
	const  gameOverSound = new Sonido(sonido = "gameOver.wav")
	const pepitaTheme = new Sonido(sonido =  "pepitaTheme.mp3")
	var property volumen = 30
	
	const carcazasDisponibles = [carcazaNormal,carcazaDeMuniciones,carcazaInfinita]
	
	const property posicionesNoUsadas = []
	const property posicionesActivas = []
	
	method cambiarVolumen(x)
	{
		volumen = (volumen+x).max(0).min(100)
	}
	
	method mainTheme() {return mainTheme}
	method gameOverSound() { return gameOverSound}
	
	method configuracionDeJuego(){
		game.clear()
		self.iniciarSonidos()
		self.resetearEntidades()
	    self.agregarObjetos()
		self.configurarColision(avion)
		self.configurarTeclas()
		self.iniciarEventos()
		self.iniciarEntidades()
	}
	
	method iniciarSonidos()
	{
		if (pepitaTheme.isActive()) pepitaTheme.stop()
		mainTheme.play(90)
		keyboard.m().onPressDo({self.cambiarVolumen(10)})
	keyboard.n().onPressDo({self.cambiarVolumen(-10)})
	}
	
	method resetearEntidades()
	{
		avion.reset()
		pointTracker.reset()
		carcazasDisponibles.forEach({x => x.reset()})
	}
	
	method iniciarEntidades()
	{
		game.addVisual(errorReporter)
		game.addVisual(entityTracker)
		game.errorReporter(errorReporter)
	}
	
	
	method iniciarEventos()
	{
		game.onTick(200,"Actualizar todas las posiciones que no sean balas" ,{self.actualizarPosicionesNoBalas()})
		game.onTick(150, "Actualizar posiciones de las balas", {self.actualizarPosicionesBalas()})
		game.onTick(1400, "Lanzar asteroide", {lanzadorDeAsteroide.lanzar()})
		game.onTick(8678, "Lanzar provision", {lanzadorDeProvisiones.lanzar()})
		game.onTick(3333, "Lanzar laser", {lanzadorDeLaser.disparar1()})
		game.schedule(60000, {self.crearPepita()})
	}
	
	method agregarObjetos()
	{
		game.addVisual(background)
		game.addVisual(avion)	
		game.addVisual(ammoTracker)
		game.addVisual(vidaTracker)
		game.addVisual(ammoTypeTracker)
		game.addVisual(pointTracker)	
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
		keyboard.y().onPressDo({self.reventarAsteroides()})
	}
	
	method reventarAsteroides()
	{
		const soundEffect = new Sonido(sonido = "bigOOF.mp3")
		const firstLayer = new BackgroundElement(image = "firstlayer.png")
		const secondLayer = new BackgroundElement(image = "secondlayer.png")
		self.mainTheme().volume(0)
		soundEffect.play()
		game.schedule(400, {game.addVisual(firstLayer)})
		game.schedule(900,{game.addVisual(secondLayer)})
		game.schedule(1700,{game.removeVisual(firstLayer)})
		game.schedule(1700,{game.allVisuals().filter({x => x.collider() == asteroideCollider}).forEach({x => x.reducirVida(5)})})
		game.schedule(1900, {game.removeVisual(secondLayer)})
		game.schedule(2000,{self.mainTheme().volume(0.8)})
	}
	

	method mainMenu()
	{
		game.clear()
	    game.boardGround("menu.png")
		keyboard.w().onPressDo({self.configuracionDeJuego()})
		keyboard.q().onPressDo({self.controles()}) 
		keyboard.s().onPressDo({game.stop()})
	} 
	
	method agregarPosicionNoUsada(position)
	{
		self.posicionesActivas().remove(position)
		self.posicionesNoUsadas().add(position)
	}
	
	method cantidadDeEntidades() = posicionesNoUsadas.size() + posicionesActivas.size()
	
	method randomPos() {
		if (not posicionesNoUsadas.isEmpty())
		{
			 const pos = posicionesNoUsadas.last()
			 posicionesNoUsadas.remove(pos)
			 if (posicionesActivas.contains(pos))
			 {
			 return self.randomPos()
			 }
			 else
			 {
			 posicionesActivas.add(pos)
			 return pos
			 }
		}
		else 
		{
			const pos = new MutablePosition(x =0.randomUpTo(game.width()),y=game.height())
			posicionesActivas.add(pos)
			return pos 
		}
			
		}
		
	
	

	method gameOver()
	{
		if (mainTheme.isActive()) mainTheme.stop()
		if (pepitaTheme.isActive()) pepitaTheme.stop()
		gameOverSound.play()
		self.mainMenu()
		game.addVisual(object { method text() = "El puntaje final fue " + pointTracker.puntajeAcumulado().toString() method position() = game.center().up(1).right(5) method textColor() = "FFFFFFF"})
	}
	
	method controles(){
		game.clear()
		game.addVisual(object { method image() = "controles.png" method position() = game.origin()})
		keyboard.w().onPressDo({self.mainMenu()})
	}
	
	
	method actualizarPosicionesNoBalas()
	{
		game.allVisuals().filter({x => x.seMueve()}).filter({x => not (x.collider() == balaCollider)}).forEach({x => x.desplazar()})
	}
	
	method actualizarPosicionesBalas()
	{
		game.allVisuals().filter({x =>  x.collider() == balaCollider}).forEach({x => x.desplazar()})
	}
	
	method crearPepita()
	{
		self.reventarAsteroides()
		mainTheme.stop()
		game.removeTickEvent("Lanzar asteroide")
		game.removeTickEvent("Lanzar laser")
		game.removeTickEvent("Lanzar provision")
		game.schedule(2000,{pepita.aparecer()})
		game.schedule(4000,{self.iniciarPepitaFase()})	
	}
	
	method iniciarPepitaFase()
	{
		pepitaTheme.play()
		game.onTick(1200,"Lanzar laser", {lanzadorDeLaser.disparar1()})
		game.onTick(3000, "Lanzar asteroide", {lanzadorDeAsteroide.lanzar()})
		game.onTick(6200,"Lanzar provision", {lanzadorDeProvisiones.lanzar()})
		game.onTick(10000,"Teleport pepita", {pepita.teleport()})
		game.onTick(400,"Mover pepita",{pepita.moverse()})
		game.onTick(6000, "Pepita ataca", {pepita.attack()})
	}
	
	
}


object pointTracker inherits TextObject 
{
	const property position = new MutablePosition(x = 3,y = game.height() - 1)
	var property puntajeAcumulado = 0
	
	method reset()
	{
		puntajeAcumulado = 0
	}
	
	method aumentarPuntaje(x)
	{
		puntajeAcumulado = puntajeAcumulado + x
	}
	
	method text() = "Puntaje: "  + puntajeAcumulado.toString()
	method textColor() = "FFFFFFF"
}

class BackgroundElement inherits TextObject{
const property position = new MutablePosition(x= 0, y= 0)
const property image
}

object background inherits BackgroundElement(image = "espacio.png")
{
}

object errorReporter inherits TextObject // Hay algunos errores con las colisiones que no afectan al juego pero tiran error y queda medio feo, por lo que decidi esconder los errores por el momento en este objeto. 
{
	const property position = new MutablePosition(x = -20, y = 20)
	const property text = "No me llamen escoba, es ofensivo."
}

object entityTracker inherits TextObject
{
	const property position = new MutablePosition(x = 0,y= game.height() - 1)
	method text() = configuracion.cantidadDeEntidades().toString()
}




