#!/bin/bash
set -e

cd /home/lazarmarkov/blog

source ~/.bashrc
git pull origin main
bundle install
bundle exec rails db:migrate
systemctl --user restart blog

echo "Deployment completed successfully at $(date)"
