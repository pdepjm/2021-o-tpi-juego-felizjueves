import wollok.game.*
import configuracion.*
import objetoVolador.*

object avion {
	const property type = "Avion"
	
	var property esChocable = true
	
	var property posicion = game.at(15,0)
	
	var property municiones = [balaDefault,balaTriple,balaChica]
	
	var carcaza = carcazaDefault
	
	var municionSeleccionada = 0
	
	var property seMueve = true
	
	method cambiarMunicion()
	{
		game.removeVisual(municiones.get(municionSeleccionada))
		municionSeleccionada = (municionSeleccionada + 1).rem(municiones.size())
		game.addVisual(municiones.get(municionSeleccionada))

	}
	
	method danio() = carcaza.danio()
    
    method vida() = carcaza.vida()
	
	method image() {
		return "avion.png"
	} 
	method position (){
		return posicion
	}
	
	method moverHacia(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	
	method bajarVida(x) {carcaza.bajarVida(x)}
	
	
	 
	method dispara(){
		municiones.get(municionSeleccionada).disparar(self)
	}
	
	//method dispara(municionElegida){
		//municionElegida.disparar(self)
	//}
	
	method desplazar(){}
}

///////////////////////////////////////////////////////////////////////////////////////////////////

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
	

class Carcaza
{
	var property vida
	var property danio
	
	method bajarVida(x)
	{
		vida = vida - x
		if (vida <= 0) configuracion.gameOver()
	}
	
	method habilidadEspecial()
}

object carcazaDefault inherits Carcaza(vida = 3, danio = 2)
{
	method habilidadEspecial()
	{
		
	}
}

object carcazaLiviana inherits Carcaza(vida = 2, danio = 0)
{
	method habilidadEspecial()
	{}
}

object carcazaPesada inherits Carcaza(vida = 5, danio = 5)
{
	method habilidadEspecial()
	{
		
	}
}


