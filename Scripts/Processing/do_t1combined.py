import ants
import antspynet

import tensorflow as tf
import sys
import os

import time

os.environ["TF_NUM_INTEROP_THREADS"] = "1"
os.environ["TF_NUM_INTRAOP_THREADS"] = "1"
os.environ["ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS"] = "1"

if not len(sys.argv) == 3:
    raise ValueError("Usage:  process_antspyt1w.py inputT1.nii.gz output_prefix")

filename = sys.argv[1]
output_prefix = sys.argv[2]

output_file0 = output_prefix + "brain_extraction_t1nobrainer.nii.gz"
output_file1 = output_prefix + "brain_extraction_t1combined.nii.gz"
output_file2 = output_prefix + "brain_extraction_t1.nii.gz"

if not os.path.exists(output_file0):
    tf.keras.backend.clear_session()

    print("Doing", filename)
    t1 = ants.image_read(filename)

    start = time.time()

    mask = antspynet.brain_extraction(t1, modality="t1nobrainer", verbose=False)
    ants.image_write(mask, output_file0)
    mask = antspynet.brain_extraction(t1, modality="t1combined", verbose=False)
    ants.image_write(mask, output_file1)
    mask = ants.threshold_image(antspynet.brain_extraction(t1, modality="t1", verbose=False), 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file2)

    end = time.time()
    print("Elapsed time: ", end - start)

