#!/usr/bin/env bash
# https://github.com/sharkdp/hyperfine

# Get the directory of the script
script_dir=$(dirname "$(readlink -f "$0")")

# Change to the script directory
cd "$script_dir" || exit

# Build single-threaded version
echo "Building single-threaded version..."
crystal build -o pi_st --release pi.cr

# Build multi-threaded version
echo "Building multi-threaded version..."
crystal build -o pi_mt --release -Dpreview_mt pi.cr

# Run benchmarks using hyperfine
hyperfine --warmup 1 \
  "./pi_st -n 1" \
  "./pi_st -n 4" \
  "./pi_mt -n 1" \
  "./pi_mt -n 2" \
  "./pi_mt -n 4" \
  "./pi_mt -n 5" \
  "./pi_mt -n 6"

# Clean up the built executables
rm ./pi_st
rm ./pi_mt
