#!/bin/sh
domain=$1
sed -i '/host_'$1' hdr/d' /etc/haproxy/haproxy.cfg
sed -i '/backend '$1'_http if/d' /etc/haproxy/haproxy.cfg
linenum_start=$(awk '/backend '$1'_http/{print NR}' /etc/haproxy/haproxy.cfg)
linenum_end=$(awk '/backend '$1'_http/{print NR+2}' /etc/haproxy/haproxy.cfg)
sed -i ''$linenum_start','$linenum_end'd' /etc/haproxy/haproxy.cfg
echo "Done"
