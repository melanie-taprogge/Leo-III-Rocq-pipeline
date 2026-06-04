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
Axiom satz6_p0 : @all lp_local_nat (fun v110131 : lp_local_nat => @all lp_local_nat (fun v110132 : lp_local_nat => (pl v110131 v110132) = (pl v110132 v110131))).
Axiom m_p1 : more (pl z x) (pl z y).
Axiom satz20a_p2 : @all lp_local_nat (fun v110133 : lp_local_nat => @all lp_local_nat (fun v110134 : lp_local_nat => @all lp_local_nat (fun v110135 : lp_local_nat => (more (pl v110133 v110135) (pl v110134 v110135)) -> more v110133 v110134))).
