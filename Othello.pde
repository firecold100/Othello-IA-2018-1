int tablero[][]; // 0=vacio, 1=Jugador1, 2=Jugador2
int alto = 8;
int ancho = 8;
int tamano = 50;
int jugadorActual = 1;

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

// Evento al dar un clic (el código se ejecuta constantemente)
void mouseClicked() {
  // Prints de prueba:
  //println(mouseX + " " + mouseY);
  //println(mouseX/tamano + " " + mouseY/tamano);

  // Colocar ficha
  if (tablero[mouseY/tamano][mouseX/tamano] == 0) {
    tablero[mouseY/tamano][mouseX/tamano] = jugadorActual;
    // Cambiar de turno/jugador:
    if (jugadorActual == 1)
      jugadorActual = 2;
    else
      jugadorActual = 1;
  }
}