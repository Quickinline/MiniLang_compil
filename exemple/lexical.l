%{
#include "syntaxique.tab.h"
extern YYSTYPE yylval;
extern int nb_ligne;
extern int nb_colonne;
extern int linecount(char comment[]);
%}
chiffre[0-9]
cst [1-9][0-9]*|0
vide [ \t]+
saut_ligne [\n]
idf [A-Z]([_]?[a-z0-9])*
int [-]?([1-9][0-9]*|0)
float [-]?([1-9][0-9]*|0)\.([0-9]*[1-9])
bool       "FALSE"|"TRUE" 
varint        "INT"|"int"
varfloat      "FLOAT"|"float"
varbool       "BOOL"|"bool"
const_int "const int"|"CONST INT"
const_float "const float"|"CONST FLOAT"
op "*"|"+"|"-"|"/"|"%"
rat "<"|"<="|"<>"|"=="|">"|">="|"!="
incr "++"
decr "--"
arc "("
farc ")"
aff "="	
vg ","
pvg ";"
debut "{"
fin "}"
if "if"|"IF"|"If"
for "for"|"FOR"
begin "begin"|"BEGIN"
end "end"|"END"
comment       "//"(.|\n)*"//"


%%
{idf}           {if (yyleng <= 12 ){yylval.str=strdup(yytext);nb_colonne+=yyleng;return(mc_idf);} else{printf("Erreur le idf est trop long ( max 12 caracteres)\n");}}
{const_float} return const_float;
{const_int} return const_int;
{vide}
{begin}		    {nb_colonne+=yyleng;return(mc_begin);}
{end}	        {nb_colonne+=yyleng;return(mc_end);}
{varint}        {yylval.type=strdup(yytext);nb_colonne+=yyleng;return(mc_varint);}
{varfloat}      {yylval.type=strdup(yytext);nb_colonne+=yyleng;return(mc_varfloat);}
{varbool}      	{yylval.type=strdup(yytext);nb_colonne+=yyleng;return(mc_varbool);}
{int}           {yylval.entier=atoi(yytext);nb_colonne+=yyleng;return(mc_int);}
{float}         {yylval.reel=atof(yytext);nb_colonne+=yyleng;return(mc_float);}
{bool}         	{yylval.bool=strdup(yytext);nb_colonne+=yyleng;return(mc_bool);}       
{if}              {nb_colonne+=yyleng;return(mc_if);}
{for}             {nb_colonne+=yyleng;return(mc_for);}
{rat} {nb_colonne+=yyleng;return mc_rat;}
{op} {nb_colonne+=yyleng;return mc_op;}
"div" {nb_colonne+=yyleng;return mc_div;}
{pvg} {nb_colonne+=yyleng;return pvg;}
{vg} {nb_colonne+=yyleng;return vg;}
{arc} {nb_colonne+=yyleng;return arc;}
{farc} {nb_colonne+=yyleng;return farc;}
{debut} {nb_colonne+=yyleng;return debut;}
{fin} {nb_colonne+=yyleng;return fin;}
{incr} {nb_colonne+=yyleng;return incr;}
{decr} {nb_colonne+=yyleng;return decr;}
{aff} {nb_colonne+=yyleng;return aff;}
{comment}       {nb_ligne+=linecount(yytext);}
{saut_ligne} {nb_ligne++; nb_colonne = 0;}

.
%%