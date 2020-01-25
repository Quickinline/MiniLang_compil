%{
#include <stdio.h>
#include "minilang.tab.h"
int yylex();
int yyerror(char *s);
%}

// Token definitions
%token token_chiffre
%token token_vide
%token token_saut_ligne
%token token_integer
%token token_float
%token token_bool
%token token_varint
%token token_varfloat
%token token_varbool
%token token_const
%token token_comment
%token token_idf
%token token_affectation
%token token_semicolon
%token token_vg
%token token_plus
%token token_minus
%token token_begin
%token token_end
%token token_op
%token token_if
%token token_comp
%token token_for
%token token_paropen
%token token_parclose
%token token_curlopen
%token token_curlclose


%%
Cret : token_plus | token_minus

Declaration: token_const token_varint token_idf token_semicolon
|	token_varint token_idf token_semicolon
|	token_varfloat token_idf token_semicolon
|	token_const token_varfloat token_idf token_semicolon


;

%%
int yyerror(char *msg) {
	printf("yyerror : %s\n",msg);
	return 0;
}

int main() {
	yyparse();
	return 0;
}

int yywrap(){}