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
Axiom powerset : iota_type -> iota_type.
Axiom binunion : iota_type -> iota_type -> iota_type.
Axiom setminus : iota_type -> iota_type -> iota_type.
Axiom setminusI : o.
Axiom setminusER : o.
Axiom binunionTIRcontra : o.
