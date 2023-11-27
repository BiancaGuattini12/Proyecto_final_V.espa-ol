//import processing.sound.*;
//SoundFile laser; 
import processing.serial.*;//Biblioteca
Serial myport;
int leer=0;
import javax.swing.JOptionPane;
 String nombre;
/////////////////////////////////////////////////////////////////////
import ddf.minim.*;
char val;
boolean newData = false;
Minim minim;
AudioPlayer player;
AudioPlayer player1;

AudioPlayer demo;
//temporizador 

////////////////////////////////////////////////////////////////////
/*ArrayList<Estrellas>: Esto indica que estamos creando una lista de objetos de la clase Estrellas.
estrellas: Este es el nombre que le damos a la lista.
new ArrayList<Estrellas>(): Esto crea una nueva lista vacía que puede contener objetos de la clase Estrellas.
En resumen, esta línea de código se utiliza para crear una lista vacía llamada estrellas que puede llenarse con objetos de la clase Estrellas. 
Esta lista probablemente se utiliza para mantener un registro de todas las estrellas que se deben dibujar en el juego.*/
ArrayList<Estrellas> estrellas= new ArrayList<Estrellas>();
int frecuencia_estrellas = 4;
////////////////////////////////////////////////////////////////
Nave jugador;
PImage nave;
///////////////////////////////////////////////////////////////
ArrayList<Enemigos> enemigos = new ArrayList<Enemigos>();
int enemigosFrecuencia = 60;
PImage enemigo;
PImage enemigo2;
//////////////////////////////////////////////////////////////
ArrayList<Balas> balas = new ArrayList<Balas>();
PImage disparos;
////////////////////////////////////////////////////////////////
//menu//
PImage galaga;
int estado_de_juego;
PImage logo;
int numE = 100;
float[] EX = new float[numE];
float[] EY = new float[numE];
float[] Etam = new float[numE];

////////////////////////////////////////////////////////////////
fin_de_juego Fin;
PImage fin;
PImage explosion;
int puntos;
///////////////////////////////////////////////////////////////
//Usuario usuario;//Jugador actual 
float contador=0;
int cont_archivo;//Empleado para recorrer un string delarchivo partida.

//////////////////////////////////////////////////////////////
int intervalo = 1000; // Intervalo de tiempo en milisegundos
int tiempoAnterior = 0;
String[] comandos = new String[0];
int n=0;
/////////////////////////////////////////
//guarda imagen
PImage[] imagenes;
int indice = 0;
boolean botonPresionado = false;
String nombre2;

void setup() {
 
  size(700, 700);
  explosion = loadImage("explosion.png"); // Cambia "explosion.png" por la ruta de tu imagen
  //////////////////////////////////////
  jugador = new Nave();
  ////////////////////////////////////////
  minim = new Minim(this);
 // 
 //laser=new SoundFile(this,"disparo.mp3");
  player = minim.loadFile("galaga.mp3");
  player1 = minim.loadFile("fin.mp3");
  
  demo = minim.loadFile("demo.mp3");

  puntos= 0;
  nave = loadImage("nave.png");
  imageMode(CENTER);
  disparos= loadImage("disparos.png");
  enemigo = loadImage("enemigo.png");
  imageMode(CENTER);
  imageMode(CENTER);
  
  fin = loadImage("fin.jpg");
  logo= loadImage("logo.png");
  logo.resize(width/2, height/2);
  imageMode(CENTER);// Redimensionar la imagen de fondo
  logo.resize(400,400);
  
  ////////////////////////////////////////////////////////////////
  /*String Puerto=Serial.list()[0];//Recordar que si se conecta algo previamente colocar 1 en vez de 0.
  myport= new Serial(this,Puerto,9600);
  myport.clear();
  myport.bufferUntil('\n');*/
 nombre2 = JOptionPane.showInputDialog("¡Bienvenido/a a esta aventura Galactica! Por favor, ingrese su nombre:");

if (nombre2 != null) {
  JOptionPane.showMessageDialog(null, "Hola, " + nombre2 + "!");
  
} else {
  JOptionPane.showMessageDialog(null, "No ingresaste un nombre.");
}

  /////////////////////////////////////////////////////////////
 int numE = 100;
  for (int i = 0; i < numE; i++) 
  {
       EX[i] = random(width);
         EY[i] = random(height);
              Etam[i] = random(1, 5);
           
  }

////////////////////////////////////////////////////////////////////////
// Cargar la secuencia de imágenes
  imagenes = new PImage[47];
  for (int i = 0; i < imagenes.length; i++) {
    imagenes[i] = loadImage("frame-" + i + ".png");
  }  
}

     void draw() 
{
    // Dibujar el menú principal
  if (estado_de_juego == 0) 
  {
       background(0);
       fill(255);
        textSize(32);
    // Dibujar la imagen de fondo centrada
    image(logo, width+20 - logo.width/2-150, height-20 - logo.height/2-250);
        fill(255, 0, 0);
    rect(width/2 - 50, height/2 + 20, 100, 50);
        fill(255);
         textSize(17);
         text("Play", width/2 - 16, height/2 + 50);
        fill(255);
    // Dibujar el botón de ayuda
       fill(255,0,0);
       
    rect(width/2 - 50, height/2 + 100, 99, 49);
       fill(255);
        textSize(17);
        
    text("Read", width/2-17, height/2 + 130);
        fill(255);
         stroke(255);
          noFill();
    // Dibujar el botón de puntaje
    fill(255,0,0);
    rect(width/2 - 50, height/2 + 180, 99, 49);
       fill(255);
        textSize(17);
        
    text("Demo", width/2 - 26, height/2 + 210);
       fill(255);
        stroke(255);
         noFill();
          noStroke();
          
    for (int i = 0; i < numE; i++)
    {
      
      if (random(1) < 0.5) 
      {
        fill(255); // Blanco
        
      } else
       {
        fill(0, 0, 255); // Azul
        
       }
         ellipse(EX[i], EY[i], Etam[i], Etam[i]);
      // Mover las estrellas hacia abajo
          EY[i] += Etam[i];
      // Si una estrella sale de la pantalla, volver a colocarla en la parte superior
      if (EY[i] > height)
      {
        EX[i] = random(width);
        EY[i] = -Etam[i];
      }
    }
   // Detectar si el botón ha sido presionado
    if (mousePressed && mouseX > width/2 - 50 && mouseX < width/2 + 49 && mouseY > height/2 + 180 && mouseY < height/2 + 229)
      {
          demo.play();
          // Reproducir la secuencia de imágenes
           background(0);
             image(imagenes[indice], 350, 350); 
         // Avanzar al siguiente cuadro cada 10 cuadros
              if (frameCount % 8 == 0) 
              {
                     indice++;
               if (indice >= imagenes.length)
               {
                     indice = 0;
               }
              }
   
       }
       
     if (mousePressed && mouseX > width/2 - 50 && mouseX < width/2 + 49 && mouseY > height/2 + 100 && mouseY < height/2 + 149)
       {
           // Dibujar el cuadro de texto
           fill(255);
           rect(50, 50, width - 100, height - 100);
           fill(0);
           textSize(20);
           text("Galaga es un clásico de los videojuegos de disparos espaciales, lanzado en 1981 por Namco. El juego se basa en el éxito de Galaxian (1979), pero introduce nuevas mecánicas y gráficos. En este proyecto, estudiantes de la universidad tecnológica regional Mendoza han recreado una versión simplificada de Galaga, usando el lenguaje de programación C++ y Java. El objetivo es compartir su pasión por los videojuegos y el aprendizaje. Esperamos que te diviertas con esta pequeña obra de arte.", 75, 75, width - 150, height - 150);
       }
  }
   if (Fin != null) 
    {
      Fin.draw_fin();
           
    } else if (estado_de_juego  == 1) 
       {
            background(0);
            //llamo a cada funcion
              draw_estrellas();
               drawEnemigos();
                fill(255, 0, 0);
                 stroke(255);
                  drawBullet();
                   jugador.draw_nave();
                    stroke(255);
                    fill(255);
                    textSize(30);
                    text("Points: " + puntos, 50, 50);
                     colision();
                    contador++;
                    
       /*while (myport.available() > 0) {
    char key = myport.readChar();
    switch (key) {
      case 'A':
        jugador.upPressed = true;
        break;
      case 'B':
        jugador.downPressed = true;
        break;
      case 'I':
        jugador.leftPressed = true;
        break;
      case 'D':
        jugador.rightPressed = true;
        break;
      case 'P':
        Balas b = new Balas(jugador);
       
        balas.add(b);
        break;
      case 'a':
        jugador.upPressed = false;
        break;
      case 'b':
        jugador.downPressed = false;
        break;
      case 'i':
        jugador.leftPressed = false;
        break;
      case 'd':
        jugador.rightPressed = false;
        break;
      // No necesitas un caso para 'p' ya que el disparo es una acción instantánea
    }
  }*/
       }
}
//Recorre todas las balas en el juego.
//Para cada bala, llama a la función draw_balas de esa bala.
///En resumen, esta función dibuja todas las balas en su posición actual en el juego. Cada bala se dibuja individualmente llamando a su propia función draw_balas. Esto probablemente actualiza la posición de la bala en la pantalla del juego.

 void drawBullet() 
{
     for (int i = 0; i<balas.size(); i++) 
     {
         balas.get(i).draw_balas();
     }
}
//Recorre todos los enemigos en el juego.

//Para cada enemigo, comprueba si ha habido una colisión con el jugador. Si es así, crea un nuevo objeto fin_de_juego con los puntos actuales, el contador y el nombre del jugador. Luego, guarda los datos y reproduce un sonido.//

//Después de comprobar la colisión con el jugador, la función recorre todas las balas en el juego.

//Para cada bala, comprueba si ha habido una colisión con el enemigo actual. Si es así, incrementa los puntos del jugador, elimina al enemigo y la bala de sus respectivas listas, y decrementa los contadores i y b para ajustar el índice debido a la eliminación//

//En resumen, esta función maneja las interacciones entre el jugador, los enemigos y las balas en el juego. Cuando un enemigo choca con el jugador, termina el juego, guarda los datos y reproduce un sonido. Cuando una bala choca con un enemigo, incrementa los puntos del jugador y elimina tanto al enemigo como a la bala//
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      jugador.upPressed = true;
      comandos = (String[]) append(comandos, "UP " + millis());
      saveStrings("comandos.txt", comandos);
    } else if (keyCode == DOWN) {
      jugador.downPressed = true;
      comandos = (String[]) append(comandos, "DOWN " + millis());
      saveStrings("comandos.txt", comandos);
    } else if (keyCode == LEFT) {
      jugador.leftPressed = true;
      comandos = (String[]) append(comandos, "LEFT " + millis());
      saveStrings("comandos.txt", comandos);
    } else if (keyCode == RIGHT) {
      jugador.rightPressed = true;
      comandos = (String[]) append(comandos, "RIGHT " + millis());
      saveStrings("comandos.txt", comandos);
    }
  } else if (key == ' ') {
   
    Balas b = new Balas(jugador);
   // laser.play();
    balas.add(b);
    comandos = (String[]) append(comandos, "SPACE " + millis());
    saveStrings("comandos.txt", comandos);
  } else if (keyCode == ESC) {
    estado_de_juego  = 0; // Volver al menú principal
  }
}


void keyReleased() {
  if (keyCode == UP) {
         jugador.upPressed = false;
  } else if (keyCode == DOWN) {
           jugador.downPressed = false;
  } else if (keyCode == LEFT) {
             jugador.leftPressed = false;
  } else if (keyCode == RIGHT) {
                jugador.rightPressed = false;
  }
}
 void colision() 
 {
  for (int i = 0; i < enemigos.size(); i++) 
  {
         Enemigos a = enemigos.get(i);
         
     if (a.colision(jugador) == true) 
     {
         Fin = new fin_de_juego(puntos,contador,nombre);
         guardarDatos(nombre2,puntos); 
         player1.play();
     }
    for (int b = 0; b < balas.size(); b++) 
    {
      Balas bala = balas.get(b);
   
      if (a.colision(bala) == true) 
      {
        puntos++;
        enemigos.remove(a);
        balas.remove(bala);
        i--;
        b--;
      }
   }
  }
}

//La función drawAsteroid() en Processing se utiliza para dibujar asteroides en la pantalla. En esta función, se utiliza la variable frameCount para determinar cuándo se debe agregar un nuevo asteroide a la lista de asteroides. Si el número de cuadros que se han dibujado desde el inicio del programa es un múltiplo de la frecuencia de los asteroides (asteroidFrequency), entonces se agrega un nuevo asteroide a la lista.
//Luego, se recorre la lista de asteroides y se llama al método drawAsteroid() de cada asteroide para dibujarlo en la pantalla. Si un asteroide ha salido de la pantalla (es decir, si su posición y es mayor que la altura de la pantalla más su tamaño), entonces se elimina de la lista de asteroides y se decrementa el puntaje del jugador.
void drawEnemigos() 
{
  if (frameCount % enemigosFrecuencia == 0) 
  {
    enemigos.add(new Enemigos(random(150, 250)));
  }
  for (int i = 0; i<enemigos.size(); i++) 
  {
       Enemigos currentAsteroid = enemigos.get(i);
       currentAsteroid.drawenemigos();
       
    if (currentAsteroid.y > height + currentAsteroid.tam) 
    {
       enemigos.remove(currentAsteroid);
       i--;
       puntos--;
    }
  }
}
// Configura el grosor de la línea (strokeWeight) a 8 y el color de la línea (stroke) a blanco (255).
//Si el recuento de cuadros actual (frameCount) es un múltiplo de la frecuencia_estrellas, crea una nueva estrella (Estrellas myE = new Estrellas()) y la añade a la lista de estrellas.
// todas las estrellas en el juego.
//Para cada estrella, llama a la función drawestrellas de esa estrella.
//En resumen, esta función dibuja estrellas en el juego a una frecuencia determinada. Cada estrella se dibuja individualmente llamando a su propia función drawestrellas. Esto probablemente actualiza la posición de la estrella en la pantalla del juego. Además, la función crea nuevas estrellas a intervalos regulares determinados por frecuencia_estrellas.


void draw_estrellas() 
{
     strokeWeight(8);
     stroke(255);
     
   if (frameCount % frecuencia_estrellas == 0)
   {
            Estrellas myE = new Estrellas();
            estrellas.add(myE);
   }
    for (int i = 0; i<estrellas.size(); i++)
    {
          Estrellas actual_estrella = estrellas.get(i);
              actual_estrella.drawestrellas();
    }
}




  
  




 void mousePressed() 
{
   if (estado_de_juego  == 0 && mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height/2 + 20 && mouseY < height/2 + 70) 
   {
          estado_de_juego  = 1;
            player.loop(); 
   }
     if (Fin!= null && Fin.mouseOverButton() == true ) 
     {
             
               reiniciar();
     } 
}
 
 void guardarDatos( String nombre2, int puntos) 
{
 
   String[] datos = { "Nombre: "  + nombre2,"Puntos: " + puntos };
     saveStrings("datos.txt", datos);
}

void reiniciar() 
{
  estrellas.clear();
   balas.clear();
     enemigos.clear();
      jugador = new Nave();
        Fin = null;
  puntos = 0;
  contador=0;
  player.play();
  player1.play();
  

}
