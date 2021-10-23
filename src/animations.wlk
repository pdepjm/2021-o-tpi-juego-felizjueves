import wollok.game.*
import MutablePosition.*

 class Animation
 {
 	const animationImages = []
 	const frameRate
 	var frame = 0
 	var position = null
 	
 	method position() = position
 	
 	method chocaContra(x) = false
 	method seMueve() = false
 	
 	method image() =  animationImages.get(frame) 
 	
 	method update(){
 		frame += 1
 		if (frame >= animationImages.size()) frame = 0
 	}
 	
 	method createAnimation(lengthOfAnimation)
 	{
 	game.schedule(lengthOfAnimation, {game.removeVisual(self)})
 	game.onTick(frameRate,"nuevo frame",{self.update()})
 	game.schedule(lengthOfAnimation,{game.removeTickEvent("nuevo frame")})
 	}
 }
 
 
 class StaticAnimation inherits Animation (position = new MutablePosition())
 {

 	
 	method runAnimation(_position, lengthOfAnimation)
 	{
 	position.goTo(_position)
 	game.addVisual(self)
 	self.createAnimation(lengthOfAnimation)
 	}
 	
 }
 
 class DynamicAnimation inherits Animation
 {
    method runAnimation(objectA,lengthOfAnimation)
 	{
 	position = objectA.position()
 	game.addVisual(self)
 	self.createAnimation(lengthOfAnimation)
 	}
 }
