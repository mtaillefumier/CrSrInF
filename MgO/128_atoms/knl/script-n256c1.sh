#!/bin/bash

#SBATCH --nodes=4
#SBATCH --ntasks-per-node=64
#SBATCH --cpus-per-task=1
#SBATCH --constraint=cache,quad
#SBATCH --partition=normal

module load cray-mpich
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export KMP_AFFINITY=scatter,granularity=fine,1

echo "srun -n 64 -c 1 --unbuffered --hint=nomultithread ../../../../q-e/PW/src/pw.x -i pw.in -ndiag 16 -npool 4" 
srun -n 256 -c 1 --unbuffered --hint=nomultithread $SCRATCH/q-e/PW/src/pw.x -i pw.in -ndiag 256 -npool 1 -sirius
