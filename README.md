shortly
=======

URL shortener service

## Endpoints

### POST /

Create a short version for the URL posted in. Returns with 200 if successful.

Params:
```
  url='example.com/somepage.html'
```

### GET /:hash

Get the redirect for the URL behind the hash with 303.

### GET /admin/stats

An endpoint that returns the total accesses of the service endpoints, i.e. how many times users asked to either shorten or expand a URL across all instances that the service may concurrently run.

### GET /admin/stats/:domain

The other endpoint gets a domain name as input and returns how many URLs we maintain for this domain.
For example example.com, www.example.com and developers.example.com are considered to be in the same domain and counted together. The returned result is not required to be completely accurate.
