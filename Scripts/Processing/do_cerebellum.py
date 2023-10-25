import ants
import antspynet

import tensorflow as tf
import sys
import os

import time

os.environ["TF_NUM_INTEROP_THREADS"] = "1"
os.environ["TF_NUM_INTRAOP_THREADS"] = "1"
os.environ["ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS"] = "2"

if not len(sys.argv) == 3:
    raise ValueError("Usage:  do_cerebellum.py inputT1.nii.gz output_prefix")

filename = sys.argv[1]
output_prefix = sys.argv[2]

output_file0 = output_prefix + "cerebellum_whole_mask.nii.gz"
output_file1 = output_prefix + "cerebellum_tissue_segmentation.nii.gz"
output_file2 = output_prefix + "cerebellum_cortical_parcellation.nii.gz"
output_file3 = output_prefix + "cerebellum_cortical_thickness.nii.gz"

if not os.path.exists(output_file3):
    tf.keras.backend.clear_session()

    print("Doing", filename)
    t1 = ants.image_read(filename)

    start = time.time()

    cereb = antspynet.cerebellum_morphology(t1, compute_thickness_image=True, verbose=True) 
    mask = ants.threshold_image(cereb['cerebellum_probability_image'], 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file0)
    ants.image_write(cereb['tissue_segmentation_image'], output_file1)
    ants.image_write(cereb['parcellation_segmentation_image'], output_file2)
    ants.image_write(cereb['thickness_image'], output_file3)

    end = time.time()
    print("Elapsed time: ", end - start)

    finished_file = output_prefix + "finished.txt"
    f = open(finished_file, "w")
    f.close()

