from pyproj import Transformer
import pandas as pd
import numpy as np

base_directory = "../Data/ukbiobank/"

data = pd.read_csv(base_directory + "ukb50844_imaging_only_Brian.csv")
number_of_subjects = data.shape[0]
longitude = np.zeros(number_of_subjects)
latitude = np.zeros(number_of_subjects)

transformer = Transformer.from_crs("epsg:27700", "epsg:4326")

for i in range( data.shape[0]):

     east = data['f.20074.2.0'][i]
     north = data['f.20075.2.0'][i]

     if pd.isna(east) or pd.isna(north):
         latitude[i], longitude[i] = (None, None)
     else:
         latitude[i], longitude[i] = transformer.transform(east, north)

     print(east, ",", north, "-->", latitude[i], ",", longitude[i], "(", i, "out of", number_of_subjects, ")")

     if i > 10:
         continue

column_index = data.columns.get_loc('f.20075.2.0')
data.insert(column_index+1, "Latitude", latitude)
data.insert(column_index+2, "Longitude", longitude)

data.to_csv(base_directory + "ukb50844_imaging_only_Brian_test.csv", index=False)
