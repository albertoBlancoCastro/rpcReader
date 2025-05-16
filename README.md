# rpcReader
rpcReader

This code was made to read RPC systems (or others) for LIP RPC systems. Things to do first time.

1 - Edit rpcReader/software/conf/initConf.m and modify SYSTEMNAME = 'mysystem'; This name will be used as head of your location togehter with the rest of the path tha you should modify on  
                     
                      HOME        = ['/home/alberto/tmp/' SYSTEMNAME '/'];

2 - Assume this file as unchange. git will not track the changes on it. 
                      
                      git update-index --assume-unchanged software/conf/initConf.m

3 - Now it is time to edit your system. For this you need to modify 

                       /software/conf/loadMyDevices.m     
                       /software/conf/loadConfiguration.m


4 - Assume this filea as unchange. git will not track the changes on it. 
                      
                      git update-index --assume-unchanged software/conf/loadMyDevices.m
                      git update-index --assume-unchanged software/conf/loadConfiguration.m
                      

5 - Run

                      dcs.m 
                
once. It will exit after creating first device.

6- Add to .gitignore the following: /system/devices/ /system/logs/ /system/lookUpTables/ /system/par/ /software/conf/data/ *.asv  

Points 2, 3 and 6 are automatically done running 

                     setgit.sh
