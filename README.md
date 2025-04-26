# rpcReader
rpcReader

This code was made to read RPC systems (or others) for LIP RPC systems. Things to do first time.

1 - Edit rpcReader/software/conf/initConf.m and modify SYSTEMNAME = 'mysystem'; This is the name of your system HOME = ['path']; this is the path of your repository => / ..../rpcReader/

2 - Assume this file as unchange. git will not track the changes on it. git update-index --assume-unchanged software/conf/initConf.m

3 - Now it is time to edit your system. For this you need to modify rpcReader/software/conf/loadConfiguration.m

4 - Assume this file as unchange. git will not track the changes on it. git update-index --assume-unchanged software/conf/loadConfiguration.m

5 - Run dcs.m once. It will exit after creating first device.

6- Add to .gitignore the following: /system/devices/ /system/logs/ /system/lookUpTables/ /system/par/ /software/conf/data/ *.asv .gitignore
