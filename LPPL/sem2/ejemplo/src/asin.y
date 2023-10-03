/*****************************************************************************/
/** Ejemplo  S E M - 2                    2023-2024 <jmbenedi@prhlt.upv.es> **/
/*****************************************************************************/
%{
#include <stdio.h>
#include <string.h>
#include "header.h"
%}

%token  APAR_  CPAR_  MAS_  MENOS_  POR_  DIV_
%token  CTE_ 

%%

programa      : listDecla
              ;

listDecla     : decla
              | listDecla decla
              ;

decla         : declaVar
              | declaFunc
              ;

expMat : exp
       ;
exp    : exp  MAS_    term
       | exp  MENOS_  term
       | term         
       ;
term   : term  POR_  fac
       | term  DIV_  fac   
       | fac             
       ;
fac    : APAR_  exp  CPAR_ 
       | CTE_            
       ;
%%
