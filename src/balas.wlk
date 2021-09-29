import wollok.game.*
import avion.*
import objetoVolador.*


class TipoDeBala
{
	var property seMueve = false
	var property esChocable = false
	
	const vidaBala
	const velocidadBala
	const danioBala
	const imagenDeBala
	
	var property municion 
	
	const texto 
	
	method position() = game.at(20,1)
	
	
	method text() = texto
	
 method disparar(avion)
	{	
		if (municion > 0)
		{	
		const bala = new Municion(vida = vidaBala, posicionObjeto = avion.posicion(),velocidad = velocidadBala,danio = danioBala,imagenObjeto = imagenDeBala)
		game.addVisual(bala)
		bala.configurar()
		municion = municion - 1
		}
	}	
}

object balaDefault inherits TipoDeBala(texto = "Municion Default", municion = 10,vidaBala = 1, velocidadBala = 1.5,danioBala = 2,imagenDeBala = "misil_chico.png")
{
}
	
object balaTriple inherits TipoDeBala(texto = "Municion Triple", municion = 5,vidaBala = 2, velocidadBala = 1,danioBala = 3, imagenDeBala = "misil_triple.png")
{

}

object balaChica inherits TipoDeBala(texto = "Municion Chica", municion = 40,vidaBala = 1, velocidadBala = 2,danioBala = 1,imagenDeBala = "misil_grande.png")
{
	
}