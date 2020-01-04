%{
    // Définitions en language C
    #include "scanner.h"
    extern YYSTYPES yylval;
    extern int nb_li;
    extern int nb_col;

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
const "CONST | const"
varint "INT"|"int"
varfloat "FLOAT"|"float"
varbool "bool"|"BOOL"
const_int "const int"|"CONST INT"
const_float "const float" | "CONST FLOAT"
comment "{"[^}]*"}"

    // Déclarations des éléments du language
idf [A-Z]([_]?[a-z0-9])*.{1-11}
semicolon ";"
arc "("
farc ")"
vg ","
plus "+""+"
minus "--"
begin "begin"|"BEGIN"
end "end"|"END"

    /*
    Définitions de la partie 
    "List Instructions" du language MiniLang
    qui inclut les instructions du language Minilang
    */

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
; {idf}           {if (yyleng <= 12 ){yylval.str=strdup(yytext);nb_col+=yyleng;return(IDF);} else{printf("Erreur le idf est trop long ( max 12 caracteres)\n");}}
{const_int}       return CONST_INT ;
{const}     return CONST;
{saut_ligne}    {nb_li++; }
{op}            { +=yyleng;return(OP);}
{begin}         {nb_col+=yyleng;return(BEGIN);}
{end}           {nb_col+=yyleng;return(END);}
{varint}        return VARINT;
{varfloat}      return VARFLOAT;
{varbool}       return VARBOOL;
{integer}       {yylval.entier=atoi(yytext);nb_col+=yyleng;return(INTEGER);}
{float}         {yylval.reel=atof(yytext);nb_col+=yyleng;return(FLOAT);}
{bool}          {yylval.bool=strdup(yytext);nb_col+=yyleng;return(BOOL);} 
{if}            {nb_col+=yyleng;return(IF);}
{for}           {nb_col+=yyleng;return(FOR);}
{semicolon}     {return SEMICOLON;}
{arc}           {nb_col+=yyleng;return(ARC);}
{farc}          {nb_col+=yyleng;return(FARC);}
{vg}            {nb_col+=yyleng;return(VG);}
{plus}          {nb_col+=yyleng;return(PLUS);}
{minus}         {nb_col+=yyleng;return(MINUS);}
{paropen}       {return(PAROPEN);}
{parclose}      {nb_col+=yyleng;return(PARCLOSE);}
{curlopen}      {nb_col+=yyleng;return(CURLOPEN);}
{curlclose}     {nb_col+=yyleng;return(CURLCLOSE);}
{comment}       {nb_li+=linecount(yytext);}
{saut_ligne}    {nb_li++;nb_col = 0 ;}



int yywrap(void)
{
    return 1;
}



%%