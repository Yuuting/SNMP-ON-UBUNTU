#manager device
sudo apt-get update
sudo apt-get install snmp snmp-mibs-downloader
#配置局域网
sudo ifconfig ens33 down
sudo ifconfig ens33 10.0.0.20 netmask 255.0.0.0
#配置文件
sudo nano /etc/snmp/snmp.conf
#注释掉mibs
#mibs
snmpget -u temp_user -l authPriv -a MD5 -x DES -A temp_password -X temp_password 10.0.0.10 1.3.6.1.2.1.1.1.0
snmpusm -u temp_user -l authPriv -a MD5 -x DES -A temp_password -X temp_password 10.0.0.10 create real_user temp_user
snmpusm -u real_user -l authPriv -a MD5 -x DES -A temp_password -X temp_password 10.0.0.10 passwd temp_password my_real_password
snmpget -u real_user -l authPriv -a MD5 -x DES -A my_real_password -X my_real_password 10.0.0.10 sysUpTime.0
#更改配置文件
sudo nano /etc/snmp/snmp.conf
defSecurityName real_user
defsecurityLevel authPriv
defAuth Type MD5
defPriv Type DES
defAuthPassphrase my_real_password 
defPrivPassphrase my_real_password
#可以进行查询
snmpget 10.0.0.10 sysUpTime.0
#删除临时用户
snmpusm 10.0.0.10 delete temp_user
#继续查询
snmpget 10.0.0.10 1.3.6.1.2.1.1.1.0
snmpget 10.0.0.10 sysDescr.0
snmpgetnext 10.0.0.10 sysDescr.0
snmpgetnext 10.0.0.10 sysObjectID.0
snmpwalk 10.0.0.10
snmpwalk 10.0.0.10 . | grep -i uptime
snmptranslate  1.3.6.1.2.1.1.1.0
snmptranslate -On HOST-RESOURCES-MIB::hrSystemUptime.O
snmptranslate -Tp 1.3.6.1.2.1.1.1.0
snmpset 10.0.0.10 sysLocation.O s "Earth"
snmpset 10.0.0.10 sysLocation.O= "New York"
snmpget 10.0.0.10 sysLocation.O
snmpbulkget 10.0.0.10 system