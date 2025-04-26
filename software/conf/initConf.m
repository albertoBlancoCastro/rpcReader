%% Check system
[status, result] = system('hostname');result = result(1:end-1);
SYSTEMNAME  = 'mingo';

if(strcmp(result,'manta'))
    OS = 'linux';
    HOSTNAME    = 2;
    %Software location
    HOME        = ['/home/alberto/tmp/' SYSTEMNAME '/'];
    %System data structure
    INTERPRETER = 'matlab';
else
    more off
    warning('off');%,' Matlab-style short-circuit operation performed for operator &');
    OS = 'linux';
    HOSTNAME    = 1;
    %Software location
    HOME        = ['/home/swgo/gate2/' SYSTEMNAME '/'];
    %System data structure
    INTERPRETER = 'octave';
end
SYS         = [HOME 'system/'];