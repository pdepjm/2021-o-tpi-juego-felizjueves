import wollok.game.*
import MutablePosition.*
import objectsAndColliders.*


 class Animation inherits TextObject
 {
 	
 	const animationImages = [] // Imagenes que se utilizan al momento de correr la animacion/
 	const frameRate // Medio falso el nombre, en verdad es el tiempo en millisegundos hasta el siguiente frame.
 	var frame = 0
 	method image() =  animationImages.get(frame) 
 	
 	method update(){
 		frame += 1
 		if (frame >= animationImages.size()) frame = 0
 	}
 	
 	method createAnimation(lengthOfAnimation) // Crea una animacion que loopea las imagenes que hay en animationImages hasta que se acaba el tiempo.
 	{
 	game.schedule(lengthOfAnimation, {game.removeVisual(self)})
 	game.onTick(frameRate,"nuevo frame",{self.update()})
 	game.schedule(lengthOfAnimation,{game.removeTickEvent("nuevo frame")})
 	}
 }
 
 
 class StaticAnimation inherits Animation 
 {
 	const property position  = new MutablePosition()
 	method runAnimation(_position, lengthOfAnimation) // las StaticAnimation reciben una posicion y ejecutan la animacion en esa posicion fija.
 	{
 	position.goTo(_position)
 	game.addVisual(self)
 	self.createAnimation(lengthOfAnimation)
 	}
 }
 
 
 class DynamicAnimation inherits Animation
 {
 	var property position = null
 	
    method runAnimation(objectA,lengthOfAnimation) // Las dynamicAnimation reciben un objeto y se acoplan a este en la duracion de la animacion
 	{
 	position = objectA.position()
 	game.addVisual(self)
 	self.createAnimation(lengthOfAnimation)
 	}
 }
