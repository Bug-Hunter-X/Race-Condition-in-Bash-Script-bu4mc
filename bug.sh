#!/bin/bash

# This script demonstrates a race condition bug.

count=0

# Function to increment the counter
increment_counter() {
  local new_count=$((count + 1))
  count=$new_count
}

# Function to print the counter
print_counter() {
  echo "Counter: $count"
}

# Create two child processes that increment the counter concurrently
increment_counter &
increment_counter &

# Wait for the child processes to finish
wait

# Print the final counter value
print_counter