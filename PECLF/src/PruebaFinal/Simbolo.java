package PruebaFinal;

import java.util.ArrayList;

//clase simbolo para la tabla de los tokens sin repetir
public class Simbolo {
	String identificador = "";
	Boolean palabraReservada = false;
	String tipo = "*";
	ArrayList<Integer> columna = new ArrayList<Integer>();
	ArrayList<Integer> fila = new ArrayList<Integer>();
	
	//constructor para identificadores
	public Simbolo(String a, String c, Integer d, Integer e) {
		this.identificador=a;
		this.tipo=c;
		this.fila.add(d);
		this.columna.add(e);
	}
	
	//contrustor para el resto
	public Simbolo(String a, Boolean b, String c, Integer d, Integer e) {
		this.identificador=a;
		this.palabraReservada=b;
		this.tipo=c;
		this.fila.add(d);
		this.columna.add(e);
	}
	
	//metodos implementados para su utilizacion
	public String Mostrar() {
			return identificador + " - " + tipo  + " - " + fila.toString()  + " - " + columna.toString();
	}
	
	public String Identificador() {
		return identificador;
	}
	
	public String Tipo() {
		return tipo;
	}
	
	public ArrayList<Integer> Fila() {
		return fila;
	}
	
	public ArrayList<Integer> Columna() {
		return columna;
	}
	
	public Integer Fila1() {
		return fila.get(0);
	}
	
	public Integer Columna1() {
		return columna.get(0);
	}
	
	public boolean Reservada() {
		return palabraReservada;
	}	
	
	public void anadirFila(Integer aux){
		this.fila.add(aux);
	}
	public void anadirColumna(Integer aux){
		this.columna.add(aux);
	}
}
