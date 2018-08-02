# Create pdf for submission
rmtexall manuscript
lyx -e pdflatex manuscript.lyx
pdflatex manuscript
bibtex manuscript
pdflatex manuscript
pdflatex manuscript

# Create files for submission

rm -r submission
mkdir submission

lyx -e pdflatex manuscript.lyx

cp manuscript.tex qjrms4.cls ~/latex/lit/numerics.bib submission
mv figures.zip submission

for file in `ls figures`; do
    ln -s ../figures/$file submission/$file
done

cd submission
sed -i 's/figures\///g' manuscript.tex
pdflatex manuscript
bibtex manuscript
pdflatex manuscript
pdflatex manuscript

# word count
pdftotext manuscript.pdf - | tr -d '.' | wc -w

