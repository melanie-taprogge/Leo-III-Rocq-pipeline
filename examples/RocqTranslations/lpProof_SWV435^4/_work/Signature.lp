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

symbol mfalse: τ (ι ⤳ o);
symbol mtrue: τ (ι ⤳ o);
symbol mor: τ ((ι ⤳ o) ⤳ ((ι ⤳ o) ⤳ (ι ⤳ o)));
symbol mbox: τ ((ι ⤳ (ι ⤳ o)) ⤳ ((ι ⤳ o) ⤳ (ι ⤳ o)));
symbol individuals: Set;
symbol mvalid: τ ((ι ⤳ o) ⤳ o);
symbol rel: τ (ι ⤳ (ι ⤳ o));
symbol icl_princ: τ ((ι ⤳ o) ⤳ (ι ⤳ o));
symbol icl_true: τ (ι ⤳ o);
symbol icl_false: τ (ι ⤳ o);
symbol icl_says: τ ((ι ⤳ o) ⤳ ((ι ⤳ o) ⤳ (ι ⤳ o)));
symbol iclval: τ ((ι ⤳ o) ⤳ o);
symbol a: τ (ι ⤳ o);
