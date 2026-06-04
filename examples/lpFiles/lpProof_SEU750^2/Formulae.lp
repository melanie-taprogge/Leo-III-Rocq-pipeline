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
require lpProof_SEU750^2.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol setminusI_def: π (S.setminusI = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A ⇒ ¬ S.in_ C B ⇒ S.in_ C (S.setminus A B))))))));
symbol setminusER_def: π (S.setminusER = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setminus A B) ⇒ ¬ S.in_ C B)))))));
symbol binunionTIRcontra_def: π (S.binunionTIRcontra = (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) ⇒ (∀(λ (C : τ ι), S.in_ C (S.powerset A) ⇒ (∀(λ (D : τ ι), S.in_ D A ⇒ ¬ S.in_ D (S.binunion B C) ⇒ ¬ S.in_ D C)))))))));
