import wollok.game.*

 class Animation
 {
 	const animationImages = []
 	var property position
 	const frameRate
 	var frame = 0
 	
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
 
 
 class StaticAnimation inherits Animation
 {
 	
 	method runAnimation(_position, lengthOfAnimation)
 	{
 	position = 	_position
 	game.addVisual(self)
 	self.createAnimation(lengthOfAnimation)
 	}
 	
 }
 
 class DynamicAnimation inherits Animation
 {
    method runAnimation(lengthOfAnimation)
 	{
 	game.addVisual(self)
 	self.createAnimation(lengthOfAnimation)
 	}
 }
