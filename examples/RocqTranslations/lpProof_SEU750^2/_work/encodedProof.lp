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
require lpProof_SEU750^2-noOp.Signature as S; 
require lpProof_SEU750^2-noOp.Formulae as F;


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// SKOLEM TERMS ///////////////////////////////////

symbol sk1: τ ι;
symbol sk1_def: π (sk1  = (ε(λ (A : τ ι), ¬ (∀(λ (B : τ ι), S.in_ B (S.powerset A) ⇒ (∀(λ (C : τ ι), S.in_ C (S.powerset A) ⇒ (∀(λ (D : τ ι), S.in_ D A ⇒ S.in_ D (S.setminus A (S.binunion B C)) ⇒ S.in_ D (S.setminus A C))))))))));
symbol sk2: τ ι;
symbol sk2_def: π (sk2  = (ε(λ (A : τ ι), ¬ (S.in_ A (S.powerset sk1) ⇒ (∀(λ (B : τ ι), S.in_ B (S.powerset sk1) ⇒ (∀(λ (C : τ ι), S.in_ C sk1 ⇒ S.in_ C (S.setminus sk1 (S.binunion A B)) ⇒ S.in_ C (S.setminus sk1 B)))))))));
symbol sk3: τ ι;
symbol sk3_def: π (sk3  = (ε(λ (A : τ ι), ¬ (S.in_ A (S.powerset sk1) ⇒ (∀(λ (B : τ ι), S.in_ B sk1 ⇒ S.in_ B (S.setminus sk1 (S.binunion sk2 A)) ⇒ S.in_ B (S.setminus sk1 A)))))));
symbol sk4: τ ι;
symbol sk4_def: π (sk4  = (ε(λ (A : τ ι), ¬ (S.in_ A sk1 ⇒ S.in_ A (S.setminus sk1 (S.binunion sk2 sk3)) ⇒ S.in_ A (S.setminus sk1 sk3)))));


// PROOF ENCODING ////////////////////////////////////////

 symbol encodedProof: π (S.setminusI ⇒ S.setminusER ⇒ S.binunionTIRcontra ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) ⇒ (∀(λ (C : τ ι), S.in_ C (S.powerset A) ⇒ (∀(λ (D : τ ι), S.in_ D A ⇒ S.in_ D (S.setminus A (S.binunion B C)) ⇒ S.in_ D (S.setminus A C)))))))))) ≔
begin
	refine (¬¬ₑ (S.setminusI ⇒ S.setminusER ⇒ S.binunionTIRcontra ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) ⇒ (∀(λ (C : τ ι), S.in_ C (S.powerset A) ⇒ (∀(λ (D : τ ι), S.in_ D A ⇒ S.in_ D (S.setminus A (S.binunion B C)) ⇒ S.in_ D (S.setminus A C)))))))))) _);
	assume negatedConjecture;
	// DefExpand;
	have step3 : π (¬ ((∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C A ⇒ ¬ S.in_ C B ⇒ S.in_ C (S.setminus A B))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), S.in_ C (S.setminus A B) ⇒ ¬ S.in_ C B)))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) ⇒ (∀(λ (C : τ ι), S.in_ C (S.powerset A) ⇒ (∀(λ (D : τ ι), S.in_ D A ⇒ ¬ S.in_ D (S.binunion B C) ⇒ ¬ S.in_ D C)))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.in_ B (S.powerset A) ⇒ (∀(λ (C : τ ι), S.in_ C (S.powerset A) ⇒ (∀(λ (D : τ ι), S.in_ D A ⇒ S.in_ D (S.setminus A (S.binunion B C)) ⇒ S.in_ D (S.setminus A C)))))))))))
		{have defExpStep : π ((¬ (S.setminusI ⇒ (S.setminusER ⇒ (S.binunionTIRcontra ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), ((S.in_ B (S.powerset A)) ⇒ (∀(λ (C : τ ι), ((S.in_ C (S.powerset A)) ⇒ (∀(λ (D : τ ι), ((S.in_ D A) ⇒ ((S.in_ D (S.setminus A (S.binunion B C))) ⇒ (S.in_ D (S.setminus A C)))))))))))))))))) ⇒ (¬ ((∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), ((S.in_ C A) ⇒ ((¬ (S.in_ C B)) ⇒ (S.in_ C (S.setminus A B)))))))))) ⇒ ((∀(λ (A : τ ι), (∀(λ (B : τ ι), (∀(λ (C : τ ι), ((S.in_ C (S.setminus A B)) ⇒ (¬ (S.in_ C B))))))))) ⇒ ((∀(λ (A : τ ι), (∀(λ (B : τ ι), ((S.in_ B (S.powerset A)) ⇒ (∀(λ (C : τ ι), ((S.in_ C (S.powerset A)) ⇒ (∀(λ (D : τ ι), ((S.in_ D A) ⇒ ((¬ (S.in_ D (S.binunion B C))) ⇒ (¬ (S.in_ D C)))))))))))))) ⇒ (∀(λ (A : τ ι), (∀(λ (B : τ ι), ((S.in_ B (S.powerset A)) ⇒ (∀(λ (C : τ ι), ((S.in_ C (S.powerset A)) ⇒ (∀(λ (D : τ ι), ((S.in_ D A) ⇒ ((S.in_ D (S.setminus A (S.binunion B C))) ⇒ (S.in_ D (S.setminus A C)))))))))))))))))))
			{eval (#repeat ((#rewrite "" "" F.setminusI_def) #orelse ((#rewrite "" "" F.setminusER_def) #orelse (#rewrite "" "" F.binunionTIRcontra_def))));
			assume h;
			refine h};
		refine (defExpStep negatedConjecture)};
	// Unencoded step (RenameCNF_conj): Clausification involving Binders not encoded;
	have step4 : Π (J : τ ι), Π (I : τ ι), Π (H : τ ι), Π (G : τ ι), Π (F : τ ι), Π (E : τ ι), Π (D : τ ι), Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (((¬ (S.in_ C A)) ∨ (S.in_ C B) ∨ (S.in_ C (S.setminus A B))) ∧ ((¬ (S.in_ F (S.setminus D E))) ∨ (¬ (S.in_ F E))) ∧ ((¬ (S.in_ H (S.powerset G))) ∨ (¬ (S.in_ I (S.powerset G))) ∨ (¬ (S.in_ J G)) ∨ (S.in_ J (S.binunion H I)) ∨ (¬ (S.in_ J I))) ∧ (S.in_ sk2 (S.powerset sk1)) ∧ (S.in_ sk3 (S.powerset sk1)) ∧ (S.in_ sk4 sk1) ∧ (S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) ∧ (¬ (S.in_ sk4 (S.setminus sk1 sk3))))
		{admit;};
	// cnfConj;
	have step11 : π (S.in_ sk2 (S.powerset sk1))
		{refine (∧ₑₙ 3 (_ ⸬ _ ⸬ _ ⸬ (S.in_ sk2 (S.powerset sk1)) ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ □) ⊤ᵢ (step4 (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// cnfConj;
	have step10 : Π (D : τ ι), Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ B (S.powerset A) ∨ (¬ S.in_ C (S.powerset A) ∨ (¬ S.in_ D A ∨ (S.in_ D (S.binunion B C) ∨ ¬ S.in_ D C))))
		{assume J I H G;
		refine (∧ₑₙ 2 (_ ⸬ _ ⸬ ((¬ (S.in_ H (S.powerset G))) ∨ (¬ (S.in_ I (S.powerset G))) ∨ (¬ (S.in_ J G)) ∨ (S.in_ J (S.binunion H I)) ∨ (¬ (S.in_ J I))) ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ □) ⊤ᵢ (step4 J I H G (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// cnfConj;
	have step5 : π (S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3)))
		{refine (∧ₑₙ 6 (_ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ (S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) ⸬ _ ⸬ □) ⊤ᵢ (step4 (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// cnfConj;
	have step12 : Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ C (S.setminus A B) ∨ ¬ S.in_ C B)
		{assume F E D;
		refine (∧ₑₙ 1 (_ ⸬ ((¬ (S.in_ F (S.setminus D E))) ∨ (¬ (S.in_ F E))) ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ □) ⊤ᵢ (step4 (el ι) (el ι) (el ι) (el ι) F E D (el ι) (el ι) (el ι)))};
	// OrderedPara;
	have step79 : Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ ⊤ ∨ (¬ S.in_ C B ∨ ¬ (S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3)) = S.in_ C (S.setminus A B))))
		{assume C B A;
		// Transform withLiteral to an equation;
		have equationalWithClause : π ((S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) = ⊤)
			{rewrite =⊤;
			refine (step5)};
		refine (∨ₑ (em ((S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) = (S.in_ C (S.setminus A B)))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((¬ x) ∨ _ ∨ _)] equationalWithClause;
			// Rewrite parent with unification constraint;
			rewrite .[x in ((¬ x) ∨ _ ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((¬ (S.in_ C (S.setminus A B))) ⸬ (¬ (S.in_ C B)) ⸬ □) ((¬ ((S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) = (S.in_ C (S.setminus A B)))) ⸬ □)) (step12 C B A))}
			{assume uniLitInEq;
			refine ((∨ᵢₙ ((¬ ⊤) ⸬ (¬ (S.in_ C B)) ⸬ □) ((¬ ((S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) = (S.in_ C (S.setminus A B)))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step80 : Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ C B ∨ ¬ (S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3)) = S.in_ C (S.setminus A B)))
		{assume C B A;
		have SimpApp : π (((¬ ⊤) ∨ (¬ (S.in_ C B)) ∨ (¬ ((S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) = (S.in_ C (S.setminus A B))))) ⇒ ((¬ (S.in_ C B)) ∨ (¬ ((S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))) = (S.in_ C (S.setminus A B))))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step79 C B A))};
	// pattern_uni;
	have step81 : π (¬ S.in_ sk4 (S.binunion sk2 sk3))
		{have Subst : π (¬ S.in_ sk4 (S.binunion sk2 sk3) ∨ ¬ (S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3)) = S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3))))
			{refine (step80 sk4 (S.binunion sk2 sk3) sk1);};
		have RemoveUniConst : π ((¬ S.in_ sk4 (S.binunion sk2 sk3) ∨ ¬ (S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3)) = S.in_ sk4 (S.setminus sk1 (S.binunion sk2 sk3)))) = ¬ S.in_ sk4 (S.binunion sk2 sk3))
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((¬ S.in_ sk4 (S.binunion sk2 sk3)) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// OrderedPara;
	have step289 : Π (D : τ ι), Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ B (S.powerset A) ∨ (¬ S.in_ C (S.powerset A) ∨ (¬ S.in_ D A ∨ (¬ S.in_ D C ∨ (¬ ⊤ ∨ ¬ (S.in_ D (S.binunion B C) = S.in_ sk4 (S.binunion sk2 sk3)))))))
		{assume D C B A;
		// Transform withLiteral to an equation;
		have equationalWithClause : π ((¬ (S.in_ B (S.powerset A))) ∨ (¬ (S.in_ C (S.powerset A))) ∨ (¬ (S.in_ D A)) ∨ ((S.in_ D (S.binunion B C)) = ⊤) ∨ (¬ (S.in_ D C)))
			{rewrite .[x in (_ ∨ _ ∨ _ ∨ x ∨ _)] =⊤;
			refine (step10 D C B A)};
		refine (∨ₑ (em ((S.in_ D (S.binunion B C)) = (S.in_ sk4 (S.binunion sk2 sk3)))) _ _)
			{assume uniConsEq;
			refine ((∨ₑₙ 3 ((¬ (S.in_ B (S.powerset A))) ⸬ (¬ (S.in_ C (S.powerset A))) ⸬ (¬ (S.in_ D A)) ⸬ ((S.in_ D (S.binunion B C)) = ⊤) ⸬ (¬ (S.in_ D C)) ⸬ □)) equationalWithClause _ _)
				{assume withLit;
				// Rewrite parent with with-literal;
				rewrite left  .[x in (_ ∨ _ ∨ _ ∨ _ ∨ (¬ x) ∨ _)] withLit;
				// Rewrite parent with unification constraint;
				rewrite .[x in (_ ∨ _ ∨ _ ∨ _ ∨ (¬ x) ∨ _)] uniConsEq;
				refine ((∨ᵢₙ ((¬ (S.in_ B (S.powerset A))) ⸬ (¬ (S.in_ C (S.powerset A))) ⸬ (¬ (S.in_ D A)) ⸬ (¬ (S.in_ D C)) ⸬ □) ((¬ (S.in_ sk4 (S.binunion sk2 sk3))) ⸬ (¬ ((S.in_ D (S.binunion B C)) = (S.in_ sk4 (S.binunion sk2 sk3)))) ⸬ □) (□)) ((∨ᵢₙ (□) ((¬ (S.in_ sk4 (S.binunion sk2 sk3))) ⸬ □) ((¬ ((S.in_ D (S.binunion B C)) = (S.in_ sk4 (S.binunion sk2 sk3)))) ⸬ □)) (step81)))}
				{assume otherLitsWithClause;
				refine ((∨ᵢₙ (□) ((¬ (S.in_ B (S.powerset A))) ⸬ (¬ (S.in_ C (S.powerset A))) ⸬ (¬ (S.in_ D A)) ⸬ (¬ (S.in_ D C)) ⸬ □) ((¬ ⊤) ⸬ (¬ ((S.in_ D (S.binunion B C)) = (S.in_ sk4 (S.binunion sk2 sk3)))) ⸬ □)) otherLitsWithClause)}}
			{assume uniLitInEq;
			refine ((∨ᵢₙ ((¬ (S.in_ B (S.powerset A))) ⸬ (¬ (S.in_ C (S.powerset A))) ⸬ (¬ (S.in_ D A)) ⸬ (¬ (S.in_ D C)) ⸬ (¬ ⊤) ⸬ □) ((¬ ((S.in_ D (S.binunion B C)) = (S.in_ sk4 (S.binunion sk2 sk3)))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step290 : Π (D : τ ι), Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ B (S.powerset A) ∨ (¬ S.in_ C (S.powerset A) ∨ (¬ S.in_ D A ∨ (¬ S.in_ D C ∨ ¬ (S.in_ D (S.binunion B C) = S.in_ sk4 (S.binunion sk2 sk3))))))
		{assume D C B A;
		have SimpApp : π (((¬ (S.in_ B (S.powerset A))) ∨ (¬ (S.in_ C (S.powerset A))) ∨ (¬ (S.in_ D A)) ∨ (¬ (S.in_ D C)) ∨ (¬ ⊤) ∨ (¬ ((S.in_ D (S.binunion B C)) = (S.in_ sk4 (S.binunion sk2 sk3))))) ⇒ ((¬ (S.in_ B (S.powerset A))) ∨ (¬ (S.in_ C (S.powerset A))) ∨ (¬ (S.in_ D A)) ∨ (¬ (S.in_ D C)) ∨ (¬ ((S.in_ D (S.binunion B C)) = (S.in_ sk4 (S.binunion sk2 sk3))))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step289 D C B A))};
	// pattern_uni;
	have step291 : Π (A : τ ι), π (¬ S.in_ sk2 (S.powerset A) ∨ (¬ S.in_ sk3 (S.powerset A) ∨ (¬ S.in_ sk4 A ∨ ¬ S.in_ sk4 sk3)))
		{assume A;
		have Subst : π (¬ S.in_ sk2 (S.powerset A) ∨ (¬ S.in_ sk3 (S.powerset A) ∨ (¬ S.in_ sk4 A ∨ (¬ S.in_ sk4 sk3 ∨ ¬ (S.in_ sk4 (S.binunion sk2 sk3) = S.in_ sk4 (S.binunion sk2 sk3))))))
			{refine (step290 sk4 sk3 sk2 A);};
		have RemoveUniConst : π ((¬ S.in_ sk2 (S.powerset A) ∨ (¬ S.in_ sk3 (S.powerset A) ∨ (¬ S.in_ sk4 A ∨ (¬ S.in_ sk4 sk3 ∨ ¬ (S.in_ sk4 (S.binunion sk2 sk3) = S.in_ sk4 (S.binunion sk2 sk3)))))) = (¬ S.in_ sk2 (S.powerset A) ∨ (¬ S.in_ sk3 (S.powerset A) ∨ (¬ S.in_ sk4 A ∨ ¬ S.in_ sk4 sk3))))
			{eval (removeTrivialFalse ".[x in ((_ ∨ (_ ∨ (_ ∨ (_ ∨ x)))) = _)]");
			refine (deleteBots (4 ⸬ □) ((¬ S.in_ sk2 (S.powerset A)) ⸬ (¬ S.in_ sk3 (S.powerset A)) ⸬ (¬ S.in_ sk4 A) ⸬ (¬ S.in_ sk4 sk3) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// cnfConj;
	have step9 : Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ C A ∨ (S.in_ C B ∨ S.in_ C (S.setminus A B)))
		{assume C B A;
		refine (∧ₑₙ 0 (((¬ (S.in_ C A)) ∨ (S.in_ C B) ∨ (S.in_ C (S.setminus A B))) ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ □) ⊤ᵢ (step4 (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) C B A))};
	// cnfConj;
	have step7 : π (¬ S.in_ sk4 (S.setminus sk1 sk3))
		{refine (∧ₑₙ 7 (_ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ (¬ (S.in_ sk4 (S.setminus sk1 sk3))) ⸬ □) ⊤ᵢ (step4 (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// OrderedPara;
	have step40 : Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ C A ∨ (S.in_ C B ∨ (¬ ⊤ ∨ ¬ (S.in_ C (S.setminus A B) = S.in_ sk4 (S.setminus sk1 sk3)))))
		{assume C B A;
		// Transform withLiteral to an equation;
		have equationalWithClause : π ((¬ (S.in_ C A)) ∨ (S.in_ C B) ∨ ((S.in_ C (S.setminus A B)) = ⊤))
			{rewrite .[x in (_ ∨ _ ∨ x)] =⊤;
			refine (step9 C B A)};
		refine (∨ₑ (em ((S.in_ C (S.setminus A B)) = (S.in_ sk4 (S.setminus sk1 sk3)))) _ _)
			{assume uniConsEq;
			refine ((∨ₑₙ 2 ((¬ (S.in_ C A)) ⸬ (S.in_ C B) ⸬ ((S.in_ C (S.setminus A B)) = ⊤) ⸬ □)) equationalWithClause _ _)
				{assume withLit;
				// Rewrite parent with with-literal;
				rewrite left  .[x in (_ ∨ _ ∨ (¬ x) ∨ _)] withLit;
				// Rewrite parent with unification constraint;
				rewrite .[x in (_ ∨ _ ∨ (¬ x) ∨ _)] uniConsEq;
				refine ((∨ᵢₙ ((¬ (S.in_ C A)) ⸬ (S.in_ C B) ⸬ □) ((¬ (S.in_ sk4 (S.setminus sk1 sk3))) ⸬ (¬ ((S.in_ C (S.setminus A B)) = (S.in_ sk4 (S.setminus sk1 sk3)))) ⸬ □) (□)) ((∨ᵢₙ (□) ((¬ (S.in_ sk4 (S.setminus sk1 sk3))) ⸬ □) ((¬ ((S.in_ C (S.setminus A B)) = (S.in_ sk4 (S.setminus sk1 sk3)))) ⸬ □)) (step7)))}
				{assume otherLitsWithClause;
				refine ((∨ᵢₙ (□) ((¬ (S.in_ C A)) ⸬ (S.in_ C B) ⸬ □) ((¬ ⊤) ⸬ (¬ ((S.in_ C (S.setminus A B)) = (S.in_ sk4 (S.setminus sk1 sk3)))) ⸬ □)) otherLitsWithClause)}}
			{assume uniLitInEq;
			refine ((∨ᵢₙ ((¬ (S.in_ C A)) ⸬ (S.in_ C B) ⸬ (¬ ⊤) ⸬ □) ((¬ ((S.in_ C (S.setminus A B)) = (S.in_ sk4 (S.setminus sk1 sk3)))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step41 : Π (C : τ ι), Π (B : τ ι), Π (A : τ ι), π (¬ S.in_ C A ∨ (S.in_ C B ∨ ¬ (S.in_ C (S.setminus A B) = S.in_ sk4 (S.setminus sk1 sk3))))
		{assume C B A;
		have SimpApp : π (((¬ (S.in_ C A)) ∨ (S.in_ C B) ∨ (¬ ⊤) ∨ (¬ ((S.in_ C (S.setminus A B)) = (S.in_ sk4 (S.setminus sk1 sk3))))) ⇒ ((¬ (S.in_ C A)) ∨ (S.in_ C B) ∨ (¬ ((S.in_ C (S.setminus A B)) = (S.in_ sk4 (S.setminus sk1 sk3))))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step40 C B A))};
	// pattern_uni;
	have step42 : π (¬ S.in_ sk4 sk1 ∨ S.in_ sk4 sk3)
		{have Subst : π (¬ S.in_ sk4 sk1 ∨ (S.in_ sk4 sk3 ∨ ¬ (S.in_ sk4 (S.setminus sk1 sk3) = S.in_ sk4 (S.setminus sk1 sk3))))
			{refine (step41 sk4 sk3 sk1);};
		have RemoveUniConst : π ((¬ S.in_ sk4 sk1 ∨ (S.in_ sk4 sk3 ∨ ¬ (S.in_ sk4 (S.setminus sk1 sk3) = S.in_ sk4 (S.setminus sk1 sk3)))) = (¬ S.in_ sk4 sk1 ∨ S.in_ sk4 sk3))
			{eval (removeTrivialFalse ".[x in ((_ ∨ (_ ∨ x)) = _)]");
			refine (deleteBots (2 ⸬ □) ((¬ S.in_ sk4 sk1) ⸬ (S.in_ sk4 sk3) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// cnfConj;
	have step6 : π (S.in_ sk4 sk1)
		{refine (∧ₑₙ 5 (_ ⸬ _ ⸬ _ ⸬ _ ⸬ _ ⸬ (S.in_ sk4 sk1) ⸬ _ ⸬ _ ⸬ □) ⊤ᵢ (step4 (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// RewriteSimp;
	have step58 : π (¬ ⊤ ∨ S.in_ sk4 sk3)
		{have TransformToEqLits_0 : π (⊤ = (S.in_ sk4 sk1))
			{rewrite ⊤=;
			refine (step6)};
		rewrite .[x in ((¬ x) ∨ _)] TransformToEqLits_0;
		refine ((step42))};
	// FormulaSimp;
	have step59 : π (S.in_ sk4 sk3)
		{have SimpApp : π (((¬ ⊤) ∨ (S.in_ sk4 sk3)) ⇒ (S.in_ sk4 sk3))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step58))};
	// RewriteSimp;
	have step1719 : Π (A : τ ι), π (¬ S.in_ sk2 (S.powerset A) ∨ (¬ S.in_ sk3 (S.powerset A) ∨ (¬ S.in_ sk4 A ∨ ¬ ⊤)))
		{assume A;
		have TransformToEqLits_0 : π (⊤ = (S.in_ sk4 sk3))
			{rewrite ⊤=;
			refine (step59)};
		rewrite .[x in (_ ∨ _ ∨ _ ∨ (¬ x))] TransformToEqLits_0;
		refine ((step291 A))};
	// FormulaSimp;
	have step1720 : Π (A : τ ι), π (¬ S.in_ sk2 (S.powerset A) ∨ (¬ S.in_ sk3 (S.powerset A) ∨ ¬ S.in_ sk4 A))
		{assume A;
		have SimpApp : π (((¬ (S.in_ sk2 (S.powerset A))) ∨ (¬ (S.in_ sk3 (S.powerset A))) ∨ (¬ (S.in_ sk4 A)) ∨ (¬ ⊤)) ⇒ ((¬ (S.in_ sk2 (S.powerset A))) ∨ (¬ (S.in_ sk3 (S.powerset A))) ∨ (¬ (S.in_ sk4 A))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step1719 A))};
	// OrderedPara;
	have step1815 : Π (A : τ ι), π (¬ ⊤ ∨ (¬ S.in_ sk3 (S.powerset A) ∨ (¬ S.in_ sk4 A ∨ ¬ (S.in_ sk2 (S.powerset sk1) = S.in_ sk2 (S.powerset A)))))
		{assume A;
		// Transform withLiteral to an equation;
		have equationalWithClause : π ((S.in_ sk2 (S.powerset sk1)) = ⊤)
			{rewrite =⊤;
			refine (step11)};
		refine (∨ₑ (em ((S.in_ sk2 (S.powerset sk1)) = (S.in_ sk2 (S.powerset A)))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((¬ x) ∨ _ ∨ _ ∨ _)] equationalWithClause;
			// Rewrite parent with unification constraint;
			rewrite .[x in ((¬ x) ∨ _ ∨ _ ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((¬ (S.in_ sk2 (S.powerset A))) ⸬ (¬ (S.in_ sk3 (S.powerset A))) ⸬ (¬ (S.in_ sk4 A)) ⸬ □) ((¬ ((S.in_ sk2 (S.powerset sk1)) = (S.in_ sk2 (S.powerset A)))) ⸬ □)) (step1720 A))}
			{assume uniLitInEq;
			refine ((∨ᵢₙ ((¬ ⊤) ⸬ (¬ (S.in_ sk3 (S.powerset A))) ⸬ (¬ (S.in_ sk4 A)) ⸬ □) ((¬ ((S.in_ sk2 (S.powerset sk1)) = (S.in_ sk2 (S.powerset A)))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step1816 : Π (A : τ ι), π (¬ S.in_ sk3 (S.powerset A) ∨ (¬ S.in_ sk4 A ∨ ¬ (S.in_ sk2 (S.powerset sk1) = S.in_ sk2 (S.powerset A))))
		{assume A;
		have SimpApp : π (((¬ ⊤) ∨ (¬ (S.in_ sk3 (S.powerset A))) ∨ (¬ (S.in_ sk4 A)) ∨ (¬ ((S.in_ sk2 (S.powerset sk1)) = (S.in_ sk2 (S.powerset A))))) ⇒ ((¬ (S.in_ sk3 (S.powerset A))) ∨ (¬ (S.in_ sk4 A)) ∨ (¬ ((S.in_ sk2 (S.powerset sk1)) = (S.in_ sk2 (S.powerset A))))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step1815 A))};
	// pattern_uni;
	have step1817 : π (¬ S.in_ sk3 (S.powerset sk1) ∨ ¬ S.in_ sk4 sk1)
		{have Subst : π (¬ S.in_ sk3 (S.powerset sk1) ∨ (¬ S.in_ sk4 sk1 ∨ ¬ (S.in_ sk2 (S.powerset sk1) = S.in_ sk2 (S.powerset sk1))))
			{refine (step1816 sk1);};
		have RemoveUniConst : π ((¬ S.in_ sk3 (S.powerset sk1) ∨ (¬ S.in_ sk4 sk1 ∨ ¬ (S.in_ sk2 (S.powerset sk1) = S.in_ sk2 (S.powerset sk1)))) = (¬ S.in_ sk3 (S.powerset sk1) ∨ ¬ S.in_ sk4 sk1))
			{eval (removeTrivialFalse ".[x in ((_ ∨ (_ ∨ x)) = _)]");
			refine (deleteBots (2 ⸬ □) ((¬ S.in_ sk3 (S.powerset sk1)) ⸬ (¬ S.in_ sk4 sk1) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// cnfConj;
	have step8 : π (S.in_ sk3 (S.powerset sk1))
		{refine (∧ₑₙ 4 (_ ⸬ _ ⸬ _ ⸬ _ ⸬ (S.in_ sk3 (S.powerset sk1)) ⸬ _ ⸬ _ ⸬ _ ⸬ □) ⊤ᵢ (step4 (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι) (el ι)))};
	// RewriteSimp;
	have step1899 : π (¬ ⊤ ∨ ¬ ⊤)
		{have TransformToEqLits_0 : π (⊤ = (S.in_ sk4 sk1))
			{rewrite ⊤=;
			refine (step6)};
		have TransformToEqLits_1 : π (⊤ = (S.in_ sk3 (S.powerset sk1)))
			{rewrite ⊤=;
			refine (step8)};
		rewrite .[x in (_ ∨ (¬ x))] TransformToEqLits_0;
		rewrite .[x in ((¬ x) ∨ _)] TransformToEqLits_1;
		refine ((step1817))};
	// FormulaSimp;
	have step1900 : π ⊥
		{have SimpApp : π (((¬ ⊤) ∨ (¬ ⊤)) ⇒ ⊥)
			{eval applyAllSimplifications};
		refine ((SimpApp) (step1899))};
	refine step1900;
end;
