/**
 * Juego de Reversi/Othello usando Processing
 */
int ancho = 8, 
  alto = 6, 
  tamano = 64;
boolean p1Turn = true;
int playerCode;
Tablero tablero;
static final int JUGADOR1=1;
static final int JUGADOR2=2;
static final int SIN_FICHA=0;

// Inicial para establecer tamaño de ventana con variables
void settings() {
  size((ancho * tamano)+1, (alto * tamano)+1);
}

// Inicialización
void setup() {
  tablero = new Tablero(ancho, alto, tamano);
  background(0, 153, 51); // Color de fondo
}

// Update. Continuamente ejecuta y dibuja el código contenido en él
void draw() {
  tablero.display();
}

//Método que devuelve un booleano que representa al turno del jugador contrincante. 
boolean getContrincante(){
  if (p1Turn)
    return false;
  else
    return true;
}

//Metodo que devuelve el valor entero del jugador contrincante.
int getIntContrincante(){
  if (p1Turn)
    return 2;
  else
    return 1;
}
//Metodo que devuelve el valor entero del jugador actual.
int jugadorActual(){
  if (p1Turn)
    return 1;
  else
    return 2;
}

//Método que intercambia el jugador actual por el contrincante.
void intercambiaJugador(){
  p1Turn = getContrincante();
}

/** 
 * Método que verifica si a la derecha del tiro hay posibilidad de flanquear.
 * itera sobre lo que está al Éste (Derecha) de la casilla.
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
void verificaE(ArrayList<Casilla> c, int x, int y){
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i=x+1; i<ancho;i++){
    if(tablero.mundo[y][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero.mundo[y][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,y));
    }else if(tablero.mundo[y][i]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
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
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x+1, j = y-1; i<ancho && j>=0; i++,j--){
      if(tablero.mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
        break;
      if(tablero.mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
        auxCasillas.add(new Casilla(i,j));
      }else if(tablero.mundo[j][i]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
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
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int j=y-1; j>=0;j--){
    if(tablero.mundo[j][x] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero.mundo[j][x]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(x,j));
    }else if(tablero.mundo[j][x]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
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
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x-1, j = y-1; i>=0 && j>=0; i--,j--){
    if(tablero.mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero.mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(tablero.mundo[j][i]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
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
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i=x-1; i>=0;i--){
    if(tablero.mundo[y][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero.mundo[y][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,y));
    }else if(tablero.mundo[y][i]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
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
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x-1, j = y+1; i>=0 && j<alto; i--,j++){
    if(tablero.mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero.mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(tablero.mundo[j][i]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
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
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int j=y+1; j<alto;j++){
    if(tablero.mundo[j][x] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero.mundo[j][x]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(x,j));
    }else if(tablero.mundo[j][x]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
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
  int contrincante = getIntContrincante();
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x+1, j = y+1; i<ancho && j<alto; i++,j++){
    if(tablero.mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(tablero.mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(tablero.mundo[j][i]==jugadorActual() && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      c.addAll(auxCasillas);//Guarda lo que llevas
      break; //Detente
    }else{
      break; //Si no, entonces detente.
    }
  }
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
      if(jugadorActual() == JUGADOR1){
        tablero.mundo[c.y][c.x] = JUGADOR1;
      }else{
        tablero.mundo[c.y][c.x] = JUGADOR2;
      }
}



// Callback. Evento que ocurre después de presionar el botón del mouse
void mouseClicked() {
  if (tablero.mundo[mouseY/tamano][mouseX/tamano] == 0 && tiroValido(mouseX/tamano,mouseY/tamano)) { //Si la casilla está vacía entonces...
    tablero.mundo[mouseY/tamano][mouseX/tamano] = jugadorActual(); //Pon la ficha del jugador actual
    // Intercambia al jugador actual.
    intercambiaJugador(); 
  }
}