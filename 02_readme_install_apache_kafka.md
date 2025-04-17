
Install Apache Kafka in Ubuntu server

1. Check the java version : java -version
root@ubuntu-kafka:~# java -version
Command 'java' not found, but can be installed with:
apt install openjdk-17-jre-headless  # version 17.0.14+7-1~24.04, or
apt install openjdk-21-jre-headless  # version 21.0.6+7-1~24.04.1
apt install default-jre              # version 2:1.17-75
apt install openjdk-19-jre-headless  # version 19.0.2+7-4
apt install openjdk-20-jre-headless  # version 20.0.2+9-1
apt install openjdk-22-jre-headless  # version 22~22ea-1
apt install openjdk-11-jre-headless  # version 11.0.26+4-1ubuntu1~24.04
apt install openjdk-8-jre-headless   # version 8u442-b06~us1-0ubuntu1~24.04
root@ubuntu-kafka:~#

2. sudo apt-get update
3. sudo apt install openjdk-11-jdk
# Add Azul's Zulu JDK 17 repository (or use OpenJDK)
sudo apt update
sudo apt install openjdk-17-jdk -y


4. java version
root@ubuntu-kafka:~/downloads/kafka# java -version
openjdk version "17.0.14" 2025-01-21
OpenJDK Runtime Environment (build 17.0.14+7-Ubuntu-124.04)
OpenJDK 64-Bit Server VM (build 17.0.14+7-Ubuntu-124.04, mixed mode, sharing)
root@ubuntu-kafka:~/downloads/kafka# 

Set Java 17 as default (if multiple versions exist):
sudo update-alternatives --config java
# Select the one with Java 17


5. current directory
root@ubuntu-kafka:~# pwd
/root

6. mkdir downloads
7. cd downloads
7. Go to https://kafka.apache.org/downloads
   https://dlcdn.apache.org/kafka/4.0.0/kafka_2.13-4.0.0.tgz
   root@ubuntu-kafka:~/downloads# curl https://dlcdn.apache.org/kafka/4.0.0/kafka_2.13-4.0.0.tgz -o kafka.tgz
8. root@ubuntu-kafka:~/downloads/kafka# tar -xvf ~/downloads/kafka.tgz --strip 1
9. list files
root@ubuntu-kafka:~/downloads/kafka# ls -lrt
total 64
-rw-r--r-- 1 root root 27064 Mar 14 08:19 NOTICE
-rw-r--r-- 1 root root 14699 Mar 14 08:19 LICENSE
drwxr-xr-x 2 root root  4096 Mar 14 08:20 licenses
drwxr-xr-x 2 root root  4096 Mar 14 08:20 config
drwxr-xr-x 3 root root  4096 Mar 14 08:20 bin
drwxr-xr-x 2 root root  4096 Mar 14 08:20 site-docs
drwxr-xr-x 2 root root  4096 Apr 16 20:23 libs
root@ubuntu-kafka:~/downloads/kafka#


Find the Kafka version

apt install binutils
strings libs/kafka-clients-*.jar | grep "Kafka version"

root@ubuntu-kafka:~/downloads/kafka# ls libs/kafka-clients-*.jar
libs/kafka-clients-4.0.0.jar
Kafka 4.0+ uses KRaft mode only — so if you’re not using ZooKeeper, you're likely on version 4.0 or newer.


root@ubuntu-kafka:~/downloads/kafka# bin/kafka-run-class.sh kafka.Kafka -version
