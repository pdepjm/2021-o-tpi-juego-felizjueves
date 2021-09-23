import avion.*
import wollok.game.*
import direcciones.*

object configuracion {
	method configuracionInicial(){
		game.addVisual(avion)		
		//game.ground(espacio)
		self.configurarTeclas()
	}

	method configurarTeclas(){
		keyboard.left().onPressDo({avion.moverHacia(izquierda) })
		keyboard.up().onPressDo({ avion.moverHacia(arriba) })
		keyboard.right().onPressDo({avion.moverHacia(derecha) })
		keyboard.down().onPressDo({avion.moverHacia(abajo) })

	}
	
}