#!/bin/bash

# This script demonstrates a solution to the race condition bug using a lock file.

count=0
lock_file="counter.lock"

# Function to increment the counter
increment_counter() {
  # Acquire the lock
  flock $lock_file

  local new_count=$((count + 1))
  count=$new_count

  # Release the lock
  flock -u $lock_file
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