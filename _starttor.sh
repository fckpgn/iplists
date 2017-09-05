\cp /overlay/mnt/iplists/_torconfig /etc/torrc
/etc/init.d/tor start
iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 9053
iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 9053

while read listfile; do 
	while read range; do
		iptables -t nat -A PREROUTING -p tcp --dst-range $range -j REDIRECT --to-ports 9040
	done < /overlay/mnt/iplists/$listfile
done < /overlay/mnt/iplists/_list.txt