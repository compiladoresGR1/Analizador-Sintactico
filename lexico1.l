%option noyywrap
%option yylineno
%{
#include <stdio.h>
#include "asintactico.tab.h"
int bandera =0;
%}

ignorar " "|\t|\n
digito [0-9]
ID [a-z][a-zA-Z0-9_$]*
caracter [\'].[\']

%%
{ID}{ID}"["{digito}+"]"	return VECTOR;
{ignorar}*              {;}
"."			{return '.';}
","			{return ',';}
";"			{return ';';}
"("			{return '(';}
")"			{return ')';}
"["			{return '[';}
"]"			{return ']';}
"{"			{return '{';}
"}"			{return '}';}
#include		{return INCLUDE;}
[<][a-z]+\.h[>]	|
[\"][a-z]+\.h[\"]	{return LIBRERIAS;}		
if			{return SI;}
"else if"		{return SINO;}
else			{return NO;}
for			{return PARA;}
while			{return MIENTRAS;}
main			{return MAIN;}
int			{return TIPO_INTEGER;}
float			{return TIPO_FLOAT;}
char			{return TIPO_CHAR;}
bool			{return TIPO_BOOLEANO;}
"+"			{return SUMA;}
"-"			{return RESTA;}
"*"			{return MULTIPLICACION;}
"/"			{return DIVISION;}
"++"			{return AUMENTAR;}
"--"			{return DISMINUIR;}
"="			{return ASIGNADOR;}
">"			{return MAYOR;}
"<"			{return MENOR;}
"=="			{return IGUAL;}
">="			{return MAYORIGUAL;}
"<="			{return MENORIGUAL;}
"!="			{return NOIGUAL;}
{digito}+		{return INTEGER;}
{digito}"."{digito}+	{return FLOAT;}
{caracter}		{return CHAR;}
{ID}			{return ID;}
.			{printf("ERROR caracter no identificado : %s en linea: %d \n",yytext, yylineno);
			bandera=1;}


%%
yyerror(char * msg){
printf("%s en %d\n ",msg,yylineno);
}

int main(void){

yyin=fopen("entrada.txt","rt");

if(yyin==NULL){
printf("no se pudo abrir el archivo");
}else{

if(!yyparse() && bandera==0 ){
printf("\n se compilo correctamente\n");
}
}
fclose(yyin);
}


