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
Axiom in_ : nat -> nat -> o.
Axiom exu : (nat -> o) -> o.
Axiom setextAx : o.
Axiom emptyset : nat.
Axiom emptysetAx : o.
Axiom setadjoin : nat -> nat -> nat.
Axiom setadjoinAx : o.
Axiom powerset : nat -> nat.
Axiom powersetAx : o.
Axiom setunion : nat -> nat.
Axiom setunionAx : o.
Axiom omega : nat.
Axiom omega0Ax : o.
Axiom omegaSAx : o.
Axiom omegaIndAx : o.
Axiom replAx : o.
Axiom foundationAx : o.
Axiom wellorderingAx : o.
Axiom descr : (nat -> o) -> nat.
Axiom descrp : o.
Axiom dsetconstr : nat -> (nat -> o) -> nat.
Axiom dsetconstrI : o.
Axiom dsetconstrEL : o.
Axiom dsetconstrER : o.
Axiom exuE1 : o.
Axiom prop2set : o -> nat.
Axiom prop2setE : o.
Axiom emptysetE : o.
Axiom emptysetimpfalse : o.
Axiom notinemptyset : o.
Axiom exuE3e : o.
Axiom setext : o.
Axiom emptyI : o.
Axiom noeltsimpempty : o.
Axiom setbeta : o.
Axiom nonempty : nat -> o.
Axiom nonemptyE1 : o.
Axiom nonemptyI : o.
Axiom nonemptyI1 : o.
Axiom setadjoinIL : o.
Axiom emptyinunitempty : o.
Axiom setadjoinIR : o.
Axiom setadjoinE : o.
Axiom setadjoinOr : o.
Axiom setoftrueEq : o.
