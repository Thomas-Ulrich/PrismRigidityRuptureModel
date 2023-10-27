prefix=$1
python /hppfs/work/pr45fi/di73yeq4/SeisSol/postprocessing/visualization/tools/extractDataFromUnstructuredOutput.py ${prefix}-fault.xdmf --Data ASl SR --do 2
python /hppfs/work/pr45fi/di73yeq4/SeisSol/postprocessing/visualization/tools/extractDataFromUnstructuredOutput.py ${prefix}-surface.xdmf --Data u1 u2 u3 --last
python /hppfs/work/pr45fi/di73yeq4/SeisSol/postprocessing/visualization/tools/extractDataFromUnstructuredOutput.py ${prefix}.xdmf --Data eta --last


