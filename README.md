# Detroit Tigers API

[![Build Status](https://travis-ci.org/macklinu/detroit-tigers-api.svg?branch=master)](https://travis-ci.org/macklinu/detroit-tigers-api)

This is an MVP of scraping detroit.tigers.mlb.com and turning the Detroit Tigers schedule into a REST API. :baseball:

Right now, there is one endpoint to return the next 7 days worth of games, but ideas/feature requests are welcome - please open an [issue](https://github.com/macklinu/detroit-tigers-api/issues)!

## Endpoints

### `/v1/games/upcoming`

Returns an array of games from the current date until the following week (e.g. Sunday to Saturday). Games are sorted by `date`, from present to future.

#### Values

* `date` - the `MMMM-YY-DD` date of the game.
* `time` - the ISO-8601 UTC date string representing the start time of the game. May be `null` if a game does not have a start time (some games are TBD throughout the season).
* `opponent` - the opposing team. Starts with "at" when the Tigers are the away team.

#### Example

```json
[
  {
    "date": "2017-04-09",
    "time": "2000-01-01T17:10:00.000Z",
    "opponent": "Red Sox"
  },
  {
    "date": "2017-04-10",
    "time": "2000-01-01T17:10:00.000Z",
    "opponent": "Red Sox"
  },
  {
    "date": "2017-04-11",
    "time": "2000-01-01T17:10:00.000Z",
    "opponent": "Twins"
  },
  {
    "date": "2017-04-12",
    "time": "2000-01-01T17:10:00.000Z",
    "opponent": "Twins"
  },
  {
    "date": "2017-04-13",
    "time": "2000-01-01T17:10:00.000Z",
    "opponent": "Twins"
  },
  {
    "date": "2017-04-14",
    "time": "2000-01-01T23:10:00.000Z",
    "opponent": "at Indians"
  },
  {
    "date": "2017-04-15",
    "time": "2000-01-01T20:10:00.000Z",
    "opponent": "at Indians"
  }
]
```

## Development

### Serve API locally

```sh
$ bundle exec rackup
```

This serves the API on port 9292 by default and uses `config.ru` as the default config. This is the same command used by Heroku to serve the API, so this provides some dev/prod parity when testing locally.

### Run tests

```sh
$ bundle exec rspec
```

You can also use Guard to watch and run tests and Rubocop locally when files change:

```sh
$ bundle exec guard
```

### Meta

Install [Overcommit](https://github.com/brigade/overcommit#installation) for pre- and post-commit hooks. See `.overcommit.yml` for more information.
