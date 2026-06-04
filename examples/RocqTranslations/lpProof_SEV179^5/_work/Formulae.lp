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
require lpProof_SEV179^5-noOp.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol cD_FOR_X5309_def: π (S.cD_FOR_X5309 = (λ (A : τ ((ι ⤳ o) ⤳ ι)), λ (B : τ ι), (∃(λ (C : τ (ι ⤳ o)), ¬ C (A C) ∧ B = A C))));
