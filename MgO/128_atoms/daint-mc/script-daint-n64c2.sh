#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=2
#SBATCH --constraint=cache,quad
#SBATCH --partition=normal

module load cray-mpich
export OMP_NUM_THREADS=2
export MKL_NUM_THREADS=2
export KMP_AFFINITY=scatter,granularity=fine,1

echo "srun -n 64 -c 1 --unbuffered --hint=nomultithread ../../../../q-e/PW/src/pw.x -i pw.in -ndiag 16 -npool 4" 
srun -n 64 -c 2 --unbuffered  ~/pw.x -i pw.in -ndiag 64 -npool 1 -sirius -sirius_cfg sirius.json
#srun -n 64 -c 2 --unbuffered  $SCRATCH/q-e/PW/src/pw.x -i pw.in -ndiag 64 -npool 1 
