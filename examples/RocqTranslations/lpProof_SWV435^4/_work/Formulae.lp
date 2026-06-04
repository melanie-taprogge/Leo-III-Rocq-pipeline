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
require lpProof_SWV435^4-noOp.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol mfalse_def: π (S.mfalse = (λ (A : τ ι), ⊥));
symbol mtrue_def: π (S.mtrue = (λ (A : τ ι), ⊤));
symbol mor_def: π (S.mor = (λ (A : τ (ι ⤳ o)), λ (B : τ (ι ⤳ o)), λ (C : τ ι), A C ∨ B C));
symbol mbox_def: π (S.mbox = (λ (A : τ (ι ⤳ (ι ⤳ o))), λ (B : τ (ι ⤳ o)), λ (C : τ ι), (∀(λ (D : τ ι), A C D ⇒ B D))));
symbol mvalid_def: π (S.mvalid = (∀) [ι]);
symbol icl_princ_def: π (S.icl_princ = (λ (A : τ (ι ⤳ o)), A));
symbol icl_true_def: π (S.icl_true = S.mtrue);
symbol icl_false_def: π (S.icl_false = S.mfalse);
symbol icl_says_def: π (S.icl_says = (λ (A : τ (ι ⤳ o)), λ (B : τ (ι ⤳ o)), S.mbox S.rel (S.mor A B)));
symbol iclval_def: π (S.iclval = S.mvalid);
symbol ax1_p0: π (S.icl_princ S.a = S.icl_true);
