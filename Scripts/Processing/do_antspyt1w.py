import sys
import os
import glob

os.environ["TF_NUM_INTEROP_THREADS"] = "1"
os.environ["TF_NUM_INTRAOP_THREADS"] = "1"
os.environ["ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS"] = "1"

import antspyt1w
import ants
import pandas as pd
import numpy as np

image_suffix = ".nii.gz"

if not len(sys.argv) == 3:
    raise ValueError("Usage:  process_antspyt1w.py inputT1.nii.gz output_prefix")

filename = sys.argv[1]
output_prefix = sys.argv[2]

t1 = ants.image_read(filename)
results = antspyt1w.hierarchical(t1, output_prefix=output_prefix, labels_to_register=None, cit168=False, verbose=True)

# antspyt1w.write_hierarchical(results, output_prefix=output_prefix)

# Write images to disk

# for i in range(len(results['dkt_parc']['tissue_probabilities'])):
#     if i > 0:
#         ants.image_write(results['dkt_parc']['tissue_probabilities'][i], output_prefix + 'tissue_probabilities' + str(i) + image_suffix)
# ants.image_write(results['brain_n4_dnz'], output_prefix + 'brain_n4_dnz' + image_suffix)

ants.image_write(results['dkt_parc']['tissue_segmentation'], output_prefix + 'tissue_segmentation' + image_suffix)
ants.image_write(results['dkt_parc']['dkt_parcellation'], output_prefix + 'dkt_parcellation' + image_suffix)
ants.image_write(results['dkt_parc']['dkt_lobes'], output_prefix + 'dkt_lobes' + image_suffix)
ants.image_write(results['dkt_parc']['dkt_cortex'], output_prefix + 'dkt_cortex' + image_suffix)
ants.image_write(results['dkt_parc']['hemisphere_labels'], output_prefix + 'hemisphere_labels' + image_suffix)

ants.image_write(results['bf'], output_prefix + 'bf' + image_suffix)
# ants.image_write(results['deep_cit168lab'], output_prefix + 'deep_cit168lab' + image_suffix)

files_citi = glob.glob(output_prefix + "_CIT168*")
for i in range(len(files_citi)):
    os.remove(files_citi[i])

files_snr = glob.glob(output_prefix + "_SNR*")
for i in range(len(files_snr)):
    os.remove(files_snr[i])

files_png = glob.glob(output_prefix + "*png")
for i in range(len(files_png)):
    os.remove(files_png[i])

# ants.image_write(results['hippLR']['HLProb'], output_prefix + 'HLProb' + image_suffix)
# ants.image_write(results['hippLR']['HRProb'], output_prefix + 'HRProb' + image_suffix)
# ants.image_write(results['white_matter_hypointensity']['wmh_probability_image'], output_prefix + 'wmh_probability_image' + image_suffix)
# ants.image_write(results['wm_tractsL'], output_prefix + 'wm_tractsL' + image_suffix)
# ants.image_write(results['wm_tractsR'], output_prefix + 'wm_tractsR' + image_suffix)

# Write numerics

wm_df = pd.DataFrame(np.array([[results['dkt_parc']['wmSNR'], results['dkt_parc']['wmcsfSNR']]]), columns=('wmSNR', 'wmcsfSNR'))
wm_df.to_csv(output_prefix + "SNR.csv")

# results['hippLR']['HLStats'].to_csv(output_prefix + "HLStats.csv")
# results['hippLR']['HRStats'].to_csv(output_prefix + "HRStats.csv")

results['dataframes']['hemispheres'].to_csv(output_prefix + "hemispheres.csv")
results['dataframes']['tissues'].to_csv(output_prefix + "tissues.csv")
results['dataframes']['dktlobes'].to_csv(output_prefix + "dktlobes.csv")
results['dataframes']['dktregions'].to_csv(output_prefix + "dktregions.csv")
results['dataframes']['dktcortex'].to_csv(output_prefix + "dktcortex.csv")
results['dataframes']['rbp'].to_csv(output_prefix + "random_basis_projection.csv")
# results['dataframes']['wmtracts_left'].to_csv(output_prefix + "wmtracts_left.csv")
# results['dataframes']['wmtracts_right'].to_csv(output_prefix + "wmtracts_right.csv")
# results['dataframes']['wmh'].to_csv(output_prefix + "wmh.csv")


# cortical thickness

kk_segmentation = ants.image_clone(results['dkt_parc']['tissue_segmentation'])
kk_segmentation[kk_segmentation == 4] = 3
gray_matter = results['dkt_parc']['tissue_probabilities'][2]
white_matter = (results['dkt_parc']['tissue_probabilities'][3] + results['dkt_parc']['tissue_probabilities'][4])
kk = ants.kelly_kapowski(s=kk_segmentation, g=gray_matter, w=white_matter,
                        its=45, r=0.025, m=1.5, x=0, verbose=int(True))
ants.image_write(kk, output_prefix + 'thickness' + image_suffix)



finished_file = output_prefix + "finished.txt"
f = open(finished_file, "w")
f.close()

