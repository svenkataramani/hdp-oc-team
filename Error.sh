kticket='klist | grep doritijr.godaddy.com'


if [ -n "$kticket" ]; then
    echo $kticket
else
    echo "No ticket"
    exit 1
fi