
class Balas {
  //Clase destinada a las balas de la nave 
  float x, y, vy; //variables 
  float tam; // variable de tamaño
  
  Balas(Nave jugador) {

    this.x = jugador.x;//cordenas de el juegador en x e y
    this.y = jugador.y - 15;
    this.vy = -10;
    this.tam = 9; // determina el tamaño de las balas
  }
  
  void draw_balas() { // grafica de balas
    //color?
      //balas2.play();
    //fill(255, 0, 0);
    stroke(255, 0, 0); // establece color rojo en las balas
    image(disparos,x, y, tam, tam+12); // configuro la forma y el tamaño de la bala
    y+=vy;
  }
    
    
}
