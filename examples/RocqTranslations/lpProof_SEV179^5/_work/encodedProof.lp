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
require lpProof_SEV179^5-noOp.Signature as S; 
require lpProof_SEV179^5-noOp.Formulae as F;


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// SKOLEM TERMS ///////////////////////////////////

symbol sk1: τ ((ι ⤳ o) ⤳ ι);
symbol sk1_def: π (sk1  = (ε(λ (A : τ ((ι ⤳ o) ⤳ ι)), ¬ (∃(λ (B : τ (ι ⤳ o)), ¬ B (A B) ∧ A (λ (C : τ ι), (∃(λ (D : τ (ι ⤳ o)), ¬ D (A D) ∧ C = A D))) = A B)))));
symbol sk2: τ (ι ⤳ o);
symbol sk2_def: π (sk2  = (ε(λ (A : τ (ι ⤳ o)), ¬ A (sk1 A) ∧ sk1 (λ (B : τ ι), (∃(λ (C : τ (ι ⤳ o)), ¬ C (sk1 C) ∧ B = sk1 C))) = sk1 A)));


// PROOF ENCODING ////////////////////////////////////////

 symbol encodedProof: π (∀(λ (A : τ ((ι ⤳ o) ⤳ ι)), S.cD_FOR_X5309 A (A (S.cD_FOR_X5309 A)))) ≔
begin
	refine (¬¬ₑ (∀(λ (A : τ ((ι ⤳ o) ⤳ ι)), S.cD_FOR_X5309 A (A (S.cD_FOR_X5309 A)))) _);
	assume negatedConjecture;
	// DefExpand;
	have step3 : π (¬ (∀(λ (A : τ ((ι ⤳ o) ⤳ ι)), (∃(λ (B : τ (ι ⤳ o)), ¬ B (A B) ∧ A (λ (C : τ ι), (∃(λ (D : τ (ι ⤳ o)), ¬ D (A D) ∧ C = A D))) = A B)))))
		{have defExpStep : π ((¬ (∀(λ (A : τ ((ι ⤳ o) ⤳ ι)), (S.cD_FOR_X5309 A (A (S.cD_FOR_X5309 A)))))) ⇒ (¬ (∀(λ (A : τ ((ι ⤳ o) ⤳ ι)), (∃(λ (B : τ (ι ⤳ o)), ((¬ (B (A B))) ∧ ((A (λ (C: τ ι), (∃(λ (D : τ (ι ⤳ o)), ((¬ (D (A D))) ∧ (C = (A D))))))) = (A B)))))))))
			{eval (#repeat (#rewrite "" "" F.cD_FOR_X5309_def));
			assume h;
			refine h};
		refine (defExpStep negatedConjecture)};
	// Unencoded step (RenameCNF_conj): Clausification involving Binders not encoded;
	have step4 : Π (A : τ (ι ⤳ o)), π ((A (sk1 A)) ∨ (¬ ((sk1 (λ (B: τ ι), (∃(λ (C : τ (ι ⤳ o)), ((¬ (C (sk1 C))) ∧ (B = (sk1 C))))))) = (sk1 A))))
		{admit;};
	// LiftEq;
	have step5 : Π (A : τ (ι ⤳ o)), π (¬ (sk1 (λ (B : τ ι), (∃(λ (C : τ (ι ⤳ o)), ¬ C (sk1 C) ∧ B = sk1 C))) = sk1 A) ∨ A (sk1 A))
		{assume A;
		refine (permute (1 ⸬ 0 ⸬ □) ((A (sk1 A)) ⸬ (¬ ((sk1 (λ (B: τ ι), (∃(λ (C : τ (ι ⤳ o)), ((¬ (C (sk1 C))) ∧ (B = (sk1 C))))))) = (sk1 A))) ⸬ □) ⊤ᵢ (step4 A))};
	// pattern_uni;
	have step7 : π (∃(λ (A : τ (ι ⤳ o)), ¬ A (sk1 A) ∧ sk1 (λ (B : τ ι), (∃(λ (C : τ (ι ⤳ o)), ¬ C (sk1 C) ∧ B = sk1 C))) = sk1 A))
		{have Subst : π (¬ (sk1 (λ (A : τ ι), (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 (λ (C : τ ι), B C)) ∧ A = sk1 (λ (C : τ ι), B C)))) = sk1 (λ (A : τ ι), (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 (λ (C : τ ι), B C)) ∧ A = sk1 (λ (C : τ ι), B C))))) ∨ (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 B) ∧ sk1 (λ (C : τ ι), (∃(λ (D : τ (ι ⤳ o)), ¬ D (sk1 D) ∧ C = sk1 D))) = sk1 B)))
			{refine (step5 (λ (A : τ ι), (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 B) ∧ A = sk1 B))));};
		have RemoveUniConst : π ((¬ (sk1 (λ (A : τ ι), (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 (λ (C : τ ι), B C)) ∧ A = sk1 (λ (C : τ ι), B C)))) = sk1 (λ (A : τ ι), (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 (λ (C : τ ι), B C)) ∧ A = sk1 (λ (C : τ ι), B C))))) ∨ (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 B) ∧ sk1 (λ (C : τ ι), (∃(λ (D : τ (ι ⤳ o)), ¬ D (sk1 D) ∧ C = sk1 D))) = sk1 B))) = (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 B) ∧ sk1 (λ (C : τ ι), (∃(λ (D : τ (ι ⤳ o)), ¬ D (sk1 D) ∧ C = sk1 D))) = sk1 B)))
			{eval (removeTrivialFalse ".[x in ((x ∨ _) = _)]");
			refine (deleteBots (0 ⸬ □) ((∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 B) ∧ sk1 (λ (C : τ ι), (∃(λ (D : τ (ι ⤳ o)), ¬ D (sk1 D) ∧ C = sk1 D))) = sk1 B)) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// Unencoded step (RenameCNF_conj): Clausification involving Binders not encoded;
	have step13 : π ((¬ (sk2 (sk1 sk2))) ∧ ((sk1 (λ (A: τ ι), (∃(λ (B : τ (ι ⤳ o)), ((¬ (B (sk1 B))) ∧ (A = (sk1 B))))))) = (sk1 sk2)))
		{admit;};
	// cnfConj;
	have step15 : π (sk1 (λ (A : τ ι), (∃(λ (B : τ (ι ⤳ o)), ¬ B (sk1 B) ∧ A = sk1 B))) = sk1 sk2)
		{refine (∧ₑₙ 1 (_ ⸬ ((sk1 (λ (A: τ ι), (∃(λ (B : τ (ι ⤳ o)), ((¬ (B (sk1 B))) ∧ (A = (sk1 B))))))) = (sk1 sk2)) ⸬ □) ⊤ᵢ (step13))};
	// OrderedPara;
	have step31 : Π (A : τ (ι ⤳ o)), π (¬ (sk1 (λ (B : τ ι), (∃(λ (C : τ (ι ⤳ o)), ¬ C (sk1 C) ∧ B = sk1 C))) = sk1 (λ (B : τ ι), (∃(λ (C : τ (ι ⤳ o)), ¬ C (sk1 C) ∧ B = sk1 C)))) ∨ (A (sk1 A) ∨ ¬ (sk1 sk2 = sk1 A)))
		{assume A;
		refine (∨ₑ (em ((sk1 sk2) = (sk1 A))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite .[x in ((¬ (_ = x)) ∨ _ ∨ _)] (step15);
			// Rewrite parent with unification constraint;
			rewrite .[x in ((¬ (_ = x)) ∨ _ ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((¬ ((sk1 (λ (B: τ ι), (∃(λ (C : τ (ι ⤳ o)), ((¬ (C (sk1 C))) ∧ (B = (sk1 C))))))) = (sk1 A))) ⸬ (A (sk1 A)) ⸬ □) ((¬ ((sk1 sk2) = (sk1 A))) ⸬ □)) (step5 A))}
			{assume uniLitInEq;
			refine ((∨ᵢₙ ((¬ ((sk1 (λ (B: τ ι), (∃(λ (C : τ (ι ⤳ o)), ((¬ (C (sk1 C))) ∧ (B = (sk1 C))))))) = (sk1 (λ (B: τ ι), (∃(λ (C : τ (ι ⤳ o)), ((¬ (C (sk1 C))) ∧ (B = (sk1 C))))))))) ⸬ (A (sk1 A)) ⸬ □) ((¬ ((sk1 sk2) = (sk1 A))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step32 : Π (A : τ (ι ⤳ o)), π (A (sk1 A) ∨ ¬ (sk1 sk2 = sk1 A))
		{assume A;
		have SimpApp : π (((¬ ((sk1 (λ (B: τ ι), (∃(λ (C : τ (ι ⤳ o)), ((¬ (C (sk1 C))) ∧ (B = (sk1 C))))))) = (sk1 (λ (B: τ ι), (∃(λ (C : τ (ι ⤳ o)), ((¬ (C (sk1 C))) ∧ (B = (sk1 C))))))))) ∨ (A (sk1 A)) ∨ (¬ ((sk1 sk2) = (sk1 A)))) ⇒ ((A (sk1 A)) ∨ (¬ ((sk1 sk2) = (sk1 A)))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step31 A))};
	// pattern_uni;
	have step33 : π (sk2 (sk1 sk2))
		{have Subst : π (sk2 (sk1 sk2) ∨ ¬ (sk1 (λ (A : τ ι), sk2 A) = sk1 (λ (A : τ ι), sk2 A)))
			{refine (step32 sk2);};
		have RemoveUniConst : π ((sk2 (sk1 sk2) ∨ ¬ (sk1 (λ (A : τ ι), sk2 A) = sk1 (λ (A : τ ι), sk2 A))) = sk2 (sk1 sk2))
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((sk2 (sk1 sk2)) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// cnfConj;
	have step14 : π (¬ sk2 (sk1 sk2))
		{refine (∧ₑₙ 0 ((¬ (sk2 (sk1 sk2))) ⸬ _ ⸬ □) ⊤ᵢ (step13))};
	// RewriteSimp;
	have step70 : π ⊥
		{have TransformToEqLits_0 : π (⊥ = (sk2 (sk1 sk2)))
			{rewrite ⊥=;
			refine (step14)};
		rewrite .[x in x] TransformToEqLits_0;
		refine ((step33))};
	refine step70;
end;
