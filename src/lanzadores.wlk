import configuracion.*
import wollok.game.*
import asteroide.*
import avion.*
import balas.*
import animations.*
import sonidos.*
import MutablePosition.*
import carcazas.*
import balas.*
import objectsAndColliders.*
import templates.*

class Lanzador
{
	const listaDeTemplates
	method lanzar()
	{
		const objt = listaDeTemplates.anyOne().crearTemplate()
		objt.initPos(game.height())
		game.addVisual(objt)
		configuracion.configurarColision(objt)
	}
}

object lanzadorDeAsteroide inherits Lanzador(listaDeTemplates = [new TemplateAsteroide(danio =1, imagen = "asteroideChiquitin.png", velocidad = -0.4, puntaje = 100,vida = 1),
							new TemplateAsteroide(danio =1, imagen = "asteroideMediano.png", velocidad = -0.4, puntaje = 200,vida = 2),
							new TemplateAsteroide(danio =1, imagen = "asteroideGrande.png", velocidad = -0.3, puntaje = 300,vida = 3)])
{}

object lanzadorDeProvisiones inherits  Lanzador(listaDeTemplates = [new TemplateVida(vida = 1), new TemplateVida(vida = 3), new TemplateMunicion(cartucho = cartuchoDefault,cantidad = 10), new TemplateMunicion(cartucho = cartuchoGrande, cantidad = 5), new TemplateMunicion(cartucho = cartuchoMediano,cantidad = 4), new TemplateArmadura(armor = carcazaInfinita), new TemplateArmadura(armor = carcazaNormal), new TemplateArmadura(armor = carcazaDeMuniciones)])
{}



object lanzadorDeLaser
{
	const laserAnimation = new StaticAnimation(frameRate = 25, animationImages = ["001.png","002.png","003.png","004.png","005.png","006.png","007.png","008.png","009.png","010.png","011.png"])
    const warningAnimation = new StaticAnimation(frameRate = 50, animationImages = ["warning.png","warning1.png","warning2.png","warning3.png","warning2.png","warning1.png"])
	const laserSound = new Sonido(sonido = "laser.wav")
	const warningSound = new Sonido(sonido = "warning.wav")
	const position = new MutablePosition()
	
	method disparar1()
	{
		position.goToRandom(game.height() - 1)
		warningAnimation.runAnimation(position,900)
		warningSound.play(20)
		game.schedule(900,{self.disparar2()})
	}
	
	method disparar2()
	{
		position.goDown(game.height())
		laserSound.play(20)
		laserAnimation.runAnimation(position,275)
		if(avion.chocaContraLaser(position.x()))
		{
			avion.reducirVida(2)
		}
	}
	
}
 



