#!/bin/sh
domain=$1
ip=$2
port=$3
sed -r -i 's/-i console/-i console \n\tacl host_'$1' hdr_dom(host) -i '$1'/' /etc/haproxy/haproxy.cfg
sed -r -i 's/if host_console/if host_console \n\tuse_backend '$1'_http if host_'$1'/' /etc/haproxy/haproxy.cfg
sed -r -i 's/127.0.0.1:82/127.0.0.1:82\n\nbackend '$1'_http\nmode http\nserver '$1' '$2':'$3'/' /etc/haproxy/haproxy.cfg
echo "done"
