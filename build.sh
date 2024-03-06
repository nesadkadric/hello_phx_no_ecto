#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
#npm install --prefix ./assets
#npm run deploy --prefix ./assets
MIX_ENV=prod mix assets.deploy

#mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite

#_build/prod/rel/hello_phx_no_ecto/bin/hello_phx_no_ecto start