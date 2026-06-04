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
require open Leo-III-lambdapi-lib-noOp.UserTactic;
require lpProof_SEU518^1-noOp.Signature as S; 




// PROBLEM ENCODING //////////////////////////////////////

symbol exu_def: π (S.exu = (λ (A : τ (ι ⤳ o)), (∃(λ (B : τ ι), A B ∧ (∀(λ (C : τ ι), A C ⇒ B = C))))));
symbol setextAx_def: π (S.setextAx = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A = S.in_ C B)) ⇒ A = B)))));
symbol emptysetAx_def: π (S.emptysetAx = (∀(λ (A : τ ι), ¬ S.in_ A S.emptyset)));
symbol setadjoinAx_def: π (S.setadjoinAx = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) = (C = A ∨ S.in_ C B))))))));
symbol powersetAx_def: π (S.powersetAx = (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) = (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)))))));
symbol setunionAx_def: π (S.setunionAx = (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.setunion A) = (∃(λ (C : τ ι), S.in_ B C ∧ S.in_ C A)))))));
symbol omega0Ax_def: π (S.omega0Ax = S.in_ S.emptyset S.omega);
symbol omegaSAx_def: π (S.omegaSAx = (∀(λ (A : τ ι), S.in_ A S.omega ⇒ S.in_ (S.setadjoin A A) S.omega)));
symbol omegaIndAx_def: π (S.omegaIndAx = (∀(λ (A : τ ι), S.in_ S.emptyset A ∧ (∀(λ (B : τ ι), S.in_ B S.omega ∧ S.in_ B A ⇒ S.in_ (S.setadjoin B B) A)) ⇒ (∀(λ (B : τ ι), S.in_ B S.omega ⇒ S.in_ B A)))));
symbol replAx_def: π (S.replAx = (∀(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.exu (A C))) ⇒ (∃(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C = (∃(λ (E : τ ι), S.in_ E B ∧ A E D)))))))))));
symbol foundationAx_def: π (S.foundationAx = (∀(λ (A : τ ι), (∃(λ (B : τ ι), S.in_ B A)) ⇒ (∃(λ (B : τ ι), S.in_ B A ∧ ¬ (∃(λ (C : τ ι), S.in_ C B ∧ S.in_ C A)))))));
symbol wellorderingAx_def: π (S.wellorderingAx = (∀(λ (A : τ ι), (∃(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C A ∧ S.in_ D A ⇒ (∀(λ (E : τ ι), S.in_ E B ⇒ S.in_ C E = S.in_ D E)) ⇒ C = D)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C B ∧ S.in_ D B ⇒ (∀(λ (E : τ ι), S.in_ E C ⇒ S.in_ E D)) ∨ (∀(λ (E : τ ι), S.in_ E D ⇒ S.in_ E C)))))) ∧ (∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)) ∧ (∃(λ (D : τ ι), S.in_ D C)) ⇒ (∃(λ (D : τ ι), (∃(λ (E : τ ι), S.in_ D B ∧ (S.in_ E C ∧ (¬ (∃(λ (F : τ ι), S.in_ F D ∧ S.in_ F C)) ∧ (∀(λ (F : τ ι), S.in_ F B ⇒ (∀(λ (G : τ ι), S.in_ G F ⇒ S.in_ G D)) ∨ S.in_ E F)))))))))))))))));
symbol descrp_def: π (S.descrp = (∀(λ (A : τ (ι ⤳ o)), S.exu A ⇒ A (S.descr A))));
symbol dsetconstrI_def: π (S.dsetconstrI = (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ B C ⇒ S.in_ C (S.dsetconstr A B))))))));
symbol dsetconstrEL_def: π (S.dsetconstrEL = (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C (S.dsetconstr A B) ⇒ S.in_ C A)))))));
symbol dsetconstrER_def: π (S.dsetconstrER = (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C (S.dsetconstr A B) ⇒ B C)))))));
symbol exuE1_def: π (S.exuE1 = (∀(λ (A : τ (ι ⤳ o)), S.exu A ⇒ (∃(λ (B : τ ι), A B ∧ (∀(λ (C : τ ι), A C ⇒ B = C)))))));
symbol prop2set_def: π (S.prop2set = (λ (A : τ o), S.dsetconstr (S.powerset S.emptyset) (λ (B : τ ι), A)));
symbol prop2setE_def: π (S.prop2setE = (∀(λ (A : τ o), (∀(λ (B : τ ι), S.in_ B (S.prop2set A) ⇒ A)))));
symbol emptysetE_def: π (S.emptysetE = (∀(λ (A : τ ι), S.in_ A S.emptyset ⇒ (∀(λ (B : τ o), B)))));
symbol emptysetimpfalse_def: π (S.emptysetimpfalse = (∀(λ (A : τ ι), S.in_ A S.emptyset ⇒ ⊥)));
symbol notinemptyset_def: π (S.notinemptyset = (∀(λ (A : τ ι), ¬ S.in_ A S.emptyset)));
symbol exuE3e_def: π (S.exuE3e = (∀(λ (A : τ (ι ⤳ o)), S.exu A ⇒ (∃(λ (B : τ ι), A B)))));
symbol setext_def: π (S.setext = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A ⇒ S.in_ C B)) ⇒ (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ A = B)))));
symbol emptyI_def: π (S.emptyI = (∀(λ (A : τ ι), (∀(λ (B : τ ι), ¬ S.in_ B A)) ⇒ A = S.emptyset)));
symbol noeltsimpempty_def: π (S.noeltsimpempty = (∀(λ (A : τ ι), (∀(λ (B : τ ι), ¬ S.in_ B A)) ⇒ A = S.emptyset)));
symbol setbeta_def: π (S.setbeta = (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ S.in_ C (S.dsetconstr A B) = B C)))))));
symbol nonempty_def: π (S.nonempty = (λ (A : τ ι), ¬ (A = S.emptyset)));
symbol nonemptyE1_def: π (S.nonemptyE1 = (∀(λ (A : τ ι), S.nonempty A ⇒ (∃(λ (B : τ ι), S.in_ B A)))));
symbol nonemptyI_def: π (S.nonemptyI = (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ B C ⇒ S.nonempty (S.dsetconstr A B))))))));
symbol nonemptyI1_def: π (S.nonemptyI1 = (∀(λ (A : τ ι), (∃(λ (B : τ ι), S.in_ B A)) ⇒ S.nonempty A)));
symbol setadjoinIL_def: π (S.setadjoinIL = (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ A (S.setadjoin A B))))));
symbol emptyinunitempty_def: π (S.emptyinunitempty = S.in_ S.emptyset (S.setadjoin S.emptyset S.emptyset));
symbol setadjoinIR_def: π (S.setadjoinIR = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C (S.setadjoin A B))))))));
symbol setadjoinE_def: π (S.setadjoinE = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) ⇒ (∀(λ (D : τ o), (C = A ⇒ D) ⇒ (S.in_ C B ⇒ D) ⇒ D)))))))));
symbol setadjoinOr_def: π (S.setadjoinOr = (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) ⇒ C = A ∨ S.in_ C B)))))));
symbol setoftrueEq_def: π (S.setoftrueEq = (∀(λ (A : τ ι), S.dsetconstr A (λ (B : τ ι), ⊤) = A)));
