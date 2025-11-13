#!/bin/bash
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
exec /home/lazarmarkov/blog/bin/rails server
