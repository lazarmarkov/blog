# Clean up your deploy.sh back to simple version:
#!/bin/bash
set -e

cd /home/lazarmarkov/blog
git pull origin main

# Initialize rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

bundle install
bundle exec rails db:migrate
systemctl --user restart blog

echo "Deployment completed successfully at $(date)"
