#lang racket

(require redex)

(provide (all-defined-out))

; Definição da Linguagem da Lógica em S-Expression

;  L → v             -> Uma fórmula lógica pode ser uma variável proposicional
;    | ⊤             -> Uma fórmula lógica pode ser verdadeira
;    | ⊥             -> Uma fórmula lógica pode ser falsa   
;    | ¬L            -> Uma fórmula lógica pode ser a negação de outra fórmula lógica
;    | L ∧ L         -> Uma fórmula lógica pode ser a conjunção de duas fórmulas lógicas
;    | L ∨ L         -> Uma fórmula lógica pode ser a disjunção de duas fórmulas lógicas
;    | L → L         -> Uma fórmula lógica pode ser a implicação de duas fórmulas lógicas
;    | L ↔ L         -> Uma fórmula lógica pode ser a bicondicional de duas fórmulas lógicas

; Definição da Linguagem da Lógica
(define-language Logic
  (L ::= 
        v
        (verdadeiro)
        (falso)
        (nao L)
        (L e L)
        (L ou L)
        (se L entao L)
        (se e somente se L L)
        [p q r t ::= variable-not-otherwise-mentioned]))


; Testes e exemplos
(redex-match? Logic L (term (nao (verdadeiro)) ) ) 
(redex-match? Logic L (term (nao (falso)) ) ) 
(redex-match? Logic L (term (p e se r entao t)))