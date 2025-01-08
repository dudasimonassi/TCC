#lang racket

(require redex)

(define-language L
  (e (e e)
     (λ (x t) e)
     x
     (amb e ...)
     number
     (+ e ...)
     (if0 e e e)
     (fix e))
  (t (→ t t) num)
  (x variable-not-otherwise-mentioned))

; Caso o casamento não seja bem sucedido, o redex-match retorna #f
(printf "Exemplos\n")
(redex-match
   L
   e
   (term (λ (x) x)))

; Caso o casamento seja bem sucedido, o redex-match retorna a expressão casada
(redex-match
   L
   e
   (term ((λ (x num) (amb x 1))
          (+ 1 2))))
; Resultado: (list (match (list (bind 'e '((λ (x num) (amb x 1)) (+ 1 2))))))


; ------------------- Exercícios -------------------
; Ex 01:
(printf "Exercício 01\n")
(redex-match
    L
    (λ (x t) e-body)
    (term ((λ (x num) (+ x 1)) 17)))