import avion.*
import wollok.game.*
import direcciones.*

object configuracion {
	method configuracionInicial(){
		game.addVisual(avion)		
		game.boardGround("espacio.png")
		self.configurarTeclas()
	}

	method configurarTeclas(){
		keyboard.left().onPressDo({avion.moverHacia(izquierda) })
		keyboard.up().onPressDo({ avion.moverHacia(arriba) })
		keyboard.right().onPressDo({avion.moverHacia(derecha) })
		keyboard.down().onPressDo({avion.moverHacia(abajo) })
		keyboard.space().onPressDo({avion.dispara()})

	}
	
}