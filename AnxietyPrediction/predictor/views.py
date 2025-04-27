from django.shortcuts import render
from django.http import JsonResponse
from .data import title,fields,categories
import json
from django.views.decorators.csrf import csrf_exempt
import pickle
import pandas as pd
from django.conf import settings
import os


# Create your views here.

def home(request):
    
    return JsonResponse({"title":title,"fields":fields,"categories":categories})

@csrf_exempt
def datavalidation(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        print(data)
        if len(data) == len(fields):
            for key, value in data.items():
                if value in "<select>":
                    print(value)
                    return JsonResponse({"message": "Data Validation Error"})
            predicted = prediction(data)
            print("Prediction:",predicted)
            return JsonResponse({"message": int(predicted[0])})
        else:
            return JsonResponse({"message": "Error Occured, Must select all values"})

def prediction(data):
    Anxietymodel = os.path.join(settings.BASE_DIR,"predictor","savedmodel","AnxietyModel.sav")
    encoder_columns = os.path.join(settings.BASE_DIR,"predictor","savedmodel","encoder_columns.sav")
    SelectedFeatures = os.path.join(settings.BASE_DIR,"predictor","savedmodel","SelectedFeatures.sav")
    model = pickle.load(open(Anxietymodel,"rb"))

    encoder_columns = pickle.load(open(encoder_columns,"rb"))
    
    new_data = pd.DataFrame(columns=fields,data=[[data[fields[0]],data[fields[1]],data[fields[2]],data[fields[3]],data[fields[4]],data[fields[5]],data[fields[6]] ]])
    new_data_encoded = pd.get_dummies(new_data)
    
    for col in encoder_columns:
        if col not in new_data_encoded.columns:
            new_data_encoded[col]=0
 
    new_data_encoded= new_data_encoded[encoder_columns]
    selected_features = pickle.load(open(SelectedFeatures,"rb"))
    return model.predict(new_data_encoded[selected_features])

    

