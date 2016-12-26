.PHONY: all clean install

targets = $(patsubst %.hs,out/%,$(wildcard [a-z]*.hs))

GHCFLAGS = -O -threaded


all: $(targets)

clean:
	rm -rf out tmp

install: $(targets)
	mkdir -p $(out)/bin
	install -s $(targets) $(out)/bin


out/%: %.hs
	@mkdir -p out tmp/$@
	ghc $(GHCFLAGS) -outputdir=tmp/$@ -o $@ $<
	@touch $@
