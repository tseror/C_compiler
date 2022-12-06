(* Syntaxe abstraite pour Petit C *)

type include_ = string
type ident = string
type localisation = Lexing.position * Lexing.position

type ctype = Void | Int | Bool | Star of ctype

type param = ctype * ident

type binop =
  | Badd | Bsub | Bmul | Bdiv | Bmod    (* + - * / % *)
  | Beqq | Bneq | Blt | Ble | Bgt | Bge  (* == != < <= > >= *)
  | Band | Bor                          (* && || *)

type expr =
  {desc_e: desc_e;
   loc : localisation}
and desc_e =
  | Eint of int | True | False | Null
  | Eident of ident
  | Epointer of expr
  | Eassign of expr * expr
  | Ecall of ident * expr list
  | Einc1 of expr | Edec1 of expr | Einc2 of expr | Edec2 of expr
  | Eaddress of expr
  | Enot of expr
  | Eneg of expr
  | Eplus of expr
  | Ebinop of binop * expr * expr
  | Esizeof of ctype

type decl_var =
  {desc_dv: desc_dv;
   loc : Lexing.position * Lexing.position}
and desc_dv = ctype * ident * expr option

type instruction = 
  | None
  | Expr of expr 
  | Bloc of bloc
  | If of expr * instruction * instruction
  | While of expr * instruction
  | For of decl_var option * expr option * expr list * instruction
  | Return of expr option * localisation
  | Break of localisation
  | Continue of localisation
and decl_instr = 
| Decl_var of decl_var 
| Decl_fct of decl_fct
| Decl_instr of instruction
and decl_fct = 
  {desc_df: desc_df;
  loc: Lexing.position * Lexing.position}
and desc_df = ctype * ident * param list * bloc
and bloc = decl_instr list

type fichier = include_ list * decl_fct list

