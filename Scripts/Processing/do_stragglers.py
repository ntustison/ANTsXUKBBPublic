import os
import glob

import subprocess

os.environ["TF_NUM_INTEROP_THREADS"] = "1"
os.environ["TF_NUM_INTRAOP_THREADS"] = "1"
os.environ["ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS"] = "1"

processed_directory = "/Volumes/UK Biobank/ProcessedX/"

antspyt1w_command_script = processed_directory + "../Scripts/do_antspyt1w.py"

ids = (4016232, 2393360, 3079691, 3239270, 4195219, 4207722, 5271600)
t1_files = list()
for i in range(len(ids)):
    t1_files.append(processed_directory + "../Nifti/" + str(ids[i]) + "/20252_2_0/T1/T1.nii.gz")


for i in range(len(t1_files)):

    print("Processing: " + t1_files[i] + "(" + str(i) + " out of " + str(len(t1_files)) + ")")

    output_directory = os.path.dirname(t1_files[i]).replace("Nifti", "ProcessedX")
    output_prefix = output_directory + "antspyt1w_"

    subprocess.run(["python3", antspyt1w_command_script, t1_files[i], output_prefix])

 