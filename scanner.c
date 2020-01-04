#include <stdio.h>
#include "miniLang.h"
extern YYSTYPE yylval;
extern int nb_ligne yylineno;
extern int yylex();
extern char* yytext;
char* names[] = {NULL,"IDF","CONST_INT","CONST_FLOAT","OP","BEGIN","END","VARINT","VARFLOAT","VARBOOL","INT","FLOAT","BOOL","IF","FOR","DEBUT","FIN","AFFECTATION","SEMICOLON","ARC","FARC","VG","PVG","PLUS","MINUS","PAROPEN","PARCLOSE","CURLOPEN","CURLCLOSE"}


int main(void){
	int ntoken,vtoken;
	ntoken=yylex();
	while(ntoken){
		printf("%d\n",ntoken);
		ntoken=yylex();
	}
	return 0;
}