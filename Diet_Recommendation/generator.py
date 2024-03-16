from data import data
from model import recommend,output_recommended_recipes

class Generator:
    def __init__(self,nutrition_input:list,ingredients:list=[],params:dict={'n_neighbors':5,'return_distance':False}):
        self.nutrition_input=nutrition_input
        self.ingredients=ingredients
        self.params=params

    def set_request(self,nutrition_input:list,ingredients:list,params:dict):
        self.nutrition_input=nutrition_input
        self.ingredients=ingredients
        self.params=params

    def generate(self,):
        request={
            'nutrition_input':self.nutrition_input,
            'ingredients':self.ingredients,
            'params':self.params

        }
        recommendation_dataframe=recommend(data,request['nutrition_input'],request['ingredients'],request['params'])
        response=output_recommended_recipes(recommendation_dataframe)
        return response