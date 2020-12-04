import socket
import sys

s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_ICMP)
while True:
    data, src = s.recvfrom(1600)
    payload = data[44:60]
    sys.stdout.write(payload)
