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
require lpProof_SWV435^4.Signature as S; 
require lpProof_SWV435^4.Formulae as F;


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// SKOLEM TERMS ///////////////////////////////////

symbol sk1: τ ι;
symbol sk1_def: π (sk1  = (ε(λ (A : τ ι), ¬ (∀(λ (B : τ ι), S.rel A B ⇒ S.a B)))));
symbol sk2: τ ι;
symbol sk2_def: π (sk2  = (ε(λ (A : τ ι), ¬ (S.rel sk1 A ⇒ S.a A))));


// PROOF ENCODING ////////////////////////////////////////

opaque symbol encodedProof: π (S.iclval (S.icl_says (S.icl_princ S.a) S.icl_false)) ≔
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
