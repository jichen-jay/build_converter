
podman build -f Dockerfile.w_uv -t convert


podman run --rm -it -v "$PWD:/data" -w /app localhost/convert:latest /app/convert.py /data/gov.pdf
