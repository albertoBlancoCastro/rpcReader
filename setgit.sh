git update-index --assume-unchanged software/conf/loadMySystem.m
git update-index --assume-unchanged software/conf/loadMyDevices.m
git update-index --assume-unchanged software/conf/loadConfiguration.m

echo -e "/localbin/\n/bin/\n/system/devices/\n/system/logs/\n/system/lookUpTables/\n/system/par/\n/software/conf/data/\n*.asv\n.gitignore" >> .gitignore
