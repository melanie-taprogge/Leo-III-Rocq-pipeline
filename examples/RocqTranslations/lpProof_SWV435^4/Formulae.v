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
Axiom mfalse_def : mfalse = (fun v110164 : nat => False).
Axiom mtrue_def : mtrue = (fun v110165 : nat => True).
Axiom mor_def : mor = (fun v110166 : nat -> o => fun v110167 : nat -> o => fun v110168 : nat => (v110166 v110168) \/ (v110167 v110168)).
Axiom mbox_def : mbox = (fun v110169 : nat -> nat -> o => fun v110170 : nat -> o => fun v110171 : nat => @all nat (fun v110172 : nat => (v110169 v110171 v110172) -> v110170 v110172)).
Axiom mvalid_def : mvalid = (@all nat).
Axiom icl_princ_def : icl_princ = (fun v110173 : nat -> o => v110173).
Axiom icl_true_def : icl_true = mtrue.
Axiom icl_false_def : icl_false = mfalse.
Axiom icl_says_def : icl_says = (fun v110174 : nat -> o => fun v110175 : nat -> o => mbox rel (mor v110174 v110175)).
Axiom iclval_def : iclval = mvalid.
Axiom ax1_p0 : (icl_princ a) = icl_true.
