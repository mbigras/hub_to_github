Hub to GitHub

Create a GitHub repository using the hub cli inside a Docker container.

Todo

Generate temporary SSH keys

Build

docker build --tag mbigras/hub .

Usage

read -p 'Email: ' EMAIL

docker run --name lastpass-cli --rm -itd mbigras/lastpass-cli
docker exec -it lastpass-cli lpass login $EMAIL

# todo: generate ssh keys

docker run --name hub --rm -itd -v "$(pwd)":/workdir -v ~/.ssh/id_rsa:/root/.ssh/id_rsa mbigras/hub
docker exec hub sh -c "
cat <<EOL >/root/.config/hub
github.com:
- user: mbigras
  oauth_token: $(docker exec lastpass-cli lpass show --notes gh_repo_token)
EOL
hub create $(pwd | xargs -I {} basename '{}')
"
docker rm -f hub lastpass-cli

Delete a repository

https://developer.github.com/v3/repos/#delete-a-repository

curl \
-s \
-H 'Accept: application/vnd.github.v3+json' \
-H "Authorization: token $(lpass show --notes gh_repo_token)" \
-X DELETE https://api.github.com/repos/mbigras/hub_to_github

Links

https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
https://developer.github.com/v3/repos/#delete-a-repository