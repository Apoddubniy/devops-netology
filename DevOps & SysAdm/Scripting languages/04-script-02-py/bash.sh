IP=(192.168.0.1 173.194.222.113 87.250.250.242)
num = 5
for num in {1..5}
  do curl --connect-timeout  $IP{@}:80 >> log.txt
  done