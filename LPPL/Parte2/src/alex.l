/*******************************************************************/
/** SEMINARIO 1: PABLO GARCÍA LÓPEZ 4CO21 <pgarlop@etsinf.upv.es> **/
/*******************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"
#include "asin.h"

#define  retornar(x) {if (verbosidad) ECHO; return(x); }
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
id              [_a-zA-Z][_a-zA-Z0-9]*
cte             {entero}|{digito}*"."{digito}+|{digito}+"."{digito}*
comentario      \/\/.*\n

%%
{delimitador}   { if (verbosidad) ECHO; }
{comentario}    { if (verbosidad) ECHO; }
"++"            { retornar (INC_);      }
"+"	            { retornar (MAS_);      }
"--"            { retornar (DEC_);      }
"-"             { retornar (MENOS_);    }
"*"             { retornar (POR_);      }
"/"             { retornar (DIV_);      }
"("             { retornar (APAR_);     }
")"             { retornar (CPAR_);     }  
"["             { retornar (ACOR_);     }
"]"             { retornar (CCOR_);     }
"{"             { retornar (ALLA_);     }
"}"             { retornar (CLLA_);     }

{cte}           { retornar (CTE_);      }

"=="            { retornar (IG_);       }
"="             { retornar (ASI_);      }
"&&"            { retornar (AND_);      }
"||"            { retornar (OR_);       }
"!="            { retornar (DIF_);      }
"<="            { retornar (MENIG_);    }
">="            { retornar (MAYIG_);    }
">"             { retornar (MAYOR_);    }
"<"             { retornar (MENOR_);    }
"!"             { retornar (NOT_);      }
";"             { retornar (PUNCOM_);   }
","             { retornar (COMA_);     }
"."             { retornar (PUNTO_);    }

int             { retornar (INT_);      }
if              { retornar (IF_);       }
else            { retornar (ELSE_);     }
for             { retornar (FOR_);      }
while           { retornar (WHILE_);    }
struct          { retornar (STRUCT_);   }
true            { retornar (TRUE_);     }
false           { retornar (FALSE_);    }
read            { retornar (READ_);     }
print           { retornar (PRINT_);    }
return          { retornar (RETURN_);   }
bool            { retornar (BOOL_);     }

{id}            { retornar (ID_);       }

.	              { yyerror("Caracter desconocido"); }

%%
/*****************************************************************************/
