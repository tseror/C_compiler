/* Analyseur syntaxique pour Petit C */

%{
  open Ast
%}

/* Déclaration des tokens */

%token <string> INCLUDE
%token <string> IDENT
%token <int> INTEGER
%token BOOL BREAK CONTINUE ELSE FALSE FOR IF INT NULL RETURN SIZEOF TRUE VOID WHILE
%token EQ OR AND EQQ NEQ LT LEQ GT GEQ PLUS MINUS TIMES DIV MOD NOT AMPERSAND INC DEC
%token LBRACKET RBRACKET LSQ RSQ LP RP SEMICOLON COMMA
%token EOF

/* Priorités et associativités des tokens */


%right EQ
%left OR
%left AND
%left EQQ NEQ
%left LT LEQ GT GEQ
%left PLUS MINUS
%left TIMES DIV MOD
%right NOT INC DEC AMPERSAND
%nonassoc LSQ RSQ
%nonassoc RP
%nonassoc ELSE

/* Point d'entrée de la grammaire */
%start fichier

/* Type des valeurs renvoyées par l'analyseur syntaxique */
%type <Ast.fichier> fichier

%%

/* Déclaration des règles de grammaire */

fichier:
    | package_list = INCLUDE* function_list = decl_fct* EOF {(package_list, function_list)}
;

decl_fct:
    | t = type_ x = IDENT pl = separated_list(COMMA, param) b = bloc {(t, x, pl, b)}
;

type_:
    | VOID {Void}
    | INT {Int} 
    | BOOL {Bool} 
    | t = type_ TIMES {Star t}
;

param:
    | t = type_ x = IDENT {(t, x)}
;

expr:
    | i = INTEGER {Eint i} | TRUE {True} | FALSE {False} | NULL {Null}
    | x = IDENT {Eident x}
    | TIMES e = expr {Epointer e}
    | e1 = expr LSQ e2 = expr RSQ {Eget (e1, e2)}
    | e1 = expr EQ e2 = expr {Eassign (e1, e2)}
    | f = IDENT LP args = separated_list(COMMA, expr) RP {Ecall (f, args)}
    | INC e = expr | DEC e = expr | e = expr INC | e = expr DEC {e} (* Non implémenté *)
    | AMPERSAND e = expr {Eaddress e} | NOT e = expr {Enot e} | MINUS e = expr {Eneg e} | PLUS e = expr {Eplus e}
    | e1 = expr op = operateur e2 = expr {Ebinop (op, e1, e2)}
    | SIZEOF LP t = type_ RP {Esizeof t}
    | LP e = expr RP {e}
%inline operateur:
    | EQQ {Beqq} | NEQ {Bneq} | LT {Blt} | LEQ {Ble} | GT {Bgt} | GEQ {Bge}
    | PLUS {Badd} | MINUS {Bsub} | TIMES {Bmul} | DIV {Bdiv} | MOD {Bmod}
    | AND {Band} | OR {Bor}
;

instruction:
    | SEMICOLON {None}
    | e = expr SEMICOLON {Expr e}
    | IF LP e = expr RP instr = instruction {If (e, instr, None)}
    | IF LP e = expr RP if_instr = instruction ELSE else_instr = instruction {If (e, if_instr, else_instr)}
    | WHILE LP e = expr RP instr = instruction {While (e, instr)}
    | FOR LP d = decl_var? SEMICOLON e = expr? SEMICOLON el = separated_list(COMMA, expr) RP instr = instruction {For (d, e, el, instr)}
    | b = bloc {Bloc b}
    | RETURN e = expr? SEMICOLON {Return e}
    | BREAK SEMICOLON {Break}
    | CONTINUE SEMICOLON {Continue}
;

bloc:
    | LBRACKET instruction_list = decl_instruction* RBRACKET {instruction_list}
;

decl_instruction:
    | dinstr = instruction {Decl_instr dinstr}
    | dfct = decl_fct {Decl_fct dfct}
    | dvar = decl_var SEMICOLON {Decl_var dvar}
;

decl_var:
    | t = type_ var = IDENT {(t, var, None)}
    | t = type_ var = IDENT EQ e = expr {(t, var, Some e)}
;
