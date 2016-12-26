.PHONY: all

targets = $(patsubst %.hs,%,$(wildcard [a-z]*.hs))

GHCFLAGS = -O -threaded


all: $(targets)


%: %.hs
	@mkdir -p tmp/$@
	ghc $(GHCFLAGS) -outputdir=tmp/$@ -o $@ $<
	@touch $@
