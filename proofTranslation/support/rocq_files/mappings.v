From Stdlib Require Export Classical_Prop.
From Stdlib Require Export ClassicalEpsilon.
From Stdlib Require Export Bool.Bool.
From Stdlib Require Export Arith.PeanoNat.
From Stdlib Require Export Lists.List.
From Stdlib Require Export Lia.

(*************************************************************************)
(* Core correspondence mappings                                           *)
(*                                                                       *)
(* These definitions are intended to express the direct target encoding:  *)
(* Lambdapi/STT primitives and basic library symbols as native Rocq terms. *)
(*************************************************************************)

(* Prop.lp *)
Definition imp (p q : Prop) : Prop := p -> q.
Definition or_elim (A B P : Prop) (h : A \/ B) (ha : A -> P) (hb : B -> P) : P :=
  match h with
  | or_introl a => ha a
  | or_intror b => hb b
  end.

(* Set.lp *)
Record Type' := { type :> Type; el : type }.

(* Fol.lp *)
Definition all (a : Type') (P: a -> Prop) : Prop := forall x:a, P x.
Definition ex_ (a : Type') (P: a -> Prop) : Prop := exists x:a, P x.
Definition ex_elim (a : Type') (P : a -> Prop) (h : ex_ a P) (Q : Prop)
    (k : forall x : a, P x -> Q) : Q :=
  match h with
  | ex_intro _ x px => k x px
  end.

(* Hol.lp *)
Definition arr a (b : Type') := {| type := a -> b; el := fun _ => el b |}.
Canonical arr.

(* Impred.lp *)
Definition o := {| type := Prop; el := True |}.
Canonical o.

(* Eq.lp *)
Lemma ind_eq : forall {a : Type'} {x y : a}, (x = y) -> forall p, (p y) -> p x.
Proof.
  intros a x y e p py. rewrite e. exact py.
Qed.
Definition neq {a : Type'} (x y : a) := ~ (x = y).

(* Prod.lp *)
Definition lp_u00d7 (a b : Type') : Type' := {| type := (a * b)%type; el := (el a, el b) |}.
Canonical lp_u00d7.
Definition lp_u201a (a b : Type') (x : a) (y : b) : lp_u00d7 a b := (x, y).
Definition lp_u2081 (a b : Type') (p : lp_u00d7 a b) : a := fst p.
Definition lp_u2082 (a b : Type') (p : lp_u00d7 a b) : b := snd p.

(* Bool.lp *)
Definition bool' := {| type := bool ; el := true|}.
Canonical bool'.
Definition injectiveistrue : bool' -> Prop := Is_true.

(*************************************************************************)
(* Stdlib shim workaround mappings                                        *)
(*                                                                       *)
(* These constants replace Lambdapi/Dedukti stdlib declarations or        *)
(* theorem proofs whose original checking relied on rewrite rules. They   *)
(* are proved or defined once in Rocq, then selected through mappings.lp.  *)
(*************************************************************************)

(* Bool.lp shim *)

Definition case_𝔹 (b : bool) : b = true \/ b = false :=
  match b with
  | true => or_introl eq_refl
  | false => or_intror eq_refl
  end.

Lemma ind_𝔹_eq (P : bool -> Prop) (b : bool)
    (ht : b = true -> P b) (hf : b = false -> P b) : P b.
Proof. destruct b; [apply ht | apply hf]; reflexivity. Qed.

Definition istrue_eq_true (b : bool) : Is_true b -> b = true :=
  match b with
  | true => fun _ => eq_refl
  | false => fun h => False_ind _ h
  end.

Lemma true_eq_istrue (b : bool) : b = true -> Is_true b.
Proof. intros ->. exact I. Qed.

Definition not_istrue_eq_false (b : bool) : ~ Is_true b -> b = false :=
  match b with
  | true => fun h => False_ind _ (h I)
  | false => fun _ => eq_refl
  end.

Lemma false_eq_not_istrue (b : bool) : b = false -> ~ Is_true b.
Proof. intros -> h. exact h. Qed.

Definition false_neq_true : false <> true := fun h => Bool.diff_false_true h.
Definition true_neq_false : true <> false := fun h => Bool.diff_true_false h.

Definition not_istrue (b : bool) : ~ Is_true b -> Is_true (negb b) :=
  match b with
  | true => fun h => False_ind _ (h I)
  | false => fun _ => I
  end.

Definition bool_istrue_not (b : bool) : Is_true (negb b) -> ~ Is_true b :=
  match b with
  | true => fun h _ => h
  | false => fun _ h => h
  end.

Definition or_istrue (p q : bool) : Is_true (orb p q) -> Is_true p \/ Is_true q :=
  match p, q with
  | true, _ => fun _ => or_introl I
  | false, true => fun _ => or_intror I
  | false, false => fun h => False_ind _ h
  end.

Definition bool_istrue_or (p q : bool) : Is_true p \/ Is_true q -> Is_true (orb p q) :=
  match p, q with
  | true, _ => fun _ => I
  | false, true => fun _ => I
  | false, false => fun h => or_elim _ _ _ h (fun f => f) (fun f => f)
  end.

Definition or_i1 (p q : bool) : Is_true p -> Is_true (orb p q) :=
  fun h => bool_istrue_or p q (or_introl h).

Definition or_i2 (p q : bool) : Is_true q -> Is_true (orb p q) :=
  fun h => bool_istrue_or p q (or_intror h).

Definition or_e (p q r : bool) : Is_true (orb p q) ->
    (Is_true p -> Is_true r) -> (Is_true q -> Is_true r) -> Is_true r :=
  fun hpq hpr hqr => or_elim _ _ _ (or_istrue p q hpq) hpr hqr.

Definition orC : forall p q : bool, orb p q = orb q p := Bool.orb_comm.
Definition orA : forall p q r : bool, orb (orb p q) r = orb p (orb q r) :=
  fun p q r => eq_sym (Bool.orb_assoc p q r).

Definition and_istrue (p q : bool) : Is_true (andb p q) -> Is_true p /\ Is_true q :=
  match p, q with
  | true, true => fun _ => conj I I
  | true, false => fun h => False_ind _ h
  | false, true => fun h => False_ind _ h
  | false, false => fun h => False_ind _ h
  end.

Definition bool_istrue_and (p q : bool) : Is_true p /\ Is_true q -> Is_true (andb p q) :=
  match p, q with
  | true, true => fun _ => I
  | true, false => fun h => proj2 h
  | false, true => fun h => proj1 h
  | false, false => fun h => proj1 h
  end.

Definition and_i (p q : bool) : Is_true p -> Is_true q -> Is_true (andb p q) :=
  fun hp hq => bool_istrue_and p q (conj hp hq).

Definition and_e1 (p q : bool) : Is_true (andb p q) -> Is_true p :=
  fun h => proj1 (and_istrue p q h).

Definition and_e2 (p q : bool) : Is_true (andb p q) -> Is_true q :=
  fun h => proj2 (and_istrue p q h).

Definition if' (b : bool) {a : Type'} (e1 : a) (e2 : a) := 
    if b then e1 else e2.

(* Nat.lp shim *)
Definition nat' := {| type := nat; el := O |}.
Canonical nat'.

(* Numeric constants exported through Dedukti can appear as Nat._1, Nat._2, ...
   after module-prefix stripping. Rocq accepts these names, so expose aliases. *)
Definition _1 : nat := S O.
Definition _2 : nat := S _1.
Definition _3 : nat := S _2.
Definition _4 : nat := S _3.
Definition _5 : nat := S _4.
Definition _6 : nat := S _5.
Definition _7 : nat := S _6.
Definition _8 : nat := S _7.
Definition _9 : nat := S _8.
Definition _10 : nat := S _9.
Definition _11 : nat := S _10.
Definition _12 : nat := S _11.
Definition _13 : nat := S _12.
Definition _14 : nat := S _13.
Definition _15 : nat := S _14.
Definition _16 : nat := S _15.

Definition is0 (n : nat) := Nat.eqb n O.
Definition eqn := Nat.eqb.
Definition leq := Nat.leb.
Definition ltn (n m : nat) := Nat.leb (S n) m.
Definition geq (n m : nat) := Nat.leb m n.
Definition gtn (n m : nat) := Nat.leb (S m) n.
Definition maxn := Nat.max.
Definition minn := Nat.min.
Definition expn := Nat.pow.

Fixpoint factn (n : nat) : nat :=
  match n with
  | O => S O
  | S p => Nat.mul (S p) (factn p)
  end.

Lemma eqn_correct (n m : nat) : Is_true (eqn n m) -> n = m.
Proof.
  unfold eqn.
  destruct (Nat.eqb_spec n m); [exact (fun _ => e) | simpl; contradiction].
Qed.

Lemma eqn_complete (n m : nat) : n = m -> Is_true (eqn n m).
Proof.
  intros ->. unfold eqn. rewrite Nat.eqb_refl. exact I.
Qed.

Lemma eqn_refl (n : nat) : Is_true (eqn n n).
Proof. apply eqn_complete. reflexivity. Qed.

Lemma eqn_sym (n m : nat) : Is_true (eqn n m) -> Is_true (eqn m n).
Proof.
  intro h. apply eqn_complete. symmetry. apply eqn_correct. exact h.
Qed.

Lemma lp_s_u2260_0 (n : nat) : @neq nat' (S n) O.
Proof. unfold neq. discriminate. Qed.

Lemma lp_0_u2260_s (n : nat) : @neq nat' O (S n).
Proof. unfold neq. discriminate. Qed.

Lemma casen (n : nat') : n = O \/ @neq nat' n O.
Proof.
  destruct n as [|n]; [left; reflexivity | right; apply lp_s_u2260_0].
Qed.

Lemma lp_u002b_1_inj (n m : nat') : S n = S m -> n = m.
Proof. intros h. injection h. exact id. Qed.

Lemma add0n (n : nat') : Nat.add O n = n.
Proof. reflexivity. Qed.

Lemma addn0 (n : nat') : Nat.add n O = n.
Proof. lia. Qed.

Lemma addSn (n m : nat) : Nat.add (S n) m = S (Nat.add n m).
Proof. reflexivity. Qed.

Lemma addnS (n m : nat) : Nat.add n (S m) = S (Nat.add n m).
Proof. lia. Qed.

Lemma add1n (n : nat) : Nat.add (S O) n = S n.
Proof. reflexivity. Qed.

Lemma addn1 (n : nat) : Nat.add n (S O) = S n.
Proof. lia. Qed.

Lemma addnC (n m : nat) : Nat.add n m = Nat.add m n.
Proof. lia. Qed.

Definition addSnnS (n m : nat) : Nat.add (S n) m = Nat.add n (S m) :=
  eq_sym (Nat.add_succ_r n m).

Definition addnA (n m p : nat) : Nat.add (Nat.add n m) p = Nat.add n (Nat.add m p) :=
  eq_sym (Nat.add_assoc n m p).

Lemma addnCA (n m p : nat) : Nat.add (Nat.add n m) p = Nat.add (Nat.add n p) m.
Proof. lia. Qed.

Lemma addnAC (n m p : nat) : Nat.add n (Nat.add m p) = Nat.add m (Nat.add n p).
Proof. lia. Qed.

Lemma addnCAC (n m p : nat) : Nat.add (Nat.add n m) p = Nat.add (Nat.add p m) n.
Proof. lia. Qed.

Lemma addnACl (n m p : nat) : Nat.add (Nat.add n m) p = Nat.add m (Nat.add p n).
Proof. lia. Qed.

Lemma addnACA (n m p q : nat) :
  Nat.add (Nat.add n m) (Nat.add p q) = Nat.add (Nat.add n p) (Nat.add m q).
Proof. lia. Qed.

Lemma addnI (n m p : nat) : Nat.add p n = Nat.add p m -> n = m.
Proof. lia. Qed.

Lemma addIn (n m p : nat) : Nat.add n p = Nat.add m p -> n = m.
Proof. lia. Qed.

Lemma addn_eq0 (n m : nat') : iff (Nat.add n m = O) (n = O /\ m = O).
Proof. split; intros; lia. Qed.

Lemma eqn_add2l (n m p : nat) : iff (Nat.add n m = Nat.add n p) (m = p).
Proof. split; intros; lia. Qed.

Lemma eqn_add2r (n m p : nat) : iff (Nat.add m n = Nat.add p n) (m = p).
Proof. split; intros; lia. Qed.

Lemma lp_2_u002a_u003d_0 (n : nat) : Nat.add n n = O -> n = O.
Proof. lia. Qed.

Lemma lp_2_u002a_inj (n m : nat) : Nat.add n n = Nat.add m m -> n = m.
Proof. lia. Qed.

Lemma lp_odd_u2260_even (n m : nat) : @neq nat' (S (Nat.add n n)) (Nat.add m m).
Proof. unfold neq. lia. Qed.

Lemma sub0n (n : nat) : Nat.sub n O = n.
Proof. lia. Qed.

Lemma subn0 (n : nat) : Nat.sub O n = O.
Proof. destruct n; reflexivity. Qed.

Lemma subn1 (n : nat) : Nat.sub n (S O) = pred n.
Proof. lia. Qed.

Lemma subSS (n m : nat) : Nat.sub (S n) (S m) = Nat.sub n m.
Proof. reflexivity. Qed.

Lemma subSnn (n : nat) : Nat.sub (S n) n = S O.
Proof. lia. Qed.

Lemma subnn (n : nat) : Nat.sub n n = O.
Proof. lia. Qed.

Lemma subnS (n m : nat) : Nat.sub n (S m) = pred (Nat.sub n m).
Proof. lia. Qed.

Lemma predn_sub (n m : nat) : pred (Nat.sub n m) = Nat.sub (pred n) m.
Proof. lia. Qed.

Lemma subnAC (n m p : nat) : Nat.sub (Nat.sub m p) n = Nat.sub (Nat.sub m n) p.
Proof. lia. Qed.

Lemma addnK (n m : nat) : Nat.sub (Nat.add n m) m = n.
Proof. lia. Qed.

Lemma subnDA (n m p : nat) : Nat.sub n (Nat.add m p) = Nat.sub (Nat.sub n m) p.
Proof. lia. Qed.

Lemma subnDl (n m p : nat) : Nat.sub (Nat.add n m) (Nat.add n p) = Nat.sub m p.
Proof. lia. Qed.

Lemma subnDr (n m p : nat) : Nat.sub (Nat.add m n) (Nat.add p n) = Nat.sub m p.
Proof. lia. Qed.

Lemma subSKn (n m : nat) : pred (Nat.sub (S n) m) = Nat.sub n m.
Proof. lia. Qed.

Lemma mul0n (n : nat) : Nat.mul n O = O.
Proof. nia. Qed.

Lemma muln0 (n : nat) : Nat.mul O n = O.
Proof. nia. Qed.

Lemma mul1n (n : nat) : Nat.mul (S O) n = n.
Proof. nia. Qed.

Lemma muln1 (n : nat) : Nat.mul n (S O) = n.
Proof. nia. Qed.

Lemma mulSn (n m : nat) : Nat.mul (S n) m = Nat.add m (Nat.mul n m).
Proof. nia. Qed.

Lemma mulSnr (n m : nat) : Nat.mul (S n) m = Nat.add (Nat.mul n m) m.
Proof. nia. Qed.

Lemma mulnS (n m : nat) : Nat.mul n (S m) = Nat.add n (Nat.mul n m).
Proof. nia. Qed.

Lemma mulnSr (n m : nat) : Nat.mul n (S m) = Nat.add (Nat.mul n m) n.
Proof. nia. Qed.

Lemma mulnC (n m : nat) : Nat.mul n m = Nat.mul m n.
Proof. nia. Qed.

Lemma mulnDl (n m p : nat) : Nat.mul (Nat.add n m) p = Nat.add (Nat.mul n p) (Nat.mul m p).
Proof. nia. Qed.

Lemma mulnDr (n m p : nat) : Nat.mul p (Nat.add n m) = Nat.add (Nat.mul p n) (Nat.mul p m).
Proof. nia. Qed.

Lemma mulnBr (n m p : nat) : Nat.mul n (Nat.sub m p) = Nat.sub (Nat.mul n m) (Nat.mul n p).
Proof. nia. Qed.

Lemma mulnBl (n m p : nat) : Nat.mul (Nat.sub n m) p = Nat.sub (Nat.mul n p) (Nat.mul m p).
Proof. nia. Qed.

Lemma mulnA (n m p : nat) : Nat.mul (Nat.mul n m) p = Nat.mul n (Nat.mul m p).
Proof. nia. Qed.

Lemma mulnCA (n m p : nat) : Nat.mul n (Nat.mul m p) = Nat.mul m (Nat.mul n p).
Proof. nia. Qed.

Lemma mulnAC (n m p : nat) : Nat.mul (Nat.mul n m) p = Nat.mul (Nat.mul n p) m.
Proof. nia. Qed.

Lemma mulnACA (n m p q : nat) :
  Nat.mul (Nat.mul n m) (Nat.mul p q) = Nat.mul (Nat.mul n p) (Nat.mul m q).
Proof. nia. Qed.

Lemma muln_eq0 (n m : nat) : iff (Nat.mul n m = O) (n = O \/ m = O).
Proof. split; intros; nia. Qed.

Lemma istrue_leb_le (n m : nat) : Is_true (Nat.leb n m) <-> n <= m.
Proof.
  unfold Is_true.
  destruct (Nat.leb_spec0 n m); simpl; lia.
Qed.

Ltac nat_bool :=
  intros;
  unfold leq, ltn, geq, gtn, neq, not in *;
  repeat match goal with
  | H : _ /\ _ |- _ => destruct H
  | H : _ \/ _ |- _ => destruct H
  end;
  repeat split;
  repeat match goal with
  | H : Is_true (Nat.leb _ _) |- _ => apply istrue_leb_le in H
  | |- Is_true (Nat.leb _ _) => apply istrue_leb_le
  end;
  try tauto;
  lia.

Lemma lp_u2264_0 (n : nat) : Is_true (leq n O) -> n = O.
Proof. nat_bool. Qed.

Lemma lp_u2264_refl (n : nat) : Is_true (leq n n).
Proof. nat_bool. Qed.

Lemma eq_leq (n m : nat) : n = m -> Is_true (leq n m).
Proof. nat_bool. Qed.

Lemma leq_trans (n m p : nat) :
  Is_true (leq n m) -> Is_true (leq m p) -> Is_true (leq n p).
Proof. nat_bool. Qed.

Lemma eqn_leq (n m : nat) :
  iff (Is_true (leq n m) /\ Is_true (leq m n)) (n = m).
Proof. split; nat_bool. Qed.

Lemma leqsnn (n : nat) : Is_true (leq (S n) n) -> False.
Proof. nat_bool. Qed.

Lemma letnS (n m : nat) : Is_true (ltn n (S m)) -> Is_true (leq n m).
Proof. nat_bool. Qed.

Lemma ltn0 (n : nat) : Is_true (ltn n O) -> False.
Proof. nat_bool. Qed.

Lemma ltnn (n : nat) : Is_true (ltn n n) -> False.
Proof. nat_bool. Qed.

Lemma ltnSn (n : nat) : Is_true (ltn n (S n)).
Proof. nat_bool. Qed.

Lemma leq0n (n : nat) : Is_true (leq O n).
Proof. nat_bool. Qed.

Lemma ltn0Sn (n : nat) : Is_true (ltn O (S n)).
Proof. nat_bool. Qed.

Lemma leqnSn (n : nat) : Is_true (leq n (S n)).
Proof. nat_bool. Qed.

Lemma leq_pred (n : nat) : Is_true (leq (pred n) n).
Proof. nat_bool. Qed.

Lemma ltnW (n m : nat) : Is_true (ltn n m) -> Is_true (leq n m).
Proof. nat_bool. Qed.

Lemma leqW (n m : nat) : Is_true (leq n m) -> Is_true (leq n (S m)).
Proof. nat_bool. Qed.

Lemma ltn_trans (n m p : nat) :
  Is_true (ltn n m) -> Is_true (ltn m p) -> Is_true (ltn n p).
Proof. nat_bool. Qed.

Lemma lp_u003c_asym (n m : nat) : Is_true (ltn n m) -> ~ Is_true (ltn m n).
Proof.
  unfold not, ltn.
  intros hnm hmn.
  apply istrue_leb_le in hnm.
  apply istrue_leb_le in hmn.
  lia.
Qed.

Lemma anti_ltn (n m : nat) : Is_true (ltn n m) -> Is_true (ltn m n) -> n = m.
Proof. nat_bool. Qed.

Lemma leq_total (n m : nat) : Is_true (leq n m) \/ Is_true (leq m n).
Proof.
  destruct (Nat.leb_spec0 n m).
  - left. nat_bool.
  - right. nat_bool.
Qed.

Lemma lt0n (n : nat) : iff (Is_true (gtn n O)) (@neq nat' n O).
Proof. split; unfold neq; nat_bool. Qed.

Lemma leq_eqVlt (n m : nat) : iff (Is_true (leq n m)) (n = m \/ Is_true (ltn n m)).
Proof.
  split.
  - unfold leq, ltn. intro h.
    apply istrue_leb_le in h.
    destruct (Nat.eq_dec n m) as [e | ne].
    + left. exact e.
    + right. apply istrue_leb_le. lia.
  - nat_bool.
Qed.

Lemma leq_add0 (n m : nat) :
  Is_true (leq O n) -> Is_true (leq O m) -> Is_true (leq O (Nat.add n m)).
Proof. nat_bool. Qed.

Lemma leq_add2l (n m p : nat) :
  iff (Is_true (leq (Nat.add n m) (Nat.add n p))) (Is_true (leq m p)).
Proof. split; nat_bool. Qed.

Lemma ltn_add2l (n m p : nat) :
  iff (Is_true (ltn (Nat.add n m) (Nat.add n p))) (Is_true (ltn m p)).
Proof. split; nat_bool. Qed.

Lemma leq_add2r (n m p : nat) :
  iff (Is_true (leq (Nat.add m n) (Nat.add p n))) (Is_true (leq m p)).
Proof. split; nat_bool. Qed.

Lemma ltn_add2r (n m p : nat) :
  iff (Is_true (ltn (Nat.add m n) (Nat.add p n))) (Is_true (ltn m p)).
Proof. split; nat_bool. Qed.

Lemma leq_addl (n m : nat) : Is_true (leq m (Nat.add n m)).
Proof. nat_bool. Qed.

Lemma leq_addr (n m : nat) : Is_true (leq m (Nat.add m n)).
Proof. nat_bool. Qed.

Lemma leq_subr (n m : nat) : Is_true (leq (Nat.sub m n) m).
Proof. nat_bool. Qed.

Lemma subn_eq0 (n m : nat) : iff (Nat.sub n m = O) (Is_true (leq n m)).
Proof. split; nat_bool. Qed.

Lemma ltn_addl (n m p : nat) : Is_true (ltn n m) -> Is_true (ltn n (Nat.add p m)).
Proof. nat_bool. Qed.

Lemma ltn_addr (n m p : nat) : Is_true (ltn n m) -> Is_true (ltn n (Nat.add m p)).
Proof. nat_bool. Qed.

Lemma addn_gt0 (n m : nat) :
  iff (Is_true (ltn O (Nat.add n m))) (Is_true (ltn O n) \/ Is_true (ltn O m)).
Proof.
  split.
  - unfold ltn. intro h.
    apply istrue_leb_le in h.
    destruct n as [|n']; [right | left]; apply istrue_leb_le; lia.
  - nat_bool.
Qed.

Lemma subn_gt0 (n m : nat) : iff (Is_true (ltn O (Nat.sub m n))) (Is_true (ltn n m)).
Proof. split; nat_bool. Qed.

Lemma leq_add (n m p q : nat) :
  Is_true (leq n p) -> Is_true (leq m q) -> Is_true (leq (Nat.add n m) (Nat.add p q)).
Proof. nat_bool. Qed.

Lemma leq_subLR (n m p : nat) :
  iff (Is_true (leq (Nat.sub n m) p)) (Is_true (leq n (Nat.add m p))).
Proof. split; nat_bool. Qed.

Lemma subnKC (n m : nat) : Is_true (leq n m) -> Nat.add n (Nat.sub m n) = m.
Proof. nat_bool. Qed.

Lemma addnBn (n m : nat) : Nat.add n (Nat.sub m n) = Nat.add (Nat.sub n m) m.
Proof. lia. Qed.

Lemma addnBA (n m p : nat) : Is_true (leq p m) -> Nat.add n (Nat.sub m p) = Nat.sub (Nat.add n m) p.
Proof. nat_bool. Qed.

Lemma subnK (n m : nat) : Is_true (leq n m) -> Nat.add (Nat.sub m n) n = m.
Proof. nat_bool. Qed.

Lemma subSn (n m : nat) : Is_true (leq m n) -> Nat.sub (S n) m = S (Nat.sub n m).
Proof. nat_bool. Qed.

Lemma addnBAC (n m p : nat) :
  Is_true (leq m n) -> Nat.add (Nat.sub n m) p = Nat.sub (Nat.add n p) m.
Proof. nat_bool. Qed.

Lemma leq_sub2r (n m p : nat) :
  Is_true (leq n m) -> Is_true (leq (Nat.sub n p) (Nat.sub m p)).
Proof. nat_bool. Qed.

Lemma leq_sub2l (n m p : nat) :
  Is_true (leq n m) -> Is_true (leq (Nat.sub p m) (Nat.sub p n)).
Proof. nat_bool. Qed.

Lemma leq_sub (n m p q : nat) :
  Is_true (leq n m) -> Is_true (leq q p) -> Is_true (leq (Nat.sub n p) (Nat.sub m q)).
Proof. nat_bool. Qed.

Ltac minmax_nat :=
  unfold maxn, minn in *;
  repeat match goal with
  | H : context [Nat.max ?a ?b] |- _ =>
      destruct (Nat.leb_spec0 a b);
      [rewrite (Nat.max_r a b) in H by lia | rewrite (Nat.max_l a b) in H by lia]
  | |- context [Nat.max ?a ?b] =>
      destruct (Nat.leb_spec0 a b);
      [rewrite (Nat.max_r a b) by lia | rewrite (Nat.max_l a b) by lia]
  | H : context [Nat.min ?a ?b] |- _ =>
      destruct (Nat.leb_spec0 a b);
      [rewrite (Nat.min_l a b) in H by lia | rewrite (Nat.min_r a b) in H by lia]
  | |- context [Nat.min ?a ?b] =>
      destruct (Nat.leb_spec0 a b);
      [rewrite (Nat.min_l a b) by lia | rewrite (Nat.min_r a b) by lia]
  end;
  try nat_bool;
  nia.

Lemma maxnC (n m : nat) : maxn n m = maxn m n.
Proof. minmax_nat. Qed.

Lemma maxnA (n m p : nat) : maxn (maxn n m) p = maxn n (maxn m p).
Proof. minmax_nat. Qed.

Lemma maxnAC (n m p : nat) : maxn (maxn n m) p = maxn (maxn n p) m.
Proof. minmax_nat. Qed.

Lemma maxnCA (n m p : nat) : maxn n (maxn m p) = maxn m (maxn n p).
Proof. minmax_nat. Qed.

Lemma maxnACA (n m p q : nat) :
  maxn (maxn n m) (maxn p q) = maxn (maxn n p) (maxn m q).
Proof. minmax_nat. Qed.

Lemma addn_maxl (n m p : nat) :
  Nat.add (maxn m p) n = maxn (Nat.add m n) (Nat.add p n).
Proof. minmax_nat. Qed.

Lemma addn_maxr (n m p : nat) :
  Nat.add n (maxn m p) = maxn (Nat.add n m) (Nat.add n p).
Proof. minmax_nat. Qed.

Lemma subn_maxl (n m p : nat) :
  Nat.sub (maxn n m) p = maxn (Nat.sub n p) (Nat.sub m p).
Proof. minmax_nat. Qed.

Lemma maxnE (n m : nat) : maxn n m = Nat.add n (Nat.sub m n).
Proof. minmax_nat. Qed.

Lemma maxnn (n : nat) : maxn n n = n.
Proof. minmax_nat. Qed.

Lemma leq_maxl (n m : nat) : Is_true (leq n (maxn n m)).
Proof.
  unfold leq, maxn.
  apply istrue_leb_le.
  apply Nat.le_max_l.
Qed.

Lemma leq_maxr (n m : nat) : Is_true (leq m (maxn n m)).
Proof.
  unfold leq, maxn.
  apply istrue_leb_le.
  apply Nat.le_max_r.
Qed.

Lemma ltn_predK (n m : nat) : Is_true (ltn n m) -> S (pred m) = m.
Proof.
  intros h.
  destruct m as [|m]; [exact (False_ind _ h) | reflexivity].
Qed.

Lemma prednK (n : nat') : Is_true (ltn O n) -> S (pred n) = n.
Proof. apply ltn_predK. Qed.

Lemma ltn0_neq0 (n : nat') : iff (Is_true (ltn O n)) (@neq nat' n O).
Proof.
  split.
  - intros h.
    destruct n as [|n]; [exact (False_ind _ h) | apply lp_s_u2260_0].
  - intros h.
    destruct n as [|n]; [exfalso; apply h; reflexivity | exact I].
Qed.

Lemma disj0 (n : nat') : n = O \/ @neq nat' n O.
Proof. apply casen. Qed.

Lemma leq_pmull (n m : nat) : Is_true (gtn m O) -> Is_true (leq n (Nat.mul m n)).
Proof.
  unfold gtn, leq. intros h.
  apply istrue_leb_le in h.
  apply istrue_leb_le.
  nia.
Qed.

Lemma leq_pmulr (n m : nat) : Is_true (gtn m O) -> Is_true (leq n (Nat.mul n m)).
Proof.
  unfold gtn, leq. intros h.
  apply istrue_leb_le in h.
  apply istrue_leb_le.
  nia.
Qed.

Lemma leq_mul2l (n m p : nat) :
  iff (Is_true (leq (Nat.mul n m) (Nat.mul n p))) (n = O \/ Is_true (leq m p)).
Proof.
  split.
  - unfold leq. intro h.
    apply istrue_leb_le in h.
    destruct n as [|n']; [left; reflexivity | right; apply istrue_leb_le; nia].
  - unfold leq. intro h.
    destruct h as [h | h]; [subst | apply istrue_leb_le in h]; apply istrue_leb_le; nia.
Qed.

Lemma leq_mul2r (n m p : nat) :
  iff (Is_true (leq (Nat.mul m n) (Nat.mul p n))) (n = O \/ Is_true (leq m p)).
Proof.
  rewrite (mulnC m n).
  rewrite (mulnC p n).
  exact (leq_mul2l n m p).
Qed.

Lemma leq_mul (n m p q : nat) :
  Is_true (leq n p) -> Is_true (leq m q) -> Is_true (leq (Nat.mul n m) (Nat.mul p q)).
Proof.
  unfold leq. intros hnp hmq.
  apply istrue_leb_le in hnp.
  apply istrue_leb_le in hmq.
  apply istrue_leb_le.
  nia.
Qed.

Lemma eqn_mul2l (n m p : nat) :
  iff (Nat.mul n m = Nat.mul n p) (n = O \/ m = p).
Proof.
  split.
  - intro h. destruct n as [|n']; [left; reflexivity | right; nia].
  - intro h. destruct h as [h | h]; subst; nia.
Qed.

Lemma eqn_mul2r (n m p : nat) :
  iff (Nat.mul m n = Nat.mul p n) (n = O \/ m = p).
Proof.
  rewrite (mulnC m n).
  rewrite (mulnC p n).
  exact (eqn_mul2l n m p).
Qed.

Lemma eqn_pmul2l (n m p : nat) :
  Is_true (ltn O n) -> iff (Nat.mul n m = Nat.mul n p) (m = p).
Proof.
  intros hn.
  split.
  - intros h. unfold ltn in hn. apply istrue_leb_le in hn. nia.
  - intros ->. reflexivity.
Qed.

Lemma eqn_pmul2r (n m p : nat) :
  Is_true (ltn O n) -> iff (Nat.mul m n = Nat.mul p n) (m = p).
Proof.
  intros hn.
  rewrite (mulnC m n).
  rewrite (mulnC p n).
  exact (eqn_pmul2l n m p hn).
Qed.

Lemma leq_pmul2l (n m p : nat) :
  Is_true (ltn O n) -> iff (Is_true (leq (Nat.mul n m) (Nat.mul n p))) (Is_true (leq m p)).
Proof.
  intro hn.
  split.
  - unfold ltn, leq in *. intros hmp.
    apply istrue_leb_le in hn.
    apply istrue_leb_le in hmp.
    apply istrue_leb_le.
    nia.
  - unfold ltn, leq in *. intros hmp.
    apply istrue_leb_le in hn.
    apply istrue_leb_le in hmp.
    apply istrue_leb_le.
    nia.
Qed.

Lemma leq_pmul2r (n m p : nat) :
  Is_true (ltn O n) -> iff (Is_true (leq (Nat.mul m n) (Nat.mul p n))) (Is_true (leq m p)).
Proof.
  intros hn.
  rewrite (mulnC m n).
  rewrite (mulnC p n).
  exact (leq_pmul2l n m p hn).
Qed.

Lemma minnC (n m : nat) : minn n m = minn m n.
Proof. minmax_nat. Qed.

Lemma minnA (n m p : nat) : minn (minn n m) p = minn n (minn m p).
Proof. minmax_nat. Qed.

Lemma minnAC (n m p : nat) : minn (minn n m) p = minn (minn n p) m.
Proof. minmax_nat. Qed.

Lemma minnCA (n m p : nat) : minn n (minn m p) = minn m (minn n p).
Proof. minmax_nat. Qed.

Lemma minnACA (n m p q : nat) :
  minn (minn n m) (minn p q) = minn (minn n p) (minn m q).
Proof. minmax_nat. Qed.

Lemma addn_minl (n m p : nat) :
  Nat.add (minn m p) n = minn (Nat.add m n) (Nat.add p n).
Proof. minmax_nat. Qed.

Lemma addn_minr (n m p : nat) :
  Nat.add n (minn m p) = minn (Nat.add n m) (Nat.add n p).
Proof. minmax_nat. Qed.

Lemma subn_minl (n m p : nat) :
  Nat.sub (minn n m) p = minn (Nat.sub n p) (Nat.sub m p).
Proof. minmax_nat. Qed.

Lemma minnn (n : nat) : minn n n = n.
Proof. minmax_nat. Qed.

Lemma geq_minl (n m : nat) : Is_true (leq (minn n m) n).
Proof. minmax_nat. Qed.

Lemma geq_minr (n m : nat) : Is_true (leq (minn n m) m).
Proof. minmax_nat. Qed.

Lemma addn_min_max (n m : nat) : Nat.add (minn n m) (maxn n m) = Nat.add n m.
Proof. minmax_nat. Qed.

Lemma maxnK (n m : nat) : minn (maxn n m) n = n.
Proof. minmax_nat. Qed.

Lemma maxKn (n m : nat) : minn m (maxn n m) = m.
Proof. minmax_nat. Qed.

Lemma minnK (n m : nat) : maxn (minn n m) n = n.
Proof. minmax_nat. Qed.

Lemma minKn (n m : nat) : maxn m (minn n m) = m.
Proof. minmax_nat. Qed.

Lemma maxn_minl (n m p : nat) : maxn n (minn m p) = minn (maxn n m) (maxn n p).
Proof. minmax_nat. Qed.

Lemma maxn_minr (n m p : nat) : maxn (minn m p) n = minn (maxn m n) (maxn p n).
Proof. minmax_nat. Qed.

Lemma minn_maxl (n m p : nat) : minn n (maxn m p) = maxn (minn n m) (minn n p).
Proof. minmax_nat. Qed.

Lemma minn_maxr (n m p : nat) : minn (maxn m p) n = maxn (minn m n) (minn p n).
Proof. minmax_nat. Qed.

Lemma maxnMr (n m p : nat) : Nat.mul (maxn m p) n = maxn (Nat.mul m n) (Nat.mul p n).
Proof. minmax_nat. Qed.

Lemma maxnMl (n m p : nat) : Nat.mul n (maxn m p) = maxn (Nat.mul n m) (Nat.mul n p).
Proof. minmax_nat. Qed.

Lemma minnMr (n m p : nat) : Nat.mul (minn m p) n = minn (Nat.mul m n) (Nat.mul p n).
Proof. minmax_nat. Qed.

Lemma minnMl (n m p : nat) : Nat.mul n (minn m p) = minn (Nat.mul n m) (Nat.mul n p).
Proof. minmax_nat. Qed.

Lemma expn0 (n : nat) : expn n O = S O.
Proof. exact (Nat.pow_0_r n). Qed.

Lemma expn1 (n : nat) : expn n (S O) = n.
Proof. exact (Nat.pow_1_r n). Qed.

Lemma expnS (n m : nat) : expn n (S m) = Nat.mul n (expn n m).
Proof.
  unfold expn.
  rewrite Nat.pow_succ_r by lia.
  reflexivity.
Qed.

Lemma expnSr (n m : nat) : expn n (S m) = Nat.mul (expn n m) n.
Proof.
  rewrite expnS.
  apply mulnC.
Qed.

Lemma exp0n (n : nat) : Is_true (ltn O n) -> expn O n = O.
Proof.
  intros hn.
  destruct n as [|n]; [exact (False_ind _ hn) |].
  unfold expn.
  rewrite Nat.pow_0_l by lia.
  reflexivity.
Qed.

Lemma exp1n (n : nat) : expn (S O) n = S O.
Proof. exact (Nat.pow_1_l n). Qed.

Lemma expnD (n m p : nat) : expn n (Nat.add m p) = Nat.mul (expn n m) (expn n p).
Proof. exact (Nat.pow_add_r n m p). Qed.

Lemma expnMn (n m p : nat) : expn (Nat.mul n m) p = Nat.mul (expn n p) (expn m p).
Proof. exact (Nat.pow_mul_l n m p). Qed.

Lemma expnM (n m p : nat) : expn n (Nat.mul m p) = expn (expn n m) p.
Proof. exact (Nat.pow_mul_r n m p). Qed.

Lemma expnAC (n m p : nat) : expn (expn n m) p = expn (expn n p) m.
Proof.
  rewrite <- (expnM n m p).
  rewrite <- (expnM n p m).
  rewrite mulnC.
  reflexivity.
Qed.

Lemma fact0 : factn O = S O.
Proof. reflexivity. Qed.

Lemma factS (n : nat) : factn (S n) = Nat.mul (S n) (factn n).
Proof. reflexivity. Qed.

Lemma fact_gt0 (n : nat) : Is_true (gtn (factn n) O).
Proof.
  induction n as [|n ih]; [exact I |].
  simpl.
  unfold gtn in *.
  apply istrue_leb_le in ih.
  apply istrue_leb_le.
  nia.
Qed.

Lemma fact_gt1 (n : nat) : Is_true (geq (factn n) (S O)).
Proof. exact (fact_gt0 n). Qed.

Lemma fact_geq (n : nat) : Is_true (leq n (factn n)).
Proof.
  induction n as [|n ih]; [exact I |].
  unfold leq in *.
  apply istrue_leb_le in ih.
  apply istrue_leb_le.
  simpl.
  pose proof (fact_gt0 n) as hgt.
  unfold gtn in hgt.
  apply istrue_leb_le in hgt.
  nia.
Qed.

(* List.lp Disj support *)

Definition list_type (a : Type') : Type' := {| type := Datatypes.list a; el := nil |}.
Canonical list_type.
Notation list := list_type (only parsing).

Definition 𝕃 (a : Type') : Type := Datatypes.list a.
Definition lp_u25a1 (a : Type') : 𝕃 a := nil.
Definition lp_u2e2c (a : Type') (x : a) (xs : 𝕃 a) : 𝕃 a := cons x xs.
Definition lp_is_u25a1 (a : Type') (xs : 𝕃 a) : bool :=
  match xs with
  | nil => true
  | cons _ _ => false
  end.

Definition ind_𝕃 (a : Type') (P : 𝕃 a -> Prop)
    (p_nil : P (lp_u25a1 a))
    (p_cons : forall x xs, P xs -> P (lp_u2e2c a x xs)) :
    forall xs, P xs :=
  fix go xs :=
    match xs with
    | nil => p_nil
    | cons x xs' => p_cons x xs' (go xs')
    end.

Fixpoint lp_u2208 (a : Type') (eqb : a -> a -> bool) (x : a) (xs : 𝕃 a) : bool :=
  match xs with
  | nil => false
  | cons y ys => orb (eqb x y) (lp_u2208 a eqb x ys)
  end.

Fixpoint lp_u2286 (a : Type') (eqb : a -> a -> bool) (xs ys : 𝕃 a) : bool :=
  match xs with
  | nil => true
  | cons x xs' => andb (lp_u2208 a eqb x ys) (lp_u2286 a eqb xs' ys)
  end.

Lemma mem_seq1 (a : Type') (eqb : a -> a -> bool) (x y : a) :
    lp_u2208 a eqb x (lp_u2e2c a y (lp_u25a1 a)) = eqb x y.
Proof.
  simpl.
  rewrite orb_false_r.
  reflexivity.
Qed.

Lemma not_mem_cons_head (a : Type') (eqb : a -> a -> bool) (xs : 𝕃 a) (y x : a) :
    ~ Is_true (orb (eqb x y) (lp_u2208 a eqb x xs)) -> ~ Is_true (eqb x y).
Proof.
  intros h hx.
  destruct (eqb x y); simpl in *.
  - apply h. exact I.
  - exact hx.
Qed.

Lemma not_mem_cons_tail (a : Type') (eqb : a -> a -> bool) (xs : 𝕃 a) (y x : a) :
    ~ Is_true (orb (eqb x y) (lp_u2208 a eqb x xs)) -> ~ Is_true (lp_u2208 a eqb x xs).
Proof.
  intros h hx.
  destruct (lp_u2208 a eqb x xs); simpl in *.
  - apply h.
    destruct (eqb x y); exact I.
  - exact hx.
Qed.

Lemma subset_cons_r (a : Type') (eqb : a -> a -> bool) (y : a) (xs ys : 𝕃 a) :
    Is_true (lp_u2286 a eqb xs ys) ->
    Is_true (lp_u2286 a eqb xs (lp_u2e2c a y ys)).
Proof.
  revert ys.
  induction xs as [|x xs ih]; intros ys h; simpl; [exact I |].
  apply bool_istrue_and.
  split.
  - apply or_i2.
    exact (and_e1 (lp_u2208 a eqb x ys) (lp_u2286 a eqb xs ys) h).
  - apply ih.
    exact (and_e2 (lp_u2208 a eqb x ys) (lp_u2286 a eqb xs ys) h).
Qed.

Lemma subset_cons_l (a : Type') (eqb : a -> a -> bool) (x : a) (xs ys : 𝕃 a) :
    Is_true (andb (lp_u2208 a eqb x ys) (lp_u2286 a eqb xs ys)) ->
    Is_true (lp_u2286 a eqb xs ys).
Proof.
  exact (and_e2 (lp_u2208 a eqb x ys) (lp_u2286 a eqb xs ys)).
Qed.

Lemma subset_cons (a : Type') (eqb : a -> a -> bool)
    (eqb_refl : forall x : a, Is_true (eqb x x))
    (ys xs : 𝕃 a) (x : a) :
    Is_true (lp_u2286 a eqb xs ys) ->
    Is_true (andb (orb (eqb x x) (lp_u2208 a eqb x ys))
      (lp_u2286 a eqb xs (lp_u2e2c a x ys))).
Proof.
  intro h.
  apply bool_istrue_and.
  split.
  - apply or_i1.
    apply eqb_refl.
  - apply subset_cons_r.
    exact h.
Qed.

Definition lp_u002b_u002b (a : Type') (xs ys : 𝕃 a) : 𝕃 a := xs ++ ys.
Definition size (a : Type') (xs : 𝕃 a) : nat := length xs.
Definition head (a : Type') (default : a) (xs : 𝕃 a) : a :=
  match xs with
  | nil => default
  | cons x _ => x
  end.
Definition behead (a : Type') (xs : 𝕃 a) : 𝕃 a :=
  match xs with
  | nil => nil
  | cons _ ys => ys
  end.
Fixpoint eql (a : Type') (eqb : a -> a -> bool) (xs ys : 𝕃 a) : bool :=
  match xs, ys with
  | nil, nil => true
  | cons x xs', cons y ys' => andb (eqb x y) (eql a eqb xs' ys')
  | _, _ => false
  end.
Fixpoint nseq (a : Type') (n : nat) (x : a) : 𝕃 a :=
  match n with
  | O => nil
  | S n' => cons x (nseq a n' x)
  end.
Fixpoint ncons (a : Type') (n : nat) (x : a) (xs : 𝕃 a) : 𝕃 a :=
  match n with
  | O => xs
  | S n' => cons x (ncons a n' x xs)
  end.
Fixpoint catrev (a : Type') (xs acc : 𝕃 a) : 𝕃 a :=
  match xs with
  | nil => acc
  | cons x xs' => catrev a xs' (cons x acc)
  end.
Definition rev (a : Type') (xs : 𝕃 a) : 𝕃 a := catrev a xs nil.
Fixpoint rcons (a : Type') (xs : 𝕃 a) (x : a) : 𝕃 a :=
  match xs with
  | nil => cons x nil
  | cons y ys => cons y (rcons a ys x)
  end.
Fixpoint Arr (n : nat) (a b : Type') : Type :=
  match n with
  | O => b
  | S n' => a -> Arr n' a b
  end.
Fixpoint seqn_acc (a : Type') (n : nat) : 𝕃 a -> Arr n a (list_type a) :=
  match n return 𝕃 a -> Arr n a (list_type a) with
  | O => fun xs => rev a xs
  | S n' => fun xs x => seqn_acc a n' (cons x xs)
  end.
Fixpoint lp_last (a : Type') (default : a) (xs : 𝕃 a) : a :=
  match xs with
  | nil => default
  | cons x xs' => lp_last a x xs'
  end.
Fixpoint belast (a : Type') (default : a) (xs : 𝕃 a) : 𝕃 a :=
  match xs with
  | nil => nil
  | cons x xs' => cons default (belast a x xs')
  end.
Definition iota (start len : nat) : 𝕃 nat' := seq start len.
Definition indexes (a : Type') (xs : 𝕃 a) : 𝕃 nat' := iota O (size a xs).
Definition lp_nth (a : Type') (default : a) (xs : 𝕃 a) (n : nat) : a :=
  nth n xs default.
Notation nth := lp_nth (only parsing).
Fixpoint incr_nth (xs : 𝕃 nat') (n : nat) : 𝕃 nat' :=
  match xs, n with
  | nil, O => cons (S O) nil
  | nil, S n' => cons O (incr_nth nil n')
  | cons x xs', O => cons (S x) xs'
  | cons x xs', S n' => cons x (incr_nth xs' n')
  end.
Fixpoint zip (a b : Type') (xs : 𝕃 a) (ys : 𝕃 b) : 𝕃 (lp_u00d7 a b) :=
  match xs, ys with
  | cons x xs', cons y ys' => cons (lp_u201a a b x y) (zip a b xs' ys')
  | _, _ => nil
  end.
Fixpoint unzip1 (a b : Type') (xs : 𝕃 (lp_u00d7 a b)) : 𝕃 a :=
  match xs with
  | nil => nil
  | cons p ps => cons (lp_u2081 a b p) (unzip1 a b ps)
  end.
Fixpoint unzip2 (a b : Type') (xs : 𝕃 (lp_u00d7 a b)) : 𝕃 b :=
  match xs with
  | nil => nil
  | cons p ps => cons (lp_u2082 a b p) (unzip2 a b ps)
  end.

Lemma nth_zip (a b : Type') (default_a : a) (default_b : b)
    (xs : 𝕃 a) (ys : 𝕃 b) (n : nat) :
    size a xs = size b ys ->
    nth (lp_u00d7 a b) (lp_u201a a b default_a default_b) (zip a b xs ys) n =
      lp_u201a a b (nth a default_a xs n) (nth b default_b ys n).
Proof.
  revert ys n.
  induction xs as [|x xs ih]; intros ys n h; destruct ys as [|y ys].
  - destruct n; reflexivity.
  - simpl in h. discriminate h.
  - simpl in h. discriminate h.
  - destruct n as [|n']; simpl; [reflexivity |].
    apply ih.
    simpl in h.
    injection h; auto.
Qed.

Fixpoint all2 (a b : Type') (p : a -> b -> bool) (xs : 𝕃 a) (ys : 𝕃 b) : bool :=
  match xs, ys with
  | nil, nil => true
  | cons x xs', cons y ys' => andb (p x y) (all2 a b p xs' ys')
  | _, _ => false
  end.
Definition drop (a : Type') (n : nat) (xs : 𝕃 a) : 𝕃 a := skipn n xs.
Definition take (a : Type') (n : nat) (xs : 𝕃 a) : 𝕃 a := firstn n xs.

Lemma size_drop (a : Type') (xs : 𝕃 a) (n : nat) :
    size a (drop a n xs) = Nat.sub (size a xs) n.
Proof.
  unfold size, drop.
  apply length_skipn.
Qed.

Lemma drop_drop (a : Type') (xs : 𝕃 a) (m n : nat) :
    drop a m (drop a n xs) = drop a (Nat.add m n) xs.
Proof.
  unfold drop.
  apply skipn_skipn.
Qed.

Lemma take_drop (a : Type') (n m : nat) (xs : 𝕃 a) :
    take a n (drop a m xs) = drop a m (take a (Nat.add n m) xs).
Proof.
  unfold take, drop.
  rewrite firstn_skipn_comm.
  rewrite Nat.add_comm.
  reflexivity.
Qed.

Lemma takeD (a : Type') (n m : nat) (xs : 𝕃 a) :
    take a (Nat.add n m) xs =
      lp_u002b_u002b a (take a n xs) (take a m (drop a n xs)).
Proof.
  unfold take, drop, lp_u002b_u002b.
  revert xs m.
  induction n as [|n ih]; intros xs m; destruct xs as [|x xs]; simpl; try reflexivity.
  - destruct m; reflexivity.
  - rewrite ih.
    reflexivity.
Qed.

Lemma takeC (a : Type') (xs : 𝕃 a) (n m : nat) :
    take a n (take a m xs) = take a m (take a n xs).
Proof.
  unfold take.
  repeat rewrite firstn_firstn.
  rewrite Nat.min_comm.
  reflexivity.
Qed.

Definition rot (a : Type') (n : nat) (xs : 𝕃 a) : 𝕃 a :=
  lp_u002b_u002b a (drop a n xs) (take a n xs).

Lemma rot0 (a : Type') (xs : 𝕃 a) : rot a O xs = xs.
Proof.
  unfold rot, drop, take, lp_u002b_u002b.
  simpl.
  apply app_nil_r.
Qed.

Lemma size_rot (a : Type') (xs : 𝕃 a) (n : nat) :
    size a (rot a n xs) = size a xs.
Proof.
  unfold rot, size, drop, take, lp_u002b_u002b.
  rewrite length_app.
  rewrite length_skipn.
  rewrite length_firstn.
  lia.
Qed.

Definition rotr (a : Type') (n : nat) (xs : 𝕃 a) : 𝕃 a :=
  rot a (Nat.sub (size a xs) n) xs.

Lemma rotr0 (a : Type') (xs : 𝕃 a) : rotr a O xs = xs.
Proof.
  unfold rotr, rot, size, drop, take, lp_u002b_u002b.
  rewrite Nat.sub_0_r.
  rewrite skipn_all.
  rewrite firstn_all.
  reflexivity.
Qed.

Fixpoint nths (a : Type') (default : a) (xs : 𝕃 a) (ns : 𝕃 nat') : 𝕃 a :=
  match ns with
  | nil => nil
  | cons n ns' => cons (lp_nth a default xs n) (nths a default xs ns')
  end.

Fixpoint rem_nth (a : Type') (xs : 𝕃 a) (n : nat) : 𝕃 a :=
  match xs, n with
  | nil, _ => nil
  | cons _ xs', O => xs'
  | cons x xs', S n' => cons x (rem_nth a xs' n')
  end.

Fixpoint set_nth (a : Type') (default : a) (xs : 𝕃 a) (n : nat) (x : a) : 𝕃 a :=
  match xs, n with
  | nil, O => cons x nil
  | nil, S n' => cons default (set_nth a default nil n' x)
  | cons _ xs', O => cons x xs'
  | cons y ys, S n' => cons y (set_nth a default ys n' x)
  end.

Fixpoint undup_first (a : Type') (eqb : a -> a -> bool) (xs : 𝕃 a) : 𝕃 a :=
  match xs with
  | nil => nil
  | cons x xs' =>
      cons x (filter (fun y => negb (eqb x y)) (undup_first a eqb xs'))
  end.

Lemma catrev_cat (a : Type') (xs ys : 𝕃 a) :
    catrev a xs ys = lp_u002b_u002b a (rev a xs) ys.
Proof.
  unfold rev, lp_u002b_u002b.
  revert ys.
  induction xs as [|x xs ih]; intros ys; simpl; [reflexivity |].
  rewrite ih.
  rewrite (ih (cons x nil)).
  rewrite <- app_assoc.
  reflexivity.
Qed.

Lemma rev_cons (a : Type') (xs : 𝕃 a) (x : a) :
    rev a (lp_u2e2c a x xs) = lp_u002b_u002b a (rev a xs) (lp_u2e2c a x (lp_u25a1 a)).
Proof.
  unfold rev.
  simpl.
  rewrite catrev_cat.
  reflexivity.
Qed.

Lemma rev_eq_std (a : Type') (xs : 𝕃 a) : rev a xs = List.rev xs.
Proof.
  induction xs as [|x xs ih]; [reflexivity |].
  unfold rev.
  simpl.
  rewrite catrev_cat.
  unfold lp_u002b_u002b.
  rewrite ih.
  reflexivity.
Qed.

Lemma rev_cat (a : Type') (xs ys : 𝕃 a) :
    rev a (lp_u002b_u002b a xs ys) = lp_u002b_u002b a (rev a ys) (rev a xs).
Proof.
  unfold lp_u002b_u002b.
  repeat rewrite rev_eq_std.
  apply rev_app_distr.
Qed.

Lemma rev_idem (a : Type') (xs : 𝕃 a) : rev a (rev a xs) = xs.
Proof.
  rewrite rev_eq_std.
  rewrite rev_eq_std.
  apply rev_involutive.
Qed.

Lemma size_rev (a : Type') (xs : 𝕃 a) : size a (rev a xs) = size a xs.
Proof.
  unfold size.
  rewrite rev_eq_std.
  apply length_rev.
Qed.

Lemma cats1 (a : Type') (xs : 𝕃 a) (x : a) :
    lp_u002b_u002b a xs (lp_u2e2c a x (lp_u25a1 a)) = rcons a xs x.
Proof.
  induction xs as [|y ys ih]; simpl; [reflexivity |].
  rewrite ih.
  reflexivity.
Qed.

Lemma rcons_cons (a : Type') (x : a) (xs : 𝕃 a) (z : a) :
    rcons a (lp_u2e2c a x xs) z = lp_u2e2c a x (rcons a xs z).
Proof. reflexivity. Qed.

Fixpoint index (a : Type') (eqb : a -> a -> bool) (x : a) (xs : 𝕃 a) : nat :=
  match xs with
  | nil => O
  | cons y ys => if eqb x y then O else S (index a eqb x ys)
  end.

Lemma index_size (a : Type') (eqb : a -> a -> bool) (x : a) (xs : 𝕃 a) :
    Is_true (leq (index a eqb x xs) (size a xs)).
Proof.
  induction xs as [|y ys ih]; simpl; [exact I |].
  destruct (eqb x y); simpl; [exact I | exact ih].
Qed.

Lemma index_head (a : Type') (eqb : a -> a -> bool) (x : a) (xs : 𝕃 a) :
    eqb x x = true -> index a eqb x (lp_u2e2c a x xs) = O.
Proof.
  intro h.
  simpl.
  rewrite h.
  reflexivity.
Qed.

Fixpoint has (a : Type') (p : a -> bool) (xs : 𝕃 a) : bool :=
  match xs with
  | nil => false
  | cons x xs' => if p x then true else has a p xs'
  end.
Fixpoint list_all (a : Type') (p : a -> bool) (xs : 𝕃 a) : bool :=
  match xs with
  | nil => true
  | cons x xs' => if p x then list_all a p xs' else false
  end.
Fixpoint find (a : Type') (p : a -> bool) (xs : 𝕃 a) : nat :=
  match xs with
  | nil => O
  | cons x xs' => if p x then O else S (find a p xs')
  end.

Lemma find_size (a : Type') (p : a -> bool) (xs : 𝕃 a) :
    Is_true (leq (find a p xs) (size a xs)).
Proof.
  induction xs as [|x xs ih]; simpl; [exact I |].
  destruct (p x); simpl; [exact I | exact ih].
Qed.

Fixpoint count (a : Type') (p : a -> bool) (xs : 𝕃 a) : nat :=
  match xs with
  | nil => O
  | cons x xs' => if p x then S (count a p xs') else count a p xs'
  end.

Lemma count_size (a : Type') (p : a -> bool) (xs : 𝕃 a) :
    Is_true (leq (count a p xs) (size a xs)).
Proof.
  induction xs as [|x xs ih]; simpl; [exact I |].
  destruct (p x); simpl.
  - exact ih.
  - destruct (leq (count a p xs) (size a xs)) eqn:eih; [| exfalso; exact ih].
    destruct (leq (count a p xs) (S (size a xs))) eqn:e; [exact I |].
    apply Nat.leb_le in eih.
    apply Nat.leb_gt in e.
    lia.
Qed.

Fixpoint is_constant (a : Type') (eqb : a -> a -> bool) (xs : 𝕃 a) : bool :=
  match xs with
  | nil => true
  | cons x xs' => if list_all a (eqb x) xs' then true else false
  end.
Fixpoint uniq (a : Type') (eqb : a -> a -> bool) (xs : 𝕃 a) : bool :=
  match xs with
  | nil => true
  | cons x xs' => if negb (lp_u2208 a eqb x xs') then uniq a eqb xs' else false
  end.
Fixpoint subseq (a : Type') (eqb : a -> a -> bool) (xs ys : 𝕃 a) : bool :=
  match xs, ys with
  | nil, nil => true
  | cons _ _, nil => false
  | nil, cons _ _ => false
  | cons x xs', cons y ys' => if eqb x y then subseq a eqb xs' ys' else false
  end.
Definition is_prefix (a : Type') (eqb : a -> a -> bool) (xs ys : 𝕃 a) : bool :=
  subseq a eqb xs (take a (size a xs) ys).
Fixpoint list_eq (a : Type') (eqb : a -> a -> bool) (xs ys : 𝕃 a) : bool :=
  eql a eqb xs ys.
Fixpoint infix_index (a : Type') (eqb : a -> a -> bool) (needle haystack : 𝕃 a) : nat :=
  match haystack with
  | nil => if list_eq a eqb needle nil then O else S O
  | cons _ hs' =>
      if list_eq a eqb needle (take a (size a needle) haystack)
      then O
      else S (infix_index a eqb needle hs')
  end.
Definition is_infix (a : Type') (eqb : a -> a -> bool) (needle haystack : 𝕃 a) : bool :=
  Nat.leb (infix_index a eqb needle haystack) (size a haystack).
Definition lp_filter (a : Type') (p : a -> bool) (xs : 𝕃 a) : 𝕃 a := filter p xs.
Fixpoint undup (a : Type') (eqb : a -> a -> bool) (xs : 𝕃 a) : 𝕃 a :=
  match xs with
  | nil => nil
  | cons x xs' =>
      let rest := undup a eqb xs' in
      if lp_u2208 a eqb x rest then rest else cons x rest
  end.
Definition lp_map (a b : Type') (f : a -> b) (xs : 𝕃 a) : 𝕃 b := map f xs.
Definition sumn (xs : 𝕃 nat') : nat := fold_right Nat.add O xs.
Definition prodn (xs : 𝕃 nat') : nat := fold_right Nat.mul (S O) xs.

Definition mem_head (a : Type') (eqb : a -> a -> bool) (x : a) (xs : 𝕃 a) :
    eqb x x = true -> Is_true (orb (eqb x x) (lp_u2208 a eqb x xs)).
Proof. intros ->. exact I. Defined.

Definition mem_tail (a : Type') (eqb : a -> a -> bool) (x y : a) (xs : 𝕃 a) :
    Is_true (lp_u2208 a eqb x xs) -> Is_true (orb (eqb x y) (lp_u2208 a eqb x xs)).
Proof. destruct (eqb x y); simpl; [exact (fun _ => I) | exact (fun h => h)]. Defined.

Lemma nths_succ_cons (a : Type') (default x : a) (xs : 𝕃 a) (ns : 𝕃 nat') :
  nths a default (cons x xs) (map S ns) = nths a default xs ns.
Proof.
  induction ns as [|n ns ih]; simpl; [reflexivity |].
  rewrite ih.
  reflexivity.
Qed.

Lemma seq_succ_map (start len : nat) : seq (S start) len = map S (seq start len).
Proof.
  revert start.
  induction len as [|len ih]; intros start; simpl; [reflexivity |].
  rewrite ih.
  reflexivity.
Qed.

Lemma nths_indexes_id (a : Type') (default : a) (xs : 𝕃 a) :
  nths a default xs (indexes a xs) = xs.
Proof.
  unfold indexes, iota, size.
  induction xs as [|x xs ih]; simpl; [reflexivity |].
  rewrite seq_succ_map.
  rewrite nths_succ_cons.
  rewrite ih.
  reflexivity.
Qed.

Lemma iota_decrement (start len n : nat) :
  Is_true (lp_u2208 nat' eqn (S n) (iota (S start) len)) ->
  Is_true (lp_u2208 nat' eqn n (iota start len)).
Proof.
  unfold iota.
  revert start n.
  induction len as [|len ih]; intros start n; simpl; [exact (fun h => h) |].
  intro h.
  apply or_istrue in h.
  destruct h as [h | h].
  - apply bool_istrue_or. left.
    apply eqn_complete.
    apply eqn_correct in h.
    lia.
  - apply bool_istrue_or. right.
    apply ih.
    exact h.
Qed.

Lemma indexes_decrement (a : Type') (n : nat) (x : a) (xs : 𝕃 a) :
  Is_true (lp_u2208 nat' eqn (S n) (iota (S O) (size a xs))) ->
  Is_true (lp_u2208 nat' eqn n (iota O (size a xs))).
Proof. apply iota_decrement. Qed.

Lemma mem_to_In (a : Type') (eqb : a -> a -> bool)
    (eqb_correct : forall x y, Is_true (eqb x y) -> x = y)
    (x : a) (xs : 𝕃 a) :
    Is_true (lp_u2208 a eqb x xs) -> In x xs.
Proof.
  induction xs as [|y ys ih]; simpl; intro h; [exact (False_ind _ h) |].
  apply or_istrue in h.
  destruct h as [h | h].
  - left. symmetry. apply eqb_correct. exact h.
  - right. apply ih. exact h.
Qed.

Lemma In_to_mem (a : Type') (eqb : a -> a -> bool)
    (eqb_refl : forall x, Is_true (eqb x x))
    (x : a) (xs : 𝕃 a) :
    In x xs -> Is_true (lp_u2208 a eqb x xs).
Proof.
  induction xs as [|y ys ih]; simpl; intro h; [contradiction |].
  destruct h as [h | h].
  - subst y. apply bool_istrue_or. left. apply eqb_refl.
  - apply bool_istrue_or. right. apply ih. exact h.
Qed.

Lemma In_to_subset (a : Type') (eqb : a -> a -> bool)
    (eqb_refl : forall x, Is_true (eqb x x))
    (xs ys : 𝕃 a) :
    (forall x, In x xs -> In x ys) ->
    Is_true (lp_u2286 a eqb xs ys).
Proof.
  induction xs as [|x xs ih]; simpl; intro hsub; [exact I |].
  apply bool_istrue_and.
  split.
  - apply (In_to_mem a eqb eqb_refl).
    apply hsub. left. reflexivity.
  - apply ih.
    intros y hy.
    apply hsub. right. exact hy.
Qed.

Lemma In_undup_first (a : Type') (eqb : a -> a -> bool)
    (eqb_correct : forall x y, Is_true (eqb x y) -> x = y)
    (x : a) (xs : 𝕃 a) :
    In x xs -> In x (undup_first a eqb xs).
Proof.
  induction xs as [|y ys ih]; simpl; intro h; [contradiction |].
  destruct h as [h | h].
  - subst y. left. reflexivity.
  - destruct (eqb y x) eqn:hyx.
    + left. apply eqb_correct. rewrite hyx. exact I.
    + right. apply filter_In. split.
      * apply ih. exact h.
      * rewrite hyx. reflexivity.
Qed.

Lemma subset_undup_first (a : Type') (eqb : a -> a -> bool)
    (eqb_correct : forall x y, Is_true (eqb x y) -> x = y)
    (eqb_refl : forall x, Is_true (eqb x x))
    (eqb_sym : forall x y, Is_true (eqb x y) -> Is_true (eqb y x))
    (xs : 𝕃 a) :
    Is_true (lp_u2286 a eqb xs (undup_first a eqb xs)).
Proof.
  apply (In_to_subset a eqb eqb_refl).
  intros x hx.
  apply (In_undup_first a eqb eqb_correct).
  exact hx.
Qed.

(* Disj.lp/Conj.lp shim *)

Fixpoint disj (xs : 𝕃 o) : o :=
  match xs with
  | nil => False
  | cons p nil => p
  | cons p ps => p \/ disj ps
  end.

Definition preserves_contents (ns : 𝕃 nat') (ps : 𝕃 o) : bool' :=
  lp_u2286 nat' Nat.eqb (indexes o ps) ns.

Fixpoint conj_list (xs : 𝕃 o) : o :=
  match xs with
  | nil => True
  | cons p nil => p
  | cons p ps => p /\ conj_list ps
  end.

Fixpoint insertBot (xs : 𝕃 o) (n : nat) : 𝕃 o :=
  match xs, n with
  | nil, O => lp_u2e2c o False (lp_u25a1 o)
  | nil, S _ => lp_u25a1 o
  | cons p ps, O => lp_u2e2c o False (lp_u2e2c o p ps)
  | cons p ps, S n' => lp_u2e2c o p (insertBot ps n')
  end.

Fixpoint insertBots (xs : 𝕃 o) (ns : 𝕃 nat') : 𝕃 o :=
  match ns with
  | nil => xs
  | cons n ns' => insertBots (insertBot xs n) ns'
  end.

(* Comp.lp shim *)
Definition comparison' := {| type := comparison ; el := Eq|}.

Definition ind_Comp (P : comparison -> Prop)
    (pEq : P Eq) (pLt : P Lt) (pGt : P Gt) (c : comparison) : P c :=
  match c with
  | Eq => pEq
  | Lt => pLt
  | Gt => pGt
  end.

Definition isEq (c : comparison) := 
 match c with
 | Eq => true
 | _ => false
 end.

Definition isLt (c : comparison) := 
 match c with
 | Lt => true
 | _ => false
 end.	

Definition isGt (c : comparison) := 
 match c with
 | Gt => true
 | _ => false
 end.		       

Definition isLe (c : comparison) :=
 match c with
 | Gt => false
 | _ => true
 end.

Definition isGe (c : comparison) :=
 match c with
 | Lt => false
 | _ => true
 end.

Definition case_Comp := fun (A : Type') (c : comparison') (x y z : A) =>
match c with
| Eq => x
| Lt => y
| Gt => z
end.

(* Epsilon.v*)
Definition eps (A : Type') (P : type A -> Prop) : type A :=
  epsilon (inhabits (el A)) P.

Lemma eps_spec (A : Type') (P : type A -> Prop) : (exists x, P x) -> P (eps A P).
Proof. intro h. unfold eps. apply epsilon_spec. exact h. Qed.
