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
* sports (id, name, logo_url, description)
* event_status (id, name(upcoming, live, completed))
* teams (id, sport_id, team_name, logo_url)
* events (id, event_status_id, sport_id, occurs_on, location)
* teams_events(team_id, event_id)
* odds (id, event_id, win (float), draw(float), loss(float))
* bet type (id, name) ( win, lose, draw)
* bet status (id, name) (pending, won, lost)
* bets (id, user_id, event_id, bet_type_id, bet_status_id, bet_amount, odds (float: odds for the bet))
* emails (id, user_id, subject, content)
* users emails (id, user_id, email_id)
* users token (id, user_id, token, context, sent_to)

#### Relationships:

* Users and Bets: One-to-Many relationship. A user can place multiple bets.
* Events and Bets: One-to-Many relationship. An event can have multiple bets placed on it.
* Users and Journals: One-to-Many relationship. A user can have multiple transactions (deposits, withdrawals, winnings, losses).
* Events and Teams: Many-to-Many relationship. An event can have multiple teams, and a team can participate in multiple events.
