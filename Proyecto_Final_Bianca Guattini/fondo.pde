class Estrellas { //clase destinada a la formar las estrellas
  float x, y;
  int vy;
  
  Estrellas() { //CONSTRUCTOR
    this.x = random(width);
    this.y = 0;
    this.vy = 10;// Aumenta el valor de vy para hacer que las estrellas se muevan más rápido
  }
  
  void drawestrellas() {
    stroke(frameCount % 255, frameCount % 200, frameCount % 100); // Establece el color del borde en función del frameCount
    y+=vy;
    point(x,y);
    
  }
}
