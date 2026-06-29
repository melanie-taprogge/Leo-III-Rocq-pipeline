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
Axiom cD_FOR_X5309_def : cD_FOR_X5309 = (fun v112287 : (iota_type -> o) -> iota_type => fun v112288 : iota_type => ex_ (iota_type -> o) (fun v112289 : iota_type -> o => (~ (v112289 (v112287 v112289))) /\ (v112288 = (v112287 v112289)))).
