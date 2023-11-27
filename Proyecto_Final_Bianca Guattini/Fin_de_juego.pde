class fin_de_juego {
  String gameOverText, botonText, puntosText, tiempoText, nombre;
  int botonX, botonY, botonW, botonH;
  int score;
  float tiempo;
  int size;
  
  
  fin_de_juego(int puntos, float contador,String nombre2) {
   // this.gameOverText = "Perdiste!";
    this.botonText = "Reset";
    this.puntosText = "record " + puntos;
    this.botonW = 200;
    this.botonH = 100;
    this.botonX = width/2 - this.botonW/2;
    this.botonY = height/2 - this.botonH/2;
    this.score = puntos;
   this.nombre = "Hasta la proxima " + nombre2;
    //this.tiempo = contador;
  
    //this.tiempoText = "tiempo " + contador;
    
    player.pause();

  }

  void draw_fin() {
    //OVERLAY
    fill(#000000);
    rect(0, 0, width,height );
    image(fin,width/2,height/2-158);
    //STARS
    for (int i = 0; i < 9; i++) {
      float x = random(width);
      float y = random(height);
      stroke(255);
      point(x, y);
    }
    rect(botonX+50, botonY+50, botonW/2, botonH/2);

    //BUTTON
    fill(0);
    stroke(200);
    rect(botonX+50, botonY+50, botonW/2, botonH/2);
    fill(200);
    textSize(30);
    text(botonText, botonX+68, botonY+85);
    
    //SCORE
    stroke(255);
    fill(255,0,0);
    textSize(35);
    text(puntosText, width/2-150, height - height/4);
     stroke(255);
    fill(255,0,0);
    textSize(20);

    text("Presione la tecla 'ESC' para salir del juego", width/2-300, height - height/4+100);
  }

  
  boolean mouseOverButton() {
    return (mouseX > botonX 
      && mouseX < botonX + botonW
      && mouseY > botonY
      && mouseY < botonY + botonH);
  }


  
}
