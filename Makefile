SANDBOX=cabal sandbox init
DEPS=cabal install --enable-tests --only-dependencies
CONFIGURE=cabal configure --enable-tests
BUILD=cabal build
TEST=cabal test
DOC=cabal haddock --executables --tests
CLEAN=cabal clean
CLOBBER=rm -rf .cabal-sandbox cabal.sandbox.config

all: package

package: test doc

doc:
	$(DOC)

test: build
	$(TEST)

build: configure
	$(BUILD)

configure: deps
	$(CONFIGURE)

deps: .cabal-sandbox
	$(DEPS)

.cabal-sandbox: 
	$(SANDBOX)

clean:
	$(CLEAN)

clobber: clean
	$(CLOBBER)
