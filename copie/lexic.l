%{
#include "syntaxic.tab.h"
%}


chiffre       [0-9]
vide          [ \t\n]+
idf           [A-Z]([_]?[a-z0-9])*
BEGIN         "BEGIN"
END           "END" 
int           [-+]?([1-9][0-9]*|0)
float         [-+]?([1-9][0-9]*|0)\.[0-9]*[1-9]
bool          "TRUE"|"true"|"FALSE"|"false"
CONST         "CONST"
vartype       "INT"|"FLOAT"|"BOOL"
pvg           ";"
aff           "="
verg          ","
if            "IF"
for           "FOR"
paropen       "("
parclose      ")"
accopen       "{"
accclose      "}"
op            "+"|"-"|"/"|"*"|"%"
plus          "++"
moins         "--"
comp          "<"|">"|"=="|"<="|">="|"!="
comment       [{][^}]*[}]



%%

{vide}          
{vartype}       {return(mc_vartype);}
BEGIN		    {return(mc_begin);}
END		        {return(mc_end);}
{int}           {return(mc_int);}
{float}         {return(mc_float);}
{bool}          {return(mc_bool);}
CONST			{return(mc_const);}
{if}            {return(mc_if);}
{paropen}       {return(mc_paropen);}
{parclose}      {return(mc_parclose);}
{accopen}       {return(mc_accopen);}
{accclose}      {return(mc_accclose);}
{pvg}           {return(mc_pvg);}
{aff}           {return(mc_aff);}
{op}            {return(mc_op);}
{verg}          {return(mc_verg);}
{comp}          {return(mc_comp);}
{plus}          {return(mc_plus);}
{moins}         {return(mc_moins);}
{for}           {return(mc_for);}
{idf}           {return(mc_idf);}
{comment}       {printf("c'est un commentaire\n");}
.               {printf("erreur");}

%%
