# shellcheck disable=SC2034
# shellcheck disable=SC2164
cd /d/ActiveMQ/classic/bin
#!/bin/bash

# Define the keywords to search for in the process details
SEARCH_KEYWORDS=("c/Program Files/Java/jdk-20/bin/java")

# Find the PID of the Java process that matches the keywords
# shellcheck disable=SC2009
PID=$(ps -e pid,command | grep -E "$(IFS="|"; echo "${SEARCH_KEYWORDS[*]}")" | grep -v grep | awk '{print $1}')

if [ -n "$PID" ]; then
    echo "Found Java process with PID: $PID"
    # Check if the process exists
    if ps -p "$PID" > /dev/null; then
        echo "Killing Java process with PID $PID..."
        kill -SIGTERM $PID
        sleep 5 # Allow some time for the process to terminate gracefully
        if ps -p "$PID" > /dev/null; then
            echo "Java process with PID $PID did not stop gracefully, forcibly terminating..."
            kill -SIGKILL $PID
        else
            echo "Java process with PID $PID has been stopped."
        fi
    else
        echo "Java process with PID $PID not found."
    fi
else
    echo "No Java process matching the keywords found."
fi
sleep 5