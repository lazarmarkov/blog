#!/bin/bash
set -e

cd /home/lazarmarkov/blog
git pull origin main

# Debug rbenv setup
echo "=== Checking rbenv setup ==="
echo "PATH before: $PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
echo "PATH after: $PATH"
echo "rbenv location: $(which rbenv || echo 'rbenv not found')"

# Try to initialize rbenv
if [ -d "$HOME/.rbenv" ]; then
    echo "rbenv directory exists"
    eval "$(rbenv init - bash)"
    echo "rbenv initialized"
else
    echo "ERROR: rbenv directory not found!"
fi

echo "Ruby version: $(ruby -v 2>&1 || echo 'ruby not found')"
echo "Bundle location: $(which bundle 2>&1 || echo 'bundle not found')"
echo "=== End debug ==="

bundle install
bundle exec rails db:migrate
systemctl --user restart blog

echo "Deployment completed successfully at $(date)"
