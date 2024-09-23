import pickle
from sklearn.ensemble import RandomForestRegressor
from sklearn.multioutput import MultiOutputRegressor
import numpy as np

class model:
    
    def load_model(path: str):
        with open(path, 'rb') as file:
            loaded_model = pickle.load(file)
        return loaded_model

    def analyze(loaded_model, X):

        X = X.loc[:, ['delta_engine_rpm', 'delta_engine_load', 'delta_vehicle_speed', 'diff_allowed_speed', 'throttle_pos', 'delta_throttle_pos', 'vehicle_speed', 'engine_rpm', 'engine_load']]

        predictions = loaded_model.predict(X)
        scores = {}

        target_names = ['score_safety', 'score_eco', 'score_wear']
        for i, target_name in enumerate(target_names):
            mean = np.int32(np.mean(predictions[:, i]).round(2) * 100)
            scores[f'{target_name}'] = f'{mean}'

        return scores
        
    