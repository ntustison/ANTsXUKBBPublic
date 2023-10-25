import antspynet
import numpy as np
import pandas as pd
import shap
import os

import tensorflow as tf
tf.compat.v1.disable_v2_behavior()

which="90Percent"
# which="5000"

# data_directory = "/home/ntustison/Data/ANTsXUKBB/"
data_directory = "/Users/ntustison/Data/ANTsXUKBB/Data/ukbiobank/"

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
                        "binary",              # RiskTaking
                        "binary"              # SameSexIntercourse
                       ]

for i in range(len(target_names)):
    # if i < 11:
    #     continue
    print(target_names[i], " ---> ", target_measures_type[i])
    single_target = target_data[target_names[i]]
    age_target = target_data['Age']
    genetic_sex_target = target_data['GeneticSex']
    for j in range(len(model_names)):
        print("    " + model_names[j])
        file = data_directory + "antsxukbb_deeplearning_" + model_names[j] + ".csv"
        idps = pd.read_csv(file)
        target_plus_idps = None
        if target_names[i] == "Age":
            target_plus_idps = pd.concat([single_target, genetic_sex_target, idps], axis=1)
        elif target_names[i] == "GeneticSex":
            target_plus_idps = pd.concat([single_target, age_target, idps], axis=1)
        else:
            target_plus_idps = pd.concat([single_target, age_target, genetic_sex_target, idps], axis=1)
        input_layer_size = target_plus_idps.shape[1] - 1
        target_plus_idps_complete = target_plus_idps.dropna()
        X = target_plus_idps_complete.drop([target_names[i]], axis=1)
        norm_X = (X - X.min()) / (X.max() - X.min())
        Y = target_plus_idps_complete[target_names[i]]
        norm_Y = None
        number_of_classes = 0
        mode = None
        if target_measures_type[i] == "binary" or target_measures_type[i] == "multi":
            Y = Y.astype(int)
            number_of_classes = len(Y.unique())
            mode = "classification"
        else:
            Y = Y.astype(float)
            norm_Y = (Y - Y.min()) / (Y.max() - Y.min())
            mode = "regression"
        model = antspynet.create_dense_model(input_layer_size,
                                                number_of_filters_at_base_layer=512,
                                                number_of_layers=2,
                                                mode=mode,
                                                number_of_classification_labels=number_of_classes)
        shap_values_df = pd.DataFrame()
        background = norm_X.iloc[np.random.choice(norm_X.shape[0], 1000, replace=False)]
        for k in range(10):
            print("        " + str(k) + ": ")
            output_csv_file = (data_directory + "ExperimentalResults/ANTsXNet" + which + "TrainingData/" + 
                target_names[i] + "/ShapValues-" + model_names[j] + "-" + target_names[i] + ".csv")
            input_model_file = (data_directory + "ExperimentalResults/ANTsXNet" + which + "TrainingData/" + 
                            target_names[i] + "/ModelWeights-" + model_names[j] + "-" + target_names[i] + "_" + 
                            str(k) + ".hdf5")
           
            if not os.path.exists(input_model_file):
                raise ValueError("Model does not exist.")
                # continue

            model.load_weights(input_model_file)
            explainer = shap.DeepExplainer((model.layers[0].input, model.layers[-1].output), background)
            shap_values = explainer.shap_values(norm_X[:100].values, check_additivity=False)
            mean_shap_values = np.mean(shap_values[0], axis=0)
            for l in range(1, len(shap_values)):
                mean_shap_values = (mean_shap_values * l + np.mean(shap_values[l], axis=0)) / (l + 1)
            shap_values_df = pd.concat([shap_values_df, pd.DataFrame(mean_shap_values, index=list(background.columns)).T])
            shap_values_df.to_csv(output_csv_file, index=False)  




