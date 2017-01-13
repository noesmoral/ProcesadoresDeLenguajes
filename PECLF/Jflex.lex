package PruebaFinal;

import java_cup.runtime.*;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;

%%
// OPTIONES, DECLARACIONES Y MACROS 
%unicode                // formato unicode */
%line                   // activar contador de lineas ("yyline") */
%column                 // activar contador de columnas ("yycolumn") */
%cup

/* La directiva %init permite introducir código en el constructor de la clase. se usará para inicializar variables */
%init{ 
    Yylex.tokensList = new ArrayList<String>();
    Yylex.errorLexTokensList = new ArrayList<String>();
    Yylex.contenedor = new Tabla();
	yyline = 1; 
	yycolumn = 1; 
%init}

%{/* Esta variable almacenara información de los tokens token's */
//private ArrayList tokensList;
public static ArrayList<String> tokensList = new ArrayList<String>();
public static ArrayList<String> errorLexTokensList = new ArrayList<String>();
public static Tabla contenedor = new Tabla();
public static int contErrorLex = 0;

/* Método de escribir en el fichero de salida y por pantalla*/
public static void writeOutputFile() throws IOException {
	String filename = "file.out";
	BufferedWriter out = new BufferedWriter(new FileWriter(filename));

	for (String s : tokensList) {
		System.out.println(s);
		out.write(s + "\n");
	} 
	System.out.println();
	out.close();
}

public static void writeOutputFileReglasLex() throws IOException {
	System.out.println("Lista de errores en caso de haberlos:");
	String filename1 = "filErrorLex.out";
	BufferedWriter out1 = new BufferedWriter(new FileWriter(filename1));
	for (String s : errorLexTokensList) {
		System.out.println(s);
		out1.write(s + "\n");
	}
	if(contErrorLex>0){
		System.out.println("Cantidad de errores lexicos: " + contErrorLex);
		System.out.println();
	}else{
		System.out.println("Cantidad de errores lexicos: 0 todo correcto");
		System.out.println();
	}
	out1.close();
}

//Metodos para insertar
private void insertarIdentificadores(){
	if(contenedor.estaSimbolo(yytext().toLowerCase())){
		Simbolo aux = Yylex.contenedor.BuscarSimbolo_TablaSimbolo(yytext());
	    aux.anadirFila(yyline);
	    aux.anadirColumna(yycolumn);
	}else{
		Yylex.contenedor.Insertar_TablaSimbolo(yytext().toLowerCase(), new Simbolo(yytext().toLowerCase(), "identificador",yyline,yycolumn));
	}
}
%}

// Básicamente, las macros se utilizan para nombrar las expresiones regulares 
PROGRAM		= [pP][rR][oO][gG][rR][aA][mM]		//palabras reservadas
IS			= [iI][sS]
BEGIN		= [bB][eE][gG][iI][nN]
END			= [eE][nN][dD]
VAR			= [vV][aA][rR]
INTEGER		= [iI][nN][tT][eE][gG][eE][rR]
BOOLEAN		= [bB][oO][oO][lL][eE][aA][nN]
READ		= [rR][eE][aA][dD]
WRITE		= [wW][rR][iI][tT][eE]
SKIP		= [sS][kK][iI][pP]
WHILE		= [wW][hH][iI][lL][eE]
DO			= [dD][oO]
IF			= [iI][fF]
THEN		= [tT][hH][eE][nN]
ELSE		= [eE][lL][sS][eE]
AND			= [aA][nN][dD]
OR			= [oO][rR]
TRUE		= [tT][rR][uU][eE]
FALSE		= [fF][aA][lL][sS][eE]
NOT			= [nN][oO][tT]
//otros tokens para gramatica
ASIGNACION	= (\:\=) 		//Asignacion
MENOR_IGUAL = (\<\=)		//OperadorRelacion
MENOR		= (\<)
IGUAL		= (\=)
MAYOR		= (\>)
MAYOR_IGUAL	= (\>\=) 
DISTINTOS	= (\<\>)
SUMA		= (\+)			//OperadorMatematic
RESTA		= (\-)
MULTIPLICACION = (\*)
DIVISION	= (\/)
PARENTESIS_IZQUIERDO = (\() //SignoPuntuacion
PARENTESIS_DERECHO = (\))
COMA		= (\,)
PUNTO_COMA  = (\;)
DOS_PUNTOS	= (\:)		
ENTERO 		= [0-9]+	//entero	//revisar para lo de +980 y -2948
IDENTIFIER  = [a-zA-Z][a-zA-Z0-9]*  // Identificadores 
ESPACIO_BLANCO= (\u0020)		//otros
TABULADOR= (\u0009)
ERROR1= [0-9][a-zA-Z0-9]* 	//errores parametrizados para simplificar

%%
// REGLA LEXICAS Y ACCIONES: Aquí se introduce el código que se ejecuta cuando la entrada coincide con una expresión regular. 
// Como les hemos llamado usando las macros usamos esos nombres aquí. 
{PROGRAM}       {Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] PROGRAM: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Program", new Simbolo("Program",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.PROGRAM, yyline, yycolumn, yytext());}     
{IS}  			{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] IS: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Is", new Simbolo("Is",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.IS, yyline, yycolumn, yytext());}  		
{BEGIN}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] BEGIN: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Begin", new Simbolo("Begin",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.BEGIN, yyline, yycolumn, yytext());}  	
{END}	  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] END: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("End", new Simbolo("End",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.END, yyline, yycolumn, yytext());}  		
{VAR}	  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] VAR: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Var", new Simbolo("Var",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.VAR, yyline, yycolumn, yytext());}  	 	 
{INTEGER}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] INTEGER: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Integer", new Simbolo("Integer",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.INTEGER, yyline, yycolumn, yytext());}  	
{BOOLEAN}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] BOOLEAN: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Boolean", new Simbolo("Boolean",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.BOOLEAN, yyline, yycolumn, yytext());}  	
{READ}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] READ: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Read", new Simbolo("Read",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.READ, yyline, yycolumn, yytext());}  	 	 
{WRITE}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] WRITE: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Write", new Simbolo("Write",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.WRITE, yyline, yycolumn, yytext());}  	 
{SKIP}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] SKIP: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Skip", new Simbolo("Skip",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.SKIP, yyline, yycolumn, yytext());}  		
{WHILE}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] WHILE: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("While", new Simbolo("While",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.WHILE, yyline, yycolumn, yytext());}  	 
{DO}	  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] DO: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Do", new Simbolo("Do",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.DO, yyline, yycolumn, yytext());}  		 
{IF}	  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] IF: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("If", new Simbolo("If",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.IF, yyline, yycolumn, yytext());}  		 
{THEN}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] THEN: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Then", new Simbolo("Then",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.THEN, yyline, yycolumn, yytext());}  		
{ELSE}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] ELSE: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Else", new Simbolo("Else",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.ELSE, yyline, yycolumn, yytext());}  		 
{AND}	  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] AND: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("And", new Simbolo("And",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.AND, yyline, yycolumn, yytext());}  		 
{OR}	  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] OR: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Or", new Simbolo("Or",true,"reservada",yyline,yycolumn)); 
				return new Symbol(JcupSym.OR, yyline, yycolumn, yytext());}  		 
{TRUE}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] TRUE: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("True", new Simbolo("True",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.TRUE, yyline, yycolumn, yytext());}   		 
{FALSE}  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] FALSE: " + yytext());  
				Yylex.contenedor.Insertar_TablaSimbolo("False", new Simbolo("False",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.FALSE, yyline, yycolumn, yytext());}  	 
{NOT}	  		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] NOT: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Not", new Simbolo("Not",true,"reservada",yyline,yycolumn));
				return new Symbol(JcupSym.NOT, yyline, yycolumn, yytext());}  	 	 
{ASIGNACION}	{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] ASIGNACION: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Asignacion", new Simbolo("Asignacion",false,"Operador de asignación",yyline,yycolumn)); 
				return new Symbol(JcupSym.ASIGNACION, yyline, yycolumn, yytext());}
{MENOR_IGUAL} 	{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] MENOR_IGUAL: " + yytext());
				Yylex.contenedor.Insertar_TablaSimbolo("Menor_Igual", new Simbolo("Menor_Igual",false,"Operador de relacion",yyline,yycolumn));
				return new Symbol(JcupSym.MENOR_IGUAL, yyline, yycolumn, yytext());}
{MENOR}			{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] MENOR: " + yytext());
				Yylex.contenedor.Insertar_TablaSimbolo("Menor", new Simbolo("Menor",false,"Operador de relacion",yyline,yycolumn));
				return new Symbol(JcupSym.MENOR, yyline, yycolumn, yytext());}
{IGUAL} 		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] IGUAL: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Igual", new Simbolo("Igual",false,"Operador de relacion",yyline,yycolumn));
				return new Symbol(JcupSym.IGUAL, yyline, yycolumn, yytext());}
{MAYOR}			{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] MAYOR: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Mayor", new Simbolo("Mayor",false,"Operador de relacion",yyline,yycolumn));
				return new Symbol(JcupSym.MAYOR, yyline, yycolumn, yytext());}
{MAYOR_IGUAL} 	{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] MAYOR_IGUAL: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Mayor_Igual", new Simbolo("Mayor_Igual",false,"Operador de relacion",yyline,yycolumn));
				return new Symbol(JcupSym.MAYOR_IGUAL, yyline, yycolumn, yytext());}
{DISTINTOS}		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] DISTINTOS: " + yytext());
				Yylex.contenedor.Insertar_TablaSimbolo("Distintos", new Simbolo("Distintos",false,"Operador de relacion",yyline,yycolumn));
				return new Symbol(JcupSym.DISTINTOS, yyline, yycolumn, yytext());}
{SUMA} 			{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] SUMA: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Suma", new Simbolo("Suma",false,"Operador matematico",yyline,yycolumn));
				return new Symbol(JcupSym.SUMA, yyline, yycolumn, yytext());}
{RESTA}			{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] RESTA: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Resta", new Simbolo("Resta",false,"Operador matematico",yyline,yycolumn));
				return new Symbol(JcupSym.RESTA, yyline, yycolumn, yytext());}
{MULTIPLICACION} {Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] MULTIPLICACION: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Multiplicacion", new Simbolo("Multiplicacion",false,"Operador matematico",yyline,yycolumn));
				return new Symbol(JcupSym.MULTIPLICACION, yyline, yycolumn, yytext());}
{DIVISION} 		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] DIVISION: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Division", new Simbolo("Division",false,"Operador matematico",yyline,yycolumn));
				return new Symbol(JcupSym.DIVISION, yyline, yycolumn, yytext());}
{PARENTESIS_IZQUIERDO} {Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] PARENTESIS_IZQUIERDO: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Parentesis_Izquierdo", new Simbolo("Parentesis_Izquierdo",false,"Signos de puntuación",yyline,yycolumn));
				return new Symbol(JcupSym.PARENTESIS_IZQUIERDO, yyline, yycolumn, yytext());}
{PARENTESIS_DERECHO} {Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] PARENTESIS_DERECHO: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Parentesis_Derecho", new Simbolo("Parentesis_Derecho",false,"Signos de puntuación",yyline,yycolumn));
				return new Symbol(JcupSym.PARENTESIS_DERECHO, yyline, yycolumn, yytext());}
{COMA} 			{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] COMA: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Coma", new Simbolo("Coma",false,"Signos de puntuación",yyline,yycolumn));
				return new Symbol(JcupSym.COMA, yyline, yycolumn, yytext());}
{PUNTO_COMA} 	{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] PUNTO_COMA: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Punto_Coma", new Simbolo("Punto_Coma",false,"Signos de puntuación",yyline,yycolumn)); 
				return new Symbol(JcupSym.PUNTO_COMA , yyline, yycolumn, yytext());}
{DOS_PUNTOS} 	{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] DOS_PUNTOS: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Dos_Puntos", new Simbolo("Dos_Puntos",false,"Signos de puntuación",yyline,yycolumn));
				return new Symbol(JcupSym.DOS_PUNTOS, yyline, yycolumn, yytext());}
{ENTERO}		{Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] ENTERO: " + yytext()); 
				Yylex.contenedor.Insertar_TablaSimbolo("Entero", new Simbolo("Entero",false,"Integer",yyline,yycolumn));  
				return new Symbol(JcupSym.ENTERO, yyline, yycolumn, yytext());}
{IDENTIFIER}    {Yylex.tokensList.add("[" + yyline + "," + yycolumn + "] IDENTIFIER: " + yytext()); 
				insertarIdentificadores(); 
				return new Symbol(JcupSym.IDENTIFIER, yyline, yycolumn, yytext());}  /* Código ejecutado cuando se encuentra un Identifier */
{ESPACIO_BLANCO}	{	}
{TABULADOR}		{	}
\r|\n|\r\n		{	}
\u2028|\u2029|\u000B|\u000C|\u0085 {                                                      /* Regla léxica para evitar estrellarse cuando y se encuentra EOL, en realidad, no hacemos nada */}
<<EOF>>         {return new Symbol(JcupSym.EOF);  /* Código ejecutado cuando se encuentra EOF */}  
.               {Yylex.errorLexTokensList.add("Se ha encontrado un error en la fila "+yyline+" columna "+yycolumn+" con el simbolo "+yytext().toString()); 
				contErrorLex=contErrorLex+1; /*Lista de errores añadidos a la tabla de errores*/}
{ERROR1}		{Yylex.errorLexTokensList.add("Se ha encontrado un error en la fila "+yyline+" columna "+yycolumn+" con el simbolo "+yytext().toString()); 
				contErrorLex=contErrorLex+1;}