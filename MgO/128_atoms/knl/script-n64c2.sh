#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --cpus-per-task=1
#SBATCH --constraint=cache,quad
#SBATCH --partition=normal
#SBATCH --output=qe-sirius-knl-n64c1-%j.out

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export KMP_AFFINITY=scatter,granularity=fine,1

echo "srun -n 64 -c 1 --unbuffered --hint=nomultithread ../../../../q-e/PW/src/pw.x -i pw.in -ndiag 16 -npool 4" 
srun -n 64 -c 1 --unbuffered --hint=nomultithread $SCRATCH/q-e/PW/src/pw.x -i pw.in -ndiag 64 -npool 1 -sirius -sirius_cfg sirius.json
