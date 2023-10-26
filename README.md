# LiveBetting

To run database

* Run `docker network create value8-network`
* Run `docker-compose up -d`

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4001`](http://localhost:4000) from your browser.

### Tables & schemas

* journal (id, user_id, particulars, debit, credit) = [deposit, withdrawal, winning, losing]
* users (id, username, msisdn, email, password_hash)
* events (id, sport, event_date_time, location, status(upcoming, live, completed))
* bets (id, user_id, event_id, bet_amount, bet_type ( win, lose, draw), odds (float: odds for the bet), status(pending, won, lost))
* teams (id, team_name, sport, logo_url)
* teams_events(team_id, event_id)
* notifications (id, user_id, subject, content)

#### Relationships:

* Users and Bets: One-to-Many relationship. A user can place multiple bets.
* Events and Bets: One-to-Many relationship. An event can have multiple bets placed on it.
* Users and Journals: One-to-Many relationship. A user can have multiple transactions (deposits, withdrawals, winnings, losses).
* Events and Teams: Many-to-Many relationship. An event can have multiple teams, and a team can participate in multiple events.
