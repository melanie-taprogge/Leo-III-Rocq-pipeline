Require Import EPrules.
Require Import MetaTheorems.
Require Import Bool.
Require Import Classic.
Require Import Conj.
Require Import Disj.
Require Import Epsilon.
Require Import Eq.
Require Import FOL.
Require Import FunExt.
Require Import HOL.
Require Import Impred.
Require Import Prod.
Require Import PropExt.
Require Import mappings.
Axiom mfalse : nat -> o.
Axiom mtrue : nat -> o.
Axiom mor : (nat -> o) -> (nat -> o) -> nat -> o.
Axiom mbox : (nat -> nat -> o) -> (nat -> o) -> nat -> o.
Axiom individuals : Type'.
Axiom mvalid : (nat -> o) -> o.
Axiom rel : nat -> nat -> o.
Axiom icl_princ : (nat -> o) -> nat -> o.
Axiom icl_true : nat -> o.
Axiom icl_false : nat -> o.
Axiom icl_says : (nat -> o) -> (nat -> o) -> nat -> o.
Axiom iclval : (nat -> o) -> o.
Axiom a : nat -> o.
