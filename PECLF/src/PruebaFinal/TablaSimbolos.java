package PruebaFinal;
import java.util.HashMap;

//interface solo declaraciones
public interface TablaSimbolos {

	//Estructuras utilizadas con sus tipos
	 static  HashMap<String, Simbolo> tablaSimbolos  = new HashMap<String, Simbolo>(); 
	 static  HashMap<String, TipoDato> listaVariables = new HashMap<String, TipoDato>();

	 /**
	  * getTablaSimbolos .- Devuelve la Tabla de Simbolos
	  */
	 public HashMap<String, Simbolo> getTablaSimbolos();

	 /**
	  * getListaVariables .- Devuelve la lista de variables
	  */
	 public HashMap<String, TipoDato> getListaVariables();

	 /**
	  * Inserta un tipoDato en la Lista de Variables
	  */
	 public boolean Insertar_ListaVariables(String nombre, TipoDato tipoDato) ;

	 /**
	  * Inserta un Simbolo en la Tabla de Simbolos
	  */
	  public boolean Insertar_TablaSimbolo(String nombre, Simbolo simbolo) ;

	 /**
	  * Modificar el tipo de dato de un Simbolo en la Tabla de Simbolos

	  */
	  public void ModificarTipo_TablaSimbolo(String nombre, Simbolo simbolo) ;

	 /**
	  * Modificar el tipo de dato de un tipodato en la Lista de Variables
	  */
	  public void ModificarTipo_ListaVariables(String nombre, TipoDato tipoDato) ;

	 /**
	  * Buscar un simbolo en la Tabla de Simbolos
	  */
	  public Simbolo BuscarSimbolo_TablaSimbolo(String nombre) ;

	 /**
	  * Buscar un tipoDato en la ListaVariables
	  */
	  public TipoDato BuscarSimbolo_ListaVariables(String nombre) ;

	 /**
	  * Imprimir Tabla de Simbolos y la Lista de Variables
	  */
	  public void ImprimirTablaSimbolo();
	  
	  public void ImprimirTablaVariables();
	  
	  /**
	   * Busca si esta en Tabla de Simbolos y la Lista de Variables
	  */
	  public boolean estaSimbolo(String nombre);
	  public boolean estaVariable(String nombre);
}
