#/bin/bash

module purge
rm -f *.out

module load intel
echo "Building with ifort..."
ifort -o intel.out pgi_err.F90
ls *.out
echo ""

module swap intel gnu
echo "Building with gfortran..."
gfortran -o gnu.out pgi_err.F90
ls *.out
echo ""

rm -f a.out
module swap gnu pgi
echo "Building with pgf90..."
pgf90 -o pgi.out pgi_err.F90
ls *.out
