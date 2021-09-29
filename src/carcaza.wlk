import wollok.game.*
import avion.*
import objetoVolador.*
import configuracion.*

	

class Carcaza
{
	var property vida
	var property danio
	
	method bajarVida(x)
	{
		vida = vida - x
		if (vida <= 0) configuracion.gameOver()
	}
	
	method habilidadEspecial()
}

object carcazaDefault inherits Carcaza(vida = 3, danio = 2)
{
	method habilidadEspecial()
	{
		
	}
}

object carcazaLiviana inherits Carcaza(vida = 2, danio = 0)
{
	method habilidadEspecial()
	{}
}

object carcazaPesada inherits Carcaza(vida = 5, danio = 5)
{
	method habilidadEspecial()
	{
		
	}
}