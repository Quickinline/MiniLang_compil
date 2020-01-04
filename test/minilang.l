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

    // Définitions
varint "INT"|"int"
varfloat "FLOAT"|"float"
varbool "bool"|"BOOL"
const "CONST"|"const"
comment "{"[^}]*"}"

    // Déclarations des éléments du language
idf [A-Z]([_]?[a-z0-9])*.{1-11}
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
op "+"|"-"|"*"|"/"

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

%%