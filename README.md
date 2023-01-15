# Compilateur `petit C` 

Le projet est organisé selon l'arborescence suivante :

```
.
├── Makefile
├── src
│   ├── ast.ml
│   ├── dune
│   ├── lexer.mll
│   ├── printer.ml
│   ├── petitc.ml
│   ├── parser.mly
│   ├── compile.ml
│   ├── x86_64.ml
│   └── typer.ml
└─ README.md
```

On peut utiliser les commandes du `Makefile` suivantes : 

```
make 		-> compile petit C en ./petitc.exe
make clean 	-> nettoie le répertoire
```


## Analyse Lexicale :

Pour l’analyse lexicale, on utilise l’outil `ocamllex`. On traite les commentaires
avec un analyseur dédié, comme vu en cours. On appelle `Lexing.new_line` pour
chaque retour chariot, afin d’avoir les bons numéros de lignes lors du renvoi d’erreurs.


Pour l’analyse syntaxique, on utilise l’outil menhir. Pour permettre la localisation
des erreurs, on conserve une information de localisation dans l’arbre de syntaxe
abstraite. On récupère cette information dans les valeurs $startpos et $endpos
transmise par l’analyseur lexical.

## Analyse Syntaxique :

Pour l’analyse syntaxique, on utilise l’outil `menhir`. 
Pour permettre la localisation des erreurs lors du typage, on rajoute une information de localisation à l’arbre de syntaxe abstraite. On récupère cette information dans les valeurs `$startpos` et `$endpos` transmise par l’analyseur lexical.

On utilise la structure suivante

```ocaml

type localisation = Lexing.position * Lexing.position

[...]
and expr = {desc : desc; loc : localisation}
and desc = 
  | Eint of int | True | False | Null
  | Eident of ident
  | Epointer of expr
  | ...

type decl_var =
  {desc_dv: desc_dv;
   loc : localisation}

[...]

```

## Typage

On procède en deux étapes, on commence par vérifier que le programme est bien typé, puis on construit un nouvel arbre qui sera utilisé pour la production de code.

On définit un type d'environnement `typeEnv` pour stocker les types des variables, des fonctions, et des paramètres.

On définit les fonctions suivantes pour la première étape : 

```ocaml
val type_expr : typeEnv -> expr -> ctype
val check_type_instr : ?inloop:bool -> typeEnv -> ctype -> instruction -> ()
val check_type_bloc : ?inloop:bool -> typeEnv -> IdSet.t -> ctype -> bloc -> ()
```

Et les fonctions suivantes pour la construction du nouvel arbre :

```ocaml
val build_exp : typeEnv -> expr -> texpr
val build_instr : typeEnv -> instruction -> tinstr
val build_bloc : typeEnv -> bloc -> tbloc
val build_file : typeEnv -> fichier -> tfichier
```

## Production de code

Pour la production de code, on utilise le module `x86_64.ml`. On commence par parcourir les arbres en sortie de typage pour associer à chaque variable l'entier correspondant au décalage de son addresse par rapport à `%rbp`.

On utilise une fonction
```ocaml
val get_new_label : () -> label
```
pour générer les étiquettes utilisées lors de la compilation des structures de contrôles (boucles, if/else).

Pour l'écriture du code en assembleur, on définit les fonctions suivantes :

```ocaml
val compile_expr : aexpr -> text
val compile_instr : ?current_loop:label * label -> instr -> text
val compile_bloc : ?current_loop:label * label -> bloc -> text
```

Le paramètre optionnel `current_loop` contient les deux étiquettes à placer lors d'un appel à `continue` ou `break`.


### Quelques remarques sur les difficultés rencontrées :

- Appels à `malloc` et `putchar` :

Lorsqu'on appelle ces fonctions, on prend soin d'aligner la pile de sorte à ce que `%rsp` soit un multiple de 16. De plus, l'argument doit être passé dans `%rdi` plutôt que sur la pile. On sauvegarde donc `%rsp` dans `%rbx` (callee-saved), et on le récupère après l'appel. On compilera donc un appel à `malloc` ou `putchar` de la manière suivante :

```asm
popq  %rdi
movq  %rsp      %rbx 
andq  $-16      %rsp 
call  malloc (ou putchar)
movq  %rbx      %rsp
```

- Évaluation paresseuse

Afin d'assurer l'évaluation paresseuse de `&&` et `||`, on utilise des étiquettes. Par exemple, pour la compilation de `&&` on adopte le schéma suivant (après avoir mis les expressions à comparer dans `%rax` et `rcx`) :

```ocaml
let lfalse = get_new_label() in
    cmpq (imm 0) (reg rax) 
    ++ movq (imm 0) (reg rax) 
    ++ je lfalse 
    ++ cmpq (imm 0) (reg rcx) 
    ++ je lfalse 
    ++ movq (imm 1) (reg rax) 
    ++ label lfalse
    ++ movq (reg rax) (reg rdi)
```

- Arithmétique de pointeurs

Lors de la compilation des opérations d'arithmétique (addition, soustraction, incrémentation, décrémentation), les pointeurs ne doivent pas être compilés comme les autres variables. Par exemple, lors de la compilation de `p[1] = *(p+1)`, `p+1` correspond à l'addresse suivant `p`, c'est à dire 1 octet de plus. On doit donc incrémenter l'addresse `p` de 8.


