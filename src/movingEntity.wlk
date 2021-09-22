import wollok.game.*


class Movement
{
	var property xMovement
	var property yMovement
	
	/* Desplaza una posicion por un vector definito por los parametros de xMovement e yMovement */
	
	method displace(position)
	{
		var positionToReturn = position
		if (xMovement >= 0) positionToReturn = position.right(xMovement) else positionToReturn = position.left(xMovement)
		if (yMovement >= 0) positionToReturn = position.up(yMovement) else positionToReturn = position.down(yMovement)
		return positionToReturn
	}
}

/* Clase abstracta representando a todas las entidades del juego. Define cosas super basicas. Despues se va especificando para objetos 
 * que se mueven, etc.
 */

class Entity
{
	var property position
	var property image
	var property health
	
	/* Actualiza la vida por un factor de x, que puede ser negativo o positivo */
	method updateHealth(x)
	{
		health = health + x
	}
	
	/* Actualiza la iamgen por una nueva imagen*/
	method image(newImage)
	{
		image = newImage
	}
	
	/* Actualiza la posicion por una nuevo posicion */
	method changePosition(_position)
	{
		position = _position
	}
}

class MovingEntity inherits Entity
{
	
	var property stepSize
	
   /* Metodo general para moverse en alguna direccion */
	
  method moveDirection(direction)
  {
  	direction.displace(position)
  }
  
  
   /* Metodo general para moverse en la direccion de alguna otra posicion. Como no se puede mover menos de uno en un turno dado, lo trunco
    * para que quede como un entero */
   
  method moveInDirectionOf(_position)
  {
  	const directionx = (self.position().x() - _position.x() *  stepSize).truncate(0)
  	const directiony = (self.position().y() - _position.y() * stepSize).truncate(0)
  	const directionOfEntity = new Movement(xMovement = directionx,yMovement =directiony)
  	self.moveDirection(directionOfEntity)
  }
  	
}