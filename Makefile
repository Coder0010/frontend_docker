# Please make sure that you have all needed variables at .env.docker
destroy:
	clear
	docker-compose down --rmi all --volumes --remove-orphans
build:
	clear
	docker-compose up -d --build
	docker-compose exec node sh -c 'yarn install'

rebuild-container:
	clear
	@make destroy
	@make build

node-bash:
	clear
	docker-compose exec node sh

yarn-build:
	clear
	docker-compose exec node sh -c 'yarn build-laravel && nginx -t'
	sudo chmod -R 777 dist/

yarn-serve:
	clear
	docker-compose exec node sh -c 'yarn serve-laravel'
