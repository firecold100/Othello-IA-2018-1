/*Representación de un movimiento.
*Este tipo de dato se guarda en el arbol para mantener
*la información de las tiradas en todo momento.
*/
public class Configuracion{
  public int valor;
  public int x;
  public int y;
  public int[][] mundo;
  
  public Configuracion(int valor, int x, int y, int[][] mundo){
    this.valor = valor;
    this.x = x;
    this.y = y;
    this.mundo = mundo;
  }
  
  public Configuracion(int x, int y, int[][] mundo){
    this.x = x;
    this.y = y;
    this.mundo = mundo;
  }
  
  public Configuracion(int valor){
    this.valor = valor;
  }
  
  public Configuracion(int[][] mundo){
    this.mundo = mundo;
  }
  
  public int[][] getMundo(){
    return this.mundo;
  }
}