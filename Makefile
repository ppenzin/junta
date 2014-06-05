# Cabal commands
SANDBOX=sandbox init
DEPS=install --enable-tests --only-dependencies
CONFIGURE=configure --enable-tests
BUILD=build
TEST=test
DOC=haddock --executables --tests
INSTALL=install
CLEAN=clean
#Manually cleaning up
CLOBBER=rm -rf .cabal-sandbox cabal.sandbox.config

all: package

install: package
	cabal $(INSTALL)

package: test doc

doc:
	cabal $(DOC)

test: build
	cabal $(TEST)

build: configure
	cabal $(BUILD)

configure: deps
	cabal $(CONFIGURE)

deps: .cabal-sandbox
	cabal $(DEPS)

.cabal-sandbox: 
	cabal $(SANDBOX)

clean:
	cabal $(CLEAN)

clobber: clean
	$(CLOBBER)
