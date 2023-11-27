class Enemigos {


  float tam, x, y;
  int speed = 2;
  float vy = 2; // la velocidad del enemigo
  float angle;
  boolean naveGolpeada = false;
  /*El constructor Enemigos(float size) es una función que se utiliza para crear un nuevo objeto de tipo Enemigos. Aquí está lo que hace cada parte:

this.tam = size; - Esto establece el tamaño (tam) del enemigo al valor del parámetro size.
this.x = random(width); - Esto establece la posición horizontal (x) del enemigo a un valor aleatorio entre 0 y width (probablemente el ancho de la pantalla del juego).
this.y = -size; - Esto establece la posición vertical (y) del enemigo a -size, lo que probablemente coloca al enemigo justo fuera de la parte superior de la pantalla del juego*/
  Enemigos(float size) {
    this.tam = size;
    this.x = random(width);
    this.y = -size;
  }

/*La función `drawenemigos` se encarga de dibujar y mover los enemigos en el juego. Aquí está lo que hace cada parte:

1. Configura el color de relleno y el color de la línea a 150 (gris).
2. Dibuja la imagen del enemigo en las coordenadas `(x, y)` con un tamaño ajustado (`tam-120`).
3. Aumenta la coordenada `y` del enemigo por `vy`, lo que probablemente hace que el enemigo se mueva hacia abajo en la pantalla.
4. Calcula el ángulo entre el enemigo y el jugador, y luego ajusta las coordenadas `(x, y)` del enemigo para moverlo en la dirección del jugador a una velocidad determinada (`speed`).
5. Con una probabilidad muy pequeña (0.01%), reinicia la posición del enemigo a una ubicación aleatoria en la parte superior de la pantalla.

En resumen, esta función dibuja cada enemigo en su posición actual, los mueve hacia el jugador y ocasionalmente reinicia su posición a la parte superior de la pantalla.
Esto probablemente crea un efecto de enemigos que constantemente se mueven hacia el jugador desde la parte superior de la pantalla.*/
  void drawenemigos() {
    // Calcular el ángulo hacia el jugador
 /* float angle2 = atan2(jugador.y - y/2-5, jugador.x - x);

  // Modificar la velocidad en X y Y
  float speedX = speed * cos(angle2) + 1.0 * sin(frameCount * 0.05);  // Añadir movimiento de zigzag en X
  float speedY = (speed-2) * sin(angle2);  // Reducir la velocidad en Y

  // Actualizar la posición del enemigo
  x += speedX;
  y += speedY;*/
      fill(150);
      stroke(150);
     // image(enemigo2, x1, y1, tam-120, tam-120);
      image(enemigo,x,y, tam-120,tam-120);
        y +=vy;
     float angle = atan2(jugador.y - y/2-5, jugador.x - x);
     x += cos(angle) * speed;
      y += sin(angle) * speed-2;

     // if (random(1) < 0.0001) { // Cambiar la posición del asteroide con una probabilidad del 10%
      // x = random(width);
      //  y = -tam;
      // }
     
    
   
  }
 /* La función `colision` verifica si ha ocurrido una colisión entre el objeto actual y otro objeto en el juego. Aquí está lo que hace cada parte:

1. Comprueba si el `other` objeto es una instancia de `Nave` (probablemente la nave del jugador). Si es así, calcula la distancia entre el objeto actual y 
la nave. Si la distancia es menor que un cierto umbral, llena la pantalla con un color rojo (indicando una colisión), espera un poco y luego devuelve `true` 
(indicando que ha ocurrido una colisión).

2. Si el `other` objeto no es una `Nave`, entonces comprueba si es una instancia de `Balas` (probablemente una bala disparada por el jugador o un enemigo). 
Si es así, calcula la distancia entre el objeto actual y la bala. Si la distancia es menor que un cierto umbral, 
llena la pantalla con un color verde (indicando una colisión), y luego devuelve `true` (indicando que ha ocurrido una colisión).

3. Si el `other` objeto no es ni una `Nave` ni una `Balas`, la función devuelve `false` (indicando que no ha ocurrido ninguna colisión).

En resumen, esta función se utiliza para detectar colisiones entre diferentes objetos en el juego. 
Cuando detecta una colisión, cambia el color de la pantalla y devuelve `true`. 
Si no detecta ninguna colisión, simplemente devuelve `false`. 
Esta función es probablemente utilizada en el bucle principal del juego para actualizar el estado del juego en función de las colisiones que ocurran.*/

  boolean colision(Object other) {
    if (other instanceof Nave) {
      Nave jugador = (Nave) other;
      float ang = 10 * tan(60);
      float distance = dist(x, y, jugador.x, jugador.y - ang); // se disminuyo el area del enemigo para observar adecucadamente la colision de la nave.
      if (distance < tam / 8 + ang + 10) {
       
        delay(100);// se coloca un tiempo para poder observar la colision  de la nave con el enemigo. Se debe evitar que pase rapido debido a que no es adecuado para la jugabilidad y el entorno 
        return true;
      }
    } else if (other instanceof Balas) {
      Balas balas = (Balas) other;
      float distance = dist(x, y, balas.x, balas.y);
      println(distance);
      if (distance <= tam /6 + balas.tam / 2) {
       
     //   fill(0, 255, 0, 100);
       // rect(0, 0, width, height);
       // fill(255);
     // image(explosion,x,y, tam-120,tam-120);
       delay(100);
        vy=vy+0.75;
       
        return true;
      }
    }
    return false;

  }
}
