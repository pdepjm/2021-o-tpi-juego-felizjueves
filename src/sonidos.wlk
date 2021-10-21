import wollok.game.*

class Sonido
{
	const property sonido
	var property activeSound = null

	
	method playSound()
	{
		activeSound = game.sound(sonido)
		activeSound.play()
	}
	
	method playSound(volume)
	{
		self.playSound()
		activeSound.volume(volume/100)
	}
	
	method volume(volume)
	{
		activeSound.volume(volume)
	}
}