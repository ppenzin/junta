HC=ghc
BOOTDIR=boot
BOOT=$(BOOTDIR)/junta
SRC=src/main/haskell

all: build

build: $(BOOT)
	$(BOOT) compile

$(BOOT): $(SRC)/Main.hs
	$(HC) -hidir $(BOOTDIR) -odir $(BOOTDIR) $^ -o $@

clean:
	rm -f $(BOOT) $(BOOTDIR)/*.hi $(BOOTDIR)/*.o
