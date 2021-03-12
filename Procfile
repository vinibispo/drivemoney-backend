worker: bundle exec sidekiq -q default -q mailers -c 2
payment_worker: bundle exec sidekiq -q payment -c 1
release: rake db:migrate
