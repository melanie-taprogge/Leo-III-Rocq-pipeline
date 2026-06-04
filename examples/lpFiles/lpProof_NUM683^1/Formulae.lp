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
require lpProof_NUM683^1.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol satz6_p0: π (∀(λ (A : τ S.nat), (∀(λ (B : τ S.nat), S.pl A B = S.pl B A))));
symbol m_p1: π (S.more (S.pl S.z S.x) (S.pl S.z S.y));
symbol satz20a_p2: π (∀(λ (A : τ S.nat), (∀(λ (B : τ S.nat), (∀(λ (C : τ S.nat), S.more (S.pl A C) (S.pl B C) ⇒ S.more A B))))));
