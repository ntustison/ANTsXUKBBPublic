import pandas as pd
import numpy as np
import os

os.environ["CUDA_VISIBLE_DEVICES"] = "2"

import sklearn
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split

from pytorch_tabnet.tab_model import TabNetRegressor, TabNetClassifier
from pytorch_tabnet.metrics import Metric

import tensorflow as tf

class AUC(Metric):
    def __init__(self):
        self._name = "auc"
        self._maximize = True
    def __call__(self, y_true, y_score):
        y_true_one_hot = tf.keras.utils.to_categorical(y_true)
        y_score_one_hot = tf.keras.utils.to_categorical(y_score)
        auc = sklearn.metrics.roc_auc_score(y_true_one_hot, y_score_one_hot)
        return auc

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
                        "multi",               # Alzheimers
                        # "multi",               # Parkinsons
                        "regression",          # PairsTest
                        "regression",          # DurationTrailMaking
                        "binary",              # RiskTaking 
                        "binary"               # SameSexIntercourse 
                        # "binary"               # NonviablePregnancy
                       ]

number_of_permutations = 10
training_data_percentage = 0.90

for i in range(len(target_names)):

    single_target = target_data[target_names[i]]
    age_target = target_data['Age']
    genetic_sex_target = target_data['GeneticSex']

    output_directory = data_directory + "/TabNet90PercentTrainingData/" + target_names[i] + "/"
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
        if target_measures_type[i] == "binary" or target_measures_type[i] == "multi":
            loss_type = "accuracy"
            # loss_type = AUC
            mode = "classification"

        number_of_training_data = int(training_data_percentage * target_plus_idps_complete.shape[0])

        output_values_df = pd.DataFrame()

        for n in range(number_of_permutations):

            train_val_indices, test_indices = train_test_split(
                range(X.shape[0]), train_size=number_of_training_data, random_state=n)
            train_indices, valid_indices = train_test_split(
                train_val_indices, test_size=0.2, random_state=n)

            X_train = X.iloc[train_indices].values
            X_valid = X.iloc[valid_indices].values
            X_test = X.iloc[test_indices].values

            clf = None
            if mode == "regression":
                clf = TabNetRegressor()
                Y_train = Y.iloc[train_indices].values.reshape(-1,1)
                Y_valid = Y.iloc[valid_indices].values.reshape(-1,1)
                Y_test = Y.iloc[test_indices].values.reshape(-1,1)
            else:
                clf = TabNetClassifier()
                Y_train = Y.iloc[train_indices].values
                Y_valid = Y.iloc[valid_indices].values
                Y_test = Y.iloc[test_indices].values

            clf.fit(
                X_train=X_train,
                y_train=Y_train,
                eval_set=[(X_train, Y_train), (X_valid, Y_valid)],
                eval_name=['train', 'val'],
                eval_metric=[loss_type],
                max_epochs=1000,
                patience=20,
                batch_size=1000,
                virtual_batch_size=128,
                num_workers=0,
                drop_last=False)

            Y_pred = clf.predict(X_test)

            measure = None
            if target_measures_type[i] == "regression":
                measure = mean_squared_error(Y_test, Y_pred, squared=False)
            else:
                Y_test_one_hot = tf.keras.utils.to_categorical(Y_test, num_classes=number_of_classes)
                Y_pred_one_hot = tf.keras.utils.to_categorical(Y_pred, num_classes=number_of_classes)
                measure = sklearn.metrics.roc_auc_score(Y_test_one_hot, Y_pred_one_hot)

            single_permutation_df = np.array([measure, *clf.feature_importances_])
            output_values_df = pd.concat([output_values_df, pd.DataFrame(single_permutation_df, index=("Measure", *X.columns)).T])

            output_values_df.to_csv(output_directory + "/Measures-" + model_names[j] + "-" + target_names[i] + ".csv")










