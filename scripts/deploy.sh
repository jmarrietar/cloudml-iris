# Deploy models and versions 
gcloud ai-platform models create "iris"

# Set Environment Variables
MODEL_DIR="gs://<YOUR_BUCKET_NAME>/model" 
VERSION_NAME="v1"
MODEL_NAME="iris"
FRAMEWORK="SCIKIT_LEARN"

# Create a version 
gcloud ai-platform versions create $VERSION_NAME \
  --model $MODEL_NAME \
  --origin $MODEL_DIR \
  --runtime-version=1.13 \
  --framework $FRAMEWORK \
  --python-version=3.5

# Get information about your new version
gcloud ai-platform versions describe $VERSION_NAME \
  --model $MODEL_NAME

# Token 
access_token=$(gcloud auth application-default print-access-token)
