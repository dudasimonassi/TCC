#lang racket

(require redex)

(provide (all-defined-out))

(define-language Logic
  [L ::= true false 
     (¬ L)
     (L ∧ L)
     (L ∨ L)
     (L → L)
     (L ↔ L)])