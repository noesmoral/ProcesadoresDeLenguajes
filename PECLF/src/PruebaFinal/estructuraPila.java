package PruebaFinal;

//clase especial para la pila
public class estructuraPila {
	String nombre;			//nombre el cual es el mismo que el del identificador
	Integer fila = 0;		//posicion en fila delcaracion
	Integer columna = 0;	//posicion en columna declaracion

	//constructor
	public estructuraPila(String a, Integer d, Integer e){
		this.nombre=a;
		this.fila=d;
		this.columna=e;
	}
}
