/* 
import soundProducer.*
import wollok.game.*
import avion.*
import direcciones.*
import balas.*
import asteroide.*
import configuracion.*

describe "Funcionamiento de movimientos" {
	method initialize() {
		//soundProducer.provider(soundProviderMock)		
	}
	
	
	test "La nave se mueve hacia arriba" {
		avion.moverHacia(arriba)
		assert.equals(game.at(2,1),avion.position())
	}
	
	test "La nave se mueve hacia abajo" {
		avion.moverHacia(abajo)
		assert.equals(game.at(2,-1),avion.position())
	}
	
	test "La nave se mueve hacia la izquierda" {
		avion.moverHacia(izquierda)
		assert.equals(game.at(1,0),avion.position())
	}
	
	test "La nave se mueve hacia la derecha" {
		avion.moverHacia(derecha)
		assert.equals(game.at(3,0),avion.position())
	}
					
}

describe "Funcionamiento del disparo" {
	
	//Cantidad de balas iniciales del cartuchoDefault : 30
	
	test "Luego de disparar una vez aun le quedan balas"{
		avion.dispara()
		assert.that(cartuchoDefault.tieneBalas())
	}
	
	test "Luego de disparar 30 veces el cartucho se queda sin balas"{
		30.times({_ => avion.dispara()})
		assert.notThat(cartuchoDefault.tieneBalas())
	}
	
	test "Inicialmente el arma tiene el cartuchoDefault"{
		assert.equals(cartuchoDefault,rifle.cartuchos().get(rifle.selectorCartucho()))
	}
	
	test "Cambiar a cartucho grande  "{
		avion.cambiarMunicion()
		assert.equals(cartuchoGrande,rifle.cartuchos().get(rifle.selectorCartucho()))
	}
}

describe "Verificar vida de la nave"{
	
	// La carcaza de la nave tiene vida igual a 1
	test "Inicialmente la nave tiene una vida mayor a 0"{
		assert.equals(1,carcaza.vida())
	}
	
	test "la nave recibe daño y su vida queda en 0"{
		avion.reducirVida(1)
		assert.equals(0,carcaza.vida())
	}
}

describe "Asteroides"{
	
	const template = new TemplateAsteroide(danio =1, imagen = "asteroideChiquitin.png", velocidad = -0.3, puntaje = 100,vida = 1)
	const asteroidePrueba = template.crearTemplateAsteroide()
	
	
	test "El asteroide no esta destruido(tiene vida)"{
		assert.notThat(asteroidePrueba.sinVida())
	}
	
	//Inicialmente tiene 1 de vida
	test "El asteroide recibe 2 de daño"{
		asteroidePrueba.reducirVida(2)
		assert.equals(-1,asteroidePrueba.vida())
	}
	
	test "Al recibir 3 de daño, es destruido(sin vida)"{
		asteroidePrueba.reducirVida(3)
		assert.that(asteroidePrueba.sinVida())
	}
	
	test "Al morir,se suma 100 puntos al pointTracker"{
		asteroidePrueba.morir()
		assert.equals(100,pointTracker.puntajeAcumulado())
	}
	
	test "Al chocar con el avion, el avion pierde vida"{
		asteroidePrueba.aplicarEfectoSobre(avion)
		assert.equals(0,carcaza.vida())
		
	}
}
* */
