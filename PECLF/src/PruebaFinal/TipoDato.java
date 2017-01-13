package PruebaFinal;

import java.util.Random;


//clase para el tipodato de las variables
public class TipoDato {
	//variables
	String nombre;
	String tipo;
	Integer valorInteger=null;
	Boolean valorBoolean=null;
	Integer fila = 0;
	Integer columna = 0;
	
	//constructor para las variables integer
	public TipoDato(String a, String b, Integer c,Integer d, Integer e){
		Random rand = new Random();
		this.nombre=a;
		this.tipo=b;
		this.valorInteger=rand.nextInt(999999 - 0 + 1) + 0;	//al crearlo se mete basura hasta que se asigna
		this.fila=d;
		this.columna=e;
	}
	
	//constructor para las variables Boolean
	public TipoDato(String a, String b, Boolean c,Integer d, Integer e){
		this.nombre=a;
		this.tipo=b;
		this.valorBoolean=true;	//al crearlo meto true para evitar fallos al mostrarlo
		this.fila=d;
		this.columna=e;
	}
	
	//metodo para imprimir indistintamente ambos
	public String Imprimir() {
		if(valorBoolean==null){
			return nombre + " - " + tipo + " - " + valorInteger.toString() + " - " + fila.toString() + " - " + columna.toString();
		}else {
			return nombre + " - " + tipo + " - " + valorBoolean + " - " + fila.toString() + " - " + columna.toString();
		}
	}
	
	//metodos genericos para modificar cambiar comprobar
	public void modificarTipo(String a) {
		this.tipo=a;
	}
	
	public void modificarValor(Integer a) {
		this.valorInteger=a;
	}

	public void modificarValor(Boolean a) {
		this.valorBoolean=a;
	}
	
	//metodo para verificar el tipo
	public boolean deQueTipo(){
		if (this.valorBoolean==null) {
			return true;
		}else {
			return false;
		}
	}

}
