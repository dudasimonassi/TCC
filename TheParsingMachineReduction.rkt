#lang racket

(require redex)

(require "TheParsingMachineLanguage.rkt")

(define PM
  (reduction-relation
   ParsingMachineLanguage
   #:domain (R Program Input natural natural Stack)
   
    ;; Char instruction - success case
     (--> (suc ((I_1 ...) ((Char natural) I_2 ...)) ((natural_1 ...) (natural natural_2 ...)) natural_pc natural_i Stack)                                          
          (suc ((I_1 ... (Char natural)) (I_2 ...)) ((natural_1 ... natural) (natural_2 ...)) ,(+ (term natural_pc) 1) ,(+ (term natural_i) 1) Stack) 
     "char-match")

     ;; Char instruction - fail case
     (--> (suc ((I_1 ...) ((Char (name var1 natural_!_)) I_2 ...)) ((natural_1 ...) ((name var2 natural_!_) natural_2 ...)) natural_pc natural_i Stack)                                          
          (fail ((I_1 ...) ((Char var1) I_2 ...)) ((natural_1 ...) (var2 natural_2 ...)) natural_pc natural_i Stack) 
     "char-fail")

     ;; Char instruction - fail empty case
     (--> (suc ((I_1 ...) ((Char natural) I_2 ...)) ((natural_1 ...) ( )) natural_pc natural_i Stack)                                          
          (fail ((I_1 ...) ((Char natural) I_2 ...)) ((natural_1 ... ) ( )) natural_pc natural_i Stack) 
     "char-fail-empty")

     ;; Any instruction - success case
     (--> (suc ((I_1 ...) (Any I_2 ...)) ((natural_1 ...) (natural_2 natural_3 ...)) natural_pc natural_i Stack)                                          
          (suc ((I_1 ... Any) (I_2 ...)) ((natural_1 ... natural_2) (natural_3 ...)) ,(+ (term natural_pc) 1) ,(+ (term natural_i) 1) Stack)
     "any-match")

     ;; Any instruction - fail case
     (--> (suc ((I_1 ...) (Any I_2 ...)) ((natural_1 ...) ( )) natural_pc natural_i Stack)                                          
          (fail ((I_1 ...) (Any I_2 ...)) ((natural_1 ... ) ( )) natural_pc natural_i Stack)
     "any-fail-empty")

     ;; Choice instruction
     (--> (suc ((I_1 ...) ((Choice integer) I_2 ...)) Input natural_pc natural_i (StackEntry ...))           
          (suc ((I_1 ... (Choice integer)) (I_2 ...)) Input ,(+ (term natural_pc) 1) natural_i ((,(+ (term natural_pc) (term integer)) natural_i) StackEntry ...))
     "choice-match")

     ;; Jump instruction
     (--> (suc ((I_1 ...) ((Jump integer) I_2 ...)) Input natural_pc natural_i Stack)           
          (suc (moveProgram ((I_1 ...) ((Jump integer) I_2 ...)) integer) Input ,(+ (term natural_pc) (term integer)) natural_i Stack)      
     "jump-match")

     ;; Call instruction
     (--> (suc ((I_1 ...) ((Call integer) I_2 ...)) Input natural_pc natural_i (StackEntry ...))           
          (suc ((I_1 ... (Call integer)) (I_2 ...)) Input ,(+ (term natural_pc) (term integer)) natural_i (,(+ (term natural_pc) 1) StackEntry ...))
     "call-match")

     ;; Return instruction
     (--> (suc ((I_1 ...) (Return I_2 ...)) Input natural_pc0 natural_i (natural_pc1 StackEntry ...))
          (suc (moveProgram ((I_1 ...) (Return I_2 ...)) ,(- (term natural_pc1) (term natural_pc0))) Input natural_pc1 natural_i (StackEntry ...))
     "return-match")

     ;; Commit instruction
     (--> (suc ((I_1 ...) ((Commit integer) I_2 ...)) Input natural_pc natural_i (natural_head StackEntry ...))
          (suc (moveProgram ((I_1 ...) ((Commit integer) I_2 ...)) integer) Input ,(+ (term natural_pc) (term integer)) natural_i (StackEntry ...))
     "commit-match")

     ;; Fail instruction
     (--> (suc ((I_1 ...) (Fail I_2 ...)) Input natural_pc natural_i Stack)
          (fail ((I_1 ... Fail) (I_2 ...)) Input ,(+ (term natural_pc) 1) natural_i Stack)
     "fail-instruction")

     ;; Fail
     (--> (fail Program Input natural_pc natural_i (natural StackEntry ...))
          (fail Program Input natural_pc natural_i (StackEntry ...))
     "fail")

     ;; Fail restore instruction
     (--> (fail Program Input natural_pc natural_i ((natural_newPC natural_newI) StackEntry ...))
          (suc (moveProgram Program ,(- (term natural_newPC) (term natural_pc))) (moveInput Input ,(- (term natural_newI) (term natural_i))) natural_newPC natural_newI (StackEntry ...))
     "fail-restore")
 )
)

(define-metafunction ParsingMachineLanguage
     moveProgram : Program integer -> Program
     [(moveProgram Program 0) 
      Program]
     [(moveProgram ((I ...) ()) integer) 
      ((I ...) ()) (side-condition 
      (> (term integer) 0))]
     [(moveProgram ((I_1 ...) (I_2 I_3 ...)) integer) 
      (moveProgram((I_1 ... I_2) (I_3 ...)) ,(- (term integer) 1)) 
      (side-condition (> (term integer) 0))]
     [(moveProgram (() (I ...)) integer) 
      (() (I ...))]
     [(moveProgram ((I_1 ... I_2) (I_3 ...)) integer) 
      (moveProgram((I_1 ...) (I_2 I_3 ...)) ,(+ (term integer) 1))]
) 

(define-metafunction ParsingMachineLanguage
     moveInput : Input integer -> Input
     [(moveInput Input 0) Input]
     [(moveInput ((natural ...) ()) integer) ((natural ...) ()) (side-condition (> (term integer) 0))]
     [(moveInput ((natural_1 ...) (natural_2 natural_3 ...)) integer) (moveInput((natural_1 ... natural_2) (natural_3 ...)) ,(-  (term integer) 1)) (side-condition (> (term integer) 0))]
     [(moveInput (() (natural ...)) integer) (() (natural ...))]
     [(moveInput ((natural_1 ... natural_2) (natural_3 ...)) integer) (moveInput((natural_1 ...) (natural_2 natural_3 ...)) ,(+ (term integer) 1))]
) 

#;(firstJumpMove  (term (I_1 ...)) ((Jump natural) (term (I_2 ...))) (term natural))

#;(apply-reduction-relation PM (term (
                       suc
                        ()    
                        ((Char 97) (Char 99))    
                        () 
                        (97 98 99)          
                        0              
                        0              
                        ()))) 

#;(stepper PM (term (   suc
                        ()    
                        ((Char 97) (Char 99))    
                        () 
                        (97 98 99)          
                        0              
                        0              
                        ()))) 

(traces PM (term (      suc
                        (()    
                        ((Char 97) (Char 98) (Char 99)))  
                        (() 
                        (97 98 99 80))          
                        1              
                        0              
                        ((2 3)))))

#;(term (moveProgram (() ((Char 97) (Char 98) (Char 97) (Char 97) Any)) 7))
#;(term (moveProgram (() ((Char 97) (Char 98) (Char 97) (Char 97) Any)) 0))
#;(term (moveProgram (((Char 97) (Char 98) (Char 97)) ((Char 97) Any)) -2))