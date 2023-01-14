open Format
open X86_64
open Ast

(* phase 1 : allocation des variables *)
let label_counter = ref 0
let get_new_label () = label_counter := !label_counter + 1; ".L"^string_of_int(!label_counter - 1)
let current_loop = ref ("", "")

exception VarUndef of string

module Smap = Map.Make(String)

type local_env = shift Smap.t

let rec alloc_expr (env: local_env) (exp:expr) = match exp.desc_e with
  | Eint i -> Aint i
  | True -> ATrue
  | False -> AFalse
  | Null -> ANull
  | Eident x -> begin
    try let shift_x = Smap.find x env in Avar shift_x
    with Not_found -> raise (VarUndef x)
    end
  | Epointer e -> Apointer (alloc_expr env e)
  | Eassign (e1, e2) -> 
    let ae1 = alloc_expr env e1 in
    let ae2 = alloc_expr env e2 in 
    Aassign(ae1, ae2)
  | Ecall (f, el) -> begin
    try Acall (f, List.map (alloc_expr env) el) 
    with Not_found -> raise (VarUndef f) end
  | Einc1 e -> Ainc1 (alloc_expr env e)
  | Edec1 e -> Adec1 (alloc_expr env e)
  | Einc2 e -> Ainc2 (alloc_expr env e)
  | Edec2 e -> Adec2 (alloc_expr env e)
  | Eaddress e -> Aaddress (alloc_expr env e)
  | Enot e -> Anot (alloc_expr env e)
  | Eneg e -> Aneg (alloc_expr env e)
  | Eplus e -> Aplus (alloc_expr env e)
  | Ebinop (b, e1, e2) -> 
    let ae1 = alloc_expr env e1 in
    let ae2 = alloc_expr env e2 in
    Abinop(b, ae1, ae2)
  | Esizeof t -> Asizeof t

let rec alloc_instr (env: local_env) (fpcur:int) = function
    | None -> ANone, 0
    | Expr e -> let ae = alloc_expr env e in AExpr ae, 0
    | Bloc b -> let ab, fp = alloc_bloc env fpcur b in ABloc(ab), fp
    | Return (None, _) -> AReturn None, 0
    | Return (Some e, _) -> let ae = alloc_expr env e in AReturn (Some ae), 0
    | Break _ -> ABreak, 0
    | Continue _ -> AContinue, 0
    | If (e, i1, i2) -> let ae = alloc_expr env e in 
      let ai1, fp1 = alloc_instr env fpcur i1 in let ai2, fp2 = alloc_instr env fpcur i2 in
      AIf (ae, ai1, ai2), fp1 + fp2
    | While (e, i) -> let ae = alloc_expr env e in let ai, fpi = alloc_instr env fpcur i in
      AWhile (ae, ai), fpi
    | For (None, None, el, i) -> let ael = List.map (alloc_expr env) el in
      let ai, fpi = alloc_instr env fpcur i in AFor(None, None, ael, ai), fpi
    | For (None, Some e, el, i) -> let ae = alloc_expr env e in let ael = List.map (alloc_expr env) el in
      let ai, fpi = alloc_instr env fpcur i in AFor(None, Some ae, ael, ai), fpi
    | For (Some d, e, el, i) -> let ab, fpb = alloc_bloc env fpcur [Decl_var d; Decl_instr(For(None, e, el, i))] in (ABloc(ab), fpb)

and alloc_bloc (env: local_env) (fpcur:int) = function
    | [] -> [], fpcur
    | di :: bq -> match di with
      | Decl_var {desc_dv=(ty, x, eo); loc=loc} ->
        begin match eo with
        | Some e -> let ae = alloc_expr env e in 
          let abq, fpbq = alloc_bloc (Smap.add x (-(fpcur+8)) env) (fpcur+8) bq in 
          ADecl_var(ty, -(fpcur+8), Some ae) :: abq, fpbq
        | None -> let abq, fpbq = alloc_bloc (Smap.add x (-(fpcur+8)) env) (fpcur+8) bq in 
          ADecl_var(ty, -(fpcur+8), None) :: abq, fpbq
        end
      | Decl_fct {desc_df=(t, f, pl, bf); loc=loc} ->
        let env', ofs_p =
        List.fold_left
          (fun (env', ofs_p) p ->
            let ofs_p = ofs_p + 8 in Smap.add (snd p) ofs_p env', ofs_p)
          (env, 8) pl in (* changement: 8 au lieu de fpcur *)
        let abf, fpbf = alloc_bloc env' fpcur bf in
        let abq, fpbq = alloc_bloc env fpcur bq in 
        ADecl_fct (fpbf, f, pl, abf) :: abq, fpbq
      | Decl_instr i -> let ai, fpi = alloc_instr env fpcur i in
        let abq, fpbq = alloc_bloc env (fpcur+fpi) bq in (ADecl_instr ai) :: abq, fpbq


(* Production de code *)

let popn n = addq (imm n) !%rsp
let pushn n = subq (imm n) !%rsp
let rec compile_expr = function
  | Aint i -> movq (imm i) (reg rdi)
  | ATrue -> movq (imm 1) (reg rdi) | AFalse -> movq (imm 0) (reg rdi)
  | ANull -> movq (imm 0) (reg rdi)
  | Avar ofs_x -> movq (ind ~ofs:ofs_x rbp) (reg rdi)
  | Apointer e -> compile_expr e ++ movq (ind rdi) (reg rdi)
  | Aaddress e -> begin match e with
    | Avar ofs_x -> leaq (ind ~ofs:ofs_x rbp) rdi
    | Apointer p -> compile_expr p
    | _ -> failwith "anomaly"
  end
  | Abinop (b, e1, e2) -> compile_expr e1 ++ pushq (reg rdi) ++ 
                          compile_expr e2 ++ pushq (reg rdi) ++ 
                          popq rcx ++ popq rax ++
  (match b with
    | Badd -> addq (reg rcx) (reg rax)
    | Bsub -> subq (reg rcx) (reg rax)
    | Bmul -> imulq (reg rcx) (reg rax)
    | Bdiv -> cqto ++ idivq !%rcx
    | Bmod -> cqto ++ idivq !%rcx ++ movq (reg rdx) (reg rax)
    | Beqq -> cmpq (reg rcx) (reg rax) ++ sete (reg al)
    | Bneq -> cmpq (reg rcx) (reg rax) ++ setne (reg al)
    | Blt -> cmpq (reg rcx) (reg rax) ++ setl (reg al)
    | Ble -> cmpq (reg rcx) (reg rax) ++ setle (reg al)
    | Bgt -> cmpq (reg rcx) (reg rax) ++ setg (reg al)
    | Bge -> cmpq (reg rcx) (reg rax) ++ setge (reg al)
    | Band -> let lfalse = get_new_label() in
      cmpq (imm 0) (reg rax) ++ movq (imm 0) (reg rax) ++ je lfalse 
      ++ cmpq (imm 0) (reg rcx) ++ je lfalse
      ++ movq (imm 1) (reg rax) ++ label lfalse
    | Bor -> let ltrue = get_new_label() in
      cmpq (imm 0) (reg rax) ++ movq (imm 1) (reg rax) ++ jne ltrue 
      ++ cmpq (imm 0) (reg rcx) ++ jne ltrue
      ++ movq (imm 0) (reg rax) ++ label ltrue) 
    ++ movq (reg rax) (reg rdi)
  | Anot e -> compile_expr e ++ notq (reg rdi) 
  | Aneg e -> compile_expr e ++ negq (reg rdi)
  | Aplus e -> compile_expr e
  | Asizeof t -> movq (imm 8) (reg rdi)
  | Acall (f, ael) ->
    List.fold_left (fun acc e -> compile_expr e ++ pushq (reg rdi) ++ acc) nop ael ++
    if f = "putchar" || f = "malloc" then 
      popq rdi ++ movq (reg rsp) (reg rbx) ++ andq (imm (-16)) (reg rsp)
      ++ call f ++ movq (reg rbx) (reg rsp) 
    else call f ++ popn (8*(List.length ael))
    ++ movq (reg rax) (reg rdi)
  | Aassign (ea1, ea2) -> begin match ea1 with
    | Avar ofs_x -> compile_expr ea2 ++ movq (reg rdi) (ind ~ofs:ofs_x rbp)
    | Apointer address -> 
      compile_expr ea2 ++ movq (reg rdi) (reg rsi) ++ 
      compile_expr address ++ movq (reg rsi) (ind rdi)
    | _ -> failwith "anomaly"
  end
  | Ainc1 e -> 
    begin match e with
    | Apointer p -> compile_expr (Aassign (p, Abinop(Badd, p, Aint 8)))
    | _ -> compile_expr (Aassign (e, Abinop(Badd, e, Aint 1)))
    end  ++ compile_expr e
  | Adec1 e ->     
    begin match e with
    | Apointer p -> compile_expr (Aassign (p, Abinop(Bsub, p, Aint 8)))
    | _ -> compile_expr (Aassign (e, Abinop(Bsub, e, Aint 1)))
  end ++ compile_expr e
  | Ainc2 e -> compile_expr e ++ pushq (reg rdi) ++
    begin match e with
    | Apointer p -> compile_expr (Aassign (p, Abinop(Badd, p, Aint 8)))
    | _ -> compile_expr (Aassign (e, Abinop(Badd, e, Aint 1)))
    end ++ popq rdi
  | Adec2 e -> compile_expr e ++ pushq (reg rdi) ++
    begin match e with
    | Apointer p -> compile_expr (Aassign (p, Abinop(Bsub, p, Aint 8)))
    | _ -> compile_expr (Aassign (e, Abinop(Bsub, e, Aint 1)))
    end ++ popq rdi

let rec compile_instr = function
  | ANone -> nop
  | AExpr e -> compile_expr e
  | ABloc b -> compile_bloc b
  | AWhile (e, i) -> let body_while = get_new_label() in let test_while = get_new_label() in let end_while = get_new_label() in
    current_loop := (test_while, end_while);
    jmp test_while ++ label body_while ++ compile_instr i ++ 
    label test_while ++ compile_expr e ++ cmpq (imm 0) (reg rdi) ++ jne body_while ++ label end_while
  | AIf (e, i1, i2) -> let l_else = get_new_label() in let l_endif = get_new_label() in
    compile_expr e ++ cmpq (imm 0) (reg rdi) ++ je l_else ++
    compile_instr i1 ++ jmp l_endif ++
    label l_else ++ compile_instr i2 ++
    label l_endif
  | AFor (_, eo, el, i) -> let body_for = get_new_label() in let end_for = get_new_label() in
    begin match eo with
      | None -> current_loop := (body_for, end_for);      
        label body_for ++ compile_instr i ++ 
        List.fold_left (fun acc e -> compile_expr e ++ acc) nop el ++ 
        jmp body_for
      | Some e -> let test_for = get_new_label() in let exec_for = get_new_label() in
        current_loop := (exec_for, end_for);
        jmp test_for ++ label body_for ++ 
        compile_instr i ++ 
        label exec_for ++
        List.fold_left (fun acc e -> compile_expr e ++ acc) nop el ++
        label test_for ++ 
        compile_expr e ++
        cmpq (imm 0) (reg rdi) ++ jne body_for 
    end ++ label end_for
  | ABreak -> jmp (snd !current_loop)
  | AContinue -> jmp (fst !current_loop)
  | AReturn None -> movq (reg rbp) (reg rsp) ++ popq rbp ++ ret
  | AReturn Some e -> 
    compile_expr e ++ movq (reg rdi) (reg rax) ++ 
    movq (reg rbp) (reg rsp) ++ 
    popq rbp ++ ret
and compile_bloc = function
  | [] -> nop
  | di :: bq -> begin match di with
    | ADecl_var(_, _, None) -> nop
    | ADecl_var (ty, ofs_x, Some e) -> compile_expr e ++ movq (reg rdi) (ind ~ofs:ofs_x rbp)
    | ADecl_fct (frame_size, f, pl, bf) -> label f ++ 
    pushq (reg rbp) ++ movq (reg rsp) (reg rbp) ++ 
    subq (imm frame_size) (reg rsp) ++ compile_bloc bf ++
    movq (reg rbp) (reg rsp) ++ popq rbp ++ ret
    | ADecl_instr i -> compile_instr i
    end ++ compile_bloc bq

let rec main (f:fichier) : X86_64.text = 
  let _, decl_fcts = f in let file_bloc = (List.map (fun fct -> Decl_fct fct) decl_fcts) in
  let file_abloc, _ = alloc_bloc (Smap.empty) 0 file_bloc in
  globl "main" ++ compile_bloc file_abloc ++ ret