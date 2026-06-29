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
Axiom satz6_p0 : @all lp_local_nat (fun v112321 : lp_local_nat => @all lp_local_nat (fun v112322 : lp_local_nat => (pl v112321 v112322) = (pl v112322 v112321))).
Axiom m_p1 : more (pl z x) (pl z y).
Axiom satz20a_p2 : @all lp_local_nat (fun v112323 : lp_local_nat => @all lp_local_nat (fun v112324 : lp_local_nat => @all lp_local_nat (fun v112325 : lp_local_nat => (more (pl v112323 v112325) (pl v112324 v112325)) -> more v112323 v112324))).
