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
require lpProof_SEV179^5.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol cD_FOR_X5309_def: π (S.cD_FOR_X5309 = (λ (A : τ ((ι ⤳ o) ⤳ ι)), λ (B : τ ι), (∃(λ (C : τ (ι ⤳ o)), ¬ C (A C) ∧ B = A C))));
