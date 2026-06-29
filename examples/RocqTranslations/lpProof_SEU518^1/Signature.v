Require Import EPrules.
Require Import MetaTheorems.
Require Import Bool.
Require Import Classic.
Require Import Conj.
Require Import Disj.
Require Import Epsilon.
Require Import Eq.
Require Import FOL.
Require Import FunExt.
Require Import HOL.
Require Import Impred.
Require Import Prod.
Require Import PropExt.
Require Import mappings.
Axiom in_ : iota_type -> iota_type -> o.
Axiom exu : (iota_type -> o) -> o.
Axiom setextAx : o.
Axiom emptyset : iota_type.
Axiom emptysetAx : o.
Axiom setadjoin : iota_type -> iota_type -> iota_type.
Axiom setadjoinAx : o.
Axiom powerset : iota_type -> iota_type.
Axiom powersetAx : o.
Axiom setunion : iota_type -> iota_type.
Axiom setunionAx : o.
Axiom omega : iota_type.
Axiom omega0Ax : o.
Axiom omegaSAx : o.
Axiom omegaIndAx : o.
Axiom replAx : o.
Axiom foundationAx : o.
Axiom wellorderingAx : o.
Axiom descr : (iota_type -> o) -> iota_type.
Axiom descrp : o.
Axiom dsetconstr : iota_type -> (iota_type -> o) -> iota_type.
Axiom dsetconstrI : o.
Axiom dsetconstrEL : o.
Axiom dsetconstrER : o.
Axiom exuE1 : o.
Axiom prop2set : o -> iota_type.
Axiom prop2setE : o.
Axiom emptysetE : o.
Axiom emptysetimpfalse : o.
Axiom notinemptyset : o.
Axiom exuE3e : o.
Axiom setext : o.
Axiom emptyI : o.
Axiom noeltsimpempty : o.
Axiom setbeta : o.
Axiom nonempty : iota_type -> o.
Axiom nonemptyE1 : o.
Axiom nonemptyI : o.
Axiom nonemptyI1 : o.
Axiom setadjoinIL : o.
Axiom emptyinunitempty : o.
Axiom setadjoinIR : o.
Axiom setadjoinE : o.
Axiom setadjoinOr : o.
Axiom setoftrueEq : o.
