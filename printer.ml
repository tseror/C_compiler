open Ast
open Format

(* Printer pour le débugage *)
let rec print_type = function
  | Void -> printf "Void"
  | Int -> printf "Int"
  | Bool -> printf "Bool"
  | Star(t) -> printf "*"; print_type t

let print_bool = function
  | true -> printf "true"
  | false -> printf "false"