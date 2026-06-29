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


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// SKOLEM TERMS ///////////////////////////////////

symbol sk1: τ (ι ⤳ (ι ⤳ o));
symbol sk1_def: π (sk1  = (ε(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), A C = B)))))));
symbol sk2: τ ((ι ⤳ o) ⤳ ι);
symbol sk2_def (A : τ (ι ⤳ o)): π (sk2 A = (ε(λ (B : τ ι), sk1 B = A)));


// PROOF ENCODING ////////////////////////////////////////

symbol encodedProof: π (¬ (∃(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), A C = B))))))) ≔
begin
	refine (¬¬ₑ (¬ (∃(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), A C = B))))))) _);
	assume negatedConjecture;
	// PolaritySwitch;
	have step4 : π (∃(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), A C = B))))))
		{have PolaritySwitch_lit0 : π ((∃(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), ((A C) = B))))))) = (¬ (¬ (∃(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), ((A C) = B))))))))))
			{refine (eq_sym (¬¬ₑ_eq (∃(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), ((A C) = B)))))))))};
		rewrite PolaritySwitch_lit0;
		refine (negatedConjecture)};
	// RenameCNF_conj;
	have step5 : Π (A : τ (ι ⤳ o)), π ((sk1 (sk2 A)) = A)
		{assume B;
		have Clausification : π ((∃(λ (A : τ (ι ⤳ (ι ⤳ o))), (∀(λ (B : τ (ι ⤳ o)), (∃(λ (C : τ ι), ((A C) = B))))))) = (∀(λ (A : τ (ι ⤳ o)), ((sk1 (sk2 A)) = A))))
			{eval (skolemProzess_∃ (#rewrite "left" "" sk1_def));
			eval (move_∀_out (#assume "A"));
			eval (stepwise_quants ((skolemProzess_∃ (#rewrite "left" "" (sk2_def A))) ⸬ □))};
		refine (((=⇒ Clausification) step4) B)};
	// FuncExt;
	have step7 : Π (B : τ ι), Π (A : τ (ι ⤳ o)), π (sk1 (sk2 A) B = A B)
		{assume B A;
		have PFE_0 : (π ((sk1 (sk2 A)) = A) → π ((sk1 (sk2 A) B) = (A B)))
			{refine (PFE (sk1 (sk2 A)) A B)};
		have PFE_0_app : π ((sk1 (sk2 A) B) = (A B))
			{refine ((PFE_0 (step5 A)))};
		refine (PFE_0_app)};
	// BoolExt;
	have step9 : Π (B : τ ι), Π (A : τ (ι ⤳ o)), π (sk1 (sk2 A) B ∨ ¬ A B)
		{assume B A;
		refine ((PBE_r (sk1 (sk2 A) B) (A B)) (step7 B A))};
	// OrderedEqFac;
	have step269 : Π (B : τ ι), Π (A : τ (ι ⤳ o)), π (sk1 (sk2 A) B ∨ (¬ (A B = ¬ sk1 (sk2 A) B) ∨ ¬ ⊤))
		{assume B A;
		have WholeEqFactStep : (π ((sk1 (sk2 A) B) ∨ (¬ (A B))) → π ((sk1 (sk2 A) B) ∨ (¬ ((A B) = (¬ (sk1 (sk2 A) B)))) ∨ (¬ ⊤)))
			{assume h1;
			have pre_eqFac_transform : π ((¬ ((¬ (sk1 (sk2 A) B)) = ⊤)) ∨ (¬ ((A B) = ⊤)))
				{rewrite .[x in (x ∨ _)] (¬neg=⊤);
				rewrite .[x in (_ ∨ x)] (¬=⊤);
				refine (h1)};
			have EqFact : π ((¬ ((¬ (sk1 (sk2 A) B)) = ⊤)) ∨ (¬ ((¬ (sk1 (sk2 A) B)) = (A B))) ∨ (¬ (⊤ = ⊤)))
				{refine ((EqFact_n [o] (¬ (sk1 (sk2 A) B)) ⊤ (A B) ⊤) pre_eqFac_transform)};
			have post_eqFac_transform : π ((sk1 (sk2 A) B) ∨ (¬ ((A B) = (¬ (sk1 (sk2 A) B)))) ∨ (¬ ⊤))
				{rewrite left  .[x in (x ∨ _ ∨ _)] (¬neg=⊤);
				rewrite .[x in (_ ∨ (¬ x) ∨ _)] (=_sym [o]);
				rewrite left  .[x in (_ ∨ _ ∨ x)] (¬=⊤);
				rewrite .[x in (_ ∨ _ ∨ (¬ x))] (=_sym [o]);
				refine (EqFact)};
			refine (post_eqFac_transform)};
		refine (WholeEqFactStep (step9 B A))};
	// PreUni;
	have step294 : π (sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)))
		{have Substitution : π (sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) ∨ (¬ (¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) = ¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A))) ∨ ¬ ⊤))
			{refine (step269 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (λ (A : τ ι), ¬ sk1 A A));};
		have RemoveUniConst : π ((sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) ∨ (¬ (¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) = ¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A))) ∨ ¬ ⊤)) = sk1 (sk2 (λ (C : τ ι), ¬ sk1 C C)) (sk2 (λ (C : τ ι), ¬ sk1 C C)))
			{eval (removeTrivialFalse ".[x in ((_ ∨ (_ ∨ x)) = _)]");
			eval (removeTrivialFalse ".[x in ((_ ∨ (x ∨ _)) = _)]");
			refine (deleteBots (1 ⸬ 2 ⸬ □) ((sk1 (sk2 (λ (C : τ ι), ¬ sk1 C C)) (sk2 (λ (C : τ ι), ¬ sk1 C C))) ⸬ □));};
		refine (=⇒ RemoveUniConst Substitution);};
	// BoolExt;
	have step8 : Π (B : τ ι), Π (A : τ (ι ⤳ o)), π (¬ sk1 (sk2 A) B ∨ A B)
		{assume B A;
		refine ((PBE_l (sk1 (sk2 A) B) (A B)) (step7 B A))};
	// OrderedEqFac;
	have step19 : Π (B : τ ι), Π (A : τ (ι ⤳ o)), π (¬ sk1 (sk2 A) B ∨ (¬ (A B = ¬ sk1 (sk2 A) B) ∨ ¬ ⊤))
		{assume B A;
		have WholeEqFactStep : (π ((¬ (sk1 (sk2 A) B)) ∨ (A B)) → π ((¬ (sk1 (sk2 A) B)) ∨ (¬ ((A B) = (¬ (sk1 (sk2 A) B)))) ∨ (¬ ⊤)))
			{assume h1;
			have pre_eqFac_transform : π (((¬ (sk1 (sk2 A) B)) = ⊤) ∨ ((A B) = ⊤))
				{rewrite .[x in (x ∨ _)] (neg=⊤);
				rewrite .[x in (_ ∨ x)] (=⊤);
				refine (h1)};
			have EqFact : π (((¬ (sk1 (sk2 A) B)) = ⊤) ∨ (¬ ((¬ (sk1 (sk2 A) B)) = (A B))) ∨ (¬ (⊤ = ⊤)))
				{refine ((EqFact_p [o] (¬ (sk1 (sk2 A) B)) ⊤ (A B) ⊤) pre_eqFac_transform)};
			have post_eqFac_transform : π ((¬ (sk1 (sk2 A) B)) ∨ (¬ ((A B) = (¬ (sk1 (sk2 A) B)))) ∨ (¬ ⊤))
				{rewrite left  .[x in (x ∨ _ ∨ _)] (neg=⊤);
				rewrite .[x in (_ ∨ (¬ x) ∨ _)] (=_sym [o]);
				rewrite left  .[x in (_ ∨ _ ∨ x)] (¬=⊤);
				rewrite .[x in (_ ∨ _ ∨ (¬ x))] (=_sym [o]);
				refine (EqFact)};
			refine (post_eqFac_transform)};
		refine (WholeEqFactStep (step8 B A))};
	// PreUni;
	have step36 : π (¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)))
		{have Substitution : π (¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) ∨ (¬ (¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) = ¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A))) ∨ ¬ ⊤))
			{refine (step19 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (λ (A : τ ι), ¬ sk1 A A));};
		have RemoveUniConst : π ((¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) ∨ (¬ (¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A)) = ¬ sk1 (sk2 (λ (A : τ ι), ¬ sk1 A A)) (sk2 (λ (A : τ ι), ¬ sk1 A A))) ∨ ¬ ⊤)) = ¬ sk1 (sk2 (λ (C : τ ι), ¬ sk1 C C)) (sk2 (λ (C : τ ι), ¬ sk1 C C)))
			{eval (removeTrivialFalse ".[x in ((_ ∨ (_ ∨ x)) = _)]");
			eval (removeTrivialFalse ".[x in ((_ ∨ (x ∨ _)) = _)]");
			refine (deleteBots (1 ⸬ 2 ⸬ □) ((¬ sk1 (sk2 (λ (C : τ ι), ¬ sk1 C C)) (sk2 (λ (C : τ ι), ¬ sk1 C C))) ⸬ □));};
		refine (=⇒ RemoveUniConst Substitution);};
	// RewriteSimp;
	have step409 : π ⊥
		{have TransformToEqLits_0 : π (⊥ = (sk1 (sk2 (λ (A: τ ι), (¬ (sk1 A A)))) (sk2 (λ (A: τ ι), (¬ (sk1 A A))))))
			{rewrite ⊥=;
			refine (step36)};
		rewrite .[x in x] TransformToEqLits_0;
		refine ((step294))};
	refine step409;
end;
