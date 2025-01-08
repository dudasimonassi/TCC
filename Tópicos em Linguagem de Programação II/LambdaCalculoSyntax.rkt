#lang racket

(require redex)

(provide (all-defined-out))

; Definição da Linguagem Lambda Cálculo em S-Expression
;    E -> x
;       | λx.E
;       | (E E) 

; Definição da Linguagem Lambda Cálculo
(define-language LambdaCalculoSyntax
    [E ::=
        variable
        (lambda variable * E)
        (E E)]) 

; Testes e exemplos
(redex-match? LambdaCalculoSyntax E (term (λx.x)))
(redex-match? LambdaCalculoSyntax E (term (x (lambda x * y))))