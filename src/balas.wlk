import wollok.game.*
import objetoGenerico.*
import configuracion.*
import avion.*
import asteroide.*

class Cartucho
{
	var property bala
	
	const property tipo
	
	var cantidadDeBalas
	
	method consumirBala() {cantidadDeBalas -= 1}
	
	method tieneBalas() = cantidadDeBalas > 0
	
	method cargar(x)
	{
		cantidadDeBalas += x
	}
}

class TemplateBala 
{
	const property danio
	const property imagen
	const property velocidad
	method crearTemplateBala() = new Bala(velocidad = self.velocidad(), image = self.imagen(), position = avion.position(), danio = self.danio(),vida = 1)
	
}

class Bala inherits MovingObject(tipo  = "Bala", tiposQueChocaContra = ["Asteroide", "Provision"],vida = 1)
{
	const danio
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.reducirVida(danio)
	}
	
	override method morir()
	{
		game.removeVisual(self)
	}
}


object cartuchoDefault inherits Cartucho (bala = balaDefault,cantidadDeBalas = 30, tipo = "municion default"){}

object cartuchoGrande inherits Cartucho (bala = balaGrande,cantidadDeBalas = 10, tipo = "municion grande") {}

object balaDefault inherits TemplateBala(danio = 1, imagen = "misil_chico.png", velocidad = 0.6){}
object balaMediana inherits  TemplateBala(danio = 2, imagen = "misil_triple.png", velocidad = 0.4){}
object balaGrande inherits  TemplateBala(danio = 3, imagen = "misil_grande.png", velocidad = 0.3){}


class Municion inherits MovingObject(vida = 1,velocidad = -1, tipo = "Provision", tiposQueChocaContra = ["Avion", "Bala"], image = "municion.png")
{
	override method aplicarEfectoSobre(objeto)
	{
	}
}






