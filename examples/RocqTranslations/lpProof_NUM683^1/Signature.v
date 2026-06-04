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
Axiom lp_local_nat : Type'.
Axiom x : lp_local_nat.
Axiom y : lp_local_nat.
Axiom z : lp_local_nat.
Axiom more : lp_local_nat -> lp_local_nat -> o.
Axiom pl : lp_local_nat -> lp_local_nat -> lp_local_nat.
