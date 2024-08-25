import pickle
from sklearn.ensemble import RandomForestRegressor
from sklearn.multioutput import MultiOutputRegressor
import numpy as np

class model:
    def __init__(self, path: str):
        with open('multi_target_rf_model.pkl', 'rb') as file:
            loaded_model = pickle.load(file)
        return loaded_model
    
    def analyze(mtrf_model, X):
        predictions = mtrf_model.predict(X)

        scores_list = {}

        target_names = ['score_safety', 'score_eco', 'score_wear']
        for i, target_name in enumerate(target_names):
            scores_list[target_name] = f'{np.int32(np.mean(predictions[:, i]).round(3) * 1000)}'
            #print(f'{target_name}: {np.int32(np.mean(predictions[:, i]).round(3) * 1000)}')
        
    