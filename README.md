# LiveBetting

To run database

* Run `docker network create value8-network`
* Run `docker volume create mysql_data`
* Run `docker-compose up -d` to start mysql
* Run `docker exec -it mysql8 mysql -uroot -p` to login
* Run `UPDATE mysql.user SET host='%' WHERE user='root' AND host='localhost';`
* Run `FLUSH PRIVILEGES;`
* Run `exit;`
* Run `docker restart mysql8`

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4001`](http://localhost:4000) from your browser.

