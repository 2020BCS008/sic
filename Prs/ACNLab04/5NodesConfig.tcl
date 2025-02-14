# NS-2 Simulation Script for 5 Nodes Network

# Create a simulator object
set ns [new Simulator]

# Set up trace files for NAM and text-based output
set tracefile [open out.tr "w"]
$ns trace-all $tracefile
set namfile [open out.nam "w"]
$ns namtrace-all $namfile

# Create 5 nodes (n0, n1, n2, n3, n4)
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

# Create duplex links between the nodes
$ns duplex-link $n0 $n1 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 2Mb 10ms DropTail
$ns duplex-link $n3 $n4 2Mb 10ms DropTail

# Set the queue limits
$ns queue-limit $n0 $n1 50
$ns queue-limit $n1 $n2 50
$ns queue-limit $n2 $n3 50
$ns queue-limit $n3 $n4 50

# Create TCP agent and attach it to n0 (sender)
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

# Create a TCP sink at n4 (receiver)
set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink

# Connect the TCP agent and the sink
$ns connect $tcp $sink

# Create FTP traffic source and attach to TCP agent
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Set the FTP start and stop times
$ns at 0.1 "$ftp start"
$ns at 4.0 "$ftp stop"

# Set up UDP agent at n1 and null agent at n4 for testing
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n4 $null
$ns connect $udp $null

# Create CBR traffic generator for UDP traffic
set cbr [new Application/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 1000
$cbr set interval_ 0.005
$ns at 1.0 "$cbr start"
$ns at 4.5 "$cbr stop"

# Schedule the finish command
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Run the simulation
#$ns at 5.0 "finish"
#$ns run
