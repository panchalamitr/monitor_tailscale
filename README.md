# Tailscale Network Traffic Monitor

This Bash script monitors network traffic on the `tailscale0` interface, calculating and displaying the received and transmitted data in Mbps (Megabits per second). It provides a continuous, real-time view of network usage, updating every second.

## Features

- Monitors network traffic statistics for the `tailscale0` interface.
- Displays real-time network usage in Mbps.
- Updates the display every second.

## Prerequisites

Before running this script, ensure that:
- You have `bc` installed on your system for arithmetic calculations. Install it using:
  ```bash
  sudo apt-get install bc

## Usage
Save the script to a file, for example network_monitor.sh.
Make the script executable:

`chmod +x network_excelpttitor.sh`

Run the script:

`./network_monitor.sh`
