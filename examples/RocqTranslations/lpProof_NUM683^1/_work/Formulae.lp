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
require lpProof_NUM683^1-noOp.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol satz6_p0: π (∀(λ (A : τ S.nat), (∀(λ (B : τ S.nat), S.pl A B = S.pl B A))));
symbol m_p1: π (S.more (S.pl S.z S.x) (S.pl S.z S.y));
symbol satz20a_p2: π (∀(λ (A : τ S.nat), (∀(λ (B : τ S.nat), (∀(λ (C : τ S.nat), S.more (S.pl A C) (S.pl B C) ⇒ S.more A B))))));
