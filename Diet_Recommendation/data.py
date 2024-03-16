import pandas as pd

data=pd.read_csv('dataset.csv', compression='gzip')

dataset=data.copy()
columns=['Name','Calories','FatContent','SaturatedFatContent','CholesterolContent','SodiumContent','CarbohydrateContent','FiberContent','SugarContent','ProteinContent']
dataset=dataset[columns]

extracted_data=dataset.copy()