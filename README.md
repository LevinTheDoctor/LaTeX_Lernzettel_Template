# Lernzettel-Template

Professionelles LaTeX-Template für Lernzettel, Zusammenfassungen und
Prüfungsvorbereitungen. Kompiliert mit **LuaLaTeX + Biber** via `latexmk`.

---

## Voraussetzungen

### macOS (Homebrew)

```bash
# MacTeX installieren (enthält LuaLaTeX, latexmk, biber)
brew install --cask mactex

# Shell-Session neu starten oder:
eval "$(/usr/libexec/path_helper)"

# (Optional) latexmk separat aktualisieren
sudo tlmgr update --self && sudo tlmgr update latexmk
```

### Windows (MiKTeX)

1. [MiKTeX herunterladen](https://miktex.org/download) und installieren.
2. Im **MiKTeX Console** unter *Updates* alle Pakete aktualisieren.
3. Sicherstellen, dass `biber` installiert ist:
   ```
   miktex packages install biber
   ```
4. `latexmk` ist in MiKTeX enthalten; Perl muss installiert sein
   ([Strawberry Perl](https://strawberryperl.com/) empfohlen).

---

## Kompilieren

```bash
# Einmaliger Build (empfohlen)
make build
# oder direkt:
latexmk -lualatex main.tex

# Kontinuierlicher Rebuild bei Dateiänderungen
make watch

# Hilfsfiles aufräumen
make clean

# Alles löschen (inkl. PDF)
make distclean
```

Das fertige PDF liegt in `build/main.pdf`.

---

## VSCode-Einrichtung

### Benötigte Extensions

| Extension | ID |
|---|---|
| LaTeX Workshop | `James-Yu.latex-workshop` |
| LTeX | `valentjn.vscode-ltex` |

```bash
code --install-extension James-Yu.latex-workshop
code --install-extension valentjn.vscode-ltex
```

### settings.json (bereits im Repo unter `.vscode/settings.json`)

Falls du die Einstellungen in deine **User-Settings** übertragen möchtest,
kopiere folgenden Block in `Cmd+Shift+P → Open User Settings (JSON)`:

```jsonc
{
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk (LuaLaTeX + Biber)",
      "tools": ["latexmk-lualatex"]
    }
  ],
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk-lualatex",
      "command": "latexmk",
      "args": [
        "-lualatex",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-outdir=%OUTDIR%",
        "%DOC%"
      ],
      "env": {}
    }
  ],
  "latex-workshop.latex.outDir": "%DIR%/build",
  "latex-workshop.latex.autoBuild.run": "onSave",
  "latex-workshop.synctex.afterBuild.enabled": true,
  "latex-workshop.view.pdf.viewer": "tab",
  "ltex.language": "de-DE",
  "ltex.enabled": ["latex", "bibtex"],
  "[latex]": {
    "editor.wordWrap": "on",
    "editor.formatOnSave": false
  },
  "files.associations": {
    "*.tex": "latex",
    "*.bib": "bibtex"
  }
}
```

---

## Anpassung

| Was ändern? | Datei |
|---|---|
| Autor, Matrikelnummer, Semester | `config/usermeta.tex` |
| Titel, Fach, Beschreibung | `config/topicmeta.tex` |
| Farben, Schriften, Abstände | `config/colormeta.tex` |
| Weitere Pakete | `preamble/packages.tex` |
| Eigene Befehle/Umgebungen | `preamble/commands.tex` |
| Layout, Kopf-/Fußzeile, TOC | `preamble/styles.tex` |
| Inhalt | `content/` |
| Literatur | `bibliography/sources.bib` |

**Grundregel:** Farben und Schriften sind **ausschließlich** in
`config/colormeta.tex` definiert. Nichts anderes muss für ein Re-Design
geändert werden.

---

## Optionale Premium-Schriften

Die Standardschriften (TeX Gyre) sind immer in TeX Live enthalten.
Für ein hochwertigeres Erscheinungsbild empfehlen sich:

| Zweck | Schrift | Installation (macOS) |
|---|---|---|
| Fließtext | Source Serif 4 | `brew install --cask font-source-serif-4` |
| Sans-Serif | Source Sans 3 | `brew install --cask font-source-sans-3` |
| Monospace | JetBrains Mono | `brew install --cask font-jetbrains-mono` |

Nach der Installation in `config/colormeta.tex` eintragen:

```latex
\newcommand{\mainfont}{Source Serif 4}
\newcommand{\sansfont}{Source Sans 3}
\newcommand{\monofont}{JetBrains Mono}
```

---

## Eigene Umgebungen (Kurzreferenz)

```latex
% 1. Prozess mit nummerierten Schritten
\begin{process}
  \step{Erster Schritt}
  \step{Zweiter Schritt}
\end{process}

% 2. Infobox (Titel optional)
\begin{infobox}[Mein Titel]
  Inhalt der Infobox.
\end{infobox}

% 3. Warnbox (Titel optional)
\begin{warnbox}[Achtung!]
  Wichtiger Hinweis.
\end{warnbox}

% 4. Vor-/Nachteil-Tabelle
\begin{procon}
  \pro{Erster Vorteil}
  \pro{Zweiter Vorteil}
  \con{Erster Nachteil}
  \con{Zweiter Nachteil}
\end{procon}

% 5. Codeblock (monospace, grauer Hintergrund)
\begin{codebox}
def hello():
    print("Hallo Welt")
\end{codebox}

% 6. Zwei Inhalte nebeneinander
\sidetables{Linker Inhalt}{Rechter Inhalt}

% 7. Formatierte Tabelle mit farbiger Kopfzeile
\begin{stdtable}{l X X}{Spalte 1 & Spalte 2 & Spalte 3}
  Zeile 1 & Daten & Daten \\
  Zeile 2 & Daten & Daten \\
\end{stdtable}
```

---

## Projektstruktur

```
lernzettel-template/
├── main.tex                  ← Einstiegspunkt
├── config/
│   ├── usermeta.tex          ← Autor, Kurs, Matrikelnummer
│   ├── topicmeta.tex         ← Titel, Fach, Beschreibung
│   └── colormeta.tex         ← ALLE Farben, Schriften, Abstände
├── preamble/
│   ├── packages.tex          ← \usepackage-Deklarationen
│   ├── commands.tex          ← eigene Umgebungen und Befehle
│   └── styles.tex            ← Schriften, Layout, Kopf-/Fußzeile, TOC
├── content/
│   └── example.tex           ← Beispielkapitel (alle Umgebungen)
├── assets/images/            ← Abbildungen hier ablegen
├── bibliography/
│   └── sources.bib           ← BibTeX-Einträge
├── .vscode/settings.json     ← LaTeX Workshop + LTeX-Einstellungen
├── .latexmkrc                ← latexmk: LuaLaTeX + Biber, out=build/
├── .gitignore
├── Makefile                  ← build / watch / clean / distclean
└── README.md
```

---

## Lizenz

Dieses Template steht unter der [MIT-Lizenz](https://opensource.org/licenses/MIT).
Du kannst es frei verwenden, anpassen und weitergeben.
