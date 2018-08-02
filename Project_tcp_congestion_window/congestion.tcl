set ns [new Simulator]   
set f [ open congestion.tr w ]
$ns trace-all $f 
set nf [ open congestion.nam w ]
$ns namtrace-all $nf    

$ns color 1 Red
$ns color 2 Blue
$ns color 3 White
$ns color 4 Green

#to create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# to create the link between the nodes with bandwidth, delay and queue
$ns duplex-link $n0 $n2   2Mb  10ms DropTail
$ns duplex-link $n1 $n2   2Mb  10ms DropTail
$ns duplex-link $n2 $n3 0.3Mb 200ms DropTail
$ns duplex-link $n3 $n4 0.5Mb  40ms DropTail
$ns duplex-link $n3 $n5 0.5Mb  30ms DropTail

# Sending node with agent as Reno Agent
set tcp1 [new Agent/TCP/Reno]
$ns attach-agent $n0 $tcp1
set tcp2 [new Agent/TCP/Reno]
$ns attach-agent $n1 $tcp2
set tcp3 [new Agent/TCP/Reno]
$ns attach-agent $n2 $tcp3
set tcp4 [new Agent/TCP/Reno]
$ns attach-agent $n1 $tcp4

$tcp1 set fid_ 1
$tcp2 set fid_ 2
$tcp3 set fid_ 3
$tcp4 set fid_ 4

# receiving (sink) node
set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
set sink2 [new Agent/TCPSink]
$ns attach-agent $n5 $sink2
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
set sink4 [new Agent/TCPSink]
$ns attach-agent $n4 $sink4

# establish the traffic between the source and sink
$ns connect $tcp1 $sink1
$ns connect $tcp2 $sink2
$ns connect $tcp3 $sink3
$ns connect $tcp4 $sink4

# Setup a FTP traffic generator on "tcp"
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP 

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set type_ FTP

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ftp4 set type_ FTP                


# RTT Calculation Using Ping ------------------------------------------------

set p0 [new Agent/Ping]
$ns attach-agent $n0 $p0
set p1 [new Agent/Ping]
$ns attach-agent $n4 $p1

#Connect the two agents
$ns connect $p0 $p1

# Method call from ping.cc file
Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "node [$node_ id] received ping answer from \
$from with round-trip-time $rtt ms."
}

# ---------------------------------------------------------------------------


# start/stop the traffic
$ns at 0.2 "$p0 send"
$ns at 0.3 "$p1 send"
$ns at 0.5   "$ftp1 start"
$ns at 0.6   "$ftp2 start"
$ns at 0.7 "$ftp3 start"
$ns at 0.8   "$ftp4 start"
$ns at 66.0 "$ftp4 stop"
$ns at 67.0  "$ftp3 stop"
$ns at 68.0 "$ftp2 stop"
$ns at 70.0 "$ftp1 stop"
$ns at 70.1 "$p0 send"
$ns at 70.2 "$p1 send"

# Set simulation end time
$ns at 80.0 "finish"            

# procedure to plot the congestion window
# cwnd_ used from tcp-reno.cc file
proc plotWindow {tcpSource outfile} {
   global ns
   set now [$ns now]
   set cwnd_ [$tcpSource set cwnd_]

# the data is recorded in a file called congestion.xg.
   puts  $outfile  "$now $cwnd_"
   $ns at [expr $now+0.1] "plotWindow $tcpSource  $outfile"
}

set outfile [open  "congestion.xg"  w]
$ns  at  0.0  "plotWindow $tcp1  $outfile"
proc finish {} {
 exec nam congestion.nam &
 exec xgraph congestion.xg -geometry 300x300 &
exit 0
}
# Run simulation 
$ns run
