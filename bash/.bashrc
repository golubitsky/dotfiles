if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source ./.bashrc_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source ./.bashrc_mac
else
  raise error "Unknown OS $OSTYPE"
fi
