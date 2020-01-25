%{
    // Définitions en language C
    #include"minilang.tab.h"
    extern YYSTYPE yylval;
    extern int nbrligne;
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
integer ([1-9][0-9]*|0)
float ([1-9][0-9]*|0)\.[0-9]*[1-9]
bool "true"|"false"|"TRUE"|"FALSE"
    // Définitions
varint "INT"|"int"
varfloat "FLOAT"|"float"
varbool "bool"|"BOOL"
const "CONST"|"const"


    // Déclarations des éléments du language

    // IDF à revoir

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
comp "=="|"<"|"<="|"<>"|">"|">="

    // For loop
for "for"|"FOR"

    // Common
paropen "("
parclose ")"
curlopen "{"
curlclose "}"

idf ([A-Z]([_]?[a-z0-9])*){1,11}
comment "{"[^}]*"}"

%%
    // Expression Régulière { Action C}
{vide}
{saut_ligne} {nbrligne++;}
{integer} { yylval.entier = atoi(yytext); return token_integer;}
{float} { yylval.reel = atof(yytext); return token_float;}
{bool} { yylval.str=strdup(yytext); return token_bool;}
{varint} { yylval.str=strdup(yytext); return token_varint;}
{varfloat} { yylval.str=strdup(yytext); return token_varfloat;}
{varbool} { yylval.str=strdup(yytext); return token_varbool;}
{const} { yylval.str=strdup(yytext); return token_const;}
{comment} { yylval.str=strdup(yytext); return token_comment;}

{idf} { yylval.str=strdup(yytext); return token_idf;}

{affectation} { yylval.str=strdup(yytext); return token_affectation;}
{semicolon} { yylval.str=strdup(yytext); return token_semicolon;}
{vg} { yylval.str=strdup(yytext);  return token_vg;}
{plus} { yylval.str=strdup(yytext); return token_plus;}
{minus} { yylval.str=strdup(yytext); return token_minus;}
{beginmc} {yylval.str=strdup(yytext);return token_begin;}
{end} { yylval.str=strdup(yytext); return token_end;}
"\+" {return token_add;}
"\-" {return token_sub;}
"\*" {return token_mult;}
"/" {return token_div;}
"&&" {return token_and;}
"\|\|" {return token_or;}
{if} { yylval.str=strdup(yytext); return token_if;}
{comp} { yylval.str=strdup(yytext); return token_comp;}
{for} { yylval.str=strdup(yytext); return token_for;}
{paropen} { yylval.str=strdup(yytext); return token_paropen;}
{parclose} { yylval.str=strdup(yytext); return token_parclose;}
{curlopen} { yylval.str=strdup(yytext); return token_curlopen;}
{curlclose} { yylval.str=strdup(yytext); return token_curlclose;}
. {printf("\nErreur lexicale a la ligne %d ",nbrligne);}
%%