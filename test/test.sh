#!/bin/bash

# PUT
curl -X PUT --data-urlencode "url=example.com" 0.0.0.0:9292

# GET
curl -X GET 0.0.0.0:9292/50m3H4sh

# Admin stats
curl -X GET 0.0.0.0:9292/admin/stats/example.com
curl -X GET 0.0.0.0:9292/admin/stats/
