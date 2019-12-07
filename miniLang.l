%{
    // Définitions en language C

%}

    // les définitions des expressions régulières

    /*
    Définitions de la partie 
    "Liste Declarations" du language MiniLang
    qui inclut les déclarations du language Minilang
    */
    // les déclarations

dec "INT"|"FLOAT"|"BOOL"
const "CONST"

    // les Nombres
integer [-+]?([1-9][0-9]*|0)
float [-+]?([1-9][0-9]*|0)\.[0-9]*[1-9]
bool ("true"|"false"|"TRUE"|"FALSE")

    // Déclarations des éléments du language
idf [A-Z]([_]?[a-z0-9])*
affectation "="
semicolon ";"

    /*
    Définitions de la partie 
    "List Instructions" du language MiniLang
    qui inclut les instructions du language Minilang
    */

    // Affectation
op "+"|"-"|"*"|"/"
plus "++"
minus "--"

    // Condition if
if "if"
comp "=="|"<"|"<="|"<>"|">"|">="

    // For loop
for "for"

    // Common
paropen "("
parclose ")"
curlopen "{"
curlclose "}"

%%
    // Expression Réfulière { Action C}



%%