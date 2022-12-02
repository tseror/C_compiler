(* Syntaxe abstraite pour Petit C *)

type include_ = string
type ident = string

type ctype = Void | Int | Bool | Star of ctype

type param = ctype * ident

type binop =
  | Badd | Bsub | Bmul | Bdiv | Bmod    (* + - * / % *)
  | Beqq | Bneq | Blt | Ble | Bgt | Bge  (* == != < <= > >= *)
  | Band | Bor                          (* && || *)

type expr =
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

type decl_var = ctype * ident * expr option

type instruction = 
  | None
  | Expr of expr 
  | Bloc of bloc
  | If of expr * instruction * instruction
  | While of expr * instruction
  | For of decl_var option * expr option * expr list * instruction
  | Return of expr option
  | Break
  | Continue 
and decl_instr = 
  | Decl_var of decl_var 
  | Decl_fct of decl_fct
  | Decl_instr of instruction
and decl_fct = ctype * ident * param list * bloc
and bloc = decl_instr list

type fichier = include_ list * decl_fct list

