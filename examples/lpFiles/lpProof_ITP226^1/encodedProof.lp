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
require lpProof_ITP226^1.Signature as S; 
require lpProof_ITP226^1.Formulae as F;


// FLAGS /////////////////////////////////

flag "eta_equality" on;


// PROOF ENCODING ////////////////////////////////////////

opaque symbol encodedProof: π (S.vEBT_vebt_member S.t S.x = S.member_nat S.x (S.vEBT_set_vebt S.t)) ≔
begin
	refine (¬¬ₑ (S.vEBT_vebt_member S.t S.x = S.member_nat S.x (S.vEBT_set_vebt S.t)) _);
	assume negatedConjecture;
	// FuncExt;
	have step58 : Π (A : τ S.vEBT_VEBT), π (S.vEBT_set_vebt A = S.collect_nat (S.vEBT_V8194947554948674370ptions A))
		{assume A;
		have PFE_0 : (π (S.vEBT_set_vebt = (λ (B: τ S.vEBT_VEBT), (S.collect_nat (S.vEBT_V8194947554948674370ptions B)))) → π ((S.vEBT_set_vebt A) = (S.collect_nat (S.vEBT_V8194947554948674370ptions A))))
			{refine (PFE S.vEBT_set_vebt (λ (B: τ S.vEBT_VEBT), (S.collect_nat (S.vEBT_V8194947554948674370ptions B))) A)};
		have PFE_0_app : π ((S.vEBT_set_vebt A) = (S.collect_nat (S.vEBT_V8194947554948674370ptions A)))
			{refine ((PFE_0 (F.fact_8231_set__vebt__def_p0)))};
		refine (PFE_0_app)};
	// LiftEq;
	have step19 : π (¬ (S.member_nat S.x (S.vEBT_set_vebt S.t) = S.vEBT_vebt_member S.t S.x))
		{rewrite .[x in (¬ x)] (=_sym [o]);
		refine ((negatedConjecture))};
	// OrderedPara;
	have step106 : Π (A : τ S.vEBT_VEBT), π (¬ (S.member_nat S.x (S.collect_nat (S.vEBT_V8194947554948674370ptions A)) = S.vEBT_vebt_member S.t S.x) ∨ ¬ (S.vEBT_set_vebt A = S.vEBT_set_vebt S.t))
		{assume A;
		refine (∨ₑ (em ((S.vEBT_set_vebt A) = (S.vEBT_set_vebt S.t))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in ((¬ ((_ _ x) = _)) ∨ _)] (step58 A);
			// Rewrite parent with unification constraint;
			rewrite .[x in ((¬ ((_ _ x) = _)) ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) ((¬ ((S.member_nat S.x (S.vEBT_set_vebt S.t)) = (S.vEBT_vebt_member S.t S.x))) ⸬ □) ((¬ ((S.vEBT_set_vebt A) = (S.vEBT_set_vebt S.t))) ⸬ □)) (step19))}
			{assume uniLitInEq;
			refine (∨ᵢ₂ uniLitInEq)}};
	// pattern_uni;
	have step107 : π (¬ (S.member_nat S.x (S.collect_nat (S.vEBT_V8194947554948674370ptions S.t)) = S.vEBT_vebt_member S.t S.x))
		{have Subst : π (¬ (S.member_nat S.x (S.collect_nat (S.vEBT_V8194947554948674370ptions S.t)) = S.vEBT_vebt_member S.t S.x) ∨ ¬ (S.vEBT_set_vebt S.t = S.vEBT_set_vebt S.t))
			{refine (step106 S.t);};
		have RemoveUniConst : π ((¬ (S.member_nat S.x (S.collect_nat (S.vEBT_V8194947554948674370ptions S.t)) = S.vEBT_vebt_member S.t S.x) ∨ ¬ (S.vEBT_set_vebt S.t = S.vEBT_set_vebt S.t)) = ¬ (S.member_nat S.x (S.collect_nat (S.vEBT_V8194947554948674370ptions S.t)) = S.vEBT_vebt_member S.t S.x))
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((¬ (S.member_nat S.x (S.collect_nat (S.vEBT_V8194947554948674370ptions S.t)) = S.vEBT_vebt_member S.t S.x)) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// Unencoded step (miniscope): unencoded rule applied to F.fact_4_both__member__options__equiv__member_p2;
	have step24 : π (∀(λ (A : τ S.vEBT_VEBT), (∃(λ (B : τ S.nat), S.vEBT_invar_vebt A B)) ⇒ (∀(λ (B : τ S.nat), S.vEBT_V8194947554948674370ptions A B = S.vEBT_vebt_member A B))))
		{admit;};
	// Unencoded step (RenameCNF_conj): Clausification involving Binders not encoded;
	have step25 : Π (C : τ S.nat), Π (B : τ S.nat), Π (A : τ S.vEBT_VEBT), π ((¬ (S.vEBT_invar_vebt A B)) ∨ ((S.vEBT_V8194947554948674370ptions A C) = (S.vEBT_vebt_member A C)))
		{admit;};
	// LiftEq;
	have step26 : Π (C : τ S.nat), Π (B : τ S.nat), Π (A : τ S.vEBT_VEBT), π (S.vEBT_vebt_member A C = S.vEBT_V8194947554948674370ptions A C ∨ ¬ S.vEBT_invar_vebt A B)
		{assume C B A;
		rewrite .[x in (x ∨ _)] (=_sym [o]);
		refine (permute (1 ⸬ 0 ⸬ □) ((¬ (S.vEBT_invar_vebt A B)) ⸬ ((S.vEBT_V8194947554948674370ptions A C) = (S.vEBT_vebt_member A C)) ⸬ □) ⊤ᵢ (step25 C B A))};
	// OrderedPara;
	have step188 : Π (C : τ S.nat), Π (B : τ S.nat), Π (A : τ S.vEBT_VEBT), π (S.vEBT_vebt_member A C = S.vEBT_V8194947554948674370ptions A C ∨ (¬ ⊤ ∨ ¬ (S.vEBT_invar_vebt S.t S.n = S.vEBT_invar_vebt A B)))
		{assume C B A;
		// Transform withLiteral to an equation;
		have equationalWithClause : π ((S.vEBT_invar_vebt S.t S.n) = ⊤)
			{rewrite =⊤;
			refine (F.conj_0_p1)};
		refine (∨ₑ (em ((S.vEBT_invar_vebt S.t S.n) = (S.vEBT_invar_vebt A B))) _ _)
			{assume uniConsEq;
			// Rewrite parent with with-literal;
			rewrite left  .[x in (_ ∨ (¬ x) ∨ _)] equationalWithClause;
			// Rewrite parent with unification constraint;
			rewrite .[x in (_ ∨ (¬ x) ∨ _)] uniConsEq;
			refine ((∨ᵢₙ (□) (((S.vEBT_vebt_member A C) = (S.vEBT_V8194947554948674370ptions A C)) ⸬ (¬ (S.vEBT_invar_vebt A B)) ⸬ □) ((¬ ((S.vEBT_invar_vebt S.t S.n) = (S.vEBT_invar_vebt A B))) ⸬ □)) (step26 C B A))}
			{assume uniLitInEq;
			refine ((∨ᵢₙ (((S.vEBT_vebt_member A C) = (S.vEBT_V8194947554948674370ptions A C)) ⸬ (¬ ⊤) ⸬ □) ((¬ ((S.vEBT_invar_vebt S.t S.n) = (S.vEBT_invar_vebt A B))) ⸬ □) (□)) uniLitInEq)}};
	// FormulaSimp;
	have step189 : Π (C : τ S.nat), Π (B : τ S.nat), Π (A : τ S.vEBT_VEBT), π (S.vEBT_vebt_member A C = S.vEBT_V8194947554948674370ptions A C ∨ ¬ (S.vEBT_invar_vebt S.t S.n = S.vEBT_invar_vebt A B))
		{assume C B A;
		have SimpApp : π ((((S.vEBT_vebt_member A C) = (S.vEBT_V8194947554948674370ptions A C)) ∨ (¬ ⊤) ∨ (¬ ((S.vEBT_invar_vebt S.t S.n) = (S.vEBT_invar_vebt A B)))) ⇒ (((S.vEBT_vebt_member A C) = (S.vEBT_V8194947554948674370ptions A C)) ∨ (¬ ((S.vEBT_invar_vebt S.t S.n) = (S.vEBT_invar_vebt A B)))))
			{eval applyAllSimplifications};
		refine ((SimpApp) (step188 C B A))};
	// pattern_uni;
	have step190 : Π (A : τ S.nat), π (S.vEBT_vebt_member S.t A = S.vEBT_V8194947554948674370ptions S.t A)
		{assume C;
		have Subst : π (S.vEBT_vebt_member S.t C = S.vEBT_V8194947554948674370ptions S.t C ∨ ¬ (S.vEBT_invar_vebt S.t S.n = S.vEBT_invar_vebt S.t S.n))
			{refine (step189 C S.n S.t);};
		have RemoveUniConst : π ((S.vEBT_vebt_member S.t C = S.vEBT_V8194947554948674370ptions S.t C ∨ ¬ (S.vEBT_invar_vebt S.t S.n = S.vEBT_invar_vebt S.t S.n)) = (S.vEBT_vebt_member S.t C = S.vEBT_V8194947554948674370ptions S.t C))
			{eval (removeTrivialFalse ".[x in ((_ ∨ x) = _)]");
			refine (deleteBots (1 ⸬ □) ((S.vEBT_vebt_member S.t C = S.vEBT_V8194947554948674370ptions S.t C) ⸬ □));};
		refine (=⇒ RemoveUniConst Subst);};
	// Unencoded step (RewriteSimp): RW: Non-ground rewrite step or missing transformation;
	have step333 : π (¬ (S.member_nat S.x (S.collect_nat (S.vEBT_V8194947554948674370ptions S.t)) = S.vEBT_V8194947554948674370ptions S.t S.x))
		{admit;};
	// RenameCNF_conj;
	have step54 : Π (B : τ (S.nat ⤳ o)), Π (A : τ S.nat), π ((S.member_nat A (S.collect_nat B)) = (B A))
		{assume D C;
		have Clausification : π ((∀(λ (A : τ S.nat), (∀(λ (B : τ (S.nat ⤳ o)), ((S.member_nat A (S.collect_nat B)) = (B A)))))) = (∀(λ (A : τ S.nat), (∀(λ (B : τ (S.nat ⤳ o)), ((S.member_nat A (S.collect_nat B)) = (B A)))))))
			{eval (move_∀_out (#assume "A"));
			eval (move_∀_out (#assume "B"));
			eval onlyBoolIds};
		refine (((=⇒ Clausification) F.fact_48_mem__Collect__eq_p3) C D)};
	// Unencoded step (simplifyReflect): unencoded rule applied to step333, step54;
	have step1845 : π ⊥
		{admit;};
	refine step1845;
end;
