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
chiffre [0-9]
cst [1-9][0-9]*|0
vide [ \t]+
saut_ligne [\n]

    // les Nombres
integer [- | +]?([1-9][0-9]*|0)
float [- | +]?([1-9][0-9]*|0)\.[0-9]*[1-9]
bool ("true"|"false"|"TRUE"|"FALSE")
varint "INT" | "int"
varfloat "FLOAT" | "float"
varbool "bool" | "BOOL"
const_int "const int"|"CONST INT"
const_float "const float" | "CONST FLOAT"
comment "{"[^}]*"}"

    // Déclarations des éléments du language
idf [A-Z]([_]?[a-z0-9])*.{1-11}
affectation "="
semicolon ";"
arc "("
farc ")"
vg ","
debut "{"
fin "}"
plus "++"
minus "--"
if "if"|"IF"|"If"
for "for"|"FOR"
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