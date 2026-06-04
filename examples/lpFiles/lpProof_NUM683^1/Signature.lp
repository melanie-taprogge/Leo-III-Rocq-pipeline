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


// OBJECT DECLARATIONS ///////////////////////////////////

symbol nat: Set;
symbol x: τ nat;
symbol y: τ nat;
symbol z: τ nat;
symbol more: τ (nat ⤳ (nat ⤳ o));
symbol pl: τ (nat ⤳ (nat ⤳ nat));
