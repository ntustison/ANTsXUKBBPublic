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

output_file0 = output_prefix + "deep_flash_hm_parcellation.nii.gz"
output_file1 = output_prefix + "deep_flash_hm_medial_temporal_lobe_mask.nii.gz"
output_file2 = output_prefix + "deep_flash_hm_hippocampal_mask.nii.gz"
output_file3 = output_prefix + "deep_flash_hm_other_region_mask.nii.gz"

if not os.path.exists(output_file0):
    tf.keras.backend.clear_session()

    print("Doing", filename)
    t1 = ants.image_read(filename)

    start = time.time()

    df = antspynet.deep_flash(t1, verbose=False)
    ants.image_write(df['segmentation_image'], output_file0)
    mask = ants.threshold_image(df['medial_temporal_lobe_probability_image'], 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file1)
    mask = ants.threshold_image(df['hippocampal_probability_image'], 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file2)
    mask = ants.threshold_image(df['other_region_probability_image'], 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file3)

    end = time.time()
    print("Elapsed time: ", end - start)


output_file0 = output_prefix + "deep_flash_ri_parcellation.nii.gz"
output_file1 = output_prefix + "deep_flash_ri_medial_temporal_lobe_mask.nii.gz"
output_file2 = output_prefix + "deep_flash_ri_hippocampal_mask.nii.gz"
output_file3 = output_prefix + "deep_flash_ri_other_region_mask.nii.gz"

if not os.path.exists(output_file0):
    tf.keras.backend.clear_session()

    print("Doing", filename)
    t1 = ants.image_read(filename)

    start = time.time()

    df = antspynet.deep_flash(t1, use_rank_intensity=True, verbose=False)
    ants.image_write(df['segmentation_image'], output_file0)
    mask = ants.threshold_image(df['medial_temporal_lobe_probability_image'], 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file1)
    mask = ants.threshold_image(df['hippocampal_probability_image'], 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file2)
    mask = ants.threshold_image(df['other_region_probability_image'], 0.5, 1.1, 1, 0)
    ants.image_write(mask, output_file3)

    end = time.time()
    print("Elapsed time: ", end - start)

output_file_hipp = output_prefix + "hippmapper.nii.gz"

if not os.path.exists(output_file_hipp):
    tf.keras.backend.clear_session()

    print("Doing Hipp", filename)
    t1 = ants.image_read(filename)

    start = time.time()

    hipp = antspynet.hippmapp3r_segmentation(t1, verbose=False)
    ants.image_write(hipp, output_file_hipp)

    end = time.time()
    print("Elapsed time: ", end - start)

