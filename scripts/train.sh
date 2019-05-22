# Create a training application package
mkdir iris_training
touch iris_training/__init__.py

# Set Environment Variables
PROJECT_ID='<YOUR_PROJECT_ID>'
BUCKET_NAME=demo-iris
JOB_NAME=iris_training_$(date +"%Y%m%d_%H%M%S")
JOB_DIR=gs://$BUCKET_NAME/scikit_learn_job_dir
TRAINING_PACKAGE_PATH="./iris_training/"
MAIN_TRAINER_MODULE=iris_training.train
REGION=us-central1
RUNTIME_VERSION=1.13
PYTHON_VERSION=3.5
SCALE_TIER=BASIC

# Submit a training job
gcloud ai-platform jobs submit training $JOB_NAME \
  --job-dir $JOB_DIR \
  --package-path $TRAINING_PACKAGE_PATH \
  --module-name $MAIN_TRAINER_MODULE \
  --region $REGION \
  --runtime-version=$RUNTIME_VERSION \
  --python-version=$PYTHON_VERSION \
  --scale-tier $SCALE_TIER

# Viewing your training logs (optional)
gcloud ai-platform jobs stream-logs $JOB_NAME