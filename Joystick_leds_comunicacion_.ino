#define ARRIBA 'A'
#define ABAJO 'B'
#define IZQUIERDA 'I'
#define DERECHA 'D'
#define DISPARO 'P'
#define ARRIBA2 'a'
#define ABAJO2 'b'
#define IZQUIERDA2 'i'
#define DERECHA2 'd'

const int BOTON_ARRIBA= 11;//--------------AMARILLO
const int BOTON_ABAJO= 10;//---------------CELESTE
const int BOTON_IZQUIERDA= 9;//------------VERDE
const int BOTON_DERECHA= 12;//-------------MORADO
const int BOTON_DISPARO= 8;//--------------BLANCO
const int pulsador_1= 6;  //JUGANDO--------AZUL
const int pulsador_2= 7;  //REPLICAR-------ROJO

/////////leds///////////////
const int ledrojo = 5;
const int ledazul = 4;
const int ledverde = 3;
/////////////////////////////

// Variables para almacenar el estado y el tiempo del botón
bool estadoBotonArriba = false;
bool estadoBotonAbajo = false;
bool estadoBotonIzq = false;
bool estadoBotonDer = false;
bool estadoBotonDis = false;
bool estadoBoton1 = false;
bool estadoBoton2 = false;
unsigned long tiempoPresionado;
unsigned long valor;
unsigned long tiempoSoltado;
unsigned long tiempo[200];
unsigned long tiempo2[200];
unsigned long tiempoT;

 int indice=0;

 char botones[200];
enum Estados{
 REPLICAR,
 JUGANDO,
 ESPERANDO
 
};
Estados estado_actual= ESPERANDO;

int rojo = 0;
int azul = 0;
int verde = 0;

void setup() {
  // Configurar el botón como entrada
  pinMode (ledrojo, OUTPUT);
  pinMode (ledazul, OUTPUT);
  pinMode (ledverde, OUTPUT);
  pinMode(BOTON_ARRIBA, INPUT_PULLUP);
  pinMode(BOTON_ABAJO, INPUT_PULLUP);
  pinMode(BOTON_IZQUIERDA,INPUT_PULLUP);
  pinMode(BOTON_DERECHA, INPUT_PULLUP);
  pinMode(BOTON_DISPARO, INPUT_PULLUP);
  pinMode(pulsador_1, INPUT_PULLUP);
  pinMode(pulsador_2, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {

  // Leer el estado actual del botón
  int lecturaBotonArriba = digitalRead(BOTON_ARRIBA);
  int lecturaBotonAbajo = digitalRead(BOTON_ABAJO);
  int lecturaBotonIzquierda = digitalRead(BOTON_IZQUIERDA);
  int lecturaBotonDerecha = digitalRead(BOTON_DERECHA);
  int lecturaBotonDisparo = digitalRead(BOTON_DISPARO);
 
  int pulsador1=digitalRead(pulsador_1);
  int pulsador2 = digitalRead(pulsador_2);
  
  switch(estado_actual)
  {
  case ESPERANDO:

  if (pulsador1 == LOW){
    estado_actual=JUGANDO;
    estadoBoton2= true;
    digitalWrite (ledazul, 1);
    azul = 1;
    delay(250);
    digitalWrite (ledazul, 0);
    azul = 0;
    tiempoT=millis();
  }
  if (pulsador2 == LOW ){
    estado_actual=REPLICAR;
  }
  break;
  case JUGANDO:
  
   //Comprobar si el botón ha sido presionado
    if (lecturaBotonArriba ==LOW) {
/////////////////////// LED AMARILLO///////////////////////////
    digitalWrite (ledrojo, 1);
    digitalWrite (ledverde, 1);
    rojo = 1;
    verde = 1;
    // Registrar el tiempo en que se presionó el botón
      if(estadoBotonArriba == false)
      {
        Serial.print('A');
      botones[indice]=ARRIBA;
      tiempoPresionado = millis();
      estadoBotonArriba = true;
      indice++;
      }
      delay(25);
     }

  // Comprobar si el botón ha sido soltado
     else if (lecturaBotonArriba == HIGH && estadoBotonArriba == true) {
    digitalWrite (ledrojo, 0);
    digitalWrite (ledverde, 0);
    rojo = 0;
    verde = 0;
    // Registrar el tiempo en que se soltó el botón
      Serial.print('a');
     tiempoSoltado = millis();
     estadoBotonArriba = false;
    // Calcular la duración de la pulsación del botón
      botones[indice]=ARRIBA2;
       tiempo[indice]=tiempoSoltado - tiempoPresionado;
       indice++;
       delay(25);
     }
  // Comprobar si el botón ha sido presionado
  if (lecturaBotonAbajo == LOW ) {
/////////////////////////////LED CELESTE///////////////////////////
    digitalWrite (ledazul, 1);
    digitalWrite (ledverde, 1);
    azul= 1;
    verde= 1;
    Serial.flush();
    // Registrar el tiempo en que se presionó el botón   
    if(estadoBotonAbajo == false){
       botones[indice]= ABAJO;
       Serial.print('B');
    tiempoPresionado = millis();
    estadoBotonAbajo = true;
    indice++;
  
    }
    
    delay(25);
    
  }

  // Comprobar si el botón ha sido soltado
  if (lecturaBotonAbajo == HIGH && estadoBotonAbajo == true) {
    digitalWrite (ledazul, 0);
    digitalWrite (ledverde, 0);
    verde = 0;
    azul = 0;
     Serial.print('b');
     botones[indice]= ABAJO2;
    // Registrar el tiempo en que se soltó el botón
    tiempoSoltado = millis();
    tiempo[indice]=tiempoSoltado - tiempoPresionado;
    indice++;
    estadoBotonAbajo = false;
    delay(25);
  }
   // Comprobar si el botón ha sido presionado izquierda
  if (lecturaBotonIzquierda == LOW ) {
    // Registrar el tiempo en que se presionó el botón
    //////////////////////////////LED VERDE///////////////////////////////
    digitalWrite (ledverde, 1);
    verde = 1;
    if(estadoBotonIzq== false) {
    Serial.print('I');
    botones[indice]=IZQUIERDA;
    tiempoPresionado = millis();
    estadoBotonIzq = true;
    indice++;
    }
     delay(25); 
  }
  // Comprobar si el botón ha sido soltado
  if (lecturaBotonIzquierda ==  HIGH && estadoBotonIzq== true) {
    digitalWrite (ledverde, 0);
    verde = 0;
    // Registrar el tiempo en que se soltó el botón
    Serial.print('i');
    botones[indice]= IZQUIERDA2;
    tiempoSoltado = millis();
    estadoBotonIzq = false;
    // Calcular la duración de la pulsación del botón
    
     tiempo[indice]=tiempoSoltado - tiempoPresionado;
  
    indice++;
    delay(25);

  }
   // Comprobar si el botón ha sido presionado derecha
  if (lecturaBotonDerecha == LOW  ) {
    // Registrar el tiempo en que se presionó el botón
   //////////////////////////////LED MORADO///////////////////////////////
    digitalWrite (ledrojo, 1);
     digitalWrite (ledazul, 1);
    rojo = 1;
    azul= 1;
    if(estadoBotonDer== false){
    Serial.print('D');
    botones[indice]=DERECHA;
    tiempoPresionado = millis();
    estadoBotonDer = true;
    indice++;
    delay(25);
    } 
    
  }

  // Comprobar si el botón ha sido soltado
  if (lecturaBotonDerecha ==  HIGH && estadoBotonDer== true ) {
    digitalWrite (ledrojo, 0);
    digitalWrite (ledazul, 0);
    rojo = 0;
    azul = 0;
    // Registrar el tiempo en que se soltó el botón
    Serial.print('d');
    botones[indice]= DERECHA2;
    tiempoSoltado = millis();
    estadoBotonDer = false;
    // Calcular la duración de la pulsación del botón
     tiempo[indice]=tiempoSoltado - tiempoPresionado;
    indice++;
    delay(25);
  }
   // Comprobar si el botón ha sido presionado disparo
  if (lecturaBotonDisparo == LOW && estadoBotonDis== false) {
/////////////////////LED BLANCO//////////////////////////////
    digitalWrite (ledazul, 1);
    digitalWrite (ledrojo, 1);
    digitalWrite (ledverde, 1);
    azul = 1;
    rojo = 1;
    verde = 1;
    // Registrar el tiempo en que se presionó el botón
   
      Serial.print('P');
    tiempoPresionado = millis();
    estadoBotonDis = true;
   
  }
  // Comprobar si el botón ha sido soltado
  if (lecturaBotonDisparo ==  HIGH && estadoBotonDis== true) {
    digitalWrite (ledazul, 0);
    digitalWrite (ledrojo, 0);
    digitalWrite (ledverde, 0);
    azul = 0;
    rojo = 0;
    verde = 0;
    // Registrar el tiempo en que se soltó el botón
    botones[indice]= DISPARO;
    tiempoSoltado = millis();
    estadoBotonDis = false;
    // Calcular la duración de la pulsación del botón
    tiempo[indice]=tiempoSoltado - tiempoPresionado;
    indice++;
  }
   delay(100);
    if(pulsador2 ==LOW ){
      estado_actual=ESPERANDO;
  }
    
  break;
  case REPLICAR: 
  //////////////////////////////LED ROJO///////////////////////////////
    for(int j=0; j<indice; j++){
      digitalWrite (ledrojo, 1);
      rojo = 1;
        // Asegúrate de que los arrays 'tiempo', 'tiempo2' y 'botones' estén definidos y tengan al menos 'indice' elementos
        switch(botones[j]){
            case 'A':
            case 'B':
            case 'D':
            case 'I':
            case 'P':
                Serial.print(botones[j]);
                delay(tiempo[j]+200); // Asegúrate de que 'tiempo[j]' esté en milisegundos
                break;
            case 'a':
            case 'b':
            case 'd':
            case 'i':
                Serial.print(botones[j]);
                delay(tiempo[j]+200); // Asegúrate de que 'tiempo2[j]' esté en milisegundos
                break;
            default:
                // Aquí puedes manejar el caso en que 'botones[j]' no sea ninguno de los valores esperados
                break;
         
        }
        tiempo[j]=0;
        botones[j]=0;
        
    } 
    digitalWrite (ledrojo, 0);
        rojo = 0;
        delay (500);
        digitalWrite (ledrojo, 1);
        rojo = 1;
        delay (500);
        digitalWrite (ledrojo, 0);
        rojo = 0;
        delay (500);
        digitalWrite (ledrojo, 1);
        rojo = 1;
        delay (500);
        digitalWrite (ledrojo, 0);
        rojo = 0;
    
    estado_actual=ESPERANDO; // Asegúrate de que 'estado_actual' y 'ESPERANDO' estén definidos en alguna parte de tu código
    break; // Este 'break' faltaba para salir del 'case REPLICAR'
}
  }
