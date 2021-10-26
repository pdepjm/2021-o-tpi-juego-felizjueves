import wollok.game.*

class Sonido
{
	const property sonido
	var property activeSound = null

	
	method play()
	{
		activeSound = game.sound(sonido)
		activeSound.play()
	}
	
	method play(volume)
	{
		self.play()
		activeSound.volume(volume/100)
	}
	
	method volume(volume)
	{
		activeSound.volume(volume)
	}
}