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


// OBJECT DECLARATIONS ///////////////////////////////////

symbol in_: τ (ι ⤳ (ι ⤳ o));
symbol powerset: τ (ι ⤳ ι);
symbol binunion: τ (ι ⤳ (ι ⤳ ι));
symbol setminus: τ (ι ⤳ (ι ⤳ ι));
symbol setminusI: τ o;
symbol setminusER: τ o;
symbol binunionTIRcontra: τ o;
