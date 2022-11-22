source .env
hugo && rsync -avz --delete public/ ${USER}@${HOSTNAME}:~/blog/public/
