#!/usr/bin/env bash
source /usr/bin/lib.sh

for i in \
    PLUGIN_ACCESS_KEY,AWS_ACCESS_KEY_ID="" \
    PLUGIN_SECRET_KEY,AWS_SECRET_ACCESS_KEY="" \
    PLUGIN_REGION,AWS_DEFAULT_REGION=us-east-1 \
    PLUGIN_BUCKET,AWS_S3_TARGET_BUCKET="" \
    PLUGIN_FOLDER,AWS_S3_SOURCE_FOLDER="./" \
    PLUGIN_ACL,AWS_S3_ACL=public-read \
    PLUGIN_CLOUDFRONT_ID,AWS_CLOUDFRONT_DISTRIBUTION_ID="none" \
    PLUGIN_CLOUDFRONT_PATHS,AWS_CLOUDFRONT_PATHS="/*" \

do
    defaultEnv "${i}"
done

export DEPLOY_CMD=""

for i in $(searchEnv.values PLUGIN_ INCLUDE)
do
    export DEPLOY_CMD="${DEPLOY_CMD} --include ${i}"
done

for i in $(searchEnv.values PLUGIN_ EXCLUDE)
do
    export DEPLOY_CMD="${DEPLOY_CMD} --exclude ${i}"
done

aws s3 sync \
    "${AWS_S3_SOURCE_FOLDER}" s3://"${AWS_S3_TARGET_BUCKET}" \
    --no-progress --acl "${AWS_S3_ACL}" \
    ${DEPLOY_CMD}

if [[ "${AWS_CLOUDFRONT_DISTRIBUTION_ID}" != "none" ]]
then
    aws cloudfront create-invalidation \
        --distribution-id "${AWS_CLOUDFRONT_DISTRIBUTION_ID}" \
        --paths "${AWS_CLOUDFRONT_PATHS}"
fi