set -e # Fail fast
YOUR_DOMAIN="premioartecultura"
BUCKET_NAME="${YOUR_DOMAIN}-cdn"
# Build a fresh copy
hugo -v 
# Copy over pages
aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$BUCKET_NAME
