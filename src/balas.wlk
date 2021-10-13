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
	method crearTemplateBala() = new Bala(velocidad = self.velocidad(), image = self.imagen(), position = avion.position(), danio = self.danio(),vida = 1)
	
}

object cartuchoDefault inherits Cartucho (bala = balaDefault,cantidadDeBalas = 30){}

object cartuchoGrande inherits Cartucho (bala = balaGrande,cantidadDeBalas = 10) {}

object balaDefault inherits TemplateBala(danio = 1, imagen = "misil_chico.png", velocidad = 0.6){}
object balaMediana inherits  TemplateBala(danio = 2, imagen = "misil_triple.png", velocidad = 0.4){}
object balaGrande inherits  TemplateBala(danio = 3, imagen = "misil_grande.png", velocidad = 0.3){}


class Bala inherits MovingObject(tipo  = "Bala", tiposQueChocaContra = ["Asteroide", "Provision"])
{
	const danio
	method reducirVida(x){self.morir()}
	
	override method aplicarEfectoSobre(objetoQueChoca)
	{
		objetoQueChoca.reducirVida(danio)
	}
}

class Provision inherits MovingObject(velocidad = 1, tiposQueChocaContra = ["Avion"])
{
	const provision
	
	method reducirVida(danio){self.morir()}
	
	override method aplicarEfectoSobre(Avion)
	{
	avion.agregarProvision(provision)
	}

}

class TemplateProvision
{
	const property tipo
	const property cantidad
}

