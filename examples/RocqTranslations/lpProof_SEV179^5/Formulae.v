Require Import CNFeq.
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
Require Import Signature.
Require Import mappings.
Axiom cD_FOR_X5309_def : cD_FOR_X5309 = (fun v110097 : (nat -> o) -> nat => fun v110098 : nat => ex_ (nat -> o) (fun v110099 : nat -> o => (~ (v110099 (v110097 v110099))) /\ (v110098 = (v110097 v110099)))).
