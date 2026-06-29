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
Axiom mfalse : iota_type -> o.
Axiom mtrue : iota_type -> o.
Axiom mor : (iota_type -> o) -> (iota_type -> o) -> iota_type -> o.
Axiom mbox : (iota_type -> iota_type -> o) -> (iota_type -> o) -> iota_type -> o.
Axiom individuals : Type'.
Axiom mvalid : (iota_type -> o) -> o.
Axiom rel : iota_type -> iota_type -> o.
Axiom icl_princ : (iota_type -> o) -> iota_type -> o.
Axiom icl_true : iota_type -> o.
Axiom icl_false : iota_type -> o.
Axiom icl_says : (iota_type -> o) -> (iota_type -> o) -> iota_type -> o.
Axiom iclval : (iota_type -> o) -> o.
Axiom a : iota_type -> o.
