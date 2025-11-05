#lang racket

(require redex)

(provide (all-defined-out))

; Definição da Linguagem da Parsing Machine
(define-language ParsingMachineLanguage
    ;; Instructions
    [I ::= (Char natural)
           Any
           (Choice integer)
           (Jump integer)
           (Call integer)
           Return
           (Commit integer)
           Fail
           (Load natural)
           (Store natural)
           (Push Value)
           Pop
           Add
           Sub
           Mult
           Div
           And
           Or
           Not
           Eq
           Lt
           Head
           Tail
           Cons
           Concat
           LGet
           Assert]  
         
    ;; Program
    [Program ::= ((I ...) (I ...))]  

    [Input ::= ((natural ...) (natural ...))] 

    [Value ::= natural
               bool
               List]
  
    [List ::= nill
              (cons Value List)]

    ;; Stack definition
    [Stack ::= (StackEntry ...)]             
    [StackEntry ::= natural              
                   (natural natural)
                    Value
                    M]

    ;; Memory
    [M ::= (Value ...)]

    [R ::= suc
           fail])    


; Testes e exemplos
; (redex-match? ParsingMachineLanguage Program (term ((Char 0))))
; (redex-match? ParsingMachineLanguage Program (term ((Char 5) Any (Jump label01))))
; (redex-match? ParsingMachineLanguage Program (term ((Choice label02) (Call label03) Return)))