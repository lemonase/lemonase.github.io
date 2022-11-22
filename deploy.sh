if [ -f "./.env" ]; then
  . ./.env
else
  echo "Please create a .env file with a HUGO_USER, HUGO_HOSTNAME, and HUGO_OUTPUT_DIR variable"
  exit
fi

if ! [ -x "$(command -v hugo)" ]; then
  echo "Please install hugo and rerun script"
  exit
fi

if ! [ -x "$(command -v rsync)" ]; then
  echo "Please install rsync and rerun script"
  exit
fi

echo Building and pushing to: ${HUGO_USER}@${HUGO_HOSTNAME}:${HUGO_OUTPUT_DIR}
hugo && rsync -avz --delete public/ ${HUGO_USER}@${HUGO_HOSTNAME}:${HUGO_OUTPUT_DIR}
