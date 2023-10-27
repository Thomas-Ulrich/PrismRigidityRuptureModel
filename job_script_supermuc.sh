#!/bin/bash
# Job Name and Files (also --job-name)

#SBATCH -J Tohoku
#Output and error (also --output, --error):
#SBATCH -o ./%j.%x.out
#SBATCH -e ./%j.%x.out

#Initial working directory:
#SBATCH --chdir=./

#Notification and type
#SBATCH --mail-type=END
#SBATCH --mail-user=thomas.ulrich@lmu.de
# Wall clock limit:
#SBATCH --time=0:30:00
#SBATCH --no-requeue

#Setup of execution environment
#SBATCH --export=ALL
#SBATCH --account=pn49ha
#constraints are optional
#--constraint="scratch&work"
#SBATCH --partition=test

#Number of nodes and MPI tasks per node:
#SBATCH --nodes=16
#SBATCH --ntasks-per-node=2
#EAR may impact code performance
#SBATCH --ear=off

module load slurm_setup

#Run the program:
export MP_SINGLE_THREAD=no
unset KMP_AFFINITY
export OMP_NUM_THREADS=46
export OMP_PLACES="cores(23)"
#Prevents errors such as experience in Issue #691
export I_MPI_SHM_HEAP_VSIZE=8192

#export XDMFWRITER_ALIGNMENT=8388608
#export XDMFWRITER_BLOCK_SIZE=8388608
export XDMFWRITER_ALIGNMENT=1048576
export XDMFWRITER_BLOCK_SIZE=1048576
export SC_CHECKPOINT_ALIGNMENT=8388608

export SEISSOL_CHECKPOINT_ALIGNMENT=8388608
export SEISSOL_CHECKPOINT_DIRECT=1
export ASYNC_MODE=THREAD
export ASYNC_BUFFER_ALIGNMENT=8388608
source /etc/profile.d/modules.sh

echo 'num_nodes:' $SLURM_JOB_NUM_NODES 'ntasks:' $SLURM_NTASKS
ulimit -Ss 2097152
#mpiexec -n $SLURM_NTASKS /hppfs/work/pr45fi/di73yeq4/SeisSol/build/SeisSol_Release_dskx_2_elastic parameters.par
#mpiexec -n $SLURM_NTASKS /hppfs/work/pr45fi/di73yeq4/SeisSol/build/SeisSol_Release_dskx_4_elastic parameters.par
mpiexec -n $SLURM_NTASKS /hppfs/work/pr45fi/di73yeq4/SeisSol/build_v1.1.0/SeisSol_Release_dskx_4_elastic parametersRS.par
#mpiexec -n $SLURM_NTASKS /hppfs/work/pr45fi/di73yeq4/SeisSol/build/SeisSol_Release_dskx_5_viscoelastic2 parameters_src.par
