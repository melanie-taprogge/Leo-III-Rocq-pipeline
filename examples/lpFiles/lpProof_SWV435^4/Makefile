.POSIX:
.SUFFIXES:

.PHONY: default
default: lpo

LP := $(wildcard Signature.lp) \
      $(wildcard Formulae.lp) \
      $(filter-out Signature.lp Formulae.lp encodedProof.lp encoding.lp mappings.lp,$(wildcard *.lp)) \
      $(wildcard encodedProof.lp)

LPO := $(LP:%.lp=%.lpo)
.PHONY: lpo
lpo: $(LPO)

.PHONY: clean-lpo
clean-lpo:
	-find . -name '*.lpo' -delete

%.lpo: %.lp
	lambdapi check --gen-obj $<

.PHONY: install
install: lambdapi.pkg $(LP)
	for f in $(LP); do \
	  lambdapi check --gen-obj "$$f"; \
	  obj=$${f%.lp}.lpo; \
	  lambdapi install lambdapi.pkg "$$f" "$$obj"; \
	done

.PHONY: uninstall
uninstall: lambdapi.pkg
	lambdapi uninstall lambdapi.pkg

DK := $(LP:%.lp=%.dk)

.PHONY: dk
dk: $(DK)

%.dk: %.lp
	-find . -name '*.lpo' -delete
	lambdapi export -o dk $< > $@

.PHONY: clean-dk
clean-dk: clean-dko
	-find . -name '*.dk' -delete

DKO := $(DK:%.dk=%.dko)

.PHONY: dko
dko: $(DKO)

%.dko: %.dk
	dk check -e $<

.PHONY: clean-dko
clean-dko:
	-find . -name '*.dko' -delete

.PHONY: clean
clean: clean-lpo clean-dk

V := $(LP:%.lp=%.v)

.PHONY: v
v: $(V)

%.v: %.lp
	lambdapi export -o stt_coq --encoding encoding.lp --use-notations --mapping mappings.lp --requiring mappings $< > $@

.PHONY: clean-v
clean-v: clean-vo
	-find . -name '*.v' -a ! -name mappings.v -delete

.PHONY: clean-vo
clean-vo:
	-find . -name '*.vo' -delete
