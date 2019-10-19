## drone-s3-deploy

[![](https://images.microbadger.com/badges/image/kudato/drone-s3-deploy.svg)](https://microbadger.com/images/kudato/drone-s3-deploy "Get information about this image.")

This [Drone](https://drone.io/) plugin is just a wrapper for [awscli](https://aws.amazon.com/en/cli/).

### Usage

```yaml
...
- name: Deploy
  image: kudato/drone-s3-deploy
  settings:
    region: us-east-1
    bucket: your s3 bucket name
    folder: local folder to sync
    acl: private/public-read/..
    exlude: /*.map
    include: 
    cloudfront_id: your cloudfront distribution id
    cloudfront_paths: /*
    access_key:
      from_secret: aws_access_key_id
    secret_key:
      from_secret: aws_secret_access_key
...

```