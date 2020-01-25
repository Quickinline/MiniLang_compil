%{
#include <stdio.h>
#include <string.h>
#include "programc.h"

int yylex();
int yyerror(char *s);
char suavType [20];
int nb_ligne = 1;
int nb_colonne = 1;
float test;
char value [100] ;

%}

// DÉCLARATION DE YYSTYPE 
%union {
int entier; 
float reel; 
char* str; 
char oper; 
char* type;
char* idf;
char symbol;
char* bool;
}

// LISTE DES TERMINAUX
%token  var <entier>mc_int <reel>mc_float <oper>mc_div 
<bool>mc_bool <type>mc_varbool <idf>mc_idf <const>mc_const <type>mc_varint <type>mc_varfloat mc_begin mc_for mc_if mc_end mc_rat <oper>mc_op <symbol>pvg <symbol>vg <symbol>aff debut fin arc farc incr decr const_int const_float

%%
// LISTE DES NON-TERMINAUX
/* LE PROGRAMME DOIT RESPECTER LA SYNTAXIQUE SUIVANTE:
	LISTE DÉCLARATION
	BEGIN
	LISTE D'INSTRUCTION
	END
*/

prog: LISTEDEC mc_begin {printf("Debut du programme...\n");} LIST_INST mc_end {
 printf("FIN DU PROGRAMME\n Programme syntaxiquement correcte!  \n "); YYACCEPT; }
;

TYPEVAR: mc_varfloat {strcpy(suavType,$1)} | mc_varint {strcpy(suavType,$1)} | mc_varbool {strcpy(suavType,$1)}
;
// LE CAS D'UNE DÉCLARATION DE PLUSIEURS VARIABLES: int a,b...
VG: vg Idf VG |
;
// LE CAS D'UNE DÉCLARATION DE PLUSIEURS CONSTANTE: const int a=6,b=6...
VGCONST : vg Idf aff CONST VG|
;
// ROUTINE SÉMANTIQUE: l'existance d'un idf
Idf: mc_idf 
{if (recherche($1) != -1){printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d , l'idf %s existe déjà\n",nb_ligne,nb_colonne,$1);}else { inserer($1,"idf",suavType,"non") ;} } 
;
// ROUTINE SÉMANTIQUE: traitement d'une constante double déclaration/mauvaise affectation
IDFConst: const_int  mc_idf
{
 	if (recherche($2) != -1)
 	{
 		printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d , l'idf %s existe déjà\n",nb_ligne,nb_colonne,$2);
 	}
 	else { inserer($2,"idf","CONST INT","oui") ;
 	} } 
 | const_float mc_idf
{
 	if (recherche($2) != -1)
 	{
 		printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d , l'idf %s existe déjà\n",nb_ligne,nb_colonne,$2);
 	}
 	else { inserer($2,"idf","CONST FLOAT","oui") ;
 	} } 
 ;

// LISTE DE DÉCLARATION
LISTEDEC: TYPEVAR Idf VG pvg LISTEDEC |
IDFConst aff CONST VGCONST pvg LISTEDEC |
;

// LISTE DES CONSTANTES
CONST: mc_float{ test=$1; strcpy(value,"FLOAT");}|mc_int{ test=$1;strcpy(value,"INT");}|mc_bool{strcpy(value,"BOOL");}|mc_idf|
; 
 
// OPÉRATION ARITHMÉTIQUE
EXPARITH:CONST mc_op EXPARITH | CONST |arc EXPARITH farc|
CONST mc_op mc_idf EXPARITH | mc_idf mc_op CONST EXPARITH
 { 
   if (recherche($1) == -1){
       printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d, la variable %s n'est pas déclarée\n",nb_ligne,nb_colonne,$1);
   } }
   | CONST mc_div mc_int {if($3 == 0){printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d, division sur 0\n",nb_ligne,nb_colonne);}}
;


// AFFECTATION / ROUNTIQUE SÉMANTIQUE: DOUBLE DÉCLARATION/MAUVAISE AFFECTATION
AFFEC:mc_idf aff EXPARITH pvg  
{ 
   if (recherche($1) == -1){
       printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d, la variable %s n'est pas déclarée\n",nb_ligne,nb_colonne,$1);
   }
   else
   {
         if (verifConst($1) == 1){printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d, changement de la constante %s\n",nb_ligne,nb_colonne,$1); }
    }

   if (strcmp(typeIDF($1),"INT") == 0 && strcmp(value,"INT") != 0 ){printf("ERREUR dans la ligne %d colonne %d, Type d'affectation incorrect (entier attendue)\n",nb_ligne,nb_colonne);} 
   if (strcmp ( typeIDF($1) ,"BOOL")  == 0 && strcmp(value,"BOOL") != 0 ){printf("ERREUR dans la ligne %d colonne %d, Type d'affectation incorrect (boolean attendue)\n",nb_ligne,nb_colonne);} 
  if(strcmp(typeIDF($1),value)!=0) { printf("ERREUR SÉMANTIQUE: INCOMPATIBILITÉ DE TYPE (%s attendue)  dans la ligne %d colonne %d\n",typeIDF($1),nb_ligne,nb_colonne);}  
   if (strcmp(typeIDF($1),"FLOAT") == 0 && strcmp(value,"BOOL") == 0 ){printf("ERREUR dans la ligne %d colonne %d, Type d'affectation incorrect (entier ou reel attendue)\n",nb_ligne,nb_colonne);}  

}
| mc_idf aff mc_idf pvg {
if(strcmp(typeIDF($1),typeIDF($3))!=0) {
   printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d, Type d'affectation incorrect (%s attendue)\n",nb_ligne,nb_colonne,typeIDF($1)); } 
   }
   
| const_int mc_idf aff mc_int VGCONST pvg
{
 	if (recherche($2) != -1)
 	{
 		printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d , l'idf %s existe déjà\n",nb_ligne,nb_colonne,$2);
 	}
 	else if ( strcmp(suavType,value) != 0 ) {
 	   if (recherche($2) == -1) printf("ERREUR SÉMANTIQUE: variable non déclarée\n");  
           printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d,Mauvaise affectation de la constante ( %s attendue )\n",nb_ligne,nb_colonne,suavType);
 	}
 	else { inserer($2,"idf","CONST INT","oui") ;} }  
LISTEDEC |
const_float mc_idf aff mc_float VGCONST pvg LISTEDEC 
{
 	if (recherche($2) != -1)
 	{
 		printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d , l'idf %s existe déjà\n",nb_ligne,nb_colonne,$2);
 	}
 	else if ( strcmp(suavType,value) != 0 ) {
           printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d,mauvaise affectation de la constante ( %s attendue )\n",nb_ligne,nb_colonne,suavType);
 	}
 	else { inserer($2,"idf","CONST FLOAT","oui") ;} }
;


AFFECOND:mc_idf aff EXPARITH 
{   if (recherche($1) == -1)
       printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d, la variable %s n'est pas déclarée\n",nb_ligne,nb_colonne,$1);
}
;

LIST_INST: AFFEC LIST_INST | InstIF LIST_INST | InstFOR LIST_INST |
;
InstIF: mc_if arc CONDITION farc debut LIST_INST fin 
;
InstFOR: mc_for arc AFFECOND vg CONDITION vg Compteur farc debut LIST_INST fin 
;
CONDITION:CONST mc_rat CONST | mc_bool | EXPARITH mc_rat EXPARITH
;
Compteur: mc_idf incr| mc_idf decr
{   if (recherche($1) == -1)
       printf("ERREUR SÉMANTIQUE dans la ligne %d colonne %d, la variable %s n'est pas déclarée\n",nb_ligne,nb_colonne,$1);
}
;
%%

int yyerror(char *msg) {
	printf("ERREUR syntaxique a la ligne %d colonne %d\n",nb_ligne,nb_colonne);
	return 0;
}

int main() {
	yyparse();
	afficher();
	return 0;
}


