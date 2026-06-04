require open Stdlib.Set;
require open Stdlib.Prop;
require open Stdlib.Classic;
require open Stdlib.FOL;
require open Stdlib.HOL;
require open Stdlib.Eq;
require open Stdlib.Impred;
require open Stdlib.FunExt;
require open Stdlib.PropExt;
require open Stdlib.Nat;
require open Stdlib.Bool;
require open Stdlib.List;
require open Stdlib.Epsilon;
require open Stdlib.Disj;
require open Stdlib.Conj;
require open Leo-III-lambdapi-lib.EPrules;
require open Leo-III-lambdapi-lib.MetaTheorems;
require open Leo-III-lambdapi-lib.UserTactic;
require lpProof_ITP226^1.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol fact_8231_set__vebt__def_p0: π (S.vEBT_set_vebt = (λ (A : τ S.vEBT_VEBT), S.collect_nat (S.vEBT_V8194947554948674370ptions A)));
symbol conj_0_p1: π (S.vEBT_invar_vebt S.t S.n);
symbol fact_4_both__member__options__equiv__member_p2: π (∀(λ (A : τ S.vEBT_VEBT), (∀(λ (B : τ S.nat), (∀(λ (C : τ S.nat), S.vEBT_invar_vebt A B ⇒ S.vEBT_V8194947554948674370ptions A C = S.vEBT_vebt_member A C))))));
symbol fact_48_mem__Collect__eq_p3: π (∀(λ (A : τ S.nat), (∀(λ (B : τ (S.nat ⤳ o)), S.member_nat A (S.collect_nat B) = B A))));
