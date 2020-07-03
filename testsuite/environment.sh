function start_stream() {
   local type=${1:-orwell}
   local env=${2:-local}
   local bps=${3:-1}
   local duration=${4:-15}

   case $env in
       test) 
           echo "Ensure you're auth'd into the cluster and are port forwarding 1337"
           local testsuite_endpoint="http://localhost:1337/api/v1/namespaces/grm-adaptor-test/services/testsuite:1337/proxy/betStream"
           ;;
       stage)
           echo "Ensure you're auth'd into the cluster and are port forwarding 1337"
           local testsuite_endpoint="http://localhost:1337/api/v1/namespaces/grm-adaptor-stage/services/testsuite:1337/proxy/betStream"
           ;;
       *)
           local testsuite_endpoint="http://localhost:1337/betStream"
   esac

   echo "Posting to env: $env"
   curl -X POST "${testsuite_endpoint}?duration=${duration}&betSchema=${type}&betsPerSecond=${bps}"
   echo "" # Adds missing newline from above
}

function port_forward_testsuite() {
    kubectl proxy --port 1337
}

function stream_orwell() {
     OPTIND=1

    local options=":st"

    while getopts $options opt; do
        case $opt in
            s)
                local env=stage
                ;;
            t)
                local env=test
                ;;
            \?)
                echo "Unknown param - $options"
                return 2
                ;;
        esac
    done

    shift $((OPTIND - 1))

    start_stream orwell ${env:-local} $@
}

function stream_gsa() {
     OPTIND=1

    local options=":st"

    while getopts $options opt; do
        case $opt in
            s)
                local env=stage
                ;;
            t)
                local env=test
                ;;
            \?)
                echo "Unknown param - $options"
                return 2
                ;;
        esac
    done

    shift $((OPTIND - 1))

    start_stream gstpEventsRaw ${env:-local} $@
}

function stream_openbet() {
     OPTIND=1

    local options=":st"

    while getopts $options opt; do
        case $opt in
            s)
                local env=stage
                ;;
            t)
                local env=test
                ;;
            \?)
                echo "Unknown param - $options"
                return 2
                ;;
        esac
    done

    shift $((OPTIND - 1))

    start_stream openbetEventsRaw ${env:-local} $@
}

function stream_amelco() {
     OPTIND=1

    local options=":st"

    while getopts $options opt; do
        case $opt in
            s)
                local env=stage
                ;;
            t)
                local env=test
                ;;
            \?)
                echo "Unknown param - $options"
                return 2
                ;;
        esac
    done

    shift $((OPTIND - 1))

    start_stream amelcoEvents ${env:-local} $@
}
