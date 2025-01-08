#lang racket

(require redex)

(provide (all-defined-out))

; Definição da Linguagem While em S-Expression
;   S -> x := A
;      | skip
;      | S1 ; S2
;      | if B then S1 else S2
;      | while B do S
;   A -> n
;      | x
;      | A1 + A2
;      | A1 - A2 
;      | A1 * A2
;   B -> true   
;      | false
;      | A1 = A2
;      | A1 <= A2
;      | not B
;      | B1 and B2

; Definição da Linguagem While - Aqui foram definidos apenas os terminais?
(define-language WhileLinguage 
    [A ::=
        natural 
        variable                      ; A palavra "natural" e "variable" é reservada do Racket? A gente que define isso?
        (A + A)                                  
        (A - A)
        (A * A)]
    [B ::=
        true
        false
        (A = A)
        (A <= A)
        (not B)
        (B and B)]
    [x y z :: variable-not-otherwise-mentioned])    ; Apenas as variáveis x, y e z são válidas na Linguagem While? Consegui rodar com a

; Definição da Linguagem While Extendida - Aqui foram definidos apenas os não-terminais?
(define-extended-language While WhileLinguage
    [S ::= 
        (x := A)
        skip
        (S S)
        (if B then S else S)
        (while B do S)])


; Testes e exemplos
(redex-match? WhileLinguage A (term (1 + (a * (b - 3)))))
(redex-match? WhileLinguage B (term (true and (not false))))
(redex-match? While S (term (x := 1)))