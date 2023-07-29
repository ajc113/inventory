web: bundle exec puma -C config/puma.rb
release: bin/rails db:prepare
worker: $RAILS_ENV bin/delayed_job start
