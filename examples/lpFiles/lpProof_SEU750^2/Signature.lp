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

symbol in_: τ (ι ⤳ (ι ⤳ o));
symbol powerset: τ (ι ⤳ ι);
symbol binunion: τ (ι ⤳ (ι ⤳ ι));
symbol setminus: τ (ι ⤳ (ι ⤳ ι));
symbol setminusI: τ o;
symbol setminusER: τ o;
symbol binunionTIRcontra: τ o;
