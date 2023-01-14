(* Analyseur lexical pour Petit C *)

{
  open Lexing
  open Parser
  open Format

  (* exception à lever pour signaler une erreur lexicale *)
  exception Lexing_error of string

  let char_to_code s = 
    let char_of = function
    | "'\\n'"    -> '\n'
    | "'\\t'"    -> '\t'
    | "'\\\\'"   -> '\\'
    | "'\\\''"   -> '\''
    | _         -> s.[1]
  in int_of_char (char_of s)

}

let chiffre = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let ident = (alpha | '_') (alpha | chiffre | '_')*
let carac = [^'\\' '\''] | "\\t" | "\\n" | "\\\\" | "\\\'"
let integer = '0' | (['1'-'9'] chiffre*) | '\'' carac '\''
let space = ' ' | '\t'
let comment = "//" [^'\n']* 

rule token = parse
    | '\n' {Lexing.new_line lexbuf; token lexbuf}
    | space+ {token lexbuf}
    | comment {token lexbuf}
    | space {token lexbuf}
    | integer as x {INTEGER(try int_of_string x with _ -> char_to_code x)}
    | "#include" space* "<" ([^ '>']* as package) ">" space* "\n" {Lexing.new_line lexbuf; INCLUDE(package)}
    | "/*" {multiline_comment lexbuf}
    | "bool" {BOOL}
    | "break" {BREAK}
    | "continue" {CONTINUE}
    | "else" {ELSE}
    | "false" {FALSE}
    | "for" {FOR}
    | "if" {IF}
    | "int" {INT}
    | "NULL" {NULL}
    | "return" {RETURN}
    | "sizeof" {SIZEOF}
    | "true" {TRUE}
    | "void" {VOID}
    | "while" {WHILE}
    | "==" {EQQ}
    | "=" {EQ}
    | "||" {OR}
    | "&&" {AND}
    | "&" {AMPERSAND}
    | "!=" {NEQ}
    | "<=" {LEQ}
    | "<" {LT}
    | ">=" {GEQ}
    | ">" {GT}
    | "++" {INC}
    | "+" {PLUS}
    | "--" {DEC}
    | "-" {MINUS}
    | "*" {TIMES}
    | "/" {DIV}
    | "%" {MOD}
    | "!" {NOT}
    | "{" {LBRACKET}
    | "}" {RBRACKET}
    | "[" {LSQ}
    | "]" {RSQ}
    | "(" {LP}
    | ")" {RP}
    | ";" {SEMICOLON}
    | "," {COMMA}
    | ident as x {IDENT(x)}
    | eof {EOF}
    | _ as c {raise (Lexing_error ("illegal character: " ^ String.make 1 c))}
    and multiline_comment = parse
    | "*/" {token lexbuf}
    | '\n' {Lexing.new_line lexbuf; multiline_comment lexbuf}
    | _ {multiline_comment lexbuf}
    | eof {raise (Lexing_error "unclosed comment")}