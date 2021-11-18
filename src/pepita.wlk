import animations.*
import wollok.game.*
import MutablePosition.*
import objectsAndColliders.*
import configuracion.*
import avion.*
import direcciones.*

object pepita inherits GenericObject(collider = pepitaCollider, image = "pepita.png", position = new MutablePosition(x = game.center().x(), y = game.center().y() + 5))
{
	const teleportAnim = new DynamicAnimation(frameRate = 50, animationImages = ["pepitaAnim1.png","pepitaAnim2.png","pepitaAnim3.png","pepitaAnim4.png","pepitaAnim3.png","pepitaAnim2.png","pepitaAnim1.png"])
	const eyeAnim = new DynamicAnimation(frameRate = 150, animationImages = ["pepitaEye1.png","pepitaEye2.png","pepitaEye3.png"])
	var property vida = 10
	const vidaPTracker = pepitaHPTracker
	
	override method seMueve() = false
	
	method reducirVida(x)
	{
		self.teleport()
		vida -= x
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
		game.schedule(1300,{vidaPTracker.reset()})
		vida = 20
	}
	
	method teleport()
	{
		teleportAnim.runAnimation(self,350)
		game.schedule(300,{position.goToRandom(game.center().y() + 5)})
		game.schedule(300,{vidaPTracker.followPepita()})
		if (vida <= 4 and 0.randomUpTo(1) > 0.7) vida += 1
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
		game.schedule(2100,{pointTracker.aumentarPuntaje(9999999999)})
		game.schedule(2300,{configuracion.gameOver()})
	}
	
	method moverse()
	{
		derecha.movimientoHorizontal(position,(-2).randomUpTo(2) * (game.center().x() - position.x())/game.width()  + (-1).randomUpTo(1))
		if((position.x() - game.center().x()).abs() >= game.width()/2)
		{
			self.teleport()
		}
		vidaPTracker.followPepita()
	}
	
	
	
	
}

object pepitaHPTracker inherits TextObject
{
	const property position = new MutablePosition(x =0, y= 0)
	method image() = "hp" + self.computarVida() + ".png"
	
	method computarVida()
	{
		if (pepita.vida() > 5) return 50.toString() else return (pepita.vida()).min(50).toString()
	}
	method reset()
	{
		self.followPepita()
		game.addVisual(self)
	}
	
	method followPepita()
	{
		position.goTo(pepita.position())
	}
}


class Ala inherits MovingObject(collider = asteroideCollider, image = "alita.png", velocidad = -1.5,vida = 1)
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
	
	override method desplazar()
	{
		super()
		derecha.movimientoHorizontal(position,(avion.position().x() - position.x())/(avion.position().x() - position.x()).abs() * 1/4)
	}
}
