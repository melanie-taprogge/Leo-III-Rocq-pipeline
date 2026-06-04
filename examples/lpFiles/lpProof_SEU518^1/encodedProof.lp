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
require open Leo-III-lambdapi-lib.UserTactic;
require lpProof_SEU518^1.Signature as S; 
require lpProof_SEU518^1.Formulae as F;


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// SKOLEM TERMS ///////////////////////////////////

symbol sk1: τ (ι ⤳ (ι ⤳ ι));
symbol sk1_def (A : τ ι) (B : τ ι): π (sk1 A B = (ε(λ (C : τ ι), ¬ (S.in_ C B = S.in_ C A))));
symbol sk2: τ (ι ⤳ ι);
symbol sk2_def (A : τ ι): π (sk2 A = (ε(λ (B : τ ι), ¬ (S.in_ B S.omega ∧ S.in_ B A ⇒ S.in_ (S.setadjoin B B) A))));
symbol sk3: τ (ι ⤳ ((ι ⤳ (ι ⤳ o)) ⤳ ι));
symbol sk3_def (A : τ ι) (B : τ (ι ⤳ (ι ⤳ o))): π (sk3 A B = (ε(λ (C : τ ι), ¬ (S.in_ C A ⇒ (∃(λ (D : τ ι), B C D ∧ (∀(λ (E : τ ι), B C E ⇒ D = E))))))));
symbol sk4: τ (ι ⤳ (ι ⤳ ((ι ⤳ (ι ⤳ o)) ⤳ ι)));
symbol sk4_def (A : τ ι) (B : τ ι) (C : τ (ι ⤳ (ι ⤳ o))): π (sk4 A B C = (ε(λ (D : τ ι), ¬ (C (sk3 B C) D ⇒ A = D))));
symbol sk5: τ (ι ⤳ ((ι ⤳ (ι ⤳ o)) ⤳ ι));
symbol sk5_def (A : τ ι) (B : τ (ι ⤳ (ι ⤳ o))): π (sk5 A B = (ε(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C = (∃(λ (E : τ ι), S.in_ E A ∧ B E D)))))));
symbol sk6: τ (ι ⤳ ι);
symbol sk6_def (A : τ ι): π (sk6 A = (ε(λ (B : τ ι), S.in_ B A ∧ ¬ (∃(λ (C : τ ι), S.in_ C B ∧ S.in_ C A)))));
symbol sk7: τ (ι ⤳ ι);
symbol sk7_def (A : τ ι): π (sk7 A = (ε(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C A ∧ S.in_ D A ⇒ (∀(λ (E : τ ι), S.in_ E B ⇒ S.in_ C E = S.in_ D E)) ⇒ C = D)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C B ∧ S.in_ D B ⇒ (∀(λ (E : τ ι), S.in_ E C ⇒ S.in_ E D)) ∨ (∀(λ (E : τ ι), S.in_ E D ⇒ S.in_ E C)))))) ∧ (∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)) ∧ (∃(λ (D : τ ι), S.in_ D C)) ⇒ (∃(λ (D : τ ι), S.in_ D B ∧ (∃(λ (E : τ ι), S.in_ E C ∧ (¬ (∃(λ (F : τ ι), S.in_ F D ∧ S.in_ F C)) ∧ (∀(λ (F : τ ι), S.in_ F B ⇒ (∀(λ (G : τ ι), S.in_ G F ⇒ S.in_ G D)) ∨ S.in_ E F))))))))))))));
symbol sk8: τ (ι ⤳ (ι ⤳ (ι ⤳ ι)));
symbol sk8_def (A : τ ι) (B : τ ι) (C : τ ι): π (sk8 A B C = (ε(λ (D : τ ι), ¬ (S.in_ D (sk7 C) ⇒ S.in_ B D = S.in_ A D))));
symbol sk9: τ (ι ⤳ (ι ⤳ o));
symbol sk10: τ (ι ⤳ (ι ⤳ ι));
symbol sk10_def (A : τ ι) (B : τ ι): π (sk10 A B = (ε(λ (C : τ ι), ¬ (S.in_ C A ⇒ S.in_ C B))));
symbol sk11: τ (ι ⤳ (ι ⤳ ι));
symbol sk11_def (A : τ ι) (B : τ ι): π (sk11 A B = (ε(λ (C : τ ι), S.in_ C (sk7 B) ∧ (∃(λ (D : τ ι), S.in_ D A ∧ (¬ (∃(λ (E : τ ι), S.in_ E C ∧ S.in_ E A)) ∧ (∀(λ (E : τ ι), S.in_ E (sk7 B) ⇒ (∀(λ (F : τ ι), S.in_ F E ⇒ S.in_ F C)) ∨ S.in_ D E))))))));
symbol sk12: τ (ι ⤳ (ι ⤳ ι));
symbol sk12_def (A : τ ι) (B : τ ι): π (sk12 A B = (ε(λ (C : τ ι), S.in_ C A ∧ (¬ (∃(λ (D : τ ι), S.in_ D (sk11 A B) ∧ S.in_ D A)) ∧ (∀(λ (D : τ ι), S.in_ D (sk7 B) ⇒ (∀(λ (E : τ ι), S.in_ E D ⇒ S.in_ E (sk11 A B))) ∨ S.in_ C D))))));
symbol sk13: τ (ι ⤳ ((ι ⤳ o) ⤳ ι));
symbol sk13_def (A : τ ι) (B : τ (ι ⤳ o)): π (sk13 A B = (ε(λ (C : τ ι), ¬ (B C ⇒ A = C))));
symbol sk14: τ (ι ⤳ ((ι ⤳ o) ⤳ ι));
symbol sk14_def (A : τ ι) (B : τ (ι ⤳ o)): π (sk14 A B = (ε(λ (C : τ ι), ¬ (B C ⇒ A = C))));
symbol sk15: τ ((ι ⤳ o) ⤳ ι);
symbol sk15_def (A : τ (ι ⤳ o)): π (sk15 A = (ε(λ (B : τ ι), A B)));
symbol sk16: τ (ι ⤳ (ι ⤳ ι));
symbol sk16_def (A : τ ι) (B : τ ι): π (sk16 A B = (ε(λ (C : τ ι), ¬ (S.in_ C B ⇒ S.in_ C A))));
symbol sk17: τ (ι ⤳ (ι ⤳ ι));
symbol sk17_def (A : τ ι) (B : τ ι): π (sk17 A B = (ε(λ (C : τ ι), ¬ (S.in_ C A ⇒ S.in_ C B))));
symbol sk18: τ (ι ⤳ ι);
symbol sk18_def (A : τ ι): π (sk18 A = (ε(λ (B : τ ι), S.in_ B A)));
symbol sk19: τ (ι ⤳ ι);
symbol sk19_def (A : τ ι): π (sk19 A = (ε(λ (B : τ ι), S.in_ B A)));
symbol sk20: τ (ι ⤳ ι);
symbol sk20_def (A : τ ι): π (sk20 A = (ε(λ (B : τ ι), S.in_ B A)));
symbol sk21: τ ι;
symbol sk21_def: π (sk21  = (ε(λ (A : τ ι), ¬ (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ S.in_ B (S.powerset A))))));
symbol sk22: τ ι;
symbol sk22_def: π (sk22  = (ε(λ (A : τ ι), ¬ ((∀(λ (B : τ ι), S.in_ B A ⇒ S.in_ B sk21)) ⇒ S.in_ A (S.powerset sk21)))));
symbol sk24: τ ι;
symbol sk24_def: π (sk24  = (ε(λ (A : τ ι), ¬ (S.in_ A sk22 ⇒ S.in_ A sk21))));


// PROOF ENCODING ////////////////////////////////////////

opaque symbol encodedProof: π (S.setextAx ⇒ S.emptysetAx ⇒ S.setadjoinAx ⇒ S.powersetAx ⇒ S.setunionAx ⇒ S.omega0Ax ⇒ S.omegaSAx ⇒ S.omegaIndAx ⇒ S.replAx ⇒ S.foundationAx ⇒ S.wellorderingAx ⇒ S.descrp ⇒ S.dsetconstrI ⇒ S.dsetconstrEL ⇒ S.dsetconstrER ⇒ S.exuE1 ⇒ S.prop2setE ⇒ S.emptysetE ⇒ S.emptysetimpfalse ⇒ S.notinemptyset ⇒ S.exuE3e ⇒ S.setext ⇒ S.emptyI ⇒ S.noeltsimpempty ⇒ S.setbeta ⇒ S.nonemptyE1 ⇒ S.nonemptyI ⇒ S.nonemptyI1 ⇒ S.setadjoinIL ⇒ S.emptyinunitempty ⇒ S.setadjoinIR ⇒ S.setadjoinE ⇒ S.setadjoinOr ⇒ S.setoftrueEq ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ S.in_ B (S.powerset A)))))) ≔
begin
	refine (¬¬ₑ (S.setextAx ⇒ S.emptysetAx ⇒ S.setadjoinAx ⇒ S.powersetAx ⇒ S.setunionAx ⇒ S.omega0Ax ⇒ S.omegaSAx ⇒ S.omegaIndAx ⇒ S.replAx ⇒ S.foundationAx ⇒ S.wellorderingAx ⇒ S.descrp ⇒ S.dsetconstrI ⇒ S.dsetconstrEL ⇒ S.dsetconstrER ⇒ S.exuE1 ⇒ S.prop2setE ⇒ S.emptysetE ⇒ S.emptysetimpfalse ⇒ S.notinemptyset ⇒ S.exuE3e ⇒ S.setext ⇒ S.emptyI ⇒ S.noeltsimpempty ⇒ S.setbeta ⇒ S.nonemptyE1 ⇒ S.nonemptyI ⇒ S.nonemptyI1 ⇒ S.setadjoinIL ⇒ S.emptyinunitempty ⇒ S.setadjoinIR ⇒ S.setadjoinE ⇒ S.setadjoinOr ⇒ S.setoftrueEq ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ S.in_ B (S.powerset A)))))) _);
	assume negatedConjecture;
	// Unencoded step (DefExpand): Rweriting under binder required in order to encode Simplification step;
	have step3 : π (¬ ((∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A = S.in_ C B)) ⇒ A = B)))) ⇒ (∀(λ (A : τ ι), ¬ S.in_ A S.emptyset)) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) = (C = A ∨ S.in_ C B))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) = (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.setunion A) = (∃(λ (C : τ ι), S.in_ B C ∧ S.in_ C A)))))) ⇒ S.in_ S.emptyset S.omega ⇒ (∀(λ (A : τ ι), S.in_ A S.omega ⇒ S.in_ (S.setadjoin A A) S.omega)) ⇒ (∀(λ (A : τ ι), S.in_ S.emptyset A ∧ (∀(λ (B : τ ι), S.in_ B S.omega ∧ S.in_ B A ⇒ S.in_ (S.setadjoin B B) A)) ⇒ (∀(λ (B : τ ι), S.in_ B S.omega ⇒ S.in_ B A)))) ⇒ (∀(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ (∃(λ (D : τ ι), A C D ∧ (∀(λ (E : τ ι), A C E ⇒ D = E)))))) ⇒ (∃(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C = (∃(λ (E : τ ι), S.in_ E B ∧ A E D)))))))))) ⇒ (∀(λ (A : τ ι), (∃(λ (B : τ ι), S.in_ B A)) ⇒ (∃(λ (B : τ ι), S.in_ B A ∧ ¬ (∃(λ (C : τ ι), S.in_ C B ∧ S.in_ C A)))))) ⇒ (∀(λ (A : τ ι), (∃(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C A ∧ S.in_ D A ⇒ (∀(λ (E : τ ι), S.in_ E B ⇒ S.in_ C E = S.in_ D E)) ⇒ C = D)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C B ∧ S.in_ D B ⇒ (∀(λ (E : τ ι), S.in_ E C ⇒ S.in_ E D)) ∨ (∀(λ (E : τ ι), S.in_ E D ⇒ S.in_ E C)))))) ∧ (∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)) ∧ (∃(λ (D : τ ι), S.in_ D C)) ⇒ (∃(λ (D : τ ι), (∃(λ (E : τ ι), S.in_ D B ∧ (S.in_ E C ∧ (¬ (∃(λ (F : τ ι), S.in_ F D ∧ S.in_ F C)) ∧ (∀(λ (F : τ ι), S.in_ F B ⇒ (∀(λ (G : τ ι), S.in_ G F ⇒ S.in_ G D)) ∨ S.in_ E F)))))))))))))))) ⇒ (∀(λ (A : τ (ι ⤳ o)), (∃(λ (B : τ ι), A B ∧ (∀(λ (C : τ ι), A C ⇒ B = C)))) ⇒ A (S.descr A))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ B C ⇒ S.in_ C (S.dsetconstr A B))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C (S.dsetconstr A B) ⇒ S.in_ C A)))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C (S.dsetconstr A B) ⇒ B C)))))) ⇒ (∀(λ (A : τ o), (∀(λ (B : τ ι), S.in_ B (S.dsetconstr (S.powerset S.emptyset) (λ (C : τ ι), A)) ⇒ A)))) ⇒ (∀(λ (A : τ ι), S.in_ A S.emptyset ⇒ (∀(λ (B : τ o), B)))) ⇒ (∀(λ (A : τ ι), ¬ S.in_ A S.emptyset)) ⇒ (∀(λ (A : τ ι), ¬ S.in_ A S.emptyset)) ⇒ (∀(λ (A : τ (ι ⤳ o)), (∃(λ (B : τ ι), A B ∧ (∀(λ (C : τ ι), A C ⇒ B = C)))) ⇒ (∃(λ (B : τ ι), A B)))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A ⇒ S.in_ C B)) ⇒ (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ A = B)))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), ¬ S.in_ B A)) ⇒ A = S.emptyset)) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), ¬ S.in_ B A)) ⇒ A = S.emptyset)) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ S.in_ C (S.dsetconstr A B) = B C)))))) ⇒ (∀(λ (A : τ ι), ¬ (A = S.emptyset) ⇒ (∃(λ (B : τ ι), S.in_ B A)))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ B C ⇒ ¬ (S.dsetconstr A B = S.emptyset))))))) ⇒ (∀(λ (A : τ ι), (∃(λ (B : τ ι), S.in_ B A)) ⇒ ¬ (A = S.emptyset))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ A (S.setadjoin A B))))) ⇒ S.in_ S.emptyset (S.setadjoin S.emptyset S.emptyset) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C (S.setadjoin A B))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) ⇒ (∀(λ (D : τ o), (C = A ⇒ D) ⇒ (S.in_ C B ⇒ D) ⇒ D)))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) ⇒ C = A ∨ S.in_ C B)))))) ⇒ (∀(λ (A : τ ι), S.dsetconstr A (λ (B : τ ι), ⊤) = A)) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ S.in_ B (S.powerset A)))))))
		{admit;};
	// Unencoded step (miniscope): unencoded rule applied to step3;
	have step4 : π (¬ ((∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A = S.in_ C B)) ⇒ A = B)))) ⇒ ¬ (∃(λ (A : τ ι), S.in_ A S.emptyset)) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) = (C = A ∨ S.in_ C B))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) = (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.setunion A) = (∃(λ (C : τ ι), S.in_ B C ∧ S.in_ C A)))))) ⇒ S.in_ S.emptyset S.omega ⇒ (∀(λ (A : τ ι), S.in_ A S.omega ⇒ S.in_ (S.setadjoin A A) S.omega)) ⇒ (∀(λ (A : τ ι), S.in_ S.emptyset A ∧ (∀(λ (B : τ ι), S.in_ B S.omega ∧ S.in_ B A ⇒ S.in_ (S.setadjoin B B) A)) ⇒ (∀(λ (B : τ ι), S.in_ B S.omega ⇒ S.in_ B A)))) ⇒ (∀(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ (∃(λ (D : τ ι), A C D ∧ (∀(λ (E : τ ι), A C E ⇒ D = E)))))) ⇒ (∃(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C = (∃(λ (E : τ ι), S.in_ E B ∧ A E D)))))))))) ⇒ (∀(λ (A : τ ι), (∃(λ (B : τ ι), S.in_ B A)) ⇒ (∃(λ (B : τ ι), S.in_ B A ∧ ¬ (∃(λ (C : τ ι), S.in_ C B ∧ S.in_ C A)))))) ⇒ (∀(λ (A : τ ι), (∃(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C A ∧ S.in_ D A ⇒ (∀(λ (E : τ ι), S.in_ E B ⇒ S.in_ C E = S.in_ D E)) ⇒ C = D)))) ∧ ((∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ C B ∧ S.in_ D B ⇒ (∀(λ (E : τ ι), S.in_ E C ⇒ S.in_ E D)) ∨ (∀(λ (E : τ ι), S.in_ E D ⇒ S.in_ E C)))))) ∧ (∀(λ (C : τ ι), (∀(λ (D : τ ι), S.in_ D C ⇒ S.in_ D A)) ∧ (∃(λ (D : τ ι), S.in_ D C)) ⇒ (∃(λ (D : τ ι), S.in_ D B ∧ (∃(λ (E : τ ι), S.in_ E C ∧ (¬ (∃(λ (F : τ ι), S.in_ F D ∧ S.in_ F C)) ∧ (∀(λ (F : τ ι), S.in_ F B ⇒ (∀(λ (G : τ ι), S.in_ G F ⇒ S.in_ G D)) ∨ S.in_ E F))))))))))))))) ⇒ (∀(λ (A : τ (ι ⤳ o)), (∃(λ (B : τ ι), A B ∧ (∀(λ (C : τ ι), A C ⇒ B = C)))) ⇒ A (S.descr A))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ B C ⇒ S.in_ C (S.dsetconstr A B))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C (S.dsetconstr A B) ⇒ S.in_ C A)))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C (S.dsetconstr A B) ⇒ B C)))))) ⇒ (∀(λ (A : τ o), (∃(λ (B : τ ι), S.in_ B (S.dsetconstr (S.powerset S.emptyset) (λ (C : τ ι), A)))) ⇒ A)) ⇒ ((∃(λ (A : τ ι), S.in_ A S.emptyset)) ⇒ (∀(λ (A : τ o), A))) ⇒ ¬ (∃(λ (A : τ ι), S.in_ A S.emptyset)) ⇒ ¬ (∃(λ (A : τ ι), S.in_ A S.emptyset)) ⇒ (∀(λ (A : τ (ι ⤳ o)), (∃(λ (B : τ ι), A B ∧ (∀(λ (C : τ ι), A C ⇒ B = C)))) ⇒ (∃(λ (B : τ ι), A B)))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A ⇒ S.in_ C B)) ⇒ (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ A = B)))) ⇒ (∀(λ (A : τ ι), ¬ (∃(λ (B : τ ι), S.in_ B A)) ⇒ A = S.emptyset)) ⇒ (∀(λ (A : τ ι), ¬ (∃(λ (B : τ ι), S.in_ B A)) ⇒ A = S.emptyset)) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ S.in_ C (S.dsetconstr A B) = B C)))))) ⇒ (∀(λ (A : τ ι), ¬ (A = S.emptyset) ⇒ (∃(λ (B : τ ι), S.in_ B A)))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ (ι ⤳ o)), (∀(λ (C : τ ι), S.in_ C A ⇒ B C ⇒ ¬ (S.dsetconstr A B = S.emptyset))))))) ⇒ (∀(λ (A : τ ι), (∃(λ (B : τ ι), S.in_ B A)) ⇒ ¬ (A = S.emptyset))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ A (S.setadjoin A B))))) ⇒ S.in_ S.emptyset (S.setadjoin S.emptyset S.emptyset) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C (S.setadjoin A B))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) ⇒ (∀(λ (D : τ o), (C = A ⇒ D) ⇒ (S.in_ C B ⇒ D) ⇒ D)))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setadjoin A B) ⇒ C = A ∨ S.in_ C B)))))) ⇒ (∀(λ (A : τ ι), S.dsetconstr A (λ (B : τ ι), ⊤) = A)) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ⇒ S.in_ B (S.powerset A)))))))
		{admit;};
	// Unencoded step (RenameCNF_conj): Renaming not encoded yet;
	have step5 : Π (ZZZB : τ ι), Π (ZZZA : τ ι), Π (ZZZ : τ ι), Π (ZZY : τ ι), Π (ZZX : τ ι), Π (ZZW : τ o), Π (ZZV : τ ι), Π (ZZU : τ ι), Π (ZZT : τ ι), Π (ZZS : τ ι), Π (ZZR : τ ι), Π (ZZQ : τ ι), Π (ZZP : τ ι), Π (ZZO : τ ι), Π (ZZN : τ ι), Π (ZZM : τ ι), Π (ZZL : τ ι), Π (ZZK : τ (ι ⤳ o)), Π (ZZJ : τ ι), Π (ZZI : τ ι), Π (ZZH : τ ι), Π (ZZG : τ (ι ⤳ o)), Π (ZZF : τ ι), Π (ZZE : τ ι), Π (ZZD : τ ι), Π (ZZC : τ ι), Π (ZZB : τ ι), Π (ZZA : τ ι), Π (ZZ : τ (ι ⤳ o)), Π (ZY : τ ι), Π (ZX : τ ι), Π (ZW : τ o), Π (ZV : τ ι), Π (ZU : τ ι), Π (ZT : τ o), Π (ZS : τ ι), Π (ZR : τ (ι ⤳ o)), Π (ZQ : τ ι), Π (ZP : τ ι), Π (ZO : τ (ι ⤳ o)), Π (ZN : τ ι), Π (ZM : τ ι), Π (ZL : τ (ι ⤳ o)), Π (ZK : τ ι), Π (ZJ : τ ι), Π (ZI : τ (ι ⤳ o)), Π (ZH : τ ι), Π (ZG : τ ι), Π (ZF : τ ι), Π (ZE : τ ι), Π (ZD : τ ι), Π (ZC : τ ι), Π (ZB : τ ι), Π (ZA : τ ι), Π (Z : τ ι), Π (Y : τ ι), Π (X : τ ι), Π (W : τ ι), Π (V : τ ι), Π (U : τ ι), Π (T : τ ι), Π (S : τ ι), Π (R : τ ι), Π (Q : τ ι), Π (P : τ ι), Π (O : τ ι), Π (N : τ (ι ⤳ (ι ⤳ o))), Π (M : τ ι), Π (L : τ ι), Π (K : τ ι), Π (J : τ ι), Π (I : τ ι), Π (H : τ ι), Π (G : τ ι), Π (F : τ ι), Π (E : τ ι), Π (D : τ ι), Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (((¬ ((S.in_ (sk1 B A) A) = (S.in_ (sk1 B A) B))) ∨ (A = B)) ∧ (¬ (S.in_ C S.emptyset)) ∧ ((S.in_ F (S.setadjoin D E)) = ((F = D) ∨ (S.in_ F E))) ∧ ((S.in_ H (S.powerset G)) = (∀(λ (ZZZC : τ ι), ((S.in_ ZZZC H) ⇒ (S.in_ ZZZC G))))) ∧ ((S.in_ J (S.setunion I)) = (∃(λ (ZZZC : τ ι), ((S.in_ J ZZZC) ∧ (S.in_ ZZZC I))))) ∧ (S.in_ S.emptyset S.omega) ∧ ((¬ (S.in_ K S.omega)) ∨ (S.in_ (S.setadjoin K K) S.omega)) ∧ ((¬ (S.in_ S.emptyset L)) ∨ (S.in_ (sk2 L) S.omega) ∨ (¬ (S.in_ M S.omega)) ∨ (S.in_ M L)) ∧ ((¬ (S.in_ S.emptyset L)) ∨ (S.in_ (sk2 L) L) ∨ (¬ (S.in_ M S.omega)) ∨ (S.in_ M L)) ∧ ((¬ (S.in_ S.emptyset L)) ∨ (¬ (S.in_ (S.setadjoin (sk2 L) (sk2 L)) L)) ∨ (¬ (S.in_ M S.omega)) ∨ (S.in_ M L)) ∧ ((S.in_ (sk3 O N) O) ∨ ((S.in_ Q (sk5 O N)) = (∃(λ (ZZZC : τ ι), ((S.in_ ZZZC O) ∧ (N ZZZC Q)))))) ∧ ((¬ (N (sk3 O N) P)) ∨ (N (sk3 O N) (sk4 P O N)) ∨ ((S.in_ Q (sk5 O N)) = (∃(λ (ZZZC : τ ι), ((S.in_ ZZZC O) ∧ (N ZZZC Q)))))) ∧ ((¬ (N (sk3 O N) P)) ∨ (¬ (P = (sk4 P O N))) ∨ ((S.in_ Q (sk5 O N)) = (∃(λ (ZZZC : τ ι), ((S.in_ ZZZC O) ∧ (N ZZZC Q)))))) ∧ ((¬ (S.in_ S R)) ∨ (S.in_ (sk6 R) R)) ∧ ((¬ (S.in_ S R)) ∨ (¬ (S.in_ T (sk6 R))) ∨ (¬ (S.in_ T R))) ∧ ((¬ (S.in_ V (sk7 U))) ∨ (¬ (S.in_ W V)) ∨ (S.in_ W U)) ∧ ((¬ (S.in_ X U)) ∨ (¬ (S.in_ Y U)) ∨ (S.in_ (sk8 Y X U) (sk7 U)) ∨ (X = Y)) ∧ ((¬ (S.in_ X U)) ∨ (¬ (S.in_ Y U)) ∨ (¬ ((S.in_ X (sk8 Y X U)) = (S.in_ Y (sk8 Y X U)))) ∨ (X = Y)) ∧ ((¬ (S.in_ Z (sk7 U))) ∨ (¬ (S.in_ ZA (sk7 U))) ∨ (¬ (S.in_ ZB Z)) ∨ (S.in_ ZB ZA) ∨ (¬ (S.in_ ZC ZA)) ∨ (S.in_ ZC Z)) ∧ ((S.in_ (sk10 ZD U) ZD) ∨ (¬ (S.in_ ZE ZD)) ∨ (sk9 U ZD)) ∧ ((¬ (S.in_ (sk10 ZD U) U)) ∨ (¬ (S.in_ ZE ZD)) ∨ (sk9 U ZD)) ∧ ((¬ (sk9 U ZD)) ∨ (S.in_ (sk11 ZD U) (sk7 U))) ∧ ((¬ (sk9 U ZD)) ∨ (S.in_ (sk12 ZD U) ZD)) ∧ ((¬ (sk9 U ZD)) ∨ (¬ (S.in_ ZF (sk11 ZD U))) ∨ (¬ (S.in_ ZF ZD))) ∧ ((¬ (sk9 U ZD)) ∨ (¬ (S.in_ ZG (sk7 U))) ∨ (¬ (S.in_ ZH ZG)) ∨ (S.in_ ZH (sk11 ZD U)) ∨ (S.in_ (sk12 ZD U) ZG)) ∧ ((¬ (ZI ZJ)) ∨ (ZI (sk13 ZJ ZI)) ∨ (ZI (S.descr ZI))) ∧ ((¬ (ZI ZJ)) ∨ (¬ (ZJ = (sk13 ZJ ZI))) ∨ (ZI (S.descr ZI))) ∧ ((¬ (S.in_ ZM ZK)) ∨ (¬ (ZL ZM)) ∨ (S.in_ ZM (S.dsetconstr ZK ZL))) ∧ ((¬ (S.in_ ZP (S.dsetconstr ZN ZO))) ∨ (S.in_ ZP ZN)) ∧ ((¬ (S.in_ ZS (S.dsetconstr ZQ ZR))) ∨ (ZR ZS)) ∧ ((¬ (S.in_ ZU (S.dsetconstr (S.powerset S.emptyset) (λ (ZZZC: τ ι), ZT)))) ∨ ZT) ∧ ((¬ (S.in_ ZV S.emptyset)) ∨ ZW) ∧ (¬ (S.in_ ZX S.emptyset)) ∧ (¬ (S.in_ ZY S.emptyset)) ∧ ((¬ (ZZ ZZA)) ∨ (ZZ (sk14 ZZA ZZ)) ∨ (ZZ (sk15 ZZ))) ∧ ((¬ (ZZ ZZA)) ∨ (¬ (ZZA = (sk14 ZZA ZZ))) ∨ (ZZ (sk15 ZZ))) ∧ ((S.in_ (sk16 ZZC ZZB) ZZB) ∨ (S.in_ (sk17 ZZC ZZB) ZZC) ∨ (ZZB = ZZC)) ∧ ((S.in_ (sk16 ZZC ZZB) ZZB) ∨ (¬ (S.in_ (sk17 ZZC ZZB) ZZB)) ∨ (ZZB = ZZC)) ∧ ((¬ (S.in_ (sk16 ZZC ZZB) ZZC)) ∨ (S.in_ (sk17 ZZC ZZB) ZZC) ∨ (ZZB = ZZC)) ∧ ((¬ (S.in_ (sk16 ZZC ZZB) ZZC)) ∨ (¬ (S.in_ (sk17 ZZC ZZB) ZZB)) ∨ (ZZB = ZZC)) ∧ ((S.in_ (sk18 ZZD) ZZD) ∨ (ZZD = S.emptyset)) ∧ ((S.in_ (sk19 ZZE) ZZE) ∨ (ZZE = S.emptyset)) ∧ ((¬ (S.in_ ZZH ZZF)) ∨ ((S.in_ ZZH (S.dsetconstr ZZF ZZG)) = (ZZG ZZH))) ∧ ((ZZI = S.emptyset) ∨ (S.in_ (sk20 ZZI) ZZI)) ∧ ((¬ (S.in_ ZZL ZZJ)) ∨ (¬ (ZZK ZZL)) ∨ (¬ ((S.dsetconstr ZZJ ZZK) = S.emptyset))) ∧ ((¬ (S.in_ ZZN ZZM)) ∨ (¬ (ZZM = S.emptyset))) ∧ (S.in_ ZZO (S.setadjoin ZZO ZZP)) ∧ (S.in_ S.emptyset (S.setadjoin S.emptyset S.emptyset)) ∧ ((¬ (S.in_ ZZS ZZR)) ∨ (S.in_ ZZS (S.setadjoin ZZQ ZZR))) ∧ ((¬ (S.in_ ZZV (S.setadjoin ZZT ZZU))) ∨ (ZZV = ZZT) ∨ (S.in_ ZZV ZZU) ∨ ZZW) ∧ ((¬ (S.in_ ZZV (S.setadjoin ZZT ZZU))) ∨ (ZZV = ZZT) ∨ (¬ ZZW) ∨ ZZW) ∧ ((¬ (S.in_ ZZV (S.setadjoin ZZT ZZU))) ∨ (¬ ZZW) ∨ (S.in_ ZZV ZZU) ∨ ZZW) ∧ ((¬ (S.in_ ZZV (S.setadjoin ZZT ZZU))) ∨ (¬ ZZW) ∨ (¬ ZZW) ∨ ZZW) ∧ ((¬ (S.in_ ZZZ (S.setadjoin ZZX ZZY))) ∨ (ZZZ = ZZX) ∨ (S.in_ ZZZ ZZY)) ∧ ((S.dsetconstr ZZZA (λ (ZZZC: τ ι), ⊤)) = ZZZA) ∧ ((¬ (S.in_ ZZZB sk22)) ∨ (S.in_ ZZZB sk21)) ∧ (¬ (S.in_ sk22 (S.powerset sk21))))
		{admit;};
	// cnfConj;
	have step55 : Π (B : τ ι), Π (A : τ ι), π (S.in_ B (S.powerset A) = (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)))
		{assume H G;
		refine (∧ₑₙ 3 (_ ⸬ _ ⸬ _ ⸬ ((S.in_ H (S.powerset G)) = (∀(λ (ZZZC : τ ι), ((S.in_ ZZZC H) ⇒ (S.in_ ZZZC G))))) ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ □) ⊤ᵢ (step5 (el ι) (el ι) (el ι) (el ι) (el ι) (el o) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el o) (el ι) (el ι) (el o) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ (ι ⤳ o))) (el ι) (el ι) (el ι) (el ι) (el ι) H G (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// cnfConj;
	have step58 : π (¬ S.in_ sk22 (S.powerset sk21))
		{refine (∧ₑₙ 56 (_ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ (¬ (S.in_ sk22 (S.powerset sk21))) ⸬ □) ⊤ᵢ (step5 (el ι) (el ι) (el ι) (el ι) (el ι) (el o) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el o) (el ι) (el ι) (el o) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ (ι ⤳ o))) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// OrderedPara;
	have step345 : Π (B : τ ι), Π (A : τ ι), π (¬ (∀(λ (C : τ ι), S.in_ C B ⇒ S.in_ C A)) ∨ ¬ (S.in_ B (S.powerset A) = S.in_ sk22 (S.powerset sk21)))
		{assume B A;
		refine (∨ₑ (em ((S.in_ B (S.powerset A)) = (S.in_ sk22 (S.powerset sk21)))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((¬ x) ∨ _)] (step55 B A);
			// Rewrite parent with unification constraint;
			rewrite .[x in ((¬ x) ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((¬ (S.in_ sk22 (S.powerset sk21))) ⸬ □) ((¬ ((S.in_ B (S.powerset A)) = (S.in_ sk22 (S.powerset sk21)))) ⸬ □)) (step58))}
			{assume uniLitInEq;
			refine (∨ᵢ₂ uniLitInEq)}};
	// pattern_uni;
	have step346 : π (¬ (∀(λ (A : τ ι), S.in_ A sk22 ⇒ S.in_ A sk21)))
		{have Subst : π (¬ (∀(λ (C : τ ι), S.in_ C sk22 ⇒ S.in_ C sk21)) ∨ ¬ (S.in_ sk22 (S.powerset sk21) = S.in_ sk22 (S.powerset sk21)))
			{refine (step345 sk22 sk21);};
		have RemoveUniConst : π ((¬ (∀(λ (C : τ ι), S.in_ C sk22 ⇒ S.in_ C sk21)) ∨ ¬ (S.in_ sk22 (S.powerset sk21) = S.in_ sk22 (S.powerset sk21))) = ¬ (∀(λ (C : τ ι), S.in_ C sk22 ⇒ S.in_ C sk21)))
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((¬ (∀(λ (C : τ ι), S.in_ C sk22 ⇒ S.in_ C sk21))) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// RenameCNF_conj;
	have step373 : π ((S.in_ sk24 sk22) ∧ (¬ (S.in_ sk24 sk21)))
		{have Clausification : π ((¬ (∀(λ (A : τ ι), ((S.in_ A sk22) ⇒ (S.in_ A sk21))))) = ((S.in_ sk24 sk22) ∧ (¬ (S.in_ sk24 sk21))))
			{eval (stepwise_quants ((skolemProzess_∀ (#rewrite "left" "" sk24_def)) ⸬ □))};
		refine (((=⇒ Clausification) step346))};
	// cnfConj;
	have step374 : π (S.in_ sk24 sk22)
		{refine (∧ₑₙ 0 ((S.in_ sk24 sk22) ⸬ _ ⸬ □) ⊤ᵢ (step373))};
	// cnfConj;
	have step36 : Π (A : τ ι), π (¬ S.in_ A sk22 ∨ S.in_ A sk21)
		{assume ZZZB;
		refine (∧ₑₙ 55 (_ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ ((¬ (S.in_ ZZZB sk22)) ∨ (S.in_ ZZZB sk21)) ⸬ _ ⸬ □) ⊤ᵢ (step5 ZZZB (el ι) (el ι) (el ι) (el ι) (el o) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el o) (el ι) (el ι) (el o) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el (ι ⤳ o)) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el (ι ⤳ (ι ⤳ o))) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// OrderedPara;
	have step3344 : Π (A : τ ι), π (¬ ⊤ ∨ (S.in_ A sk21 ∨ ¬ (S.in_ sk24 sk22 = S.in_ A sk22)))
		{assume A;
		// Transform withLiteral to an equation;
		have equationalWithClause : π ((S.in_ sk24 sk22) = ⊤)
			{rewrite =⊤;
			refine (step374)};
		refine (∨ₑ (em ((S.in_ sk24 sk22) = (S.in_ A sk22))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((¬ x) ∨ _ ∨ _)] equationalWithClause;
			// Rewrite parent with unification constraint;
			rewrite .[x in ((¬ x) ∨ _ ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((¬ (S.in_ A sk22)) ⸬ (S.in_ A sk21) ⸬ □) ((¬ ((S.in_ sk24 sk22) = (S.in_ A sk22))) ⸬ □)) (step36 A))}
			{assume uniLitInEq;
			refine ((∨ᵢₙ ((¬ ⊤) ⸬ (S.in_ A sk21) ⸬ □) ((¬ ((S.in_ sk24 sk22) = (S.in_ A sk22))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step3345 : Π (A : τ ι), π (S.in_ A sk21 ∨ ¬ (S.in_ sk24 sk22 = S.in_ A sk22))
		{assume A;
		have SimpApp : π (((¬ ⊤) ∨ (S.in_ A sk21) ∨ (¬ ((S.in_ sk24 sk22) = (S.in_ A sk22)))) ⇒ ((S.in_ A sk21) ∨ (¬ ((S.in_ sk24 sk22) = (S.in_ A sk22)))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step3344 A))};
	// pattern_uni;
	have step3346 : π (S.in_ sk24 sk21)
		{have Subst : π (S.in_ sk24 sk21 ∨ ¬ (S.in_ sk24 sk22 = S.in_ sk24 sk22))
			{refine (step3345 sk24);};
		have RemoveUniConst : π ((S.in_ sk24 sk21 ∨ ¬ (S.in_ sk24 sk22 = S.in_ sk24 sk22)) = S.in_ sk24 sk21)
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((S.in_ sk24 sk21) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// cnfConj;
	have step375 : π (¬ S.in_ sk24 sk21)
		{refine (∧ₑₙ 1 (_ ⸬ (¬ (S.in_ sk24 sk21)) ⸬ □) ⊤ᵢ (step373))};
	// RewriteSimp;
	have step3391 : π ⊥
		{have TransformToEqLits_0 : π (⊥ = (S.in_ sk24 sk21))
			{rewrite ⊥=;
			refine (step375)};
		rewrite .[x in x] TransformToEqLits_0;
		refine ((step3346))};
	refine step3391;
end;
