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
require lpProof_SEU750^2-noOp.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol setminusI_def: π (S.setminusI = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A ⇒ ¬ S.in_ C B ⇒ S.in_ C (S.setminus A B))))))));
symbol setminusER_def: π (S.setminusER = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setminus A B) ⇒ ¬ S.in_ C B)))))));
symbol binunionTIRcontra_def: π (S.binunionTIRcontra = (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) ⇒ (∀(λ (C : τ ι), S.in_ C (S.powerset A) ⇒ (∀(λ (D : τ ι), S.in_ D A ⇒ ¬ S.in_ D (S.binunion B C) ⇒ ¬ S.in_ D C)))))))));
