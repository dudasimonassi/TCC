; Definição da Linguagem do Peano 

#lang racket

(require redex)

(provide (all-defined-out)) ; Torna todos os símbolos definidos no módulo disponíveis para outros módulos que o importarem.

(define-language Peano
  (P ::= 0
     (s P)
     (+ P P)))


(define ex1 (term 0))  

(displayln (redex-match Peano P ex1)) 

; Definição do Peano em S-Expression
; P → P + X
;   | X
; X → 0
;   | s(P)