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
require lpProof_SWV435^4.Signature as S; 




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
