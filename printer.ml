open Ast
open Format

(* Printer pour le débugage *)
let rec string_of_type = function
  | Void -> "Void"
  | Int -> "Int"
  | Bool -> "Bool"
  | Star(t) -> "*" ^ string_of_type t

let rec string_of_expr e = match e.desc_e with
  | Eint i -> string_of_int i
  | True -> "true"
  | False -> "false"
  | Null -> "null"
  | Eident i -> i
  | Epointer e -> "*" ^ string_of_expr e
  | Eassign (e1, e2) -> string_of_expr e1 ^ " = " ^ string_of_expr e2
  | Ecall (i, el) -> i ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Einc1 e -> "++" ^ string_of_expr e
  | Edec1 e -> "--" ^ string_of_expr e
  | Einc2 e -> string_of_expr e ^ "++"
  | Edec2 e -> string_of_expr e ^ "--"
  | Eaddress e -> "&" ^ string_of_expr e
  | Enot e -> "!" ^ string_of_expr e
  | Eneg e -> "-" ^ string_of_expr e
  | Eplus e -> "+" ^ string_of_expr e
  | Ebinop (b, e1, e2) -> string_of_expr e1 ^ " " ^ string_of_binop b ^ " " ^ string_of_expr e2
  | Esizeof t -> "sizeof(" ^ string_of_type t ^ ")"
  and string_of_binop = function
    | Badd -> "+"
    | Bsub -> "-"
    | Bmul -> "*"
    | Bdiv -> "/"
    | Bmod -> "%"
    | Band -> "&&"
    | Bor -> "||"
    | Beqq -> "=="
    | Bneq -> "!="
    | Blt -> "<"
    | Ble -> "<="
    | Bgt -> ">"
    | Bge -> ">="