#!/bin/bash
set -e

if [ -z "$EDITOR" ]; then
  echo "set \$EDITOR or run the command with EDITOR=vim run_tests.sh"
  exit 1
fi

if [ -z "$PLUGINS_PATH" ]; then
  PLUGINS_PATH=/tmp/autopairs_test
  if [ ! -d "$PLUGINS_PATH" ]; then
    echo "\$PLUGINS_PATH not supplied, saving to /tmp/autopairs_test..."
    mkdir $PLUGINS_PATH
    git clone https://github.com/junegunn/vader.vim "$PLUGINS_PATH"/vader
    git clone https://github.com/plasticboy/vim-markdown "$PLUGINS_PATH"/vim-markdown
  fi
fi

echo "filetype off" > /tmp/autopairs_test_vimrc
echo "set rtp+=." >> /tmp/autopairs_test_vimrc
echo "set rtp+=$PLUGINS_PATH/vader" >> /tmp/autopairs_test_vimrc
echo "set rtp+=$PLUGINS_PATH/vim-markdown" >> /tmp/autopairs_test_vimrc
echo "set rtp+=$PLUGINS_PATH/vim-markdown/after" >> /tmp/autopairs_test_vimrc
echo "filetype plugin indent on" >> /tmp/autopairs_test_vimrc
echo "syntax enable" >> /tmp/autopairs_test_vimrc

"$EDITOR" -Nu /tmp/autopairs_test_vimrc -c 'Vader test/*'
