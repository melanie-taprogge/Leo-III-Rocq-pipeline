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
Axiom mfalse_def : mfalse = (fun v112354 : iota_type => False).
Axiom mtrue_def : mtrue = (fun v112355 : iota_type => True).
Axiom mor_def : mor = (fun v112356 : iota_type -> o => fun v112357 : iota_type -> o => fun v112358 : iota_type => (v112356 v112358) \/ (v112357 v112358)).
Axiom mbox_def : mbox = (fun v112359 : iota_type -> iota_type -> o => fun v112360 : iota_type -> o => fun v112361 : iota_type => @all iota_type (fun v112362 : iota_type => (v112359 v112361 v112362) -> v112360 v112362)).
Axiom mvalid_def : mvalid = (@all iota_type).
Axiom icl_princ_def : icl_princ = (fun v112363 : iota_type -> o => v112363).
Axiom icl_true_def : icl_true = mtrue.
Axiom icl_false_def : icl_false = mfalse.
Axiom icl_says_def : icl_says = (fun v112364 : iota_type -> o => fun v112365 : iota_type -> o => mbox rel (mor v112364 v112365)).
Axiom iclval_def : iclval = mvalid.
Axiom ax1_p0 : (icl_princ a) = icl_true.
