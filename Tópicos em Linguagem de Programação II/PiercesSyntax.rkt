#lang racket

(require redex)

(provide (all-defined-out))

; Definição da Linguagem Pierce´s em S-Expression
;   T   →  true
;       | false
;       | if T then T else T
;       | 0
;       | succ T
;       | pred T
;       | iszero T

; Definição da Linguagem Pierce´s
(define-language Pierces
    (T ::= 
        (true)
        (false)
        (if T then T else T)
        0
        (succ T)
        (pred T)
        (iszero T)))

; Testes e exemplos
(redex-match? Pierces T (term (if (iszero 0) then (succ 0) else (pred 0)) ) ) 
(redex-match? Pierces T (term (if (iszero 0) then (succ 0) else (pred (succ 0))) ) )
(redex-match? Pierces T (term (if (iszero 0) then (succ 0) else (pred (succ (succ 10)))) ) )