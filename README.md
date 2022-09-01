# habituation-app

## setup
cd backend
docker-compose build
docker-compose up -d
docker-compose run api rails db:create
docker-compose run api rails db:migrate RAILS_ENV=development

cd ../frontend
npm i
yarn start

### test

docker-compose run api rails db:migrate RAILS_ENV=test
docker-compose run api bundle exec rake spec

