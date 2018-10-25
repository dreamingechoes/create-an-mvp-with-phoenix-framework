# Nevenote

![Nevernote](./assets/static/images/nevernote.png)

## About

Application to create blocknotes with your ideas. A revolutionary application never done before :joy:

![Nevernote](./assets/static/images/app.png)

## Setup

To start to use this application, install the following dependencies natively or with [asdf](https://github.com/asdf-vm/asdf):

* [Erlang](http://erlang.org/doc/installation_guide/INSTALL.html)
* [Elixir](https://elixir-lang.org/install.html)
* [Phoenix](https://hexdocs.pm/phoenix/installation.html)
* [Node.js](https://nodejs.org/en/download/)
* [PostgreSQL](https://www.postgresql.org/docs/9.3/static/tutorial-install.html)

This application uses `Elixir v1.7.3` and `Phoenix Framework v1.3.4`. Once all is installed, just execute these instructions:

* Install dependencies with `mix deps.get`.
* Create your database with `mix ecto.setup`.
* Install Node.js dependencies with `cd assets && npm install`.
* Start the application with `mix phx.server`.

## Setup development environment with Docker

This project is Docker friendly from day one. To start working on it:

* Setup the web container with `docker-compose build web`.
* Install dependencies with `docker-compose run web mix deps.get`.
* Create your database with `docker-compose run web mix ecto.setup`.
* Install Node.js dependencies with `docker-compose run web bash -c "cd assets; npm install"`.
* Start the application with `docker-compose up`.

## Setup testing environment with Docker

This step assumes you already followed instructions from previous paragraph.

* Create your testing database with `docker-compose run web env MIX_ENV=test mix ecto.create`.
* Migrate your testing database with `docker-compose run web env MIX_ENV=test mix ecto.migrate`.
* Run the test suite with `docker-compose run web env MIX_ENV=test mix test`.
* Run the test suite with coverage report on `cover` folder with: `docker-compose run web env MIX_ENV=test mix coveralls.html`.

----------------------------

This project was developed by [dreamingechoes](https://github.com/dreamingechoes).
It adheres to its [code of conduct](https://github.com/dreamingechoes/base/blob/master/files/CODE_OF_CONDUCT.md) and
[contributing guidelines](https://github.com/dreamingechoes/base/blob/master/files/CONTRIBUTING.md), and uses an equivalent [license](https://github.com/dreamingechoes/base/blob/master/files/LICENSE).
