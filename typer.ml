open Lexing
open Ast
open Printer

exception TypingError of string * (position * position)

module Tmap = Map.Make(String)
module IdMap = Map.Make(struct type t = ident let compare = compare end)
module IdSet = Set.Make(struct type t = ident let compare = compare end)

(* On notera l'environnement des types des variables comme un mapping: ident -> ctype *)
type vartypeEnv = ctype IdMap.t
(* On notera l'environnement des types des fonctions et des paramètres comme un mapping: ident -> ctype * ctype list *)
type functypeEnv = (ctype * ctype list) IdMap.t
type declared = IdSet.t
type typeEnv = (vartypeEnv * functypeEnv)

let compare_type t1 t2 = match (t1, t2) with 
  | (Int, Int) | (Bool, Bool) | (Int, Bool) | (Bool, Int) | (Void, Void) -> true
  | (Star(Void), Star(t)) | (Star(t), Star(Void)) -> true
  | _ -> t1 = t2

let lvalue env (e:expr) = match e.desc_e with
  | Eident x -> IdMap.mem x (fst env)
  | Epointer e -> true
  | _ -> false


let rec type_expr (env:typeEnv) (e:expr) = match e.desc_e with
  | Null -> Star(Void)
  | True | False -> Bool
  | Eint _ -> Int
  | Eident x -> begin try IdMap.find x (fst env) with Not_found -> raise(TypingError ((Printf.sprintf "undeclared indentifier %s" x), e.loc)) end
  | Esizeof t -> if compare_type t Void then raise(TypingError ("cannot take the sizeof Void", e.loc)) else Int
  | Epointer e -> begin match type_expr env e with 
    | Star t when not (compare_type t Void) -> t
    | _ -> raise (TypingError ("pointer of a non-pointer type", e.loc))
    end
  | Eaddress e -> if not (lvalue env e) then raise(TypingError ("cannot take the address of a non left value", e.loc)) else Star(type_expr env e)
  | Eassign (e1, e2) -> if not (lvalue env e1) then raise(TypingError ("cannot assign to a non left value", e.loc)) else
    if compare_type (type_expr env e1) (type_expr env e2) then type_expr env e1 else raise(TypingError ("cannot assign variables of different types", e.loc))
  | Einc1 e | Einc2 e -> 
    if not (lvalue env e) then raise(TypingError ("cannot increment a non left value", e.loc)) else type_expr env e
  | Edec1 e | Edec2 e -> 
    if not (lvalue env e) then raise(TypingError ("cannot increment a non left value", e.loc)) else type_expr env e
  | Eplus e | Eneg e -> if compare_type (type_expr env e) Int then Int else raise(TypingError ("unary plus/minus of a non-integer", e.loc))
  | Enot e -> let t = type_expr env e in if compare_type t Void then raise(TypingError ("not of Void", e.loc)) else Int
  | Ebinop (op, e1, e2) -> begin let t1 = type_expr env e1 in let t2 = type_expr env e2 in match op with
    | Beqq | Bneq | Blt | Ble | Bgt | Bge -> 
      if compare_type t1 t2 then Int else raise(TypingError ("comparison of differently typed objects", e.loc))
    | Bmul | Bdiv | Bmod | Band | Bor ->
      if ((compare_type t1 t2) && (compare_type t1 Int)) then Int else raise(TypingError ("operation on non-integers", e.loc))
    | Bsub -> begin match t1 with
      | Int | Bool -> if compare_type t1 t2 then Int else raise(TypingError ("substraction of integer with non-integer", e.loc))
      | Star(t) -> begin match t2 with
        | Int | Bool -> t1
        | Star(t') -> if t == t' then Int else raise(TypingError ("substraction of different pointer types", e.loc))
        | _ -> raise(TypingError ("illegal substraction", e.loc)) 
      end
      | Void -> raise(TypingError ("substraction on Void object", e.loc))
      end
    | Badd -> begin match t1 with
      | Int | Bool -> begin match t2 with
        | Int | Bool -> Int
        | Star(t) -> Star(t)
        | Void -> raise(TypingError ("addition of Void object", e.loc))
        end
      | Star(t) -> begin match t2 with
        | Int | Bool -> Star(t)
        | _ -> raise(TypingError ("illegal addition", e.loc))
        end
      | Void -> raise(TypingError ("addition of Void object", e.loc))
      end
    end 
  | Ecall(f, params) -> let ftype, params_types = try IdMap.find f (snd env) with Not_found -> raise(TypingError ("undefined function", e.loc)) in 
    let rec check_compatibility p ptypes = match p, ptypes with
      | [], [] -> true
      | [], _ | _, [] -> raise(TypingError ("wrong number of parameters in function call", e.loc))
      | e :: pq, t :: tq -> compare_type t (type_expr env e) && check_compatibility pq tq
    in if check_compatibility params params_types then ftype else raise(TypingError ("wrong types for parameters in function call", e.loc))

let rec check_type_instr ?(inloop = false) (env:typeEnv) (t0:ctype) (instr:instruction) = match instr with
  | None -> ()
  | Expr e -> let _ = type_expr env e in ()
  | Return (None, loc) -> if t0 == Void then () else raise(TypingError ("void function returns non-void object", loc))
  | Return (Some e, loc) -> let t = type_expr env e in if compare_type t t0 then () else raise(TypingError ("function returns wrong type", loc))
  | If (e, i1, i2) -> let t = type_expr env e in 
    if (compare_type t Void) then raise(TypingError ("void condition in if statement", e.loc)) else (); check_type_instr ~inloop env t0 i1; check_type_instr ~inloop env t0 i2
  | Break loc -> if inloop then () else raise(TypingError ("break outside of a loop", loc))
  | Continue loc -> if inloop then () else raise(TypingError ("continue outside of a loop", loc))
  | While(e, i) -> let t = type_expr env e in 
    if (compare_type t Void) then raise(TypingError ("void condition in while loop", e.loc)); check_type_instr ~inloop:true env t0 i
  | For(None, None, el, i) -> let _ = List.map (type_expr env) el in (); check_type_instr ~inloop:true env t0 i;
  | For(None, Some e, el, i) -> let t = type_expr env e in 
    if (compare_type t Void) then raise(TypingError ("void condition in for loop", e.loc));
    let _ = List.map (type_expr env) el in (); check_type_instr ~inloop:true env t0 i;
  | For(Some d, e, el, i) -> check_type_bloc ~inloop env IdSet.empty t0 ([Decl_var d; Decl_instr(For(None, e, el, i))])
  | Bloc b -> check_type_bloc ~inloop env IdSet.empty t0 b
and check_type_bloc ?(inloop = false) (env:typeEnv) (declared:declared) (t0:ctype) (b:bloc) = match b with
  | [] -> ()
  | i :: bq -> match i with 
    | Decl_var {desc_dv=(t, x, e); loc=loc} ->
      if (compare_type t Void) then raise(TypingError ("can't declare void variable", loc)) else
      if (IdSet.mem x declared) then raise(TypingError ("variable name already used in block", loc)) else
      let env' = (IdMap.add x t (fst env), IdMap.remove x (snd env)) in let declared' = (IdSet.add x declared) in
      if Option.is_some e && not (compare_type t (type_expr env' (Option.get e))) then raise(TypingError ("variable declaration is of the wrong type", loc))
      else check_type_bloc ~inloop env' declared' t0 bq
    | Decl_fct {desc_df=(t, f, pl, bf); loc=loc} -> 
      if (IdSet.mem f declared) then raise(TypingError ("function name already used in block", loc)) else
      let env' = ((fst env), IdMap.add f (t, List.map fst pl) (snd env)) in let declared' = (IdSet.add f declared) in
      check_type_bloc ~inloop:false env' (IdSet.empty) t ((List.map (fun (pt, px) -> Decl_var {desc_dv=(pt, px, None); loc=loc}) pl) @ bf); check_type_bloc ~inloop env' declared' t0 bq
    | Decl_instr i' -> check_type_instr ~inloop env t0 i'; check_type_bloc ~inloop env declared t0 bq

let main(f:fichier) =
  let env = (IdMap.empty, IdMap.add "putchar" (Int, [Int]) (IdMap.add "malloc" (Star Void, [Int]) IdMap.empty)) in
  let _, decl_fcts = f in
  if not (List.exists (fun dfct -> let (t, fname, _, _) = dfct.desc_df in t = Int && fname = "main") decl_fcts) then
    raise(TypingError ("no function main with type int", ({pos_fname = ""; pos_lnum=0; pos_bol=0; pos_cnum=0}, {pos_fname = ""; pos_lnum=0; pos_bol=0; pos_cnum=0})))
  else check_type_bloc env (IdSet.add "putchar" (IdSet.add "malloc" IdSet.empty)) Void (List.map (fun fct -> Decl_fct fct) decl_fcts)
