# Formalization of a Parsing Machine for PEGs in PLT Redex

This repository contains the implementation of a **Parsing Machine for Parsing Expression Grammars (PEGs)** using **PLT Redex**.  
The project was developed as part of my undergraduate thesis at the Federal University of Juiz de Fora.

## 📖 About the Project

In computer science, *parsing* is the process of analyzing a sequence of data to verify whether it follows specific rules.  
Parsing Expression Grammars (PEGs) provide a recognition-based foundation for syntactic analysis, ensuring deterministic parsing without ambiguities.

This work is based on the article *"A Parsing Machine for PEGs"* by Sérgio Medeiros and Roberto Ierusalimschy (2008), which introduces a virtual machine for PEGs defined by a set of instructions.  

The goal of this project is to provide an **executable formalization** of this parsing machine using **PLT Redex**, a Racket library for defining and experimenting with programming languages and semantic models.  

## 🛠️ Technologies

- [Racket](https://racket-lang.org/)  
- [PLT Redex](https://docs.racket-lang.org/redex/index.html)  

## 📂 Repository Structure

- `TheParsingMachineLanguage.rkt` → defines the language accepted by the parsing machine, including instructions, program structure, input representation, stack, and machine states.  
- `TheParsingMachineReduction.rkt` → defines the reduction relations that describe the operational semantics of the parsing machine.  

## 📊 Results

- Complete implementation of a PEG parsing machine in PLT Redex.
- Successful tests validating the reduction rules for all instructions.
- Demonstrates the practical use of Redex for executable formalizations of semantic models.

## 📚 References

- Medeiros, S., & Ierusalimschy, R. (2008). A Parsing Machine for PEGs. Symposium on Dynamic Languages.
- Felleisen, M., Findler, R. B., & Flatt, M. (2009). Semantics Engineering with PLT Redex. MIT Press.
- Ford, B. (2004). Parsing Expression Grammars: A Recognition-Based Syntactic Foundation. POPL.

## 👩‍💻 Developed by 
Maria Eduarda de Medeiros Simonassi
Federal University of Juiz de Fora
