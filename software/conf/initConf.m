%%  Load system variables
run(['./loadMySystem.m']);

%% Check the current hostname
[status, result] = system('hostname');result = result(1:end-1);


SYSTEMNAME  = systemName; clear systemName;

if(strcmp(result,'manta'))
    OS = 'linux';
    HOSTNAME    = 1;
    %Software location
    HOME        = ['/home/alberto/gate/localDocs/lip/daqSystems/' SYSTEMNAME '/'];
    %System data structure
    INTERPRETER = 'matlab';

    if(~exist([HOME 'system/devices'],'dir'))
        %% Create the scripts used locally by Alberto Very spetial ...
        % login.sh
        [status, result] = system('mkdir ../../localbin');
        [status, result] = system('echo ''#!/bin/sh'' > ../../localbin/login.sh');
        [status, result] = system(['echo ''export RPCSYSTEM=' SYSTEMNAME ''' >> ../../localbin/login.sh']);
        [status, result] = system(['echo ''export RPCREMOTEPATH=' path SYSTEMNAME '/ '' >> ../../localbin/login.sh']);
        [status, result] = system(['echo ''export RPCLOCALPATH=' HOME ''' >> ../../localbin/login.sh']);
        [status, result] = system(['echo ''export RPCREMOTECOMPUTER=' hostName ''' >> ../../localbin/login.sh']);
        [status, result] = system(['chmod u+x ../../localbin/login.sh']);

        % syncLookUpTables.sh
        [status, result] = system('echo ''#!/bin/sh'' > ../../localbin/syncLookUpTables.sh');
        [status, result] = system('echo scp  ''$RPCLOCALPATH''/system/par/*           ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/system/par          >> ../../localbin/syncLookUpTables.sh');
        [status, result] = system('echo scp  ''$RPCLOCALPATH''/system/lookUpTables/*  ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/system/lookUpTables >> ../../localbin/syncLookUpTables.sh');
        [status, result] = system(['chmod u+x ../../localbin/syncLookUpTables.sh']);

        % syncSoftware.sh
        [status, result] = system('echo ''#!/bin/sh'' > ../../localbin/syncSoftware.sh');
        [status, result] = system('echo rsync   -vrltgoD --delete                       ''$RPCLOCALPATH''/bin/*.*                               ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/bin/                         >> ../../localbin/syncSoftware.sh');
        [status, result] = system('echo rsync   -vrltgoD --delete                       ''$RPCLOCALPATH''/software/*.m                          ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/software/                 >> ../../localbin/syncSoftware.sh');
        [status, result] = system('echo rsync   -vrltgoD --delete                       ''$RPCLOCALPATH''/software/ana/                         ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/software/ana/             >> ../../localbin/syncSoftware.sh');
        [status, result] = system('echo rsync   -vrltgoD --delete                       ''$RPCLOCALPATH''/software/daq/                         ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/software/daq/             >> ../../localbin/syncSoftware.sh');
        [status, result] = system('echo rsync   -vrltgoD --delete                       ''$RPCLOCALPATH''/software/dc/                          ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/software/dc/              >> ../../localbin/syncSoftware.sh');
        [status, result] = system('echo rsync   -vrltgoD --delete                       ''$RPCLOCALPATH''/software/utils/                       ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/software/utils/           >> ../../localbin/syncSoftware.sh');
        [status, result] = system('echo rsync   -vrltgoD --delete  --exclude "''data''" ''$RPCLOCALPATH''/software/conf/                        ''$RPCREMOTECOMPUTER'':''$RPCREMOTEPATH''/software/conf/            >> ../../localbin/syncSoftware.sh');
        [status, result] = system(['chmod u+x ../../localbin/syncSoftware.sh']);
    end
else
    more off
    warning('off');%,' Matlab-style short-circuit operation performed for operator &');
    OS = 'linux';
    HOSTNAME    = 1;
    %Software location
    HOME        = [path SYSTEMNAME '/'];
    %System data structure
    INTERPRETER = 'octave';
    %% Create the sh scripts to run the software
    % dcs_om.sh
    if(~exist([HOME 'system/devices'],'dir'))
        [status, result] = system('mkdir ../../bin');
        [status, result] = system('echo ''#!/bin/sh'' > ../../bin/dcs_om.sh');
        [status, result] = system(['echo ''cd ' HOME 'software/'' >> ../../bin/dcs_om.sh']);
        [status, result] = system(['echo "pkill -xf ''/usr/bin/octave-cli --no-gui  ' HOME 'software/dcs.m''" >> ../../bin/dcs_om.sh']);
        [status, result] = system(['echo "octave --no-gui  ' HOME 'software/dcs.m" >> ../../bin/dcs_om.sh']);
        [status, result] = system(['echo "pkill -xf ''/usr/bin/octave-cli --no-gui  ' HOME 'software/OM.m''" >> ../../bin/dcs_om.sh']);
        [status, result] = system(['echo "octave --no-gui  ' HOME 'software/OM.m" >> ../../bin/dcs_om.sh']);
        [status, result] = system(['chmod u+x ../../bin/dcs_om.sh']);

        % ana.sh
        [status, result] = system('echo ''#!/bin/sh'' > ../../bin/ana.sh');
        [status, result] = system(['echo ''cd ' HOME 'software/'' >> ../../bin/ana.sh']);
        [status, result] = system(['echo "octave --no-gui  ' HOME 'software/ana.m" >> ../../bin/ana.sh']);
        [status, result] = system(['chmod u+x ../../bin/ana.sh']);

        % copyFiles.sh
        [status, result] = system('echo ''#!/bin/sh'' > ../../bin/copyFiles.sh');
        [status, result] = system(['echo ''cd ' HOME 'software/'' >> ../../bin/copyFiles.sh']);
        [status, result] = system(['echo "octave --no-gui  ' HOME 'software/copyFiles.m" >> ../../bin/copyFiles.sh']);
        [status, result] = system(['chmod u+x ../../bin/copyFiles.sh']);

        % unpacks.sh
        [status, result] = system('echo ''#!/bin/sh'' > ../../bin/unpackingContinuous.sh');
        [status, result] = system(['echo ''cd ' HOME 'software/'' >> ../../bin/unpackingContinuous.sh']);
        [status, result] = system(['echo "octave --no-gui  ' HOME 'software/unpackingContinuous.m" >> ../../bin/unpackingContinuous.sh']);
        [status, result] = system(['chmod u+x ../../bin/unpackingContinuous.sh']);

        % keepRemoteTunnelOpen.m
        [status, result] = system('echo ''#!/bin/sh'' > ../../bin/keepRemoteTunnelOpen.sh');
        [status, result] = system(['echo ''cd ' HOME 'software/'' >> ../../bin/keepRemoteTunnelOpen.sh']);
        [status, result] = system(['echo "octave --no-gui  ' HOME 'software/bin/keepRemoteTunnelOpen.m" >> ../../bin/keepRemoteTunnelOpen.sh']);
        [status, result] = system(['chmod u+x ../../bin/keepRemoteTunnelOpen.sh']);
    end
end
SYS         = [HOME 'system/'];

clear hostName path
