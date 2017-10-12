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
int getIntContrincante(int turno){
  if (turno == JUGADOR1)
    return JUGADOR2;
  else
    return JUGADOR1;
}
//Metodo que devuelve el valor entero del jugador actual.
int jugadorActual(){
  if (p1Turn)
    return JUGADOR1;
  else
    return JUGADOR2;
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
public ArrayList<Casilla> verificaE(ArrayList<Casilla> c, int x, int y,int[][] mundo,int turno){
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i=x+1; i<ancho;i++){
    if(mundo[y][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(mundo[y][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,y));
    }else if(mundo[y][i]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      return auxCasillas;//regresa lo que llevas
    }else{
      break; //Si no, entonces detente.
    }
  }
  return new ArrayList<Casilla>();
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que está al noreste (sobre la diagonal derecha de arriba).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public ArrayList<Casilla> verificaNE(ArrayList<Casilla> c, int x, int y,int[][] mundo,int turno){ 
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x+1, j = y-1; i<ancho && j>=0; i++,j--){
      if(mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
        break;
      if(mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
        auxCasillas.add(new Casilla(i,j));
      }else if(mundo[j][i]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
        return auxCasillas;//regresa lo que llevas
      }else{
        break; //Si no, entonces detente.
      }
  }
  return new ArrayList<Casilla>();
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre la vertical hacía arriba (Al norte).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public ArrayList<Casilla> verificaN(ArrayList<Casilla> c, int x, int y,int[][] mundo,int turno){
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int j=y-1; j>=0;j--){
    if(mundo[j][x] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(mundo[j][x]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(x,j));
    }else if(mundo[j][x]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      return auxCasillas;//regresa lo que llevas
    }else{
      break; //Si no, entonces detente.
    }
  }
  return new ArrayList<Casilla>();
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que está al noroeste (La diagonal izquierda de arriba).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public ArrayList<Casilla> verificaNO(ArrayList<Casilla> c, int x, int y,int[][] mundo,int turno){
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x-1, j = y-1; i>=0 && j>=0; i--,j--){
    if(mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(mundo[j][i]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      return auxCasillas;//regresa lo que llevas
    }else{
      break; //Si no, entonces detente.
    }
  }
  return new ArrayList<Casilla>();
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que está al oeste (A la izquierda de la ficha).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public ArrayList<Casilla> verificaO(ArrayList<Casilla> c, int x, int y,int[][] mundo,int turno){
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i=x-1; i>=0;i--){
    if(mundo[y][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(mundo[y][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,y));
    }else if(mundo[y][i]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      return auxCasillas;//regresa lo que llevas
    }else{
      break; //Si no, entonces detente.
    }
  }
  return new ArrayList<Casilla>();
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera sobre lo que hay al suroeste (la diagonal izquierda de abajo)
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public ArrayList<Casilla> verificaSO(ArrayList<Casilla> c, int x, int y,int[][] mundo,int turno){
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x-1, j = y+1; i>=0 && j<alto; i--,j++){
    if(mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(mundo[j][i]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      return auxCasillas;//regresa lo que llevas
    }else{
      break; //Si no, entonces detente.
    }
  }
  return new ArrayList<Casilla>();
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera hacía el sur (sobre la vertical hacía abajo).
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public ArrayList<Casilla> verificaS(ArrayList<Casilla> c, int x, int y,int[][] mundo,int turno){
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int j=y+1; j<alto;j++){
    if(mundo[j][x] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(mundo[j][x]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(x,j));
    }else if(mundo[j][x]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      return auxCasillas;//regresa lo que llevas
    }else{
      break; //Si no, entonces detente.
    }
  }
  return new ArrayList<Casilla>();
}

/**
 * Método que verifica si hay posibilidad de flanquear.
 * Ítera hacía el sureste (diagonal de abajo a la derecha)
 * @param c Las casillas a cambiar.
 * @param x Posición del tiro en x
 * @param y Posición del tiro en y
 */
public ArrayList<Casilla> verificaSE(ArrayList<Casilla> c, int x, int y, int[][] mundo,int turno){
  int contrincante = getIntContrincante(turno);
  ArrayList<Casilla> auxCasillas = new ArrayList<Casilla>();//Casillas locales a cambiar.
  for(int i = x+1, j = y+1; i<ancho && j<alto; i++,j++){
    if(mundo[j][i] == SIN_FICHA) //Si no hay ficha ya no seguimos revisando. No es válido
      break;
    if(mundo[j][i]==contrincante){ //Si la ficha es del contrincante, guarda la posición
      auxCasillas.add(new Casilla(i,j));
    }else if(mundo[j][i]== turno && auxCasillas.size()!=0){//Si encuentras ficha del jugador que tira, y ya encontraste posibilidad de flanqueo.
      return auxCasillas;//regresa lo que llevas
    }else{
      break; //Si no, entonces detente.
    }
  }
  return new ArrayList<Casilla>();
}



public ArrayList<Casilla> casillasACambiar(int x, int y, int[][] mundo, int turno){
  ArrayList<Casilla> casillasACambiar = new ArrayList<Casilla>();//Total de casillas a cambiar
  casillasACambiar.addAll(verificaE(casillasACambiar,x,y,mundo,turno));
  casillasACambiar.addAll(verificaNE(casillasACambiar,x,y,mundo,turno));
  casillasACambiar.addAll(verificaN(casillasACambiar,x,y,mundo,turno));
  casillasACambiar.addAll(verificaNO(casillasACambiar,x,y,mundo,turno));
  casillasACambiar.addAll(verificaO(casillasACambiar,x,y,mundo,turno));
  casillasACambiar.addAll(verificaSO(casillasACambiar,x,y,mundo,turno));
  casillasACambiar.addAll(verificaS(casillasACambiar,x,y,mundo,turno));
  casillasACambiar.addAll(verificaSE(casillasACambiar,x,y,mundo,turno));
  return casillasACambiar;
}

//Método que verifica si un tiro es válido o no. Checa las posiciones aledañas a la casilla para
//Checar si flanquea o no.
boolean tiroValido(ArrayList<Casilla> casillasACambiar){
  return casillasACambiar.size()!=0;
}

/**
 * Método que cambia las casillas que se pueden flanquear.
 * @param casillas ArrayList de las casillas a ser cambiadas
 */
int[][] flip(ArrayList<Casilla> casillas, int[][] mundo, int turno){
  if(casillas.size()!=0)
    for(Casilla c: casillas)
      if(turno == JUGADOR1){
        mundo[c.y][c.x] = JUGADOR1;
      }else{
        mundo[c.y][c.x] = JUGADOR2;
      }
  return mundo;
}

public ArrayList<Configuracion> generaPosiblesMovimientos(int [][] mundo, int turno){
  ArrayList<Configuracion> configuraciones = new ArrayList<Configuracion>();
  //Recorremos el tablero para buscar posibles tuplas que representan un lugar valido para tirar.
  for(int i = 0, j = 0; i<ancho && j<alto; i++,j++){
    //Si tenemos oportunidad de tirar en la posicion i,j
    if(!casillasACambiar(i,j, mundo,turno).isEmpty()){
      //Creamos el posible tablero.
      int[][] posibleMundo = flip(casillasACambiar(i,j,mundo,turno), mundo, turno);
      posibleMundo[i][j] = turno;
      //Creamos el objeto configuracion con la tirada que nos lleva a ella y el tablero en un futuro.
      Configuracion posibleConfiguracion = new Configuracion(i,j,posibleMundo);
      //Agregamos la configuracion a la lista de configuraciones posibles.
      configuraciones.add(posibleConfiguracion);
    }
  }
  return configuraciones;
}

//Funcion Minimax.
public int minimax(MyTreeNode raiz, int depth, boolean maximizaJugador){
  if(depth == 0){
    return heuristica(raiz);
  }
  if (maximizaJugador){
    int mejorValor = Integer.MIN_VALUE;
    construyeArbolAux(raiz, JUGADOR2);
    for(MyTreeNode n: (List<MyTreeNode>)raiz.getChildren()){
      int v = minimax(n, depth-1, false);
      mejorValor = Math.max(mejorValor, v);
    }
    return mejorValor;
  }else{
    int mejorValor = Integer.MAX_VALUE;
    construyeArbolAux(raiz, JUGADOR1);
    for(MyTreeNode n: (List<MyTreeNode>)raiz.getChildren()){
      int v = minimax(n, depth-1, true);
      mejorValor = Math.min(mejorValor, v);
    }
    return mejorValor;
  }
}

public int heuristica(MyTreeNode hoja){
  return (int)Math.random();
}

public void construyeArbolAux(MyTreeNode raiz, int turno){
  Configuracion c = (Configuracion)raiz.getData();
  int [][] mundoInterno = c.getMundo();
  ArrayList<Configuracion> configuraciones = generaPosiblesMovimientos(mundoInterno, turno);
  for(Configuracion conf: configuraciones){
    MyTreeNode hijo = new MyTreeNode(conf);
    raiz.addChild(hijo);
  }
}

public Configuracion getMovimiento(){
  return null;
}

// Callback. Evento que ocurre después de presionar el botón del mouse
void mouseClicked() {
  if (tablero.mundo[mouseY/tamano][mouseX/tamano] == 0 && tiroValido(casillasACambiar(mouseX/tamano,mouseY/tamano, tablero.mundo, jugadorActual()))) { //Si la casilla está vacía entonces...
    tablero.mundo[mouseY/tamano][mouseX/tamano] = jugadorActual(); //Pon la ficha del jugador actual
    tablero.mundo = flip(casillasACambiar(mouseX/tamano,mouseY/tamano, tablero.mundo ,jugadorActual()), tablero.mundo, jugadorActual());
    // Intercambia al jugador actual.
    intercambiaJugador(); 
  }
}