%{
    // Définitions en language C
    #include"minilang.tab.h"
    extern YYSTYPE yylval;
    extern int nbrligne;
    extern int nbrcol;
%}

    // les définitions des expressions régulières

    /*
    Définitions de la partie 
    "Liste Declarations" du language MiniLang
    qui inclut les déclarations du language Minilang
    */

chiffre [0-9]
vide [ \t]+
saut_ligne [\n]+

    // les Nombres (valeurs)
integer ([1-9][0-9]*|0){1,11}
float ([1-9][0-9]*|0)\.[0-9]*[1-9]
bool "true"|"false"|"TRUE"|"FALSE"
    // Définitions
varint "INT"|"int"
varfloat "FLOAT"|"float"
varbool "bool"|"BOOL"
const "CONST"|"const"


    // Déclarations des éléments du language

    // IDF à revoir
comp "=="|"<"|"<="|"<>"|">"|">="
affectation "="
semicolon ";"
vg ","
plus "++"
minus "--"
beginmc "begin"|"BEGIN"
end "end"|"END"

    /*
    Définitions de la partie 
    "List Instructions" du language MiniLang
    qui inclut les instructions du language Minilang
    */

    // Affectation
op "+"|"-"|"*"|"/"|"&&"|"\|\|"

    // Condition if
if "if"|"IF"|"If"

    // For loop
for "for"|"FOR"

    // Common
paropen "\("
parclose "\)"
curlopen "\{"
curlclose "\}"
Ac "{"
idf ([A-Z]([_]?[a-z0-9])*){1,11}
comment "*{"[^}]*"}*"

%%
    // Expression Régulière { Action C}
{vide} {nbrcol+=yyleng;}
{saut_ligne} {nbrligne++;nbrcol=0;}
{integer} {nbrcol+=yyleng; yylval.entier = atoi(yytext);return token_integer;}
{float} { nbrcol+=yyleng; yylval.reel = atof(yytext); return token_float;}
{bool} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_bool;}
{varint} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_varint;}
{varfloat} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_varfloat;}
{varbool} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_varbool;}
{const} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_const;}
{comment} { nbrcol+=yyleng; }

{idf} { nbrcol+=yyleng; if(yyleng <= 12){yylval.entier = atoi(yytext);return token_idf;}else{printf("\nErreur IDF trop long\n");}}

{affectation} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_affectation;}
{semicolon} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_semicolon;}
{vg} { nbrcol+=yyleng; yylval.str=strdup(yytext);  return token_vg;}
{plus} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_plus;}
{minus} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_minus;}
{beginmc} { nbrcol+=yyleng; yylval.str=strdup(yytext);return token_begin;}
{end} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_end;}
{Ac} { nbrcol+=yyleng; return token_curlopen;}
{if} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_if;}
{comp} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_comp;}
{for} { nbrcol+=yyleng; yylval.str=strdup(yytext); return token_for;}
"+" {nbrcol+=yyleng; return token_add;}
"-" {nbrcol+=yyleng; return token_sub;}
"*" {nbrcol+=yyleng; return token_mult;}
"/" {nbrcol+=yyleng; return token_div;}
"&&" {nbrcol+=yyleng; return token_and;}
"||" {nbrcol+=yyleng; return token_or;}
"(" {nbrcol+=yyleng; return token_paropen;}
")" {nbrcol+=yyleng; return token_parclose;}
"}" {nbrcol+=yyleng; return token_curlclose;}

. {printf("\nErreur lexicale a la ligne %d et la colonne %d ",nbrligne, nbrcol);}
%%