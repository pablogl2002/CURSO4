/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ASIN_H_INCLUDED
# define YY_YY_ASIN_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    APAR_ = 258,                   /* APAR_  */
    CPAR_ = 259,                   /* CPAR_  */
    MAS_ = 260,                    /* MAS_  */
    MENOS_ = 261,                  /* MENOS_  */
    POR_ = 262,                    /* POR_  */
    DIV_ = 263,                    /* DIV_  */
    STRUCT_ = 264,                 /* STRUCT_  */
    CTE_ = 265,                    /* CTE_  */
    ID_ = 266,                     /* ID_  */
    INT_ = 267,                    /* INT_  */
    PUNCOM_ = 268,                 /* PUNCOM_  */
    ACOR_ = 269,                   /* ACOR_  */
    CCOR_ = 270,                   /* CCOR_  */
    ALLA_ = 271,                   /* ALLA_  */
    CLLA_ = 272,                   /* CLLA_  */
    BOOL_ = 273,                   /* BOOL_  */
    RETURN_ = 274,                 /* RETURN_  */
    COMA_ = 275,                   /* COMA_  */
    READ_ = 276,                   /* READ_  */
    PRINT_ = 277,                  /* PRINT_  */
    IF_ = 278,                     /* IF_  */
    ELSE_ = 279,                   /* ELSE_  */
    WHILE_ = 280,                  /* WHILE_  */
    ASI_ = 281,                    /* ASI_  */
    PUNTO_ = 282,                  /* PUNTO_  */
    TRUE_ = 283,                   /* TRUE_  */
    FALSE_ = 284,                  /* FALSE_  */
    AND_ = 285,                    /* AND_  */
    OR_ = 286,                     /* OR_  */
    IG_ = 287,                     /* IG_  */
    DIF_ = 288,                    /* DIF_  */
    MAYOR_ = 289,                  /* MAYOR_  */
    MENOR_ = 290,                  /* MENOR_  */
    MAYIG_ = 291,                  /* MAYIG_  */
    MENIG_ = 292,                  /* MENIG_  */
    NOT_ = 293,                    /* NOT_  */
    INC_ = 294,                    /* INC_  */
    DEC_ = 295,                    /* DEC_  */
    FOR_ = 296                     /* FOR_  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_ASIN_H_INCLUDED  */
