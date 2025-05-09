
%% Device 01     CONTROLLER 01
name                = 'CONTROLER01';                                       %'DeviceName01';                   %This is the name of the device
IP                  = 'hadesfrpcgas';                                      %'DeviceIP';                       %Device IP. This relay on .ssh/config
fileExt             = 'GAS11*.log';                                        %'filePatter*.*';                  %File Pattern to match
remotePath          = '/home/rpcuser/logs/';                               %'/home/rpcuser/logs/';            %Path of the file to read
dcData2MatScript    = 'procGenericLog';                                    %'procGenericLog';                 %Name of the processing script
type                = 'I2C';                                               %'I2C';                            %Format of the timestamp of file to read
columns             = 6;                                                   %6;                                %Number of columns to read
nameFormat          = '******2024-03-01****';                              %'******2024-03-01****';           %Name of the new name. * will be removed
distributionLT      = 'lookUpTablefRPCController.m';                       %'lookUpTablefRPCController.m';    %Lookuptable of the device

[configuration, devicePos] = initReadableDevice({name,IP,fileExt,remotePath,dcData2MatScript,type,columns,nameFormat,distributionLT,configuration,devicePos,SYS,OS});

%% Device 02     GASSYSTEM
name                = 'GASSYSTEM';                                         %'RPC01';                          %This is the name of the device
[configuration, devicePos] = initNoReadableDevice({name,configuration,devicePos,SYS,OS});
