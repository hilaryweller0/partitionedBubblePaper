#!/bin/bash -e
cd makeFigs

for file in identicalParts energy1part diffuse1_noDrag diffuse1_dragDiffuse massTransfer massTransferEnergy; do
    echo $file
    lyx --export pdflatex -f $file
    pdflatex $file
    pdfcrop $file.pdf ../figures/$file.pdf
    rm $file.pdf
    gv ../figures/$file.pdf &
done

cd ..

# Graphical abstract
convert ~/OpenFOAM/hilary-dev/run/hilary/warmBubble/partitioned_05/noTransfer/200/sigmaThetaZoom.pdf sigmaThetaZoom.png


#zip figures.zip stencil.pdf solidBodyRotationOnPlane_nonOrthog_50x50_analytic_constant_mesh.pdf sbrc1.png sbrc10.png sbr_dx.pdf sbr_dt.pdf overMountains.png overMountains_dx.pdf deform_init.pdf deform.png deform_dx.pdf deform_dt.pdf

cd figures
mv sbrc1.pdf fig3.pdf
mv sbrc10.pdf fig4.pdf
mv overMountains.pdf fig7.pdf
mv deform.pdf fig10.pdf
zip figs_3_4_7_10.zip fig3.pdf fig4.pdf fig7.pdf fig10.pdf
cd ..
