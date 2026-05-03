# Makefile — Lernzettel-Template
# Voraussetzung: latexmk + lualatex + biber (Teil von TeX Live / MacTeX)
# ──────────────────────────────────────────────────────────────────────────

MAIN       := main
CHEATSHEET := cheatsheet
BUILD      := build
LATEXMK    := latexmk
FLAGS      := -lualatex -outdir=$(BUILD)

.PHONY: all build cheatsheet watch clean distclean pdf help

## Standardziel
all: build

## Einmaliger Build (LuaLaTeX + Biber, Ausgabe nach build/)
build:
	@mkdir -p $(BUILD)
	$(LATEXMK) $(FLAGS) $(MAIN).tex

## Cheat Sheet kompilieren (build/cheatsheet.pdf)
cheatsheet:
	@mkdir -p $(BUILD)
	$(LATEXMK) $(FLAGS) $(CHEATSHEET).tex

## Kontinuierlicher Build mit automatischer Aktualisierung (Ctrl+C zum Stoppen)
watch:
	@mkdir -p $(BUILD)
	$(LATEXMK) $(FLAGS) -pvc $(MAIN).tex

## Hilfsfiles löschen, PDF behalten
clean:
	$(LATEXMK) -c -outdir=$(BUILD) $(MAIN).tex
	$(LATEXMK) -c -outdir=$(BUILD) $(CHEATSHEET).tex

## Alles löschen (inkl. PDF)
distclean:
	$(LATEXMK) -C -outdir=$(BUILD) $(MAIN).tex
	$(LATEXMK) -C -outdir=$(BUILD) $(CHEATSHEET).tex
	@rmdir $(BUILD) 2>/dev/null || true

## Alias für build
pdf: build

## Hilfe
help:
	@echo ""
	@echo "  make build       Einmaliger Kompilierlauf (LuaLaTeX + Biber)"
	@echo "  make cheatsheet  Cheat Sheet kompilieren (build/cheatsheet.pdf)"
	@echo "  make watch       Automatischer Rebuild bei Dateiänderungen"
	@echo "  make clean       Hilfsfiles entfernen (PDF bleibt)"
	@echo "  make distclean   Alles im build/-Ordner löschen"
	@echo ""
