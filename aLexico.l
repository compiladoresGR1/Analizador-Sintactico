%{
#include <stdio.h>
#include "asintactico.tab.h"
%}

%option noyywrap
%option yylineno

ignorar " "|\t|\n
caracter [A-Za-z]
digito [0-9]
booleano "true"|"false"

%%
{ignorar}*		{;}
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
[<]stdio.h[>]		{return LIBRERIAS;}		
if			{return SI;}
else_if			{return SINO;}
else			{return NO;}
for			{return PARA;}
while			{return MIENTRAS;}
vacio			{return VOID;}
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
"=>"			{return ASIGNADOR;}
">"			{return MAYOR;}
"<"			{return MENOR;}
"=="			{return IGUAL;}
">="			{return MAYORIGUAL;}
"<="			{return MENORIGUAL;}
"!="			{return NOIGUAL;}
{digito}+		{return INTEGER;}
{digito}"."{digito}+	{return FLOAT;}
{caracter}		{return CHAR;}
{caracter}({caracter}|(digito))* {return ID;}
.			{printf("ERROR en linea: %d \n",yylineno);}


%%
yyerror(char * msg){
printf("%s\n",msg);
}

int main(void){

yyin=fopen("entrada.txt","rt");

if(yyin==NULL){
printf("no se pudo abrir el archivo");
}else{

if(!yyparse()&&!yylex()){
printf("\n se compilo correctamente\n");
}

}
fclose(yyin);
}


