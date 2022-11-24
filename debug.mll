(* à mettre dans lexer.mll *)
(* Exemple pour arith.mll *)

{

open Ast
open Format
let lb = Lexing.from_channel stdin
let t = ref EOF (* token arbitraire *)
let next () = t := token lb
let () = next ()

(* Pour debugger une grammaire très simple (additions, multiplications, entiers) *)

let error () = failwith "syntax error"

let rec parse_expr () =
  let e = parse_term () in
  if !t = PLUS then (next(); Add (e, parse_expr)) else e

and parse_term () =
  let e = parse_factor () in
  if !t = TIMES then (next(); Mul (e, parse_expr)) else e

and parse_factor () = match !t with
  | CONST n -> next (); Const n
  | LEFTPAR -> next(); let e = parse_expr () in if !t <> RIGHTPAR then error (); next(); e
  | _       -> error ()

let e = parse_expr
let () = if !t <> EOF then error ()

let () = printf "e=@[%a@]@." print_expr e

}