function start_stream() {
   local type=${1:-orwell}
   local bps=${2:-1}
   local duration=${3:-15}

   curl -X POST "http://localhost:1337/betStream?duration=${duration}&betSchema=${type}&betsPerSecond=${bps}"
}

function stream_orwell() {
   start_stream orwell $@
}

function stream_openbet() {
   start_stream openbetEventsRaw $@
}

function stream_amelco() {
   start_stream amelcoEvents $@
}
