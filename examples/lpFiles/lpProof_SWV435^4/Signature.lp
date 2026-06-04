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
