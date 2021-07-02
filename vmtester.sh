#!/bin/bash
echo "=========================================================================================="
echo "Memory Check" 
echo "=========================================================================================="
echo $(awk '{print $1 $2}' <(free -mh)) | tee report.txt
sleep 1
echo "=========================================================================================="
echo "Check storage" 
echo "=========================================================================================="
echo $(awk '{print $2}' <(df -mh /dev/mapper/vgmain-root)) | tee -a report.txt
echo $(awk '{print $2}' <(df -mh /dev/nvme0n1p5)) | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check CPUs"
echo "=========================================================================================="
echo $(lscpu | grep -E '^CPU\(') | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check /etc/hosts (Make sure its all in order then add to report.txt manually)"
echo "=========================================================================================="
echo "$(cat /etc/hosts)" 
sleep 1
echo "=========================================================================================="
echo "Check /etc/resolv.conf (Make sure its all in order then add to reports.txt manually)"
echo "=========================================================================================="
echo "$(cat /etc/resolv.conf)" 
sleep 1
echo "=========================================================================================="
echo "Check /etc/logrotate.conf (Make sure its all in order then add to reports.txt manually)"
echo "=========================================================================================="
echo "$(cat /etc/logrotate.conf)" 
echo "=========================================================================================="
echo "Check POSI NRPE and Monitoring installed"
echo "=========================================================================================="
echo $(cat /etc/sudoers | grep nagios) | tee -a report.txt
echo $(systemctl is-active --quiet nagios-nrpe-server && echo Nagios is running) | tee -a report.txt
echo "$(cat /etc/shorewall/rules | grep NRPE/ACCEPT)" | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check Munin []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "munin") | tee -a report.txt
echo $(systemctl is-active --quiet munin-node && echo Munin is running)
sleep 1
echo "=========================================================================================="
echo "Check pwgen []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "pwgen") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check lsof []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "lsof") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check strace []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "strace") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check vim []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "vim") | tee -a report.txt
sleep 1 
echo "=========================================================================================="
echo "Check sysstat []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "sysstat") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check vnstat []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "vnstat") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check iotop []"
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "iotop") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check htop []"
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "htop") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check dnsutils []"
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "dnsutils") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check whois []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "whois") | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check NTP is working []" 
echo "=========================================================================================="
echo $(systemctl is-active --quiet ntp && echo NTP is running) | tee -a report.txt
sleep 1
echo "=========================================================================================="
echo "Check fail2ban []" 
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "fail2ban") | tee -a report.txt
echo $(systemctl is-active --quiet fail2ban && echo Fail2ban is running) 
sleep 1
echo "=========================================================================================="
echo "check postfix []"
echo "=========================================================================================="
echo $(dpkg-query -f '${Package} ${Status}\n' -W "postfix") | tee -a report.txt 
echo $(systemctl is-active --quiet munin-node && echo Postfix is running)
sleep 1
echo "=========================================================================================="
echo "check outgoing mail [swaks may not be installed on the server by default so this may fail]"
echo "=========================================================================================="
if ! command -v swaks > /dev/null 2>&1; then
	echo "swaks is not installed on this system" 
else
	echo "Please enter your email: "
	read -n EMAIL
	swaks --to $EMAIL
	echo "swaks installed, test email has been sent" >> report.txt
fi 
sleep 1
echo "=========================================================================================="
echo "You'll have to check user logins and special configurations yourself"
echo "=========================================================================================="
