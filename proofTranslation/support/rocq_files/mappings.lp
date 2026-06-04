// ---------------------------------------------------------------------------
// Core correspondence mappings
// ---------------------------------------------------------------------------
// These establish the intended direct encoding from Lambdapi/STT symbols to
// native Rocq symbols. They should remain even without stdlib workarounds.

// Prop.lp
builtin "Prop" ≔ Prop;
builtin "True" ≔ {|⊤|};
builtin "I" ≔ {|⊤ᵢ|};
builtin "False" ≔ {|⊥|};
builtin "@False_ind" ≔ {|⊥ₑ|};
builtin "imp" ≔ {|⇒|};
builtin "not" ≔ {|¬|};
builtin "and" ≔ {|∧|};
builtin "@conj" ≔ {|∧ᵢ|};
builtin "@proj1" ≔ {|∧ₑ₁|};
builtin "@proj2" ≔ {|∧ₑ₂|};
builtin "\/" ≔ {|∨|};
builtin "@or_introl" ≔ {|∨ᵢ₁|};
builtin "@or_intror" ≔ {|∨ᵢ₂|};
builtin "or_elim" ≔ {|∨ₑ|};
builtin "@ex_intro" ≔ {|∃ᵢ|};
builtin "ex_elim" ≔ {|∃ₑ|};
builtin "iff" ≔ {|⇔|};

// Set.lp
builtin "Type'" ≔ Set;
builtin "nat" ≔ {|ι|};
builtin "el" ≔ el;

// FOL.lp
builtin "@all" ≔ {|∀|};
builtin "ex_" ≔ {|∃|};

// HOL.lp
builtin "arr" ≔ {|⤳|};

// Impred.lp
builtin "o" ≔ o;

// Eq.lp
builtin "eq" ≔ {|=|};
builtin "@eq_refl" ≔ eq_refl;
builtin "@ind_eq" ≔ ind_eq;
builtin "@neq" ≔ {|≠|};

// Prod.lp
builtin "lp_u00d7" ≔ {|×|};
builtin "lp_u201a" ≔ {|‚|};
builtin "lp_u2081" ≔ {|₁|};
builtin "lp_u2082" ≔ {|₂|};

// Bool.lp core
builtin "bool'" ≔ {|𝔹|};
builtin "bool'" ≔ bool;
builtin "true" ≔ true;
builtin "false" ≔ false;
builtin "@bool_rect" ≔ {|ind_𝔹|};
builtin "Is_true" ≔ istrue;
builtin "injectiveistrue" ≔ injectiveistrue;
builtin "negb" ≔ not;
builtin "orb" ≔ or;
builtin "andb" ≔ and;
builtin "if'" ≔ if;

// Nat.lp core
builtin "nat" ≔ {|ℕ|};
builtin "O" ≔ _0;
builtin "S" ≔ {|+1|};
builtin "nat_ind" ≔ {|ind_ℕ|};
builtin "nat'" ≔ nat;
builtin "is0" ≔ is0;
builtin "pred" ≔ {|∸1|};
builtin "Nat.eqb" ≔ eqn;
builtin "eqn_correct" ≔ eqn_correct;
builtin "eqn_complete" ≔ eqn_complete;
builtin "eqn_refl" ≔ eqn_refl;
builtin "eqn_sym" ≔ eqn_sym;
builtin "Nat.add" ≔ {|+|};
builtin "Nat.sub" ≔ {|-|};
builtin "Nat.mul" ≔ {|*|};
builtin "leq" ≔ {|≤|};
builtin "ltn" ≔ {|<|};
builtin "geq" ≔ {|≥|};
builtin "gtn" ≔ {|>|};
builtin "maxn" ≔ max;
builtin "minn" ≔ min;
builtin "expn" ≔ {|^|};
builtin "factn" ≔ !;

// List.lp core used by Disj.lp
builtin "list" ≔ list_type;
builtin "list__alt__" ≔ list_type;
builtin "lp_u1d543" ≔ {|𝕃|};
builtin "lp_u25a1" ≔ {|□|};
builtin "lp_u2e2c" ≔ {|⸬|};
builtin "lp_ind_u1d543" ≔ {|ind_𝕃|};
builtin "lp_is_u25a1" ≔ lp_is_u25a1;
builtin "lp_u2208" ≔ {|∈|};
builtin "lp_u2286" ≔ {|⊆|};
builtin "mem_seq1" ≔ mem_seq1;
builtin "not_mem_cons_head" ≔ not_mem_cons_head;
builtin "not_mem_cons_tail" ≔ not_mem_cons_tail;
builtin "subset_cons_r" ≔ subset_cons_r;
builtin "subset_cons_l" ≔ subset_cons_l;
builtin "subset_cons" ≔ subset_cons;
builtin "lp_u002b_u002b" ≔ {|++|};
builtin "head" ≔ head;
builtin "behead" ≔ behead;
builtin "eql" ≔ eql;
builtin "nseq" ≔ nseq;
builtin "ncons" ≔ ncons;
builtin "catrev" ≔ catrev;
builtin "rev" ≔ rev;
builtin "rcons" ≔ rcons;
builtin "catrev_cat" ≔ catrev_cat;
builtin "rev_cons" ≔ rev_cons;
builtin "rev_cat" ≔ rev_cat;
builtin "rev_idem" ≔ rev_idem;
builtin "size_rev" ≔ size_rev;
builtin "cats1" ≔ cats1;
builtin "rcons_cons" ≔ rcons_cons;
builtin "Arr" ≔ Arr;
builtin "seqn_acc" ≔ seqn_acc;
builtin "last" ≔ lp_last;
builtin "last__alt__" ≔ lp_last;
builtin "belast" ≔ belast;
builtin "nth" ≔ lp_nth;
builtin "nth__alt__" ≔ lp_nth;
builtin "incr_nth" ≔ incr_nth;
builtin "zip" ≔ zip;
builtin "unzip1" ≔ unzip1;
builtin "unzip2" ≔ unzip2;
builtin "nth_zip" ≔ nth_zip;
builtin "all2" ≔ all2;
builtin "drop" ≔ drop;
builtin "take" ≔ take;
builtin "size_drop" ≔ size_drop;
builtin "drop_drop" ≔ drop_drop;
builtin "take_drop" ≔ take_drop;
builtin "takeD" ≔ takeD;
builtin "takeC" ≔ takeC;
builtin "rot" ≔ rot;
builtin "rot0" ≔ rot0;
builtin "size_rot" ≔ size_rot;
builtin "rotr" ≔ rotr;
builtin "rotr0" ≔ rotr0;
builtin "nths" ≔ nths;
builtin "size" ≔ size;
builtin "iota" ≔ iota;
builtin "indexes" ≔ indexes;
builtin "indexes_decrement" ≔ indexes_decrement;
builtin "rem_nth" ≔ rem_nth;
builtin "set_nth" ≔ set_nth;
builtin "index" ≔ index;
builtin "index_size" ≔ index_size;
builtin "index_head" ≔ index_head;
builtin "has" ≔ has;
builtin "all" ≔ list_all;
builtin "all__alt__" ≔ list_all;
builtin "find" ≔ find;
builtin "find_size" ≔ find_size;
builtin "count" ≔ count;
builtin "count_size" ≔ count_size;
builtin "is_constant" ≔ is_constant;
builtin "uniq" ≔ uniq;
builtin "subseq" ≔ subseq;
builtin "is_prefix" ≔ is_prefix;
builtin "is_infix" ≔ is_infix;
builtin "infix_index" ≔ infix_index;
builtin "filter" ≔ lp_filter;
builtin "filter__alt__" ≔ lp_filter;
builtin "undup" ≔ undup;
builtin "undup_first" ≔ undup_first;
builtin "map" ≔ lp_map;
builtin "map__alt__" ≔ lp_map;
builtin "sumn" ≔ sumn;
builtin "prodn" ≔ prodn;

// Disj.lp/Conj.lp shim
builtin "disj" ≔ disj;
builtin "preserves_contents" ≔ preserves_contents;
builtin "conj" ≔ conj_list;
builtin "insertBot" ≔ insertBot;
builtin "insertBots" ≔ insertBots;

// Classic.lp
builtin "classic" ≔ em; 

// Comp.lp core
builtin "comparison'" ≔ comp;
builtin "comparison'" ≔ Comp;
builtin "Eq" ≔ Eq;
builtin "Lt" ≔ Lt;
builtin "Gt" ≔ Gt;
builtin "ind_Comp" ≔ ind_Comp;
builtin "CompOpp" ≔ opp;
builtin "isEq" ≔ isEq;
builtin "isLt" ≔ isLt;
builtin "isGt" ≔ isGt;
builtin "isLe" ≔ isLe;
builtin "isGe" ≔ isGe;
builtin "case_Comp" ≔ case_Comp;

// Epsilon.lp
builtin "eps" ≔  {|ε|};
builtin "eps_spec" ≔  {|εᵢ|};

// ---------------------------------------------------------------------------
// Stdlib shim workaround mappings
// ---------------------------------------------------------------------------
// These replace selected Lambdapi/Dedukti stdlib declarations or theorem
// proofs whose original behavior depends on rewrite rules that Rocq does not
// see as definitional computation.

// Bool.lp shim
builtin "case_𝔹" ≔ {|case_𝔹|};
builtin "ind_𝔹_eq" ≔ {|ind_𝔹_eq|};
builtin "istrue_eq_true" ≔ {|istrue=true|};
builtin "true_eq_istrue" ≔ {|true=istrue|};
builtin "not_istrue_eq_false" ≔ {|¬istrue=false|};
builtin "false_eq_not_istrue" ≔ {|false=¬istrue|};
builtin "false_neq_true" ≔ {|false≠true|};
builtin "true_neq_false" ≔ {|true≠false|};
builtin "not_istrue" ≔ {|¬_istrue|};
builtin "bool_istrue_not" ≔ istrue_not;
builtin "or_istrue" ≔ {|∨_istrue|};
builtin "bool_istrue_or" ≔ istrue_or;
builtin "or_i1" ≔ {|orᵢ₁|};
builtin "or_i2" ≔ {|orᵢ₂|};
builtin "or_e" ≔ {|orₑ|};
builtin "orC" ≔ orC;
builtin "orA" ≔ orA;
builtin "and_istrue" ≔ {|∧_istrue|};
builtin "bool_istrue_and" ≔ istrue_and;
builtin "and_i" ≔ {|andᵢ|};
builtin "and_e1" ≔ {|andₑ₁|};
builtin "and_e2" ≔ {|andₑ₂|};

// Nat.lp shim
builtin "lp_s_u2260_0" ≔ {|s≠0|};
builtin "lp_0_u2260_s" ≔ {|0≠s|};
builtin "casen" ≔ casen;
builtin "lp_u002b_1_inj" ≔ {|+1_inj|};
builtin "add0n" ≔ add0n;
builtin "addn0" ≔ addn0;
builtin "addSn" ≔ addSn;
builtin "addnS" ≔ addnS;
builtin "add1n" ≔ add1n;
builtin "Nat.add_1_r" ≔ addn1;
builtin "addn1" ≔ addn1;
builtin "Nat.add_comm" ≔ addnC;
builtin "addnC" ≔ addnC;
builtin "addSnnS" ≔ addSnnS;
builtin "addnA" ≔ addnA;
builtin "addnCA" ≔ addnCA;
builtin "addnAC" ≔ addnAC;
builtin "addnCAC" ≔ addnCAC;
builtin "addnACl" ≔ addnACl;
builtin "addnACA" ≔ addnACA;
builtin "addnI" ≔ addnI;
builtin "addIn" ≔ addIn;
builtin "addn_eq0" ≔ addn_eq0;
builtin "eqn_add2l" ≔ eqn_add2l;
builtin "eqn_add2r" ≔ eqn_add2r;
builtin "lp_2_u002a_u003d_0" ≔ {|2*=0|};
builtin "lp_2_u002a_inj" ≔ {|2*_inj|};
builtin "lp_odd_u2260_even" ≔ {|odd≠even|};
builtin "sub0n" ≔ sub0n;
builtin "subn0" ≔ subn0;
builtin "subn1" ≔ subn1;
builtin "subSS" ≔ subSS;
builtin "subSnn" ≔ subSnn;
builtin "subnn" ≔ subnn;
builtin "subnS" ≔ subnS;
builtin "predn_sub" ≔ predn_sub;
builtin "subnAC" ≔ subnAC;
builtin "addnK" ≔ addnK;
builtin "subnDA" ≔ subnDA;
builtin "subnDl" ≔ subnDl;
builtin "subnDr" ≔ subnDr;
builtin "subSKn" ≔ subSKn;
builtin "mul0n" ≔ mul0n;
builtin "muln0" ≔ muln0;
builtin "mul1n" ≔ mul1n;
builtin "muln1" ≔ muln1;
builtin "mulSn" ≔ mulSn;
builtin "mulSnr" ≔ mulSnr;
builtin "mulnS" ≔ mulnS;
builtin "mulnSr" ≔ mulnSr;
builtin "mulnC" ≔ mulnC;
builtin "mulnDl" ≔ mulnDl;
builtin "mulnDr" ≔ mulnDr;
builtin "mulnBr" ≔ mulnBr;
builtin "mulnBl" ≔ mulnBl;
builtin "mulnA" ≔ mulnA;
builtin "mulnCA" ≔ mulnCA;
builtin "mulnAC" ≔ mulnAC;
builtin "mulnACA" ≔ mulnACA;
builtin "muln_eq0" ≔ muln_eq0;
builtin "lp_u2264_0" ≔ {|≤0|};
builtin "lp_u2264_refl" ≔ {|≤_refl|};
builtin "eq_leq" ≔ eq_leq;
builtin "leq_trans" ≔ leq_trans;
builtin "eqn_leq" ≔ eqn_leq;
builtin "leqsnn" ≔ leqsnn;
builtin "letnS" ≔ letnS;
builtin "ltn0" ≔ ltn0;
builtin "ltnn" ≔ ltnn;
builtin "ltnSn" ≔ ltnSn;
builtin "leq0n" ≔ leq0n;
builtin "ltn0Sn" ≔ ltn0Sn;
builtin "leqnSn" ≔ leqnSn;
builtin "leq_pred" ≔ leq_pred;
builtin "ltnW" ≔ ltnW;
builtin "leqW" ≔ leqW;
builtin "ltn_trans" ≔ ltn_trans;
builtin "lp_u003c_asym" ≔ {|<_asym|};
builtin "anti_ltn" ≔ anti_ltn;
builtin "leq_total" ≔ leq_total;
builtin "lt0n" ≔ lt0n;
builtin "leq_eqVlt" ≔ leq_eqVlt;
builtin "leq_add0" ≔ leq_add0;
builtin "leq_add2l" ≔ leq_add2l;
builtin "ltn_add2l" ≔ ltn_add2l;
builtin "leq_add2r" ≔ leq_add2r;
builtin "ltn_add2r" ≔ ltn_add2r;
builtin "leq_addl" ≔ leq_addl;
builtin "leq_addr" ≔ leq_addr;
builtin "leq_subr" ≔ leq_subr;
builtin "subn_eq0" ≔ subn_eq0;
builtin "ltn_addl" ≔ ltn_addl;
builtin "ltn_addr" ≔ ltn_addr;
builtin "addn_gt0" ≔ addn_gt0;
builtin "subn_gt0" ≔ subn_gt0;
builtin "leq_add" ≔ leq_add;
builtin "leq_subLR" ≔ leq_subLR;
builtin "subnKC" ≔ subnKC;
builtin "addnBn" ≔ addnBn;
builtin "addnBA" ≔ addnBA;
builtin "subnK" ≔ subnK;
builtin "subSn" ≔ subSn;
builtin "addnBAC" ≔ addnBAC;
builtin "leq_sub2r" ≔ leq_sub2r;
builtin "leq_sub2l" ≔ leq_sub2l;
builtin "leq_sub" ≔ leq_sub;
builtin "maxnC" ≔ maxnC;
builtin "maxnA" ≔ maxnA;
builtin "maxnAC" ≔ maxnAC;
builtin "maxnCA" ≔ maxnCA;
builtin "maxnACA" ≔ maxnACA;
builtin "addn_maxl" ≔ addn_maxl;
builtin "addn_maxr" ≔ addn_maxr;
builtin "subn_maxl" ≔ subn_maxl;
builtin "maxnE" ≔ maxnE;
builtin "maxnn" ≔ maxnn;
builtin "leq_maxl" ≔ leq_maxl;
builtin "leq_maxr" ≔ leq_maxr;
builtin "ltn_predK" ≔ ltn_predK;
builtin "prednK" ≔ prednK;
builtin "ltn0_neq0" ≔ ltn0_neq0;
builtin "disj0" ≔ disj0;
builtin "leq_pmull" ≔ leq_pmull;
builtin "leq_pmulr" ≔ leq_pmulr;
builtin "leq_mul2l" ≔ leq_mul2l;
builtin "leq_mul2r" ≔ leq_mul2r;
builtin "leq_mul" ≔ leq_mul;
builtin "eqn_mul2l" ≔ eqn_mul2l;
builtin "eqn_mul2r" ≔ eqn_mul2r;
builtin "eqn_pmul2l" ≔ eqn_pmul2l;
builtin "eqn_pmul2r" ≔ eqn_pmul2r;
builtin "leq_pmul2l" ≔ leq_pmul2l;
builtin "leq_pmul2r" ≔ leq_pmul2r;
builtin "minnC" ≔ minnC;
builtin "minnA" ≔ minnA;
builtin "minnAC" ≔ minnAC;
builtin "minnCA" ≔ minnCA;
builtin "minnACA" ≔ minnACA;
builtin "addn_minl" ≔ addn_minl;
builtin "addn_minr" ≔ addn_minr;
builtin "subn_minl" ≔ subn_minl;
builtin "minnn" ≔ minnn;
builtin "geq_minl" ≔ geq_minl;
builtin "geq_minr" ≔ geq_minr;
builtin "addn_min_max" ≔ addn_min_max;
builtin "maxnK" ≔ maxnK;
builtin "maxKn" ≔ maxKn;
builtin "minnK" ≔ minnK;
builtin "minKn" ≔ minKn;
builtin "maxn_minl" ≔ maxn_minl;
builtin "maxn_minr" ≔ maxn_minr;
builtin "minn_maxl" ≔ minn_maxl;
builtin "minn_maxr" ≔ minn_maxr;
builtin "maxnMr" ≔ maxnMr;
builtin "maxnMl" ≔ maxnMl;
builtin "minnMr" ≔ minnMr;
builtin "minnMl" ≔ minnMl;
builtin "expn0" ≔ expn0;
builtin "expn__alt__" ≔ expn1;
builtin "expnS" ≔ expnS;
builtin "expnSr" ≔ expnSr;
builtin "exp0n" ≔ exp0n;
builtin "exp1n" ≔ exp1n;
builtin "expnD" ≔ expnD;
builtin "expnMn" ≔ expnMn;
builtin "expnM" ≔ expnM;
builtin "expnAC" ≔ expnAC;
builtin "fact0" ≔ fact0;
builtin "factS" ≔ factS;
builtin "fact_gt0" ≔ fact_gt0;
builtin "fact_gt1" ≔ fact_gt1;
builtin "fact_geq" ≔ fact_geq;
