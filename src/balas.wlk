import wollok.game.*
import objetoGenerico.*
import configuracion.*
import avion.*

class Cartucho
{
	var property bala
	
	var cantidadDeBalas
	
	method consumirBala() {cantidadDeBalas -= 1}
	
	method tieneBalas() = cantidadDeBalas > 0
}

class TemplateBala 
{
	const property danio
	const property imagen
	const property velocidad
	method crearTemplateBala() = new Bala(velocidad = self.velocidad(), image = self.imagen(), position = avion.position(), danio = self.danio())
	
}

object cartuchoDefault inherits Cartucho (bala = balaDefault,cantidadDeBalas = 30){}

object cartuchoGrande inherits Cartucho (bala = balaGrande,cantidadDeBalas = 10) {}

object balaDefault inherits TemplateBala(danio = 1, imagen = "misil_chico.png", velocidad = 1){}
object balaMediana inherits  TemplateBala(danio = 2, imagen = "misil_triple.png", velocidad = 0.3){}
object balaGrande inherits  TemplateBala(danio = 3, imagen = "misil_grande.png", velocidad = 0.3){}


class Bala inherits MovingObject(tipo  = "Bala", tiposQueChocaContra = ["Asteroide", "Provision"])
{
	const danio
	method reducirVida(x){self.morir()}
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
	
		objetoQueChoca.reducirVida(danio)
		
		if (objetoQueChoca.tipo() == "Asteroide" and objetoQueChoca.sinVida()) 
		{
		pointTracker.aumentarPuntaje(objetoQueChoca.puntaje())
		}
	}
}

class Provision inherits MovingObject(velocidad = 1, tiposQueChocaContra = ["Avion"])
{
	const cartucho
	
	method reducirVida(danio){self.morir()}
	
	override method aplicarEfectoSobre(Avion)
	{
	avion.agregarMunicion(cartucho)
	}

}

