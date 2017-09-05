\cp /mnt/iplists/_torconfig /etc/torrc
/etc/init.d/tor start
while read listfile; do 
	while read range; do
		iptables -A INPUT -p tcp -m iprange --dst-range $range -j ACCEPT
	done < /mnt/iplists/$listfile
done < /mnt/iplists/_list.txt