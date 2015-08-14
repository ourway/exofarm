#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
            SOURCE="$(readlink "$SOURCE")"
              [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
export FLIPFARM_ROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
alias flipfarm="cd $FLIPFARM_ROOT;source .pyenv/bin/activate"
alias "flipfarm-server"="flipfarm;gunicorn -b 0.0.0.0:9000 -k gevent -w 4 --worker-connections 1600 --threads 2 --max-requests 40960 -t 15 -n flipfarm-server -p server.pid app:app --reload"
alias "flipfarm-worker"="flipfarm;python clientAgent.py"
alias "flipfarm-pinger"="flipfarm;python pingAgent.py"
export PATH=$FLIPFARM_ROOT/.pyenv/bin:$PATH
#--access-logfile logs/client.log
# -f logs/clientAgent.log
