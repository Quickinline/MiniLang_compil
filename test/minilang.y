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
%token token_constant

%%

Prog: DecList token_begin InstList token_end;

DecList: Declaration DecList|Declaration | token_comment DecList | token_comment ;

Declaration: ConstIntDec | ConstFloatDec | ConstBoolDec | IntDec | FloatDec | BoolDec;

ConstIntDec: token_const token_varint MultiIdfInt token_semicolon;

ConstFloatDec: token_const token_varfloat MultiIdfFloat token_semicolon;

ConstBoolDec: token_const token_varbool MultiIdfBool token_semicolon;

IntDec: token_varint MultiIdfInt token_semicolon;
FloatDec: token_varfloat MultiIdfFloat token_semicolon;
BoolDec: token_varbool MultiIdfBool token_semicolon;

MultiIdfInt: token_idf token_vg MultiIdfInt | token_idf | token_idf token_affectation token_integer MultiIdfInt ;

MultiIdfFloat: token_idf token_vg MultiIdfFloat | token_idf | token_idf token_affectation token_integer MultiIdfFloat ;

MultiIdfBool: token_idf token_vg MultiIdfBool | token_idf | token_idf token_affectation token_integer MultiIdfBool ;


InstList: Instruction InstList | Instruction | token_comment InstList | token_comment;

Instruction: Boucle | Affectation | Condition;

Affectation: token_idf token_affectation Exp token_semicolon | Incrementation;

Incrementation: token_constant token_plus | token_constant token_minus;

Exp: token_idf token_op Exp | token_idf | ExpConst;

ExpConst: token_integer token_op ExpConst | token_float token_op ExpConst | token_bool token_op ExpConst 
|	token_bool 
|	token_constant;

Condition: token_if token_paropen ExpCond token_parclose token_curlopen InstList token_curlclose;

ExpCond: token_idf token_comp token_idf 
|	token_idf token_comp token_constant
|	token_idf token_comp token_bool
|	token_constant token_comp token_idf
|	token_bool token_comp token_idf
|	token_constant token_comp token_constant
|	token_bool;

Boucle: token_for token_paropen Affectation token_vg ExpCond token_vg Incrementation token_parclose token_curlopen InstList token_curlclose;









%%
int yyerror(char *msg) {
	printf("yyerror : %s\n",msg);
	return 0;
}

int main() {
	yyparse();
	return 0;
}

int yywrap(void){
	return 1;
}