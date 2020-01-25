%{
    // Définitions en language C
#include "minilang.tab.h"
%}

    // les définitions des expressions régulières

    /*
    Définitions de la partie 
    "Liste Declarations" du language MiniLang
    qui inclut les déclarations du language Minilang
    */

chiffre [0-9]
vide [ \t]+
saut_ligne [\n]

    // les Nombres (valeurs)
integer [- | +]?([1-9][0-9]*|0)
float [- | +]?([1-9][0-9]*|0)\.[0-9]*[1-9]
bool ("true"|"false"|"TRUE"|"FALSE")
constant integer | float;

    // Définitions
varint "INT"|"int"
varfloat "FLOAT"|"float"
varbool "bool"|"BOOL"
const "CONST"|"const"
comment "{"[^}]*"}"

    // Déclarations des éléments du language

    // IDF à revoir
idf ([A-Z]([_]?[a-z0-9])*){1,11}
affectation "="
semicolon ";"
vg ","
plus "++"
minus "--"
begin "begin"|"BEGIN"
end "end"|"END"

    /*
    Définitions de la partie 
    "List Instructions" du language MiniLang
    qui inclut les instructions du language Minilang
    */

    // Affectation
op "+"|"-"|"*"|"/"|"&&"|"||"

    // Condition if
if "if"|"IF"|"If"
comp "=="|"<"|"<="|"<>"|">"|">="

    // For loop
for "for"|"FOR"

    // Common
paropen "("
parclose ")"
curlopen "{"
curlclose "}"

%%
    // Expression Réfulière { Action C}
{chiffre} {return token_chiffre;}
{vide} {return token_vide;}
{saut_ligne} {return token_saut_ligne;}
{integer} { yylval = atoi(yytext); return token_integer;}
{float} {return token_float;}
{bool} {return token_bool;}
{varint} {return token_varint;}
{varfloat} {return token_varfloat;}
{varbool} {return token_varbool;}
{const} {return token_const;}
{comment} {return token_comment;}

{idf} {return token_idf;}

{affectation} {return token_affectation;}
{semicolon} {return token_semicolon;}
{vg} {return token_vg;}
{plus} {return token_plus;}
{minus} {return token_minus;}
{begin} {return token_begin;}
{end} {return token_end;}
{op} {return token_op;}
{if} {return token_if;}
{comp} {return token_comp;}
{for} {return token_for;}
{paropen} {return token_paropen;}
{parclose} {return token_parclose;}
{curlopen} {return token_curlopen;}
{curlclose} {return token_curlclose;}
{constant} {return token_constant;}
%%