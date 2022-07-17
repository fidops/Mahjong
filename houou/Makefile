setup: .env bundle pg dbdev dbtest

.env:
	cp .env.sample .env

.PHONY: pg
pg:
	if [ -z "`docker ps | grep pg-houou`" ] ; then \
	docker run --rm -d \
	--name pg-houou \
	-v `pwd`/tmp/pgdata:/var/lib/postgresql/data \
	-p 5432:5432 \
	--env-file .env \
	postgres:latest; fi

.PHONY: wait-for-db
wait-for-db:
	./scripts/wait-for-it.sh localhost:5432 -- echo "db ready"

.PHONY: bundle
bundle:
	bundle install

.PHONY: dbdev
dbdev:
	bundle exec rails db:reset

.PHONY: dbtest
dbtest:
	RAILS_ENV=test bundle exec rails db:reset

.PHONY: up
up: pg
	bundle exec rails s

.PHONY: down
down:
	docker stop pg-houou

.PHONY: test
test:
	RAILS_ENV=test bundle exec rspec
