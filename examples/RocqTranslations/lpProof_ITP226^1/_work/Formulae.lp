require open Stdlib-noOp.Set;
require open Stdlib-noOp.Prop;
require open Stdlib-noOp.Classic;
require open Stdlib-noOp.FOL;
require open Stdlib-noOp.HOL;
require open Stdlib-noOp.Eq;
require open Stdlib-noOp.Impred;
require open Stdlib-noOp.FunExt;
require open Stdlib-noOp.PropExt;
require open Stdlib-noOp.Nat;
require open Stdlib-noOp.Bool;
require open Stdlib-noOp.List;
require open Stdlib-noOp.Epsilon;
require open Stdlib-noOp.Disj;
require open Stdlib-noOp.Conj;
require open Leo-III-lambdapi-lib-noOp.EPrules;
require open Leo-III-lambdapi-lib-noOp.MetaTheorems;
require open Leo-III-lambdapi-lib-noOp.UserTactic;
require lpProof_ITP226^1-noOp.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol fact_8231_set__vebt__def_p0: π (S.vEBT_set_vebt = (λ (A : τ S.vEBT_VEBT), S.collect_nat (S.vEBT_V8194947554948674370ptions A)));
symbol conj_0_p1: π (S.vEBT_invar_vebt S.t S.n);
symbol fact_4_both__member__options__equiv__member_p2: π (∀(λ (A : τ S.vEBT_VEBT), (∀(λ (B : τ S.nat), (∀(λ (C : τ S.nat), S.vEBT_invar_vebt A B ⇒ S.vEBT_V8194947554948674370ptions A C = S.vEBT_vebt_member A C))))));
symbol fact_48_mem__Collect__eq_p3: π (∀(λ (A : τ S.nat), (∀(λ (B : τ (S.nat ⤳ o)), S.member_nat A (S.collect_nat B) = B A))));
