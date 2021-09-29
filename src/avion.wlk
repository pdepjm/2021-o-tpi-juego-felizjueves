import wollok.game.*
import configuracion.*
import objetoVolador.*
import balas.*
import carcaza.*

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




