# System settings
UNAME=$(shell uname)
ARCH=$(shell uname -m)
ifeq ($(UNAME), FreeBSD)
        OS=freebsd
	VIEWER=mupdf
else
ifeq ($(UNAME), Linux)
        OS=linux
	VIEWER=evince
else
        OS=unsupported
	VIEWER=unsupported
	ARCH=unsupported
endif
endif

# Compile and preveiw settings
FILE=design.pdf

all: $(FILE)

$(FILE): build_$(FILE)
	cp build/$(FILE) $@

build_$(FILE):
	cd build && gmake

clean:
	cd build && gmake clean
	rm -f $(FILE)

preview: $(FILE)
	$(VIEWER) $^ &
