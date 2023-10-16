#!/bin/bash

# Define the path to your ActiveMQ installation directory
ACTIVEMQ_PATH="/d/ActiveMQ/classic"

# Define the keywords to search for in the process details
SEARCH_KEYWORDS="/Program Files/Java/jdk-20/bin/java"

# shellcheck disable=SC2009
if ps -e command | grep "$SEARCH_KEYWORDS" | grep -v grep > /dev/null; then
    # ActiveMQ is already running
    # shellcheck disable=SC2009
    PID=$(ps -e pid,command | grep "$SEARCH_KEYWORDS" | grep -v grep | awk '{print $1}')
    echo "ActiveMQ is already running with PID: $PID"
else
    # ActiveMQ is not running, start it
    # shellcheck disable=SC2164
    cd "$ACTIVEMQ_PATH/bin"
    ./activemq start

    # Wait for ActiveMQ to start (adjust the sleep duration if needed)
    sleep 5

    # Check if ActiveMQ started successfully
    if ps -e command | grep "$SEARCH_KEYWORDS" | grep -v grep > /dev/null; then
        PID=$(ps -e pid,command | grep "$SEARCH_KEYWORDS" | grep -v grep | awk '{print $1}')
        echo "ActiveMQ started with PID: $PID"
    else
        echo "Failed to start ActiveMQ."
    fi
fi
sleep 5