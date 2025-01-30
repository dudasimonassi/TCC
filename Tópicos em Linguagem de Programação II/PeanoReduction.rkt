#lang racket

(require redex)

(require "PeanoSyntax.rkt")

(define r
  (reduction-relation Peano
     #:domain P
     #:codomain P
     (--> (+ P 0)
          P
          "↦0")
     (--> (+ P_1 (s P_2))
          (s (+ P_1 P_2))
          "↦s")))