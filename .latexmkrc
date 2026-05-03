# .latexmkrc — latexmk-Konfiguration
# Compiler: LuaLaTeX + Biber; Ausgabe nach build/
# ──────────────────────────────────────────────────────────────────────────

# PDF-Modus 4 = lualatex (1=pdflatex, 4=lualatex, 5=xelatex)
$pdf_mode = 4;

# LuaLaTeX-Befehl
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# Biber als Bibliographie-Prozessor
$bibtex_use = 2;   # 2 = biber immer ausführen wenn .bcf vorhanden
$biber      = 'biber %O %S';

# Ausgabe- und Hilfsverzeichnis
$out_dir = 'build';
$aux_dir = 'build';

# Zusätzliche Hilfsendungen beim Aufräumen (latexmk -C)
push @generated_exts, 'synctex.gz', 'run.xml', 'bbl', 'bcf', 'blg',
                       'fdb_latexmk', 'fls', 'lof', 'lot', 'toc',
                       'nav', 'snm', 'vrb';
