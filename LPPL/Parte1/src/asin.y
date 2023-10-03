/*****************************************************************************/
/** Ejemplo  S E M - 2                    2023-2024 <jmbenedi@prhlt.upv.es> **/
/*****************************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"
%}

%token  APAR_  CPAR_  MAS_  MENOS_  POR_  DIV_ STRUCT_
%token  CTE_ ID_ INT_ PUNCOM_ ACOR_ CCOR_ ALLA_ CLLA_ BOOL_ 
%token  RETURN_ COMA_ READ_ PRINT_

%%

programa      : listDecla
              ;

listDecla     : decla
              | listDecla decla
              ;

decla         : declaVar
              | declaFunc
              ;

declaVar      : tipoSimp ID_ PUNCOM_
              | tipoSimp ID_ ACOR_ CTE_ CCOR_ PUNCOM_
              | STRUCT_ ALLA_ listaCamp CLLA_ ID_ PUNCOM_
              ;

tipoSimp      : INT_
              | BOOL_
              ;

listaCamp     : tipoSimp ID_ PUNCOM_
              | listaCamp tipoSimp ID_ PUNCOM_
              ;

declaFunc     : tipoSimp ID_ APAR_ paramForm CPAR_ ALLA_ declaVarLocal listInst RETURN_ expre PUNCOM_ CLLA_
              ;

paramForm     : /* epsilon */
              | listParamForm
              ;

listParamForm : tipoSimp ID_
              | tipoSimp ID_ COMA_ listParamForm
              ;

declaVarLocal : /* epsilon */
              | declaVarLocal declaVar
              ;

listInst      : /* epsilon */
              | listInst inst
              ;

inst          : ALLA_ listInst CLLA_ 
              | instExpre
              | instEntSal
              | instSelec
              | instIter
              ;

instExp       : expre PUNCOM_
              | PUNCOM_
              ;

instEntSal    : READ_ APAR_ ID_ CPAR_ PUNCOM_
              | PRINT_ APAR_ expre CPAR_ PUNCOM_
              ;


%%
