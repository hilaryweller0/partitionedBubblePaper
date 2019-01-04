#!/bin/bash -e
cd makeFigs

for file in identicalParts energy1part diffuse1_noDrag diffuse1_dragDiffuse massTransfer massTransferEnergy; do
    echo $file
    lyx --export pdflatex -f $file
    pdflatex $file
    pdf2ps $file.pdf
    makebb $file.ps
    mv $file.ps $file.eps
    pdfcrop $file.pdf $file.cropped.pdf
    mv $file.cropped.pdf $file.pdf
    mv $file.eps $file.pdf ../figures
    gv ../figures/$file.eps &
done

cd ..

# Graphical abstract
#convert ~/OpenFOAM/hilary-dev/run/hilary/warmBubble/partitioned_05/noTransfer/200/sigmaThetaZoom.pdf sigmaThetaZoom.png

#zip figures.zip stencil.pdf solidBodyRotationOnPlane_nonOrthog_50x50_analytic_constant_mesh.pdf sbrc1.png sbrc10.png sbr_dx.pdf sbr_dt.pdf overMountains.png overMountains_dx.pdf deform_init.pdf deform.png deform_dx.pdf deform_dt.pdf

cd figures
cp *.eps ../../submission3
rm -f ../../submission3/figures.zip
zip ../../submission3/figures.zip *.eps
cd ..

