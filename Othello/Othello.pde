import java.util.ArrayList;

int tablero[][]; // 0=vacio, 1=Jugador1, 2=Jugador2
int alto = 8;
int ancho = 8;
int tamano = 50;
int jugadorActual = 1;
static final int JUGADOR1=1;
static final int JUGADOR2=2;
static final int SIN_FICHA=0;

//Clase que representa una tupla (x,y)
//Se ocupa para guardar las casillas a repintar.
class Casilla{
    public int x;
    public int y;
    public Casilla(int x, int y){
      this.x = x;
      this.y = y;
    }
}

// Establecer tamaño de ventana con variables
void settings() {
  size(tamano * ancho, tamano * alto);
}

// Inicializaciones (el código se ejecuta una sola vez)
void setup() {
  background(0, 153, 51); // Color de fondo
  stroke(181, 242, 192);  // Color de linea
  
  tablero = new int[alto][ancho];
  // Configuración inicial:
  tablero[alto/2][ancho/2] = 1;
  tablero[(alto/2)-1][(ancho/2)-1] = 1;
  tablero[(alto/2)-1][ancho/2] = 2;
  tablero[(alto/2)][(ancho/2)-1] = 2;

  // Dibujar lineas del tablero
  for (int i = 0; i < tablero.length; i++) {
    line(tamano*i, 0, tamano*i, alto*tamano); //Lineas verticales
    line(0, tamano*i, alto*tamano, i*tamano); //Lineas horizontales
  }
}

// Ciclo de dibujo (el código se ejecuta constantemente)
void draw() {
  noStroke(); // Quitar color de linea
  
  // Dibujar discos/fichas del tablero
  for (int i = 0; i < tablero.length; i++)
    for (int j = 0; j < tablero[0].length; j++) {
      if (tablero[i][j] == 1)
        fill(0); // Color de disco/ficha para Jugador 1
      else if (tablero[i][j] == 2)
        fill(255); // Color de disco/ficha para Jugador 2
      else
        noFill(); // Sin color si no hay ficha
      ellipse((j*tamano)+(tamano/2), (i*tamano)+(tamano/2), tamano/2, tamano/2);
    }
}

//Método que intercambia el jugador actual por el contrincante.
void intercambiaJugador(){
  jugadorActual = getContrincante(jugadorActual);
}

//Método que recibe un int, y regresa el int que representa al contrincante
int getContrincante(int jugadorActual){
  if (jugadorActual == JUGADOR1)
    return JUGADOR2;
  else
    return JUGADOR1;
}

//Método que verifica si un tiro es válido o no. Checa las posiciones aledañas a la casilla para
//Checar si flanquea o no.
boolean tiroValido(int x, int y){
  ArrayList<Casilla> casillasACambiar = new ArrayList<Casilla>();//Total de casillas a cambiar
  verificaE(casillasACambiar,x,y);
  verificaNE(casillasACambiar,x,y);
  verificaN(casillasACambiar,x,y);
  verificaNO(casillasACambiar,x,y);
  verificaO(casillasACambiar,x,y);
  verificaSO(casillasACambiar,x,y);
  verificaS(casillasACambiar,x,y);
  verificaSE(casillasACambiar,x,y);
  flip(casillasACambiar);
  return casillasACambiar.size()!=0;
}

/**
 * Método que cambia las casillas que se pueden flanquear.
 * @param casillas ArrayList de las casillas a ser cambiadas
 */
void flip(ArrayList<Casilla> casillas){
  if(casillas.size()!=0)
    for(Casilla c: casillas)
      if(jugadorActual == JUGADOR1){
        tablero[c.y][c.x] = JUGADOR1;
      }else{
        tablero[c.y][c.x] = JUGADOR2;
      }
}
 
 
/** 
 * Método que verifica si a la derecha del tiro hay posibilidad de flanquear.
 * itera sobre lo que está al Éste (Derecha) de la casilla.
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
void verificaE(ArrayList<Casilla> c, int x, int y){
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i=x+1; i<ancho;i++){
    if(tablero[y][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero[y][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,y));
    }else if(tablero[y][i]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que está al noreste (sobre la diagonal derecha de arriba).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public void verificaNE(ArrayList<Casilla> c, int x, int y){ 
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x+1, j = y-1; i<ancho && j>=0; i++,j--){
      if(tablero[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
        break;
      if(tablero[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
        auxCasillas.add(new Casilla(i,j));
      }else if(tablero[j][i]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
        c.addAll(auxCasillas);//Guarda lo que llevas
        break; //Detente
      }else{
        break; //Si no, entonces detente.
      }
  }
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre la vertical hacía arriba (Al norte).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public void verificaN(ArrayList<Casilla> c, int x, int y){
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int j=y-1; j>=0;j--){
    if(tablero[j][x] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero[j][x]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(x,j));
    }else if(tablero[j][x]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que está al noroeste (La diagonal izquierda de arriba).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public void verificaNO(ArrayList<Casilla> c, int x, int y){
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x-1, j = y-1; i>=0 && j>=0; i--,j--){
    if(tablero[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(tablero[j][i]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que está al oeste (A la izquierda de la ficha).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public void verificaO(ArrayList<Casilla> c, int x, int y){
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i=x-1; i>=0;i--){
    if(tablero[y][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero[y][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,y));
    }else if(tablero[y][i]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que hay al suroeste (la diagonal izquierda de abajo)
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public void verificaSO(ArrayList<Casilla> c, int x, int y){
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x-1, j = y+1; i>=0 && j<alto; i--,j++){
    if(tablero[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(tablero[j][i]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera hacía el sur (sobre la vertical hacía abajo).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public void verificaS(ArrayList<Casilla> c, int x, int y){
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int j=y+1; j<alto;j++){
    if(tablero[j][x] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero[j][x]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(x,j));
    }else if(tablero[j][x]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera hacía el sureste (diagonal de abajo a la derecha)
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public void verificaSE(ArrayList<Casilla> c, int x, int y){
  int contrincante = getContrincante(jugadorActual);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x+1, j = y+1; i<ancho && j<alto; i++,j++){
    if(tablero[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(tablero[j][i]==jugadorActual && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
}

// Evento al dar un clic (el código se ejecuta constantemente)
void mouseClicked() {
  // Prints de prueba:
  println(mouseX + " " + mouseY);
  println(mouseX/tamano + " " + mouseY/tamano);

  // Colocar ficha
  if (tablero[mouseY/tamano][mouseX/tamano] == 0 && tiroValido(mouseX/tamano,mouseY/tamano)) { //Si la casilla está vacía entonces...
    tablero[mouseY/tamano][mouseX/tamano] = jugadorActual; //Pon la ficha del jugador actual
    // Intercambia al jugador actual.
    intercambiaJugador(); 
  }
}