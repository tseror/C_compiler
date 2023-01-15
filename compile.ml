open Format
open X86_64
open Ast

(* phase 1 : allocation des variables *)
let label_counter = ref 0
let get_new_label () = label_counter := !label_counter + 1; ".L"^string_of_int(!label_counter - 1)

exception VarUndef of string

module Smap = Map.Make(String)

type local_env = shift Smap.t

let rec alloc_expr (env: local_env) (exp:texpr) = 
  let adesc = match exp.tdesc with
  | TEint i -> Aint i
  | True -> ATrue
  | False -> AFalse
  | Null -> ANull
  | TEident x -> begin
    try let shift_x = Smap.find x env in Avar shift_x
    with Not_found -> raise (VarUndef x)
    end
  | TEpointer e -> Apointer (alloc_expr env e)
  | TEassign (e1, e2) -> 
    let ae1 = alloc_expr env e1 in
    let ae2 = alloc_expr env e2 in 
    Aassign(ae1, ae2)
  | TEcall (f, el) -> begin
    try Acall (f, List.map (alloc_expr env) el) 
    with Not_found -> raise (VarUndef f) end
  | TEinc1 e -> Ainc1 (alloc_expr env e)
  | TEdec1 e -> Adec1 (alloc_expr env e)
  | TEinc2 e -> Ainc2 (alloc_expr env e)
  | TEdec2 e -> Adec2 (alloc_expr env e)
  | TEaddress e -> Aaddress (alloc_expr env e)
  | TEnot e -> Anot (alloc_expr env e)
  | TEneg e -> Aneg (alloc_expr env e)
  | TEplus e -> Aplus (alloc_expr env e)
  | TEbinop (b, e1, e2) -> 
    let ae1 = alloc_expr env e1 in
    let ae2 = alloc_expr env e2 in
    Abinop(b, ae1, ae2)
  | TEsizeof t -> Asizeof t
  in {adesc = adesc; ctype = exp.ctype}

let rec alloc_instr (env: local_env) (fpcur:int) = function
    | TNone -> ANone, 0
    | TExpr e -> let ae = alloc_expr env e in AExpr ae, 0
    | TBloc b -> let ab, fp = alloc_bloc env fpcur b in ABloc(ab), fp
    | TReturn None -> AReturn None, 0
    | TReturn (Some e) -> let ae = alloc_expr env e in AReturn (Some ae), 0
    | TBreak -> ABreak, 0
    | TContinue -> AContinue, 0
    | TIf (e, i1, i2) -> let ae = alloc_expr env e in 
      let ai1, fp1 = alloc_instr env fpcur i1 in let ai2, fp2 = alloc_instr env fpcur i2 in
      AIf (ae, ai1, ai2), max fp1 fp2
    | TWhile (e, i) -> let ae = alloc_expr env e in let ai, fpi = alloc_instr env fpcur i in
      AWhile (ae, ai), fpi
    | TFor (None, el, i) -> let ael = List.map (alloc_expr env) el in
      let ai, fpi = alloc_instr env fpcur i in AFor(None, ael, ai), fpi
    | TFor (Some e, el, i) -> let ae = alloc_expr env e in let ael = List.map (alloc_expr env) el in
      let ai, fpi = alloc_instr env fpcur i in AFor(Some ae, ael, ai), fpi

and alloc_bloc (env: local_env) (fpcur:int) = function
    | [] -> [], fpcur
    | di :: bq -> match di with
      | TDecl_var (ty, x, eo) ->
        begin match eo with
        | Some e -> let ae = alloc_expr env e in 
          let abq, fpbq = alloc_bloc (Smap.add x (-(fpcur+8)) env) (fpcur+8) bq in 
          ADecl_var(ty, -(fpcur+8), Some ae) :: abq, fpbq
        | None -> let abq, fpbq = alloc_bloc (Smap.add x (-(fpcur+8)) env) (fpcur+8) bq in 
          ADecl_var(ty, -(fpcur+8), None) :: abq, fpbq
        end
      | TDecl_fct (t, f, pl, bf) ->
        let env', ofs_p =
        List.fold_left
          (fun (env', ofs_p) p ->
            let ofs_p = ofs_p + 8 in Smap.add (snd p) ofs_p env', ofs_p)
          (env, 8) pl in (* changement: 8 au lieu de fpcur *)
        let abf, fpbf = alloc_bloc env' 0 bf in
        let abq, fpbq = alloc_bloc env fpcur bq in 
        ADecl_fct (fpbf, f, pl, abf) :: abq, fpbq
      | TDecl_instr i -> let ai, fpi = alloc_instr env fpcur i in
        let abq, fpbq = alloc_bloc env (fpcur+fpi) bq in (ADecl_instr ai) :: abq, fpbq


(* Production de code *)

let popn n = addq (imm n) !%rsp
let pushn n = subq (imm n) !%rsp
let rec compile_expr (exp:aexpr) = match exp.adesc with 
  | Aint i -> movq (imm i) (reg rdi)
  | ATrue -> movq (imm 1) (reg rdi) | AFalse -> movq (imm 0) (reg rdi)
  | ANull -> movq (imm 0) (reg rdi)
  | Avar ofs_x -> movq (ind ~ofs:ofs_x rbp) (reg rdi)
  | Apointer e -> compile_expr e ++ movq (ind rdi) (reg rdi)
  | Aaddress e -> begin match e.adesc with
    | Avar ofs_x -> leaq (ind ~ofs:ofs_x rbp) rdi
    | Apointer p -> compile_expr p
    | _ -> failwith "anomaly"
  end
  | Abinop (b, e1, e2) when (b != Badd && b != Bsub)
                        -> compile_expr e1 ++ pushq (reg rdi) ++ 
                           compile_expr e2 ++ pushq (reg rdi) ++ 
                           popq rcx ++ popq rax ++
  (match b with
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
      ++ movq (imm 0) (reg rax) ++ label ltrue
    | _ -> failwith "anomaly") 
    ++ movq (reg rax) (reg rdi)
  | Abinop(Badd, e1, e2) -> begin match e1.ctype with
    | Star(_) ->
    compile_expr e1 ++ pushq (reg rdi) ++ 
    compile_expr e2 ++ imulq (imm 8) (reg rdi) ++
    pushq (reg rdi) ++ 
    popq rcx ++ popq rax ++ 
    addq (reg rcx) (reg rax) ++ 
    movq (reg rax) (reg rdi)
    | _ ->     
    compile_expr e1 ++ pushq (reg rdi) ++ 
    compile_expr e2 ++ pushq (reg rdi) ++ 
    popq rcx ++ popq rax ++ 
    addq (reg rcx) (reg rax) ++ 
    movq (reg rax) (reg rdi)
  end
  | Abinop(Bsub, e1, e2) -> begin match e1.ctype, e2.ctype with
    | Star(_), Star(_) ->
    compile_expr e1 ++ pushq (reg rdi) ++ 
    compile_expr e2 ++ pushq (reg rdi) ++ 
    popq rcx ++ popq rax ++
    subq (reg rcx) (reg rax) ++
    shrq (imm 3) (reg rax) ++
    movq (reg rax) (reg rdi)
    | Star(_), _ -> 
    compile_expr e1 ++ pushq (reg rdi) ++ 
    compile_expr e2 ++ imulq (imm 8) (reg rdi) ++
    pushq (reg rdi) ++ 
    popq rcx ++ popq rax ++ 
    subq (reg rcx) (reg rax) ++ 
    movq (reg rax) (reg rdi)
    | _ -> 
    compile_expr e1 ++ pushq (reg rdi) ++ 
    compile_expr e2 ++ pushq (reg rdi) ++ 
    popq rcx ++ popq rax ++ 
    subq (reg rcx) (reg rax) ++ 
    movq (reg rax) (reg rdi)
  end
  | Anot e -> compile_expr e ++ cmpq (imm 0) (reg rdi) 
              ++ movq (imm 0) (reg rdi) 
              ++ sete (reg dil) ++ movzbq (reg dil) rdi
  | Aneg e -> compile_expr e ++ negq (reg rdi)
  | Aplus e -> compile_expr e
  | Asizeof t -> movq (imm 8) (reg rdi)
  | Acall (f, ael) ->
    List.fold_left (fun acc e -> compile_expr e ++ pushq (reg rdi) ++ acc) nop ael ++
    begin
    if f = "putchar" || f = "malloc" then 
      popq rdi ++ movq (reg rsp) (reg rbx) ++ andq (imm (-16)) (reg rsp)
      ++ call f ++ movq (reg rbx) (reg rsp) 
    else call f ++ popn (8*(List.length ael + 1)) end
    ++ movq (reg rax) (reg rdi)
  | Aassign (ea1, ea2) -> begin match ea1.adesc with
    | Avar ofs_x -> compile_expr ea2 ++ movq (reg rdi) (ind ~ofs:ofs_x rbp)
    | Apointer address -> 
      compile_expr ea2 ++ movq (reg rdi) (reg rsi) ++ 
      compile_expr address ++ movq (reg rsi) (ind rdi)
    | _ -> failwith "anomaly"
  end
  | Ainc1 e -> compile_expr {adesc=(Aassign (e, {adesc=Abinop(Badd, e, {adesc=(Aint 1); ctype=Int}); ctype=Int})); ctype=e.ctype}
               ++ compile_expr e
  | Adec1 e -> compile_expr {adesc=(Aassign (e, {adesc=Abinop(Bsub, e, {adesc=(Aint 1); ctype=Int}); ctype=Int})); ctype=e.ctype}
               ++ compile_expr e  
  | Ainc2 e -> compile_expr e ++ pushq (reg rdi) ++ 
               compile_expr {adesc=(Aassign (e, {adesc=Abinop(Badd, e, {adesc=(Aint 1); ctype=Int}); ctype=Int})); ctype=e.ctype} 
               ++ popq rdi
  | Adec2 e -> compile_expr e ++ pushq (reg rdi) ++ 
               compile_expr {adesc=(Aassign (e, {adesc=Abinop(Bsub, e, {adesc=(Aint 1); ctype=Int}); ctype=Int})); ctype=e.ctype}
               ++ popq rdi
  | _ -> failwith "anomaly"

let rec compile_instr ?(cl = ("","")) = function
  | ANone -> nop
  | AExpr e -> compile_expr e
  | ABloc b -> compile_bloc ~cl:cl b
  | AWhile (e, i) -> let body_while = get_new_label() in let test_while = get_new_label() in let end_while = get_new_label() in
    let cl = (test_while, end_while) in
    jmp test_while ++ label body_while ++ compile_instr ~cl:cl i ++ 
    label test_while ++ compile_expr e ++ cmpq (imm 0) (reg rdi) ++ jne body_while ++ label end_while
  | AIf (e, i1, i2) -> let l_else = get_new_label() in let l_endif = get_new_label() in
    compile_expr e ++ cmpq (imm 0) (reg rdi) ++ je l_else ++
    compile_instr ~cl:cl i1 ++ jmp l_endif ++
    label l_else ++ compile_instr ~cl:cl i2 ++
    label l_endif
  | AFor (eo, el, i) -> let body_for = get_new_label() in let end_for = get_new_label() in
    begin match eo with
      | None -> let cl = (body_for, end_for) in   
        label body_for ++ compile_instr ~cl:cl i ++ 
        List.fold_left (fun acc e -> compile_expr e ++ acc) nop el ++ 
        jmp body_for
      | Some e -> let test_for = get_new_label() in let exec_for = get_new_label() in
        let cl = (exec_for, end_for) in
        jmp test_for ++ label body_for ++ 
        compile_instr ~cl:cl i ++ 
        label exec_for ++
        List.fold_left (fun acc e -> compile_expr e ++ acc) nop el ++
        label test_for ++ 
        compile_expr e ++
        cmpq (imm 0) (reg rdi) ++ jne body_for 
    end ++ label end_for
  | ABreak -> jmp (snd cl)
  | AContinue -> jmp (fst cl)
  | AReturn None -> movq (reg rbp) (reg rsp) ++ popq rbp ++ ret
  | AReturn Some e -> 
    compile_expr e ++ movq (reg rdi) (reg rax) ++ 
    movq (reg rbp) (reg rsp) ++ 
    popq rbp ++ ret
and compile_bloc ?(cl = ("","")) = function
  | [] -> nop
  | di :: bq -> begin match di with
    | ADecl_var(_, _, None) -> nop
    | ADecl_var (ty, ofs_x, Some e) -> compile_expr e ++ movq (reg rdi) (ind ~ofs:ofs_x rbp)
    | ADecl_fct (frame_size, f, pl, bf) -> label f ++ 
    pushq (reg rbp) ++ movq (reg rsp) (reg rbp) ++ 
    subq (imm frame_size) (reg rsp) ++ compile_bloc ~cl:("","") bf ++
    movq (reg rbp) (reg rsp) ++ popq rbp ++ ret
    | ADecl_instr i -> compile_instr ~cl:cl i
    end ++ compile_bloc ~cl:cl bq

let rec main (f:tfichier) : X86_64.text = 
  let _, file_bloc = f in
  let file_abloc, _ = alloc_bloc (Smap.empty) 0 file_bloc in
  globl "main" ++ compile_bloc ~cl:("","") file_abloc ++ ret