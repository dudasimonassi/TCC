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
           Fail]  
         
    ;; Program
    [Program ::= ((I ...) (I ...))]  

    [Input ::= ((natural ...) (natural ...))] 
 

    [R ::= suc
           fail]
    
    ;; State components - Program P, Subject S, pc, i, Stack
    [State ::= (R Program (natural ...) natural natural Stack)]     

    ;; Stack definition
    [Stack ::= (StackEntry ...)]             
    [StackEntry ::= natural              
                 (natural natural)])    

; Testes e exemplos
; (redex-match? ParsingMachineLanguage Program (term ((Char 0))))
; (redex-match? ParsingMachineLanguage Program (term ((Char 5) Any (Jump label01))))
; (redex-match? ParsingMachineLanguage Program (term ((Choice label02) (Call label03) Return)))