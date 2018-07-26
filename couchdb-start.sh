#!/bin/bash

docker run --rm -p 5984:5984 -v $(pwd)/data:/opt/couchdb/data apache/couchdb

# Admin interface:
# http://127.0.0.1:5984/_utils/index.html

# EOF
