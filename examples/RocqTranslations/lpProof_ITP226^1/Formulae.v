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
Axiom fact_8231_set__vebt__def_p0 : vEBT_set_vebt = (fun v112331 : vEBT_VEBT => collect_nat (vEBT_V8194947554948674370ptions v112331)).
Axiom conj_0_p1 : vEBT_invar_vebt t n.
Axiom fact_4_both__member__options__equiv__member_p2 : @all vEBT_VEBT (fun v112332 : vEBT_VEBT => @all lp_local_nat (fun v112333 : lp_local_nat => @all lp_local_nat (fun v112334 : lp_local_nat => (vEBT_invar_vebt v112332 v112333) -> (vEBT_V8194947554948674370ptions v112332 v112334) = (vEBT_vebt_member v112332 v112334)))).
Axiom fact_48_mem__Collect__eq_p3 : @all lp_local_nat (fun v112335 : lp_local_nat => @all (lp_local_nat -> o) (fun v112336 : lp_local_nat -> o => (member_nat v112335 (collect_nat v112336)) = (v112336 v112335))).
