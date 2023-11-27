class Nave{
  //clase destinada a la nave aqui se configura la jugabilidad, sera modificado para manejar la nave con arduino
  float x, y, vx, vy; // variables
  boolean upPressed, downPressed, leftPressed, rightPressed; // aqui se definen los controles de forma de verdadero o falso. upP es presiona arriba, down hacia abajo, left izquierda, ringht derecha
 //  El método shootBullet() se encarga de crear una instancia de la clase Bullet y agregarla a una lista de bala
  int speed = 4; 
  
  Nave() { // defino el tamaño de la nave
    this.x = width/2;
    this.y = height - height/4;
    this.vy = 0;
    this.vx = 0;
  }
  
  void draw_nave() { //dibujo la nave
  //limito el movimiento de la nave 
  
   if (y < 50) {
    y = 50;
  } else if (y > height - 20) {
    y = height - 20;
  }
  
  if (x < 10) {
    x = 10;
  } else if (x > width - 10) {
    x = width - 10;
  }
    image(nave,x,y);
    if (upPressed == true) { // aqui si el jugador presiona boton hacia arriba, la nave subira. en processing los comandos son contrarios, por lo cual para que suba la nave hay que decrementarla
      vy= -speed;
    } else if (downPressed == true) { // si presiona boton hacia abajo la nave 
      vy = speed;
    } else {  // si no ha presionado ningun boton la nave permanecera en posicion inicial
      y -= vy;
      vy = 0;
    }
    
    if (leftPressed == true) { //aquie es el manejo de izquierda a derecha
      vx= -speed;
    } else if (rightPressed == true) {
      vx= speed;
    } else {
      vx=0;
    }
    
    x += vx;
    
    if (y-20>=50 && y<height) { //hasta que posicion puede subir en y
      y += vy;
    }
    
    
    if (x+10 < 0) //hasta que posicion puede moverse  en x
      x = width+9;
    
    if (x-10 > width) x = -9;
    
  // triangle(x, y-17.32, x-10, y, x+10, y);
  }
}
