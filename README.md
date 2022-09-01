# habituation-app

## setup
cd backend
docker-compose build
docker-compose up -d
docker-compose run api rails db:create

cd ../frontend
npm i
yarn start
