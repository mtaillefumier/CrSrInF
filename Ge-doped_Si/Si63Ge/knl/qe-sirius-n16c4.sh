#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=4
#SBATCH --constraint=cache,quad
#SBATCH --partition=normal
#SBATCH --output=qe-sirius-n16c4-%j.out

export OMP_NUM_THREADS=4
export MKL_NUM_THREADS=4
export KMP_AFFINITY=scatter,granularity=fine,1

cp ../*UPF .
cp ../pw.in .

echo "srun -n 16 -c 4 --unbuffered --hint=nomultithread ../../../../q-e/PW/src/pw.x -i pw.in -ndiag 16 -npool 1" 
srun -n 16 -c 4 --unbuffered --hint=nomultithread $SCRATCH/q-e/PW/src/pw.x -i pw.in -ndiag 16 -npool 1 -sirius
