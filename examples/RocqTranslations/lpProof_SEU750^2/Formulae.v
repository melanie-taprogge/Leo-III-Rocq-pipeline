Require Import CNFeq.
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
Require Import Signature.
Require Import mappings.
Axiom setminusI_def : setminusI = (@all nat (fun v110210 : nat => @all nat (fun v110211 : nat => @all nat (fun v110212 : nat => (in_ v110212 v110210) -> (~ (in_ v110212 v110211)) -> in_ v110212 (setminus v110210 v110211))))).
Axiom setminusER_def : setminusER = (@all nat (fun v110213 : nat => @all nat (fun v110214 : nat => @all nat (fun v110215 : nat => (in_ v110215 (setminus v110213 v110214)) -> ~ (in_ v110215 v110214))))).
Axiom binunionTIRcontra_def : binunionTIRcontra = (@all nat (fun v110216 : nat => @all nat (fun v110217 : nat => (in_ v110217 (powerset v110216)) -> @all nat (fun v110218 : nat => (in_ v110218 (powerset v110216)) -> @all nat (fun v110219 : nat => (in_ v110219 v110216) -> (~ (in_ v110219 (binunion v110217 v110218))) -> ~ (in_ v110219 v110218)))))).
