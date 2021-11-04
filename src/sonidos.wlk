import wollok.game.*

class Sonido
{
	const property sonido
	var property activeSound = null
	var volume = 100

	
	method play()
	{
		activeSound = game.sound(sonido)
		activeSound.volume(volume/100)
		activeSound.play()
	}
	
	method play(_volume)
	{
		volume = _volume
		self.play()
	}
	
	method isActive() = activeSound != null
	
	method volume(_volume)
	{
		activeSound.volume(_volume)
	}
	
	method stop()
	{
		activeSound.stop()
	}
}