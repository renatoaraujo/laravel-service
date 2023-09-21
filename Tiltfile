## Builds the image
docker_build('laravel-service', '.')

k8s_yaml(
    helm(
        './helm',
        'laravel-service',
    )
)