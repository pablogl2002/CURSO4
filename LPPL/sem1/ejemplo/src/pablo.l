/*******************************************************************/
/** SEMINARIO 1: PABLO GARCÍA LÓPEZ 4CO21 <pgarlop@etsinf.upv.es> **/
/*******************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"

#define  retornar(x) {if (verbosidad) ECHO; }
%}
/*-----------------------------------------------------------------------------
  Estas opciones evitan "warnings" innecesarios y permiten obtener el
  numero de linea actual en la variable global "yylineno".
-----------------------------------------------------------------------------*/
%option noinput       
%option nounput       
%option yylineno  

letra          [a-zA-Z]
delimitador    [ \t\n]+
digito         [0-9]
entero         {digito}+
id             {letra}({letra}|{digito}|['_'])*
bool           {'TRUE'|'FALSE'}


%%
{delimitador}  { if (verbosidad) ECHO; }
"+"	           { retornar (MAS_);      }
"-"            { retornar (MENOS_);    }
"*"            { retornar (POR_);      }
"/"            { retornar (DIV_);      }
"("            { retornar (APAR_);     }
")"            { retornar (CPAR_);     }
{entero}       { retornar (CTE_);      }
.	       { yyerror("Caracter desconocido"); }

%%
/*****************************************************************************/
