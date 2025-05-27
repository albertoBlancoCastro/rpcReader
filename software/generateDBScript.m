%% Configuration
clear all;close all;

run('./conf/initConf.m');
[status, RPCRUNMODE] = system('echo $RPCRUNMODE');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run([HOME 'software/conf/loadGeneralConf.m']);


%% Load configuration
%Check if this is the first time the script is run
if(~exist([SYS 'devices'],'dir'))
    conf = initSystem();
    conf = loadConfiguration({conf,HOSTNAME,SYSTEMNAME,HOME,SYS,INTERPRETER,OS});
    message2log = ['Runing dsc.m for first time and exiting.'];
    disp(message2log);
    write2log(conf.logs,message2log,'   ','syslog',OS);
    return
else
    conf = initSystem();
    conf = loadConfiguration({conf,HOSTNAME,SYSTEMNAME,HOME,SYS,INTERPRETER,OS});
end

b = conf.bar;


generateDatabase(conf);