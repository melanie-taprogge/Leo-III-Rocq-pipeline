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
require lpProof_NUM683^1-noOp.Signature as S; 
require lpProof_NUM683^1-noOp.Formulae as F;


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// PROOF ENCODING ////////////////////////////////////////

symbol encodedProof: π (S.more S.x S.y) ≔
begin
	refine (¬¬ₑ (S.more S.x S.y) _);
	assume negatedConjecture;
	// RenameCNF_conj;
	have step12 : Π (B : τ S.nat), Π (A : τ S.nat), π ((S.pl A B) = (S.pl B A))
		{assume D C;
		have Clausification : π ((∀(λ (A : τ S.nat), (∀(λ (B : τ S.nat), ((S.pl A B) = (S.pl B A)))))) = (∀(λ (A : τ S.nat), (∀(λ (B : τ S.nat), ((S.pl A B) = (S.pl B A)))))))
			{eval (move_∀_out (#assume "A"));
			eval (move_∀_out (#assume "B"));
			eval onlyBoolIds};
		refine (((=⇒ Clausification) F.satz6_p0) C D)};
	// OrderedPara;
	have step17 : Π (B : τ S.nat), Π (A : τ S.nat), π (S.more (S.pl S.z S.x) (S.pl B A) ∨ ¬ (S.pl A B = S.pl S.z S.y))
		{assume B A;
		refine (∨ₑ (em ((S.pl A B) = (S.pl S.z S.y))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((_ _ x) ∨ _)] (step12 B A);
			// Rewrite parent with unification constraint;
			rewrite .[x in ((_ _ x) ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((S.more (S.pl S.z S.x) (S.pl S.z S.y)) ⸬ □) ((¬ ((S.pl A B) = (S.pl S.z S.y))) ⸬ □)) (F.m_p1))}
			{assume uniLitInEq;
			refine (∨ᵢ₂ uniLitInEq)}};
	// pattern_uni;
	have step18 : π (S.more (S.pl S.z S.x) (S.pl S.y S.z))
		{have Subst : π (S.more (S.pl S.z S.x) (S.pl S.y S.z) ∨ ¬ (S.pl S.z S.y = S.pl S.z S.y))
			{refine (step17 S.y S.z);};
		have RemoveUniConst : π ((S.more (S.pl S.z S.x) (S.pl S.y S.z) ∨ ¬ (S.pl S.z S.y = S.pl S.z S.y)) = S.more (S.pl S.z S.x) (S.pl S.y S.z))
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((S.more (S.pl S.z S.x) (S.pl S.y S.z)) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// OrderedPara;
	have step28 : Π (B : τ S.nat), Π (A : τ S.nat), π (S.more (S.pl B A) (S.pl S.y S.z) ∨ ¬ (S.pl A B = S.pl S.z S.x))
		{assume B A;
		refine (∨ₑ (em ((S.pl A B) = (S.pl S.z S.x))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((_ x _) ∨ _)] (step12 B A);
			// Rewrite parent with unification constraint;
			rewrite .[x in ((_ x _) ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((S.more (S.pl S.z S.x) (S.pl S.y S.z)) ⸬ □) ((¬ ((S.pl A B) = (S.pl S.z S.x))) ⸬ □)) (step18))}
			{assume uniLitInEq;
			refine (∨ᵢ₂ uniLitInEq)}};
	// pattern_uni;
	have step29 : π (S.more (S.pl S.x S.z) (S.pl S.y S.z))
		{have Subst : π (S.more (S.pl S.x S.z) (S.pl S.y S.z) ∨ ¬ (S.pl S.z S.x = S.pl S.z S.x))
			{refine (step28 S.x S.z);};
		have RemoveUniConst : π ((S.more (S.pl S.x S.z) (S.pl S.y S.z) ∨ ¬ (S.pl S.z S.x = S.pl S.z S.x)) = S.more (S.pl S.x S.z) (S.pl S.y S.z))
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((S.more (S.pl S.x S.z) (S.pl S.y S.z)) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// Unencoded step (miniscope): unencoded rule applied to F.satz20a_p2;
	have step9 : π (∀(λ (A : τ S.nat), (∀(λ (B : τ S.nat), (∃(λ (C : τ S.nat), S.more (S.pl A C) (S.pl B C))) ⇒ S.more A B))))
		{admit;};
	// Unencoded step (RenameCNF_conj): Clausification involving Binders not encoded;
	have step10 : Π (C : τ S.nat), Π (B : τ S.nat), Π (A : τ S.nat), π ((¬ (S.more (S.pl A C) (S.pl B C))) ∨ (S.more A B))
		{admit;};
	// OrderedPara;
	have step84 : Π (C : τ S.nat), Π (B : τ S.nat), Π (A : τ S.nat), π (¬ ⊤ ∨ (S.more A B ∨ ¬ (S.more (S.pl S.x S.z) (S.pl S.y S.z) = S.more (S.pl A C) (S.pl B C))))
		{assume C B A;
		// Transform withLiteral to an equation;
		have equationalWithClause : π ((S.more (S.pl S.x S.z) (S.pl S.y S.z)) = ⊤)
			{rewrite =⊤;
			refine (step29)};
		refine (∨ₑ (em ((S.more (S.pl S.x S.z) (S.pl S.y S.z)) = (S.more (S.pl A C) (S.pl B C)))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((¬ x) ∨ _ ∨ _)] equationalWithClause;
			// Rewrite parent with unification constraint;
			rewrite .[x in ((¬ x) ∨ _ ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((¬ (S.more (S.pl A C) (S.pl B C))) ⸬ (S.more A B) ⸬ □) ((¬ ((S.more (S.pl S.x S.z) (S.pl S.y S.z)) = (S.more (S.pl A C) (S.pl B C)))) ⸬ □)) (step10 C B A))}
			{assume uniLitInEq;
			refine ((∨ᵢₙ ((¬ ⊤) ⸬ (S.more A B) ⸬ □) ((¬ ((S.more (S.pl S.x S.z) (S.pl S.y S.z)) = (S.more (S.pl A C) (S.pl B C)))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step85 : Π (C : τ S.nat), Π (B : τ S.nat), Π (A : τ S.nat), π (S.more A B ∨ ¬ (S.more (S.pl S.x S.z) (S.pl S.y S.z) = S.more (S.pl A C) (S.pl B C)))
		{assume C B A;
		have SimpApp : π (((¬ ⊤) ∨ (S.more A B) ∨ (¬ ((S.more (S.pl S.x S.z) (S.pl S.y S.z)) = (S.more (S.pl A C) (S.pl B C))))) ⇒ ((S.more A B) ∨ (¬ ((S.more (S.pl S.x S.z) (S.pl S.y S.z)) = (S.more (S.pl A C) (S.pl B C))))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step84 C B A))};
	// pattern_uni;
	have step86 : π (S.more S.x S.y)
		{have Subst : π (S.more S.x S.y ∨ ¬ (S.more (S.pl S.x S.z) (S.pl S.y S.z) = S.more (S.pl S.x S.z) (S.pl S.y S.z)))
			{refine (step85 S.z S.y S.x);};
		have RemoveUniConst : π ((S.more S.x S.y ∨ ¬ (S.more (S.pl S.x S.z) (S.pl S.y S.z) = S.more (S.pl S.x S.z) (S.pl S.y S.z))) = S.more S.x S.y)
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((S.more S.x S.y) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// RewriteSimp;
	have step94 : π ⊥
		{have TransformToEqLits_0 : π (⊥ = (S.more S.x S.y))
			{rewrite ⊥=;
			refine (negatedConjecture)};
		rewrite .[x in x] TransformToEqLits_0;
		refine ((step86))};
	refine step94;
end;
