# build
docker build -t ghcr.io/kmasiello/renv-session-library:2023-06-09 .

echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin

# push to ghcr.io
docker push ghcr.io/kmasiello/renv-session-library:2023-06-09 





