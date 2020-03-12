function start_stream() {
   local type=${1:-orwell}
   local bps=${2:-1}
   local duration=${3:-15}

   curl -X POST "http://localhost:1337/betStream?duration=${duration}&betSchema=${type}&betsPerSecond=${bps}"
}

function orwell_stream() {
   start_stream orwell $@
}

function openbet_stream() {
   start_stream openbetEventsRaw $@
}

function amelco_stream() {
   start_stream amelcoEvents $@
}
