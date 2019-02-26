test:
	DYNAMODB_ENDPOINT=http://localhost:8000 USER_TABLE=stns-test-users GROUP_TABLE=stns-test-groups \
  bundle exec rspec
rspec: test
spec: test

install:
	bundle install --path vendor --no-deployment --with "test"
