if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    source ~/bash/.bashrc_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    source ~/bash/.bashrc_macos
else
    raise error "Unknown OS $OSTYPE"
fi
