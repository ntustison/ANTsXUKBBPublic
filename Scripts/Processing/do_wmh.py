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

t1_filename = sys.argv[1]
t2_filename = t1_filename.replace("T1.nii.gz", "T2_FLAIR.nii.gz")
t2_filename = t2_filename.replace("T1", "T2_FLAIR")
t2_filename = t2_filename.replace("20252_2_0", "20253_2_0")

if os.path.exists(t1_filename) and os.path.exists(t2_filename):

    output_prefix = sys.argv[2]
    wmh_file = output_prefix + "sysu_wmh.nii.gz"

    if not os.path.exists(wmh_file):
        tf.keras.backend.clear_session()

        t1 = ants.image_read(t1_filename)
        t2 = ants.image_read(t2_filename)

        reg = ants.registration(t1, t2, type_of_transform="antsRegistrationSyNQuickRepro[r]", 
            outprefix=output_prefix, verbose=False)
        t2xt1 = reg['warpedfixout']

        start = time.time()

        probability_mask = antspynet.sysu_media_wmh_segmentation(t2, t1=t2xt1, use_ensemble=True, verbose=False)
        mask = ants.threshold_image(probability_mask, 0.5, 1.1, 1, 0)
        ants.image_write(mask, wmh_file)

        end = time.time()
        print("Elapsed time: ", end - start)

