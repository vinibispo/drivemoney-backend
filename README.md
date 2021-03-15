# DrivemoneyBackend

---
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)
[![Heroku](https://heroku-badge.herokuapp.com/?app=drivemoney-backend&root=/api/v1/accounts)](https://drivemoney-backend.herokuapp.com/api/v1/accounts)
[![Code Climate](https://badgen.net/codeclimate/maintainability/vinibispo/drivemoney-backend)](https://badgen.net/codeclimate/maintainability/vinibispo/drivemoney-backend)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

---

* Ruby version
  
  2.7.2

* Configuration

   ```bash
    docker-compose up -d
    ```

* Database creation

  ```bash
  docker-compose exec web rails db:create
  ```

* Database initialization

  ```bash
  docker-compose exec web rails db:migrate
  ```

* How to run the test suite

  ```bash
  docker-compose exec -e "RAILS_ENV=test" web bundle exec rspec
  ```
