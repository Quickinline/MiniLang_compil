%{
#include <stdio.h>
int yylex();
int yyerror(char *s);
%}

%token mc_if mc_begin mc_int mc_float mc_const mc_bool mc_pvg mc_aff mc_idf mc_vartype mc_verg mc_op 
%token mc_accopen mc_paropen mc_parclose mc_end mc_accclose mc_for mc_plus mc_moins mc_comp 


%%

Prog: InstDec Begin Inst End
;

Begin: mc_begin { printf("debut du programme ...\n"); }
;

End: mc_end { printf("fin du programme ... \n"); YYACCEPT; }
;

Inst: InstAff Inst | InstIf Inst | InstOp Inst | InstFor Inst | 
;

InstAff:  mc_idf  mc_aff Operation mc_pvg InstAff | 
;

InstDec :  mc_vartype InstOne InstDec | mc_vartype InstMult mc_pvg InstDec | InstConstAff InstDec |
;

InstOne :  mc_idf mc_pvg 
;

InstConstAff :  mc_const mc_vartype  mc_idf  mc_aff Value mc_pvg 
; 

InstMult : mc_idf mc_verg InstMult | mc_idf 
;

InstIf : mc_if mc_paropen Condition mc_parclose  mc_accopen Inst mc_accclose
;

InstFor : mc_for mc_paropen mc_idf mc_aff Value mc_verg Condition mc_verg Compteur mc_parclose mc_accopen Inst mc_accclose
;

Compteur :  InstOp | mc_idf Cret 
;

InstOp : mc_idf mc_aff Operation mc_pvg | mc_idf Cret
;

Condition : Operation mc_comp Operation
;

Operation : Variable mc_op Variable Operation | mc_op Variable Operation | Variable Cret | Variable |
;

Variable : Value | mc_idf
;

Value: mc_int | mc_float | mc_bool
;

Cret : mc_plus | mc_moins
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
