import datetime
import os
import subprocess
import sys
from google.cloud import storage
import pandas as pd
from sklearn import svm
from sklearn.externals import joblib

# Storage settings
BUCKET_NAME = '<YOUR_BUCKET_NAME>'
FILENAME = 'data.csv'
bucket = storage.Client().bucket(BUCKET_NAME)

# Path to the data inside the public bucket
blob = bucket.blob('data/{}'.format(FILENAME))

# Download the data
blob.download_to_filename(FILENAME)

# Read CSV File
iris_data = pd.read_csv(FILENAME)

# Get Labels
iris_label = iris_data.pop('species')

# Create the classifier
classifier = svm.SVC(gamma='auto')
classifier.fit(iris_data, iris_label)

# Export the model to a file
model_filename = 'model.joblib'
joblib.dump(classifier, model_filename)

# Upload the model to GCS
bucket = storage.Client().bucket(BUCKET_NAME)
blob = bucket.blob('{}/{}'.format(
    datetime.datetime.now().strftime('model_%Y%m%d_%H%M%S'),
    model_filename))
blob.upload_from_filename(model_filename)
