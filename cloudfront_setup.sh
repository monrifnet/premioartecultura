#!/usr/bin/env bash
# you need to have aws-cli installed, run aws configure to use the correct profile (the uploader profile found in convox dashboard has no rights over distributions)
YOUR_DOMAIN="premioartecultura.it"
BUCKET_NAME="premioartecultura-cdn"
REGION="eu-west-1"
CALLER_REF="`date +%s`" # current second
echo "{
    \"Comment\": \"$BUCKET_NAME Static Hosting\", 
    \"Origins\": {
        \"Quantity\": 1,
        \"Items\": [
            {
                \"Id\":\"$BUCKET_NAME-origin\",
                \"OriginPath\": \"\", 
                \"CustomOriginConfig\": {
                    \"OriginProtocolPolicy\": \"http-only\", 
                    \"HTTPPort\": 80, 
                    \"OriginSslProtocols\": {
                        \"Quantity\": 3,
                        \"Items\": [
                            \"TLSv1\", 
                            \"TLSv1.1\", 
                            \"TLSv1.2\"
                        ]
                    }, 
                    \"HTTPSPort\": 443
                }, 
                \"DomainName\": \"$BUCKET_NAME.s3-website-$REGION.amazonaws.com\"
            }
        ]
    }, 
    \"DefaultRootObject\": \"index.html\", 
    \"PriceClass\": \"PriceClass_All\", 
    \"Enabled\": true, 
    \"CallerReference\": \"$CALLER_REF\",
    \"DefaultCacheBehavior\": {
        \"ViewerProtocolPolicy\": \"allow-all\",
        \"TargetOriginId\": \"$BUCKET_NAME-origin\",
        \"DefaultTTL\": 1800,
        \"AllowedMethods\": {
            \"Quantity\": 2,
            \"Items\": [
                \"HEAD\", 
                \"GET\"
            ], 
            \"CachedMethods\": {
                \"Quantity\": 2,
                \"Items\": [
                    \"HEAD\", 
                    \"GET\"
                ]
            }
        }, 
        \"MinTTL\": 0, 
        \"Compress\": true,
        \"ForwardedValues\": {
            \"Headers\": {
                \"Quantity\": 0
            }, 
            \"Cookies\": {
                \"Forward\": \"none\"
            }, 
            \"QueryString\": false
        },
        \"TrustedSigners\": {
            \"Enabled\": false, 
            \"Quantity\": 0
        }
    }, 
    \"CustomErrorResponses\": {
        \"Quantity\": 2,
        \"Items\": [
            {
                \"ErrorCode\": 403, 
                \"ResponsePagePath\": \"/404.html\", 
                \"ResponseCode\": \"404\",
                \"ErrorCachingMinTTL\": 300
            }, 
            {
                \"ErrorCode\": 404, 
                \"ResponsePagePath\": \"/404.html\", 
                \"ResponseCode\": \"404\",
                \"ErrorCachingMinTTL\": 300
            }
        ]
    }, 
    \"Aliases\": {
        \"Quantity\": 2,
        \"Items\": [
            \"$YOUR_DOMAIN\", 
            \"www.$YOUR_DOMAIN\"
        ]
    }
}" > distroConfig.json

aws cloudfront create-distribution --distribution-config file://distroConfig.json
