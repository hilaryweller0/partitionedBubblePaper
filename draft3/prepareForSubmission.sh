#!/bin/bash -e

# Create pdf for submission
rmtexall manuscript
lyx -e pdflatex manuscript.lyx
pdflatex manuscript
bibtex manuscript
pdflatex manuscript
pdflatex manuscript

sed 's/figures\///g' manuscript.tex > manuscript2.tex
for ext in bbl blg aux; do
    cp manuscript.$ext manuscript2.$ext
done

rm -f manuscript2.zip
zip -j manuscript.zip manuscript2.tex figures/*eps qjrms4.cls readme manuscript2.bbl \
    manuscript2.blg manuscript2.aux ~/latex/lit/numerics.bib

# Create files for submission

rm -rf ../submission2
mkdir ../submission2

mv manuscript.zip ../submission2
cd ../submission2

unzip manuscript.zip

pdflatex manuscript2
bibtex manuscript2
pdflatex manuscript2
pdflatex manuscript2

# word count
pdftotext manuscript2.pdf - | tr -d '.' | wc -w

