(* Syntaxe abstraite pour Petit C *)

type include_ = string
type ident = string

type type_ = Void | Int | Bool | Star of type_

type param = type_ * ident

type binop =
  | Badd | Bsub | Bmul | Bdiv | Bmod    (* + - * / % *)
  | Beqq | Bneq | Blt | Ble | Bgt | Bge  (* == != < <= > >= *)
  | Band | Bor                          (* && || *)

type expr =
  | Eint of int | True | False | Null
  | Eident of ident
  | Epointer of expr
  | Eget of expr * expr
  | Eassign of expr * expr
  | Ecall of ident * expr list
  | Eaddress of expr
  | Enot of expr
  | Eneg of expr
  | Eplus of expr
  | Ebinop of binop * expr * expr
  | Esizeof of type_

type decl_var = type_ * ident * expr option

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
and decl_fct = type_ * ident * param list * bloc
and bloc = decl_instr list

type fichier = include_ list * decl_fct list

