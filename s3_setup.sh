#!/usr/bin/env bash
# you need to have aws-cli installed, run aws configure to use the correct profile (e.g. see guida tv in convox dashboard)
YOUR_DOMAIN="premioartecultura"
BUCKET_NAME="${YOUR_DOMAIN}-cdn"
aws s3 mb s3://$BUCKET_NAME
# Create website config
echo "{
    \"IndexDocument\": {
        \"Suffix\": \"index.html\"
    },
    \"ErrorDocument\": {
        \"Key\": \"404.html\"
    },
    \"RoutingRules\": [
        {
            \"Redirect\": {
                \"ReplaceKeyWith\": \"index.html\"
            },
            \"Condition\": {
                \"KeyPrefixEquals\": \"/\"
            }
        }
    ]
}" > s3website.json

echo "{
  \"Version\":\"2012-10-17\",
  \"Statement\":[{
	\"Sid\":\"PublicReadGetObject\",
        \"Effect\":\"Allow\",
	  \"Principal\": \"*\",
      \"Action\":[\"s3:GetObject\"],
      \"Resource\":[\"arn:aws:s3:::$BUCKET_NAME/*\"
      ]
    }
  ]
}
" > bucket_policy.json
aws s3api put-bucket-website --bucket $BUCKET_NAME --website-configuration file://s3website.json
aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file://bucket_policy.json
