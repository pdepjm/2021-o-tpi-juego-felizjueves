import wollok.game.*
import avion.*
import objetoVolador.*
import configuracion.*


class TipoDeBala inherits Texto
{

	
	const vidaBala
	const velocidadBala
	const danioBala
	const imagenDeBala
	
	var property cantidadDeMunicion 
	
	const texto 
	
	method position() = game.at(20,1)
	
	
	method text() = texto
	
 method disparar(avion)
	{	
		if (cantidadDeMunicion > 0)
		{	
		const bala = new Municion(vida = vidaBala, posicionObjeto = avion.posicion(),velocidad = velocidadBala,danio = danioBala,imagenObjeto = imagenDeBala)
		game.addVisual(bala)
		bala.configurar()
		cantidadDeMunicion = cantidadDeMunicion - 1
		}
	}	
}

object balaDefault inherits TipoDeBala(texto = "Municion Default", cantidadDeMunicion = 10,vidaBala = 1, velocidadBala = 1.5,danioBala = 2,imagenDeBala = "misil_chico.png")
{
}
	
object balaTriple inherits TipoDeBala(texto = "Municion Triple", cantidadDeMunicion = 5,vidaBala = 2, velocidadBala = 1,danioBala = 3, imagenDeBala = "misil_triple.png")
{

}

object balaChica inherits TipoDeBala(texto = "Municion Chica", cantidadDeMunicion = 40,vidaBala = 1, velocidadBala = 2,danioBala = 1,imagenDeBala = "misil_grande.png")
{
	
}

object contadorDeMunicion inherits Texto
{
	var property tipoDeMunicion = balaDefault
	method cambiarMunicion(nuevaMunicion){
		tipoDeMunicion = nuevaMunicion
	}
	method text() = "Cantidad de municion:  " + tipoDeMunicion.cantidadDeMunicion().toString()
	method position() = game.at(25,1)
	
}