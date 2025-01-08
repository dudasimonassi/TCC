#lang racket

(require redex)

(provide (all-defined-out))

; Definição da Linguagem Lua em S-Expression
;   I -> (Char x)            
;      | (Any)                
;      | (Choice l)           
;      | (Jump l)            
;      | (Call l)           
;      | (Return)             
;      | (Commit l)          
;      | (Fail)              
;   Program -> I*           ; Um programa é uma sequência de zero ou mais instruções.


; Definição da Linguagem Lua
(define-language Lua
 [I ::= Char x
        Any
        Choice l
        Jump l
        Call l
        Return
        Commit l
        Fail]           
  
  [Program ::= I*]

  [x ::= character]            
  [l ::= number])              


; Testes e exemplos
(redex-match? Lua Program (term ((Char a))))
(redex-match? Lua Program (term ((Char a) (Any) (Jump 5))))
(redex-match? Lua Program (term ((Choice 3) (Call 10) (Return))))


; Função para ler o arquivo e aplicar redex-match?
(define (match-file filename)
  (define content (file->string filename))  ; Lê o conteúdo do arquivo
  (define parsed-term (read (open-input-string content)))  ; Converte o conteúdo em um termo
  (redex-match? Lua Program parsed-term))  ; Aplica redex-match?

(match-file "Testes Lua/Teste01_ ProgramaEmLua.lua")