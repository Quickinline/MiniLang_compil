%{
#include <stdio.h>
#include<stdlib.h>
int nbrligne=1;
int yylex();
void yyerror(const char *s);
%}

%union {
int     entier;
float reel;
char*   str;
}

// Token definitions
%token <entier>token_integer
%token <reel>token_float
%token <str>token_bool
%token <str>token_varint
%token <str>token_varfloat
%token <str>token_varbool
%token <str>token_const
%token <str>token_comment
%token <str>token_idf
%token <str>token_affectation
%token <str>token_semicolon
%token <str>token_vg
%token <str>token_plus
%token <str>token_minus
%token <str>token_begin
%token <str>token_end
%token <str>token_if
%token <str>token_comp
%token <str>token_for
%token <str>token_paropen
%token <str>token_parclose
%token <str>token_curlopen
%token <str>token_curlclose
%token token_add
%token token_sub
%token token_mult
%token token_div
%token token_and
%token token_or


%start Prog
%%

Prog: DecList token_begin InstList token_end {YYACCEPT;}| token_begin token_end | {printf("\nprogramme vide");};

DecList: Declaration DecList|Declaration | token_comment DecList | token_comment ;

Declaration: ConstIntDec | ConstFloatDec | ConstBoolDec | IntDec | FloatDec | BoolDec;

ConstIntDec: token_const token_varint MultiIdfInt token_semicolon;

ConstFloatDec: token_const token_varfloat MultiIdfFloat token_semicolon;

ConstBoolDec: token_const token_varbool MultiIdfBool token_semicolon;

IntDec: token_varint MultiIdfInt token_semicolon;
FloatDec: token_varfloat MultiIdfFloat token_semicolon;
BoolDec: token_varbool MultiIdfBool token_semicolon;

MultiIdfInt: token_idf token_vg MultiIdfInt | token_idf | token_idf token_affectation token_integer MultiIdfInt
|	token_idf token_affectation token_integer;

MultiIdfFloat: token_idf token_vg MultiIdfFloat | token_idf | token_idf token_affectation token_float MultiIdfFloat
|	token_idf token_affectation token_float;

MultiIdfBool: token_idf token_vg MultiIdfBool | token_idf | token_idf token_affectation token_bool MultiIdfBool
|	token_idf token_affectation token_bool;


InstList: Instruction InstList | Instruction | token_comment InstList | token_comment;

Instruction: Boucle | Affectation | Condition;

Affectation: token_idf token_affectation Exp token_semicolon | Incrementation;

Incrementation: token_idf token_plus | token_idf token_minus;

OP: token_add | token_sub | token_div | token_mult | token_and | token_or;

Exp: token_idf OP Exp | token_idf | ExpConst;

ExpConst: token_integer OP ExpConst | token_float OP ExpConst | token_bool OP ExpConst 
|	token_bool 
|	token_float;
|	token_integer;


Condition: token_if token_paropen ExpCond token_parclose token_curlopen InstList token_curlclose;

ExpCond: token_idf token_comp token_idf 
|	token_idf token_comp token_integer
|	token_idf token_comp token_float
|	token_idf token_comp token_bool
|	token_integer token_comp token_idf
|	token_float token_comp token_idf
|	token_bool token_comp token_idf
|	token_integer token_comp token_integer
|	token_float token_comp token_float
|	token_bool token_comp token_bool
|	token_bool;

Boucle: token_for token_paropen Affectation token_vg ExpCond token_vg Incrementation token_parclose token_curlopen InstList token_curlclose;









%%

#include"lex.yy.c"
int main() {
	yyparse();
	return yylex();
}

void yyerror(const char *s){ printf("\nERROR %d\n",nbrligne); }
int yywrap(){ return 1; }

// int yywrap(void){
// 	return 1;
// }