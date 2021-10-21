import MutablePosition.*

object izquierda {
	method proximaPosicion(posicionActual) { posicionActual.goLeft(1) }
}

object derecha {
	method proximaPosicion(posicionActual) { posicionActual.goRight(1) }
}

object arriba {
	method proximaPosicion(posicionActual) {posicionActual.goUp(1)}
	method movimientoVertical(posicionActual,velocidad) {posicionActual.goUp(velocidad)}
}

object abajo {
	method proximaPosicion(posicionActual) { posicionActual.goDown(1)}
}

