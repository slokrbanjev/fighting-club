fighting-club
=============

Website des Fighting Club Meran/o – https://fightingclub.it
Statische Seite mit [Middleman](https://middlemanapp.com) 4, gehostet auf GitHub Pages (Branch `gh-pages`).

Voraussetzungen (einmalig)
--------------------------

* Homebrew-Ruby (nicht das System-Ruby von macOS): `brew install ruby`
  – danach in einem neuen Terminal prüfen: `ruby -v` (>= 3.4) und `bundle -v`
* Xcode Command Line Tools (für native Gems): `xcode-select --install`
* Im Projektordner: `bundle install`

Arbeiten
--------

* Entwickeln (Vorschau mit Livereload auf http://localhost:4567): `bundle exec middleman server`
* Nur bauen (nach `build/`): `bundle exec middleman build`
* **Veröffentlichen**: `bundle exec middleman deploy`
  – baut die Seite und pusht `build/` auf den Branch `gh-pages` (eigenes Git-Repo im Ordner `build/`)
* Quelltext committen und pushen (nur die geänderten Dateien stagen, kein `git add -A`):
  `git add source locales config.rb build && git commit -m "kurze Änderungsbeschreibung" && git push`

Struktur
--------

* `source/localizable/index.html.erb` – die Seite (Kurse, Trainer, Stundenplan, Kontakt)
* `source/layouts/layout.erb` – Rahmen (Menü, Footer mit Partnern, Skripte)
* `locales/{de,en,it}.yml` – alle Texte und Kursnamen
* `source/assets/css/main.css.scss` – Styles (Stundenplan-Raster: `.dow-container`)
* `source/assets/fonts/` – selbst gehostete Webfonts (Lato, Permanent Marker)
* `source/assets/js/vendor/` – jQuery, meanMenu, slippry (unverändert, mit Lizenz-Headern)
* `lib/middleman-deploy-ghpages/` – der Befehl `middleman deploy`

Stundenplan
-----------

Ein Kurs ist ein `<div class="course SPORT tHHMM sN eM left|center|right">`:
`tHHMM` = Beginn (Raster ab 15.00 Uhr), `sN` = Dauer in 15-Minuten-Schritten (s4 = 1 h, s6 = 1,5 h, s8 = 2 h),
`e1/e2/e3` = ganze/halbe/drittel Spaltenbreite bei parallelen Kursen, `left/center/right` = Position.
Die Kurse pro Tag chronologisch anordnen (Handy-Ansicht zeigt sie in dieser Reihenfolge).
