#lang racket

(require redex)

(provide (all-defined-out))

; Definição da Linguagem Lua em S-Expression
;   I -> (Char x)            
;      | (Any)                
;      | (Choice l)           
;      | (Jump l)            
;      | (Call l)           
;      | (Return)             
;      | (Commit l)          
;      | (Fail)              
;   Program -> I*           ; Um programa é uma sequência de zero ou mais instruções.


; Definição da Linguagem Lua
(define-language Lua
 [I ::= (Char natural)
        (l I)
        Any
        (Choice l)
        (Jump l)
        (Call l)
        Return
        (Commit l)
        Fail]  
         
  
  [Program ::= (I ...)]          
          
  [l ::= variable-not-otherwise-mentioned])              


; Testes e exemplos
(redex-match? Lua Program (term ((Char 0))))
(redex-match? Lua Program (term ((Char 5) Any (Jump label01))))
(redex-match? Lua Program (term ((Choice label02) (Call label03) Return)))