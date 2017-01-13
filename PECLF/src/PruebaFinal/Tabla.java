package PruebaFinal;
import java.util.HashMap;
import java.util.Iterator;

//clase tabla que implementa la interface de la tabla simbolos
public class Tabla implements TablaSimbolos {
	
	//constructor
	public Tabla() {
		
	}

	//metodos para la lista de variables (usado para variables declaradas sin repeticion)
	//metodo para obtener la lista hasmap()
	@Override
	public HashMap<String, TipoDato> getListaVariables() {
		// TODO Auto-generated method stub
		return listaVariables;
	}

	//metodo para insertar en el hasmap una variable 
	@Override
	public boolean Insertar_ListaVariables(String nombre, TipoDato tipoDato) {
		// TODO Auto-generated method stub
		if (listaVariables.isEmpty()){
			listaVariables.put(nombre.toLowerCase(), tipoDato);  
	        return true;
	    }else{
	    	if(listaVariables.containsKey(nombre.toLowerCase())){
		        return true;
	    	}else{
	    		listaVariables.put(nombre.toLowerCase(), tipoDato);  
		        return true;
	    	}
	    }	
	}
	
	//metodo para modificar una variable ya creada por otra
	@Override
	public void ModificarTipo_ListaVariables(String nombre, TipoDato tipoDato) {
		if (listaVariables.containsKey(nombre.toLowerCase())){
	        listaVariables.put(nombre.toLowerCase(), tipoDato);            
	    }
	    else{
	        System.out.println("No hay ninguna variable con ese código.");
	    }
	}	
	
	//metodo para obtener el contenido del hasmap para una variable concreta
	@Override
	public TipoDato BuscarSimbolo_ListaVariables(String nombre) {
		// TODO Auto-generated method stub
		if (listaVariables.containsKey(nombre.toLowerCase())){	    
	        return listaVariables.get(nombre.toLowerCase());       
	    }
	    else{
	        System.out.println("No hay ninguna variable con ese código.");
	        return null;
	    }
	}

	//metodo para imprimir toda la lista
	@Override
	public void ImprimirTablaVariables() {
		// TODO Auto-generated method stub
		String clave;
	    Iterator<String> contenido = listaVariables.keySet().iterator();
	    System.out.println("Hay las siguientes variables:");
	    System.out.println("Clave - Nombre - Tipo - Valor - Fila - Columna");
	    while(contenido.hasNext()){
	        clave = contenido.next();
	        System.out.println(clave + " - " + listaVariables.get(clave).Imprimir());
	    } 
	}
	
	//metodo para comprobar si esta una cierta variable
	@Override
	public boolean estaVariable(String nombre) {
		// TODO Auto-generated method stub
		if (listaVariables.containsKey(nombre.toLowerCase())) {
			return true;
		}else{
			return false;
		}
	}

	//metodos para la tabla de simbolos TOKENS (sin repetir)
	//metodo para obtener la tabla hasmap()
	@Override
	public HashMap<String, Simbolo> getTablaSimbolos() {
		// TODO Auto-generated method stub
		return tablaSimbolos;
	}
	
	//metodo para insertar en el hasmap un token valido
	@Override
	public boolean Insertar_TablaSimbolo(String nombre, Simbolo simbolo) {
		// TODO Auto-generated method stub
		if (tablaSimbolos.isEmpty()){
			tablaSimbolos.put(nombre.toLowerCase(), simbolo);  
	        return true;
	    }else{
	    	if(tablaSimbolos.containsKey(nombre.toLowerCase())){
	    		Simbolo aux = BuscarSimbolo_TablaSimbolo(nombre.toLowerCase());
	    		aux.anadirFila(simbolo.Fila1());
	    		aux.anadirColumna(simbolo.Columna1());
		        return true;
	    	}else{
	    		tablaSimbolos.put(nombre.toLowerCase(), simbolo);  
		        return true;
	    	}
	    }
	}

	//metodo para modificar un token ya creado por otro
	@Override
	public void ModificarTipo_TablaSimbolo(String nombre, Simbolo simbolo) {
		if (tablaSimbolos.containsKey(nombre.toLowerCase())){
	        tablaSimbolos.put(nombre.toLowerCase(), simbolo);            
	    }
	    else{
	        System.out.println("No hay ningun simbolo con ese código.");
	    }

	}
	
	//metodo para obtener el contenido del hasmap para un token concreto
	@Override
	public Simbolo BuscarSimbolo_TablaSimbolo(String nombre) {
		// TODO Auto-generated method stub
		if (tablaSimbolos.containsKey(nombre.toLowerCase())){	    
	        return tablaSimbolos.get(nombre.toLowerCase());       
	    }
	    else{
	        System.out.println("No hay ningun simbolo con ese código.");
	        return null;
	    }
	}
	
	//metodo para imprimir tods los tokens
	@Override
	public void ImprimirTablaSimbolo() {
		// TODO Auto-generated method stub
		String clave;
	    Iterator<String> contenido = tablaSimbolos.keySet().iterator();
	    System.out.println();
	    System.out.println("Se han encontrado los siguientes simbolos excluyendo los repetidos:");
	    System.out.println("Clave - Nombre - Tipo - Fila - Columna");
	    while(contenido.hasNext()){
	        clave = contenido.next();
	        System.out.println(clave + " - " + tablaSimbolos.get(clave).Mostrar());
	    }        
	}
	
	//metodo para comprobar si esta un cierto token
	@Override
	public boolean estaSimbolo(String nombre) {
		// TODO Auto-generated method stub
		if (tablaSimbolos.containsKey(nombre.toLowerCase())) {
			return true;
		}else{
			return false;
		}
	}

}
