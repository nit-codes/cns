set ns [new Simulator]
set tf [open lab2.tr w]
$ns trace-all $tf
set topo [new Topography]
$topo load flatgrid 1000 1000
set nf [open lab2.nam w]
$ns namtrace-all-wireless $nf 1000 1000
$ns node-config - adhocRouting DSDV \
-llType LL \
-macType Mac/802_11 \
-ifqType Queue/DropTail \
-ifqLen 50 \
-phyType Phy/WirelessPhy \
- channelType Channel/WirelessChannel \
-propType Propagation/TwoRayGround \
-antType Antenna/OmniAntenna \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
create-god 3
set no [$ns node]
set n1 [$ns node]
set n2 [$ns node]
$no label "tcp0"
$n1 label "Sink/TCP1"
$n2 label "Sink2"
$no set X 50
$no set Y 50
$no set Z 0
$n1 set X 100
$n1 set Y 100
$n1 set Z 0
$n2 set X 600
$n2 set Y 600
$n2 set Z 0
$ns at 0.1 "$n0 setdest 50 50 15"
$ns at 0.1 "$n1 setdest 100 100 25" $ns at 0.1 "$n2 setdest 600 600 25"
set tcp0 [new Agent/TCP]
$ns attach-agent $no $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0 set sinkl [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp0 $sinkl
set tcpl [new Agent/TCP]
$ns attach-agent $n1 $tcpl
set ftpl [new Application/FTP]
$ftpl attach-agent $tcp1
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp1 $sink2
$ns at 5 "$ftp0 start"
$ns at 5 "$ftp1 start"
$ns at 100 "$n1 setdest 550 550 15"
$ns at 190 "$n1 setdest 70 70 15"
proc finish {} {
global ns nf tf
$ns flush-trace
exec nam lab2.nam &
close $tf
exit 0
}
$ns at 250 "finish"
$ns run
