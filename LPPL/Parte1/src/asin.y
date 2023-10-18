/*******************************************************************/
/** SEMINARIO 1: PABLO GARCÍA LÓPEZ 4CO21 <pgarlop@etsinf.upv.es> **/
/*******************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"
%}

%token  APAR_  CPAR_  MAS_  MENOS_  POR_  DIV_ STRUCT_
%token  CTE_ ID_ INT_ PUNCOM_ ACOR_ CCOR_ ALLA_ CLLA_ BOOL_ 
%token  RETURN_ COMA_ READ_ PRINT_ IF_ ELSE_ WHILE_ ASI_ PUNTO_
%token  TRUE_ FALSE_ AND_ OR_ IG_ DIF_ MAYOR_ MENOR_ MAYIG_ MENIG_
%token  NOT_ INC_ DEC_ FOR_

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

instExpre     : expre PUNCOM_
              | PUNCOM_
              ;

instEntSal    : READ_ APAR_ ID_ CPAR_ PUNCOM_
              | PRINT_ APAR_ expre CPAR_ PUNCOM_
              ;

instSelec     : IF_ APAR_ expre CPAR_ inst ELSE_ inst
              ;

instIter      : WHILE_ APAR_ expre CPAR_ inst
              ;

expre         : expreLogic
              | ID_ ASI_ expre
              | ID_ ACOR_ expre CCOR_ ASI_ expre
              | ID_ PUNTO_ ID_ ASI_ expre
              ;

expreLogic    : expreIgual
              | expreLogic opLogic expreIgual
              ;

expreIgual    : expreRel
              | expreIgual opIgual expreRel
              ;

expreRel      : expreAd
              | expreRel opRel expreAd
              ;

expreAd       : expreMul 
              | expreAd opAd expreMul
              ;

expreMul      : expreUna
              | expreMul opMul expreUna
              ;

expreUna      : expreSufi
              | opUna expreUna
              | opIncre ID_
              ;

expreSufi     : const
              | APAR_ expre CPAR_
              | ID_
              | ID_ opIncre
              | ID_ PUNTO_ ID_
              | ID_ ACOR_ expre CCOR_
              | ID_ APAR_ paramAct CPAR_
              ;

const         : CTE_
              | TRUE_
              | FALSE_
              ;

paramAct      : /* epsilon */
              | listParamAct
              ;

listParamAct  : expre
              | expre COMA_ listParamAct
              ;

opLogic       : AND_
              | OR_
              ;

opIgual       : IG_
              | DIF_
              ;
        
opRel         : MAYOR_
              | MENOR_
              | MAYIG_
              | MENIG_
              ;

opAd          : MAS_
              | MENOS_
              ;

opMul         : POR_
              | DIV_
              ;

opUna         : MAS_
              | MENOS_
              | NOT_
              ;

opIncre       : INC_
              | DEC_
              ;

%%
    