MODULES= gpa main
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=$(MODULES:=.mli)
TEST=test.byte
MAIN=main.byte
BIN=gpa
OCAMLBUILD=ocamlbuild -use-ocamlfind 
PKGS=unix,oUnit,str,ANSITerminal
GIT_HASH=$(shell git log --pretty=format:'%h' -n 1)

default: binary

build:
	$(OCAMLBUILD) $(OBJECTS) $(MAIN)

run:
	$(OCAMLBUILD) $(OBJECTS) $(MAIN) && ./$(MAIN)

binary: 
	ocamlopt -o $(BIN) $(MLS) 

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

docs: docs-public docs-private

docs-public: build
	mkdir -p doc.public
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.public $(MLIS)

docs-private: build
	mkdir -p doc.private
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.private \
		-inv-merge-ml-mli -m A -hide-warnings $(MLIS) $(MLS)

clean:
	ocamlbuild -clean
	rm -rf doc.public doc.private report
