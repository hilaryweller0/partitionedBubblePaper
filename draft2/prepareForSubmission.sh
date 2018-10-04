#!/bin/bash -e

# Create pdf for submission
rmtexall manuscript
lyx -e pdflatex manuscript.lyx
pdflatex manuscript
bibtex manuscript
pdflatex manuscript
pdflatex manuscript

# Create files for submission

rm -rf ../submission2
mkdir ../submission2

lyx -e pdflatex manuscript.lyx

cp manuscript.tex qjrms4.cls ~/latex/lit/numerics.bib ../submission2
mv figures.zip ../submission2

for file in `ls figures`; do
    ln -sf ../draft2/figures/$file ../submission2/$file
done

cd ../submission2
sed -i 's/figures\///g' manuscript.tex
pdflatex manuscript
bibtex manuscript
pdflatex manuscript
pdflatex manuscript

# word count
pdftotext manuscript.pdf - | tr -d '.' | wc -w

