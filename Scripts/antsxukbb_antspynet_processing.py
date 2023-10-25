import antspynet
import numpy as np
import pandas as pd
import tensorflow as tf
import os
import sklearn

os.environ["CUDA_VISIBLE_DEVICES"] = "3"


# gpus = tf.config.experimental.list_physical_devices('GPU')
# if gpus:
#   try:
#     tf.config.experimental.set_virtual_device_configuration(
#         gpus[0],[tf.config.experimental.VirtualDeviceConfiguration(memory_limit=512)])
#   except RuntimeError as e:
#     print(e)

data_directory = "/home/ntustison/Data/ANTsXUKBB/Data/ukbiobank/"
# data_directory = "/Users/ntustison/Data/ANTsXUKBB/Data/ukbiobank/"

model_names = ("FSL", "FreeSurfer", "ANTsX", "All")

target_data = pd.read_csv(data_directory + "antsxukbb_deeplearning_targets.csv")
target_names = list(target_data.columns)

target_measures_type = ["regression",          # Age
                        "binary",              # GeneticSex
                        "regression",          # BMI
                        "binary",              # Hearing
                        "regression",          # TownsendDeprivationIndex
                        "regression",          # FluidIntelligence
                        "regression",          # Neuroticism
                        "regression",          # NumericMemory
                        "multi",               # Smoking
                        "multi",               # Alcohol
                        # "multi",               # Alzheimers
                        # "multi",               # Parkinsons
                        # "regression",          # PairsTest
                        # "regression",          # DurationTrailMaking
                        "binary",              # RiskTaking 
                        "binary"              # SameSexIntercourse 
                        # "binary"               # NonviablePregnancy
                       ]

number_of_permutations = 10
training_data_percentage = 0.90

for i in range(len(target_names)):

    single_target = target_data[target_names[i]]
    age_target = target_data['Age']
    genetic_sex_target = target_data['GeneticSex']

    output_directory = data_directory + "/ExperimentalResults/ANTsXNet90PercentTrainingData/" + target_names[i] + "/"
    if not os.path.exists(output_directory):
        os.makedirs(output_directory, exist_ok=True)

    for j in range(len(model_names)):

        file = data_directory + "antsxukbb_deeplearning_" + model_names[j] + ".csv"
        idps = pd.read_csv(file)

        target_plus_idps = None
        if target_names[i] == "Age":
            target_plus_idps = pd.concat([single_target, genetic_sex_target, idps], axis=1)
        elif target_names[i] == "GeneticSex" or target_names[i] == "NonviablePregnancy":
            target_plus_idps = pd.concat([single_target, age_target, idps], axis=1)
        else:
            target_plus_idps = pd.concat([single_target, age_target, genetic_sex_target, idps], axis=1)

        input_layer_size = target_plus_idps.shape[1] - 1
        target_plus_idps_complete = target_plus_idps.dropna()

        number_of_training_data = int(training_data_percentage * target_plus_idps_complete.shape[0])

        X = target_plus_idps_complete.drop([target_names[i]], axis=1)
        Y = target_plus_idps_complete[target_names[i]]

        number_of_classes = 0
        if target_measures_type[i] == "binary" or target_measures_type[i] == "multi":
            Y = Y.astype(int)
            number_of_classes = len(Y.unique())
        else:
            Y = Y.astype(float)

        loss_type = "mse"
        mode = "regression"
        if target_measures_type[i] == "binary":
            loss_type = "binary_crossentropy"
            mode = "classification"
        elif target_measures_type[i] == "multi":
            loss_type = "categorical_crossentropy"
            mode = "classification"

        results_measures = list()

        for n in range(number_of_permutations):

            X_train = X.sample(n=number_of_training_data)
            X_train_min = X_train.min(axis=0)
            X_train_max = X_train.max(axis=0)
            X_train = (X_train - X_train_min) / (X_train_max - X_train_min)

            if mode == "classification":
                Y_train = tf.keras.utils.to_categorical(Y[X_train.index])
            else:
                Y_train = Y[X_train.index]
                Y_train = (Y_train - Y_train.min()) / (Y_train.max() - Y_train.min())

            model = antspynet.create_dense_model(input_layer_size,
                                                 number_of_filters_at_base_layer=512,
                                                 number_of_layers=2,
                                                 mode=mode,
                                                 number_of_classification_labels=number_of_classes)
            if mode == "regression":
                model.compile(loss=loss_type, optimizer="adam", metrics=[tf.keras.metrics.RootMeanSquaredError()])
            else:
                model.compile(loss=loss_type, optimizer="adam", metrics=[tf.keras.metrics.AUC(multi_label=(target_measures_type[i]=="multi"))])

            early_stopping = tf.keras.callbacks.EarlyStopping(monitor="val_loss",
                                                              patience=50)

            output_model_file = output_directory + "/ModelWeights-" + model_names[j] + "-" + target_names[i] + "_" + str(n) + ".hdf5"

            if os.path.exists(output_model_file):
                model.load_weights(output_model_file)
            else:
                checkpoint = tf.keras.callbacks.ModelCheckpoint(filepath=output_model_file,
                                                                monitor='val_loss',
                                                                verbose=1,
                                                                save_weights_only=True,
                                                                save_best_only=True,
                                                                mode='auto')


                fit = model.fit(X_train, Y_train,
                                epochs=1000,
                                batch_size=5000,
                                validation_split=0.20,
                                verbose=2,
                                callbacks=[early_stopping, checkpoint])

            # Just save the models to do the prediction and evaluation in R

            X_test = X.drop(index=X_train.index, axis=0)
            X_test = (X_test - X_train_min) / (X_train_max - X_train_min)
            Y_pred = model.predict(X_test)

            measure = None
            if target_measures_type[i] == "regression":
                Y_test = Y.drop(index=X_train.index, axis=0)
                Y_train = Y[X_train.index]
                Y_pred = (Y_pred * (Y_train.max() - Y_train.min()) + Y_train.min()).flatten()
                rmse = measure = sklearn.metrics.mean_squared_error(Y_test, Y_pred, squared=False)
                measure = rmse
            else:
                # Y_decoded = tf.argmax(Y_pred, axis=1).numpy()
                Y_test = tf.keras.utils.to_categorical(Y.drop(index=X_train.index, axis=0))
                auc = sklearn.metrics.roc_auc_score(Y_test, Y_pred)
                measure = auc

            results_measures.append(measure)

            results_dataframe = pd.DataFrame(results_measures)
            results_dataframe.to_csv(output_directory + "/Measures-" + model_names[j] + "-" + target_names[i] + ".csv")










