#!/bin/bash

# Directory containing the network statistics
STATS_DIR="/sys/class/net/tailscale0/statistics"

# Function to get current received and transmitted bytes
get_network_stats() {
    new_rx_bytes=$(cat "${STATS_DIR}/rx_bytes")
    new_tx_bytes=$(cat "${STATS_DIR}/tx_bytes")
    
    # Calculate the bytes transferred since last check
    rx_diff=$((new_rx_bytes - rx_bytes))
    tx_diff=$((new_tx_bytes - tx_bytes))

    # Convert bytes to bits and then to Mbps (1 byte = 8 bits; 1 Mbps = 1,000,000 bits per second)
    rx_mbps=$(echo "scale=2; $rx_diff * 8 / 1000000 / $interval" | bc)
    tx_mbps=$(echo "scale=2; $tx_diff * 8 / 1000000 / $interval" | bc)

    echo -en "Received: $rx_mbps Mbps \t Transmitted: $tx_mbps Mbps\r"

    # Update previous bytes for next calculation
    rx_bytes=$new_rx_bytes
    tx_bytes=$new_tx_bytes
}

# Initialize previous byte counters
rx_bytes=$(cat "${STATS_DIR}/rx_bytes")
tx_bytes=$(cat "${STATS_DIR}/tx_bytes")

# Interval between checks in seconds
interval=1

# Check if the statistics directory exists
if [ ! -d "$STATS_DIR" ]; then
    echo "Statistics directory not found for tailscale0 interface."
    exit 1
fi

# Display the network usage
echo "Monitoring network usage for tailscale0 interface... Press Ctrl+C to stop."
while true; do
    get_network_stats
    sleep $interval  # Update interval
done
