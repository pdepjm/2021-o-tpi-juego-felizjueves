

object izquierda {
	method proximaPosicion(posicionActual) = posicionActual.left(3) 
}

object derecha {
	method proximaPosicion(posicionActual) = posicionActual.right(3) 
}

object arriba {
	method proximaPosicion(posicionActual) = posicionActual.up(3)
}

object abajo {
	method proximaPosicion(posicionActual) = posicionActual.down(3)
}