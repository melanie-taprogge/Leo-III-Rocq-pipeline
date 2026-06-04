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
require lpProof_SWV435^4-noOp.Signature as S; 
require lpProof_SWV435^4-noOp.Formulae as F;


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// SKOLEM TERMS ///////////////////////////////////

symbol sk1: τ ι;
symbol sk1_def: π (sk1  = (ε(λ (A : τ ι), ¬ (∀(λ (B : τ ι), S.rel A B ⇒ S.a B)))));
symbol sk2: τ ι;
symbol sk2_def: π (sk2  = (ε(λ (A : τ ι), ¬ (S.rel sk1 A ⇒ S.a A))));


// PROOF ENCODING ////////////////////////////////////////

 symbol encodedProof: π (S.iclval (S.icl_says (S.icl_princ S.a) S.icl_false)) ≔
begin
	refine (¬¬ₑ (S.iclval (S.icl_says (S.icl_princ S.a) S.icl_false)) _);
	assume negatedConjecture;
	// Unencoded step (DefExpand): Rweriting under binder required in order to encode Simplification step;
	have step6 : π (¬ (∀(λ (A : τ ι), (∀(λ (B : τ ι), S.rel A B ⇒ S.a B)))))
		{admit;};
	// RenameCNF_conj;
	have step7 : π ((S.rel sk1 sk2) ∧ (¬ (S.a sk2)))
		{have Clausification : π ((¬ (∀(λ (A : τ ι), (∀(λ (B : τ ι), ((S.rel A B) ⇒ (S.a B))))))) = ((S.rel sk1 sk2) ∧ (¬ (S.a sk2))))
			{eval (stepwise_quants ((skolemProzess_∀ (#rewrite "left" "" sk1_def)) ⸬ (skolemProzess_∀ (#rewrite "left" "" sk2_def)) ⸬ □))};
		refine (((=⇒ Clausification) step6))};
	// cnfConj;
	have step9 : π (¬ S.a sk2)
		{refine (∧ₑₙ 1 (_ ⸬ (¬ (S.a sk2)) ⸬ □) ⊤ᵢ (step7))};
	// DefExpand;
	have step22 : π (S.a = (λ (A : τ ι), ⊤))
		{have defExpStep : π (((S.icl_princ S.a) = S.icl_true) ⇒ (S.a = (λ (A: τ ι), ⊤)))
			{eval (#repeat ((#rewrite "" "" F.mtrue_def) #orelse ((#rewrite "" "" F.icl_princ_def) #orelse (#rewrite "" "" F.icl_true_def))));
			assume h;
			refine h};
		refine (defExpStep F.ax1_p0)};
	// FuncExt;
	have step24 : Π (A : τ ι), π (S.a A)
		{assume A;
		have PFE_0 : (π (S.a = (λ (B: τ ι), ⊤)) → π ((S.a A) = ⊤))
			{refine (PFE S.a (λ (B: τ ι), ⊤) A)};
		have PFE_0_app : π ((S.a A) = ⊤)
			{refine ((PFE_0 (step22)))};
		rewrite left  .[x in x] (=⊤);
		refine (PFE_0_app)};
	// Unencoded step (RewriteSimp): RW: Non-ground rewrite step or missing transformation;
	have step27 : π (¬ ⊤)
		{admit;};
	// FormulaSimp;
	have step28 : π ⊥
		{have SimpApp : π ((¬ ⊤) ⇒ ⊥)
			{eval applyAllSimplifications};
		refine ((SimpApp) (step27))};
	refine step28;
end;
