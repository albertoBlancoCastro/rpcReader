# rpcReader
rpcReader

This code was made to read RPC systems (or others) for LIP RPC systems. Things to do first time.

1 - Edit rpcReader/software/conf/loadMySystem.m and modify the three variables there, which are self-explanatory.
                      systemName     = 'backuplip';              %This is the name of the system, will be the name of the last folder on the path
                      hostName       = 'slow';                   %This is the name of the computer where software runs based on .ssh/config
                      path           = '/home/rpcuser/gate/';    %This is the path where the software is installed without systemName.

2 - Assume this file as unchange. git will not track the changes on it. 
                      
                      git update-index --assume-unchanged software/conf/loadMySystem.m

3 - Now it is time to edit your system. For this you need to modify 

                       /software/conf/loadMyDevices.m     
                       /software/conf/loadConfiguration.m

4 - Assume this file as unchange. git will not track the changes on it. 
                      
                      git update-index --assume-unchanged software/conf/loadMyDevices.m
                      git update-index --assume-unchanged software/conf/loadConfiguration.m
                      

5 - Run

                      dcs.m 
                
once. It will exit after creating first device.


6- Add to .gitignore the following: /system/devices/ /system/logs/ /system/lookUpTables/ /system/par/ /software/conf/data/ *.asv  

Points 2, 3 and 6 are automatically done running 

                     setgit.sh
