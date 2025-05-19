git update-index --assume-unchanged software/conf/initConf.m
git update-index --assume-unchanged software/conf/loadMyDevices.m
git update-index --assume-unchanged software/conf/loadConfiguration.m



echo -e "/system/devices/\n/system/logs/\n/system/lookUpTables/\n/system/par/\n/software/conf/data/\n*.asv\n.gitignore" >> .gitignore
