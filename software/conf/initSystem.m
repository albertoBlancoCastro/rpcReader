function configuration = initSystem()

%% Definition of struct
configuration  = struct(...
'HOME','',...
'SYS','',...
'INTERPRETER','',...
'OS','', ...
'bar','',...
'dev',struct([]),...
'daq',struct([]),...
'logs',struct([]));
return