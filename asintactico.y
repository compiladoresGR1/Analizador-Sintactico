%{
int yystopparse=0;
%}

%token INCLUDE 
%token LIBRERIAS 
%token VOID 
%token MAIN 
%token ID 
%token INTEGER 
%token FLOAT
%token BOOLEANO 
%token CHAR
%token TIPO_INTEGER 
%token TIPO_FLOAT 
%token TIPO_BOOLEANO 
%token TIPO_CHAR 
%token ASIGNADOR 
%token SUMA 
%token RESTA 
%token MULTIPLICACION 
%token DIVISION 
%token AUMENTAR 
%token DISMINUIR 
%token MAYOR 
%token MENOR 
%token IGUAL 
%token MAYORIGUAL 
%token MENORIGUAL 
%token NOIGUAL 
%token SI 
%token NO 
%token SINO 
%token PARA 
%token MIENTRAS
%token VECTOR

%start programa

%%

programa		: cabecera  principal funciones | cabecera principal | cabecera | cabecera  crearvariable ';' principal funciones 
			| cabecera crearvariable ';' principal
			|error;

cabecera		: INCLUDE  LIBRERIAS;

principal		: tipodato MAIN '('')'  '{' lineascodigos '}'|tipodato MAIN '('tipodato ID')'  '{' lineascodigos '}'|error;

lineascodigos		: lineacodigo |;

lineacodigo		: lineacodigo  linea | linea;

linea			: invocarmetodo ';' | crearvariable ';' | cambiarvalor ';' | buclecondicion |vector ';';

invocarmetodo		: ID '(' parametrosenvio ')';

parametrosenvio		: parenvio |;

parenvio		: parenvio ',' penvio | penvio;

penvio			: valor | ID;

valor			: INTEGER | FLOAT | BOOLEANO | CHAR;

crearvariable		: tipodato ID  | tipodato ID asignarvalor ;

tipodato		: TIPO_INTEGER | TIPO_FLOAT | TIPO_BOOLEANO | TIPO_CHAR;

asignarvalor		: ASIGNADOR operasignacion | ASIGNADOR valor | ASIGNADOR ID;

operasignacion		: aritmetico | invocarmetodo | incredismivariable;

aritmetico		: oprcomun | oprcomun oprcomplemento;

oprcomun		: valor tipoopr valor | valor tipoopr ID | ID tipoopr valor | ID tipoopr ID;

tipoopr			: SUMA | RESTA | MULTIPLICACION | DIVISION | ASIGNADOR;

oprcomplemento		: oprcomplemento oprcom | oprcom;

oprcom			: tipoopr valor | tipoopr ID;

incredismivariable	: ID indis;

indis			: AUMENTAR | DISMINUIR;

cambiarvalor		: ID ASIGNADOR cambvalor;

cambvalor		: valor | operasignacion | ID;

buclecondicion		: condicionif | buclefor | buclewhile;

condicionif		: condicionsi | condicionsi condicionno | condicionsi condicionessino condicionno;


condicionsi		: SI '(' condicion ')' '[' lineascodigos ']';

condicion		: valor condicional valor | valor condicional | ID | ID condicional valor | ID condicional ID;

condicional		: MAYOR | MENOR | IGUAL | MAYORIGUAL | MENORIGUAL | NOIGUAL;

condicionno		: NO '[' lineascodigos ']';

condicionessino		: condicionessino condicionsino | condicionsino;

condicionsino		: SINO '(' condicion ')' '[' lineascodigos ']';

buclefor		: PARA '(' iniciafor ';' condicion ';' incredismivariable ')' '[' lineascodigos ']' ;

iniciafor		: tipodato ID asignarvalor;

buclewhile		: MIENTRAS '(' condicion ')' '[' lineascodigos ']';

funciones		: funciones funcion | funcion;

funcion			: tiporetorno ID '(' parametrosin ')' '{' lineascodigos '}';

tiporetorno		: tipodato | VOID;

parametrosin		: parametros |;

parametros		: parametros ',' parametro | parametro;

parametro		: tipodato ID;

vector			: tipodato ID'['INTEGER']';


%%


