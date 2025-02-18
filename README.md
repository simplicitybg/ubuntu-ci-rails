# Ubuntu-based docker image for Ruby on Rails testing in CI
Docker image to plug in Gitlab CI for testing rails apps

The image is located at https://hub.docker.com/r/simplicity/ubuntu-ci-rails/

## Usage
You can get the image using
    
    docker pull simplicity/ubuntu-ci-rails

Or in your ```.gitlab-ci.yml``` file:

    image: "simplicity/ubuntu-ci-rails:latest"

## Building & Pushing

    docker build -t git.int.simplicity.bg:5050/docker/ubuntu-ci-rails:24.04 .
    docker push git.int.simplicity.bg:5050/docker/ubuntu-ci-rails:24.04

    # In the future
    docker build --platform linux/amd64,linux/arm64 -t simplicity/ubuntu-ci-rails:24.04 -t git.int.simplicity.bg:5050/docker/ubuntu-ci-rails:24.04 .

    # Pushing to docker.io
    docker push simplicity/ubuntu-ci-rails:24.04
