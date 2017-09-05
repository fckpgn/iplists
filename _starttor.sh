#!/bin/bash
\cp /overlay/mnt/iplists/_torconfig /etc/torrc
\cp /overlay/mnt/iplists/_torconfig /etc/tor/torrc
chown tor:root /etc/torrc
chown tor:root /etc/tor/torrc
/etc/init.d/tor restart
#iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 9053
#iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 9053


while read listfile; do 
	cat /overlay/mnt/iplists/$listfile >> /overlay/mnt/iplists/ip.list
done < /overlay/mnt/iplists/_list.txt

while read range; do
	iptables -t nat -A PREROUTING -p tcp -d $range -j REDIRECT --to-ports 9040
done < /overlay/mnt/iplists/ip.list
