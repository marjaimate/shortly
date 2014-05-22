shortly
=======

URL shortener service

## Setup

* [Install Redis](http://redis.io/download)
* Start redis - see the same page as above
* clone the repo
* Verify redis.yml config for connection details
* `$ bundle install`
* `$ rackup`

## Endpoints

### PUT /

Create a short version for the URL posted in. Returns with 200 if successful.

Params: `url='example.com/somepage.html'`

Example CURL request:
```bash
curl -X PUT --data-urlencode "url=example.com" 0.0.0.0:9292
```

Returns: `https://localhost:9292/S0m3H4sh`

### GET /:hash

Get the redirect for the URL behind the hash with 303.

Example CURL request:
```bash
curl -X GET 0.0.0.0:9292/50m3H4sh
```

Returns with 303 header redirect to found URL

### GET /admin/stats

An endpoint that returns the total accesses of the service endpoints, i.e. how many times users asked to either shorten or expand a URL across all instances that the service may concurrently run.

Example CURL request:
```bash
curl -X GET 0.0.0.0:9292/admin/stats
```

Returns: `{"get": "12", "put": "1234"}`

### GET /admin/stats/:domain

The other endpoint gets a domain name as input and returns how many URLs we maintain for this domain.
For example example.com, www.example.com and developers.example.com are considered to be in the same domain and counted together. The returned result is not required to be completely accurate.

Example CURL request:
```bash
curl -X GET 0.0.0.0:9292/admin/stats/example.com
```

Returns: `9`

## Scalability

For scalability I would run Redis as a separate instance all Ruby clients connecting to it via IP:PORT. In that case you'd get consistent data for your admin and hit counters in the store.
