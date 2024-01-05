if [ "$1" = "bot" ] ; then
	echo '[bot mode] do it by bot'
	curl -s 'https://onionoo.torproject.org/details?type=relay&order=-consensus_weight&limit=250&running=true' -o /tmp/torRelay.tmp
	EntryN=$(cat /tmp/torRelay.tmp | awk -F'fingerprint\":\"' '{print $2}' |awk -F'\",' '{print $1}' |grep -v '^$'|awk 'NR==1{print $1}')
	ExitN=$(cat /tmp/torRelay.tmp | awk -F'fingerprint\":\"' '{print $2}' |awk -F'",' '{print $1}' |grep -v '^$'|awk 'NR==2{print $1}')
	rm /tmp/torRelay.tmp
	sed -i '/^EntryNode\|^ExitNode/d' /etc/tor/torrc
	echo "EntryNodes {$EntryN}">>/etc/tor/torrc
	echo "ExitNodes {$ExitN}">>/etc/tor/torrc
else
	echo '[User mode] do it by humam!!!'
	sed -i '/^EntryNode\|^ExitNode/d' /etc/tor/torrc
fi

