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

letra           [a-zA-Z]
delimitador     [ \t\n]+
digito          [0-9]
entero          {digito}+
real            0.?{digito}*
id              {letra}({letra}|{digito}|['_'])*
bool            {'TRUE'|'FALSE'}
cte             {bool | entero | real}

%%
{delimitador}   { if (verbosidad) ECHO; }
"+"	            { retornar (MAS_);      }
"-"             { retornar (MENOS_);    }
"*"             { retornar (POR_);      }
"/"             { retornar (DIV_);      }
"("             { retornar (APAR_);     }
")"             { retornar (CPAR_);     }  
{entero}        { retornar (CTE_);      }

{id}            { retornar (ID_);       }
{real}          { retornar (DOUBLE_);   }
{bool}          { retornar (BOOL_);     }

"&&"            { retornar (AND_);      }
"||"            { retornar (OR_);       }
"=="            { retornar (IG_);       }
"!="            { retornar (DIF_);      }
">"             { retornar (MAYOR_);    }
"<"             { retornar (MENOR_);    }
">="            { retornar (MAYIG_);    }
"<="            { retornar (MENIG_);    }
"++"            { retornar (INC_);      }
"--"            { retornar (DEC_);      }
"!"             { retornar (NOT_);      }

"if"            { retornar (IF_);       }
"else"          { retornar (ELSE_);     }
"for"           { retornar (FOR_);      }
"while"         { retornar (WHILE_);    }

"read"          { retornar (READ_);     }
"print"         { retornar (PRINT_);    }
"return"        { retornar (RETURN_);   }

.	              { yyerror("Caracter desconocido"); }

%%
/*****************************************************************************/
