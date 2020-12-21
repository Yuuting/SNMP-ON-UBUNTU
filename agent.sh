#agent
sudo apt-get update
sudo apt-get install snmpd
#配置局域网
sudo ifconfig ens33 down
sudo ifconfig ens33 10.0.0.10 netmask 255.0.0.0
#测试
ping 10.0.0.20
#配置文件
sudo nano /etc/snmp/snmpd.conf
agentAddress udp:161,udp6:[::1]:161
createUser temp_user MD5 temp_password DES
rwuser temp_user priv
rwuser real_user priv
sudo service snmpd restart
uname -a
#更改配置文件
sudo nano /etc/snmp/snmpd.conf
agentAddress udp:161,udp6:[::1]:161
#createUser temp_user MD5 temp_password DES
#rwuser temp_user priv
#rwuser real_user priv
sudng on the Dock of the Bay