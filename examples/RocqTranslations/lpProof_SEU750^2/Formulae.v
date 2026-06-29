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
Axiom setminusI_def : setminusI = (@all iota_type (fun v112400 : iota_type => @all iota_type (fun v112401 : iota_type => @all iota_type (fun v112402 : iota_type => (in_ v112402 v112400) -> (~ (in_ v112402 v112401)) -> in_ v112402 (setminus v112400 v112401))))).
Axiom setminusER_def : setminusER = (@all iota_type (fun v112403 : iota_type => @all iota_type (fun v112404 : iota_type => @all iota_type (fun v112405 : iota_type => (in_ v112405 (setminus v112403 v112404)) -> ~ (in_ v112405 v112404))))).
Axiom binunionTIRcontra_def : binunionTIRcontra = (@all iota_type (fun v112406 : iota_type => @all iota_type (fun v112407 : iota_type => (in_ v112407 (powerset v112406)) -> @all iota_type (fun v112408 : iota_type => (in_ v112408 (powerset v112406)) -> @all iota_type (fun v112409 : iota_type => (in_ v112409 v112406) -> (~ (in_ v112409 (binunion v112407 v112408))) -> ~ (in_ v112409 v112408)))))).
