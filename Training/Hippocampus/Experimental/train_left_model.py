import ants
import antspynet

from tensorflow.keras.layers import Conv3D
from tensorflow.keras.models import Model
from tensorflow.keras import regularizers

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "0"
import glob

import random
import numpy as np

import tensorflow as tf
import tensorflow.keras as keras
import tensorflow.keras.backend as K

from batch_generator import batch_generator

K.clear_session()
# gpus = tf.config.experimental.list_physical_devices("GPU")
# if len(gpus) > 0:
#     tf.config.experimental.set_memory_growth(gpus[0], True)

tf.compat.v1.enable_eager_execution()

base_directory = '/home/ntustison/Data/DeepFlash/'
scripts_directory = base_directory + 'Scripts/'
prior_directory = base_directory + "Data/Priors/"

priors = list()
prior_labels = list(range(5, 18, 2)) # list(range(6, 19, 2))
for p in prior_labels:
    priors.append(ants.image_read(prior_directory + "prior" + str(p) + ".nii.gz"))

t1_template = ants.image_read(base_directory + "Data/deepFlashTemplateT1SkullStripped.nii.gz")

################################################
#
#  Create the model and load weights
#
################################################

number_of_classification_labels = 1 + len(prior_labels)
image_modalities = ["T1"]
channel_size = len(image_modalities) + len(prior_labels)
image_size = (64, 64, 96)

unet_model = antspynet.create_unet_model_3d((*image_size, channel_size),
   number_of_outputs=number_of_classification_labels, mode="classification",
   number_of_filters=(32, 64, 96, 128, 256),
   convolution_kernel_size=(3, 3, 3), deconvolution_kernel_size=(2, 2, 2),
   dropout_rate=0.0, weight_decay=0,
   additional_options=None)

weighted_loss = antspynet.weighted_categorical_crossentropy(weights=(1, 10, 10, 10, 10, 10, 10, 10))
dice_loss = antspynet.multilabel_dice_coefficient(dimensionality=3, smoothing_factor=0.)
binary_dice_loss = antspynet.binary_dice_coefficient(smoothing_factor=0.)

# multiple outputs

penultimate_layer = unet_model.layers[-2].output

# whole
output2 = Conv3D(filters=1,
                 kernel_size=(1, 1, 1),
                 activation='sigmoid',
                 kernel_regularizer=regularizers.l2(0.0),
                 name="whole_conv3d")(penultimate_layer)
#hippocampus
output3 = Conv3D(filters=1,
                 kernel_size=(1, 1, 1),
                 activation='sigmoid',
                 kernel_regularizer=regularizers.l2(0.0),
                 name="hippo_conv3d")(penultimate_layer)

# entorhinal, etc.
output4 = Conv3D(filters=1,
                 kernel_size=(1, 1, 1),
                 activation='sigmoid',
                 kernel_regularizer=regularizers.l2(0.0),
                 name="extra_conv3d")(penultimate_layer)

unet_model = Model(inputs=unet_model.input, outputs=[unet_model.output, output2, output3, output4])
weights_filename = scripts_directory + "deepFlashLeftT1Hierarchical_ri.h5"

if os.path.exists(weights_filename):
    unet_model.load_weights(weights_filename)

# unet_model.compile(optimizer=keras.optimizers.Adam(lr=2e-4),
#                   loss=[dice_loss, binary_dice_loss, binary_dice_loss, binary_dice_loss],
#                   loss_weights=[0.85, 0.05, 0.05, 0.05])
#                    # round1: loss_weights=[0.5, 0.2, 0.15, 0.15])
# parallel_model = multi_gpu_model(unet_model, gpus=4)
# parallel_model.compile(optimizer='adam',
#                     loss=[dice_loss, binary_dice_loss, binary_dice_loss, binary_dice_loss],
#                    loss_weights=[0.85, 0.05, 0.05, 0.05])

################################################
#
#  Load the data
#
################################################

print("Loading brain data.")

# t1_images = (*glob.glob(base_directory + "Data/Nifti*/S*/deepFlashTemplatexstruct.nii.gz"),
#              *glob.glob(base_directory + "Data/Nifti*/S*/Templates/*/deepFlashTemplatexstruct.nii.gz")  )

t1_images = (*glob.glob(base_directory + "Data/Nifti*/S*/deepFlashTemplatexstruct.nii.gz"),
             *glob.glob(base_directory + "Data/Nifti*/S*/Templates/MCI/deepFlashTemplatexstruct.nii.gz"),
             *glob.glob(base_directory + "Data/Nifti*/S*/Templates/ADNI/deepFlashTemplatexstruct.nii.gz"),
             *glob.glob(base_directory + "Data/Nifti*/S*/Templates/*MALE*80_90/deepFlashTemplatexstruct.nii.gz")
            )


training_t1_files = list()
training_t2_files = list()
training_seg_files = list()

for i in range(len(t1_images)):

    subject_directory = os.path.dirname(t1_images[i])
    t2_image = t1_images[i].replace("struct", "T2_struct")
    seg_image = t1_images[i].replace("struct", "sROIsubEC")

    training_t1_files.append(t1_images[i])
    training_t2_files.append(t2_image)
    training_seg_files.append(seg_image)

print("Total training image files: ", len(training_t1_files))

print( "Training")

###
#
# Set up the training generator
#

unet_model_tf = tf.keras.models.Model(
   unet_model.input, [unet_model.outputs[0], unet_model.outputs[1], unet_model.outputs[2], unet_model.outputs[3]])

optimizerAdam = tf.keras.optimizers.Adam(1.e-4)

batch_size = 4
number_of_epochs = 200
augmented_data_size = 16

X = None
Y = None
Y_mtl = None
Y_hipp = None
Y_extra = None

#left
labels = np.array((0, 5, 7, 9, 11, 13, 15, 17))
hemi = "left"
loss_weights = [0.85, 0.05, 0.05, 0.05]

current_loss = np.math.inf

for epoch in range(number_of_epochs):
    if epoch == 0 or ((epoch + 1) % int(np.round(48/batch_size)) == 0):
        with tf.device('/CPU:0'):
            augmented_data = batch_generator(batch_size=augmented_data_size,
                                             t1s=training_t1_files,
                                             t1_template=t1_template,
                                             segmentation_images=training_seg_files,
                                             which_hemi=hemi,
                                             priors=priors,
                                             do_histogram_intensity_warping=True,
                                             do_simulate_bias_field=True,
                                             do_add_noise=True,
                                             do_data_augmentation=True,
                                             use_rank_intensity=True,
                                             verbose=True
                                             )
            X = augmented_data[0]
            Y = augmented_data[1][0]
            Y_mtl = augmented_data[1][1]
            Y_hipp = augmented_data[1][2]
            Y_extra = augmented_data[1][3]

    epoch_random_indices = random.sample(list(range(augmented_data_size)), batch_size)

    X_batch = X[epoch_random_indices,:,:,:,:]
    Y_batch = Y[epoch_random_indices,:,:,:]
    Y_enc_batch = antspynet.encode_unet(Y_batch.astype('int'), labels)
    Y_mtl_batch = Y_mtl[epoch_random_indices,:,:]
    Y_hipp_batch = Y_hipp[epoch_random_indices,:,:]
    Y_extra_batch = Y_extra[epoch_random_indices,:,:]

    with tf.GradientTape(persistent=False) as tape:
        predicted_data = unet_model_tf(X_batch)
        regional_loss = dice_loss(tf.cast(Y_enc_batch, 'float32'), predicted_data[0])
        mtl_loss = binary_dice_loss(tf.cast(Y_mtl_batch, 'float32'), tf.squeeze(predicted_data[1]))
        hipp_loss = binary_dice_loss(tf.cast(Y_hipp_batch, 'float32'), tf.squeeze(predicted_data[2]))
        extra_loss = binary_dice_loss(tf.cast(Y_extra_batch, 'float32'), tf.squeeze(predicted_data[3]))

        loss = regional_loss * loss_weights[0] + mtl_loss * loss_weights[1] + hipp_loss * loss_weights[2] + extra_loss * loss_weights[3]
        unet_gradients = tape.gradient(loss, unet_model.trainable_variables)

        regional_loss_value = regional_loss.numpy()
        mtl_loss_value = mtl_loss.numpy()
        hipp_loss_value = hipp_loss.numpy()
        extra_loss_value = extra_loss.numpy()

        loss_value = regional_loss_value * loss_weights[0] + mtl_loss_value * loss_weights[1] + hipp_loss_value * loss_weights[2] + extra_loss_value * loss_weights[3]
        print("Epoch " + str(epoch) + ": Total loss = " + str(loss_value) +
            " (Regional = " + str(regional_loss_value) +
            ", MTL = " + str(mtl_loss_value) +
            ", Hipp = " + str(hipp_loss_value) +
            ", Extra = " + str(extra_loss_value) + ")")

        optimizerAdam.apply_gradients(zip(unet_gradients, unet_model_tf.trainable_variables))

    if loss_value < current_loss:
        print("*****  Current loss = " + str(loss_value) + "******")
        current_loss = loss_value
        unet_model_tf.save_weights(weights_filename)


