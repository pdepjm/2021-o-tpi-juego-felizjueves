import animations.*
import wollok.game.*
import MutablePosition.*
import objectsAndColliders.*
import configuracion.*
import avion.*

object pepita inherits GenericObject(collider = pepitaCollider, image = "pepita.png", position = new MutablePosition(x = game.center().x(), y = game.center().y() + 5))
{
	const teleportAnim = new DynamicAnimation(frameRate = 50, animationImages = ["pepitaAnim1.png","pepitaAnim2.png","pepitaAnim3.png","pepitaAnim4.png","pepitaAnim3.png","pepitaAnim2.png","pepitaAnim1.png"])
	const eyeAnim = new DynamicAnimation(frameRate = 150, animationImages = ["pepitaEye1.png","pepitaEye2.png","pepitaEye3.png"])
	var vida = 20
	
	override method seMueve() = false
	
	method reducirVida(x)
	{
		self.teleport()
		vida -= 1
		if (vida <= 0) self.morir()
	}
	
	override method aplicarEfectoSobre(objeto) 
	{
		objeto.reducirVida(2000)
	}
	
	method aparecer()
	{
		position.goTo(game.center().x(),game.center().y() + 5)
		game.addVisual(self)
		teleportAnim.runAnimation(self,350)
		game.schedule(1000,{eyeAnim.runAnimation(self,350)})
	}
	
	method teleport()
	{
		teleportAnim.runAnimation(self,350)
		game.schedule(300,{position.goToRandom(game.center().y() + 5)})
	}
	
	method attack()
	{
		eyeAnim.runAnimation(self,150)
		self.crearAla()
		game.schedule(500,{self.crearAla()})
		game.schedule(1000,{self.crearAla()})
	}
	
	method crearAla()
	{
		const ala = new Ala( position = configuracion.randomPos())
		ala.iniciar()
	}
	
	override method morir()
	{
		super()
		configuracion.reventarAsteroides()
		game.schedule(1900,{pointTracker.aumentarPuntaje(9999999999)})
		configuracion.gameOver()
	}
	
	
}


class Ala inherits MovingObject(collider = asteroideCollider, image = "alita.png", velocidad = -1,vida = 2)
{
	override method aplicarEfectoSobre(objeto)
	{
		objeto.reducirVida(2)
	}
	
	method iniciar()
	{
		position.goTo(avion.position().x(),game.height())
		game.addVisual(self)
		configuracion.configurarColision(self)
	}
}
