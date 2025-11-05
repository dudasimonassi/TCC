#lang racket

(require redex)

(require "logicSyntax.rkt")

(define r
  (reduction-relation Logic
     #:domain L
     #:codomain L
     (--> (¬ true)
          false
          "neg1")
     (--> (¬ false)
          true
          "neg2")
     (--> (true ∧ L)
          L
          "conjunção_1")
     (--> (L ∧ true)
          L
          "conj2")
     (--> (false ∧ L)
          false
          "conj3")
     (--> (L ∧ false)
          false
          "conj4")
     (--> (true ∨ L)
          true
          "disj1")
     (--> (L ∨ true)
          true
          "disjunção_2")
     (--> (true ∨ L)
          L
          "disj3")
     (--> (L ∨ false)
          L
          "disj4")
     (--> (true → L)
          L
          "condição_1")
     (--> (L → true)
          true
          "cond2")
     (--> (false → L)
          true
          "cond3")
     #;(--> (L → false)
          (¬ L)
          "cond4")
     (--> (true ↔ L)
          L
          "bic1")
     (--> (L ↔ true)
          L
          "bic2")
     (--> (false ↔ L)
          (¬ L)
          "bic3")
     (--> (L ↔ false)
          (¬ L)
          "bic4")))

(traces r (term (true ∧ (true → false ))))

#;(traces r (term (false → (false ∨ true))))