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
Axiom fact_8231_set__vebt__def_p0 : vEBT_set_vebt = (fun v110141 : vEBT_VEBT => collect_nat (vEBT_V8194947554948674370ptions v110141)).
Axiom conj_0_p1 : vEBT_invar_vebt t n.
Axiom fact_4_both__member__options__equiv__member_p2 : @all vEBT_VEBT (fun v110142 : vEBT_VEBT => @all lp_local_nat (fun v110143 : lp_local_nat => @all lp_local_nat (fun v110144 : lp_local_nat => (vEBT_invar_vebt v110142 v110143) -> (vEBT_V8194947554948674370ptions v110142 v110144) = (vEBT_vebt_member v110142 v110144)))).
Axiom fact_48_mem__Collect__eq_p3 : @all lp_local_nat (fun v110145 : lp_local_nat => @all (lp_local_nat -> o) (fun v110146 : lp_local_nat -> o => (member_nat v110145 (collect_nat v110146)) = (v110146 v110145))).
