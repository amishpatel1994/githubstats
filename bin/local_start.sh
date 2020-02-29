#! /usr/bin/env bash

CURRENT_PWD=`pwd`
BASEDIR=`dirname $0`/..
BASEDIR="`cd "${BASEDIR}";pwd`"

export $(grep -v '^#' config/localhost.env | xargs )

mix deps.get && iex -S mix phx.server
