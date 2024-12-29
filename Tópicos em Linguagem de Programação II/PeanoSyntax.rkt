; Definição da Linguagem do Peano 
#lang racket

(require redex)

(provide (all-defined-out)) ; Torna todos os símbolos definidos no módulo disponíveis para outros módulos que o importarem.

; Definição do Peano em S-Expression
; P → P + X      ->  Um número de Peano pode ser a soma de outro número de Peano (𝑃) com um termo (𝑋)
;   | X          ->  Um número de Peano também pode ser diretamente um termo (𝑋)
; X → 0          ->  Um termo (𝑋) pode ser 0
;   | s(P)       ->  Um termo (𝑋) também pode ser o sucessor de um número de Peano (𝑃)

; Definição da Linguagem do Peano 
(define-language Peano
  (P ::=               ; Regras de produção associadas ao não-terminal P. O P representa qualquer expressão válida na Linguagem do Peano.
      0                ; O número 0 é o valor base (ou caso base) na gramática de Peano
      (s P)            ; Representa o sucessor de uma expressão válida 
      (+ P P)))        ; Representa a soma de duas expressões válidas


; Testes e exemplos
; redex-match? -> Função que verifica se uma expressão é válida na Linguagem do Peano
(redex-match? Peano P (term (+ 0 (s 0) ) ) ) ; Testa se a expressão (+ 0 (s 0)) é uma expressão válida na Linguagem do Peano -> Resolução: #t
(redex-match? Peano P (term (+ 0 (s 3) ) ) ) ; Testa se a expressão (+ 0 (s 3)) é uma expressão válida na Linguagem do Peano -> Resolução: #f
(redex-match? Peano P (term (+ 0 s(0) ) ) )  ; Testa se a expressão (+ 0 s(0)) é uma expressão válida na Linguagem do Peano -> Resolução: #f

; test-equal -> Função que verifica se duas expressões são iguais -> Não exibe mensagens no código, apenas quando acessado pelo (test-results)
(test-equal (redex-match? Peano P (term (s 0) )) #t) ; Nesse caso a expressão 1 (s 0) é igual a expressão 2 (#t) -> Resolução: #t

; test-match -> Função  Verifica explicitamente se a expressão 1 corresponde a P na linguagem Peano -> Não exibe mensagens no código, apenas quando acessado pelo (test-results)
(test-match Peano P (term (s 5)))

; test-no-match -> Função  Verifica explicitamente se a expressão 1 não corresponde a P na linguagem Peano -> Não exibe mensagens no código, apenas quando acessado pelo (test-results)
(test-no-match Peano P (term (+ 0 s(0))))

; Exibe os resultados acumulados de todos os testes executados.
(test-results)