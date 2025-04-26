function [configuration, devicePos] = initReadableDevice(inputVars)

name               = inputVars{1};
IP                 = inputVars{2};
fileExt            = inputVars{3};
remotePath         = inputVars{4};
dcData2MatScript   = inputVars{5};
type               = inputVars{6};
columns            = inputVars{7};
nameFormat         = inputVars{8};
distributionLT     = inputVars{9};
configuration      = inputVars{10};
devicePos          = inputVars{11};

SYS                = inputVars{12};
OS                 = inputVars{13};b = getBarOS(OS);



dev = initDevice();

dev.active                              = 1;
dev.name                                = name;
dev.subName                             = '';
dev.type                                = 'all';
dev.subType                             = '';
dev.reportable.active                   = 0;
dev.reportable.LT                       = '';
dev.reportable.timeElapsed              = 1;
%dev.reportable.downScaling             = downScaling;
dev.path.base                           = [SYS 'devices' b  dev.name  dev.subName b];            mkdirOS(dev.path.base,OS,1);
dev.path.data                           = [dev.path.base 'data' b];                              mkdirOS(dev.path.data,OS,1);
dev.path.reporting                      = [dev.path.base 'reporting' b];                         mkdirOS(dev.path.reporting,OS,1);

dev.dcs.active                          = 1;
dev.dcs.readable                        = 1;
dev.dcs.armed                           = 1;

dev.dcs.rAccess.active                  = 1;
dev.dcs.rAccess.IP{1}                   = IP;
dev.dcs.rAccess.user{1}                 = '';
dev.dcs.rAccess.key{1}                  = '';
dev.dcs.rAccess.port{1}                 = '';

dev.dcs.rAccess.IP{2}                   = '';
dev.dcs.rAccess.user{2}                 = '';
dev.dcs.rAccess.key{2}                  = '';
dev.dcs.rAccess.port{2}                 = '';

dev.dcs.rAccess.fileExt                 = fileExt;
dev.dcs.rAccess.remotePath              = remotePath;

dev.dcs.lAccess.active                  = 0;
dev.dcs.lAccess.fileExt                 = '';
dev.dcs.lAccess.path                    = '';


dev.dcs.dcData2MatScript                = dcData2MatScript;
dev.dcs.type                            = type;
dev.dcs.columns                         = columns;
dev.dcs.nameFormat                      = nameFormat;

dev.dcs.distributionLT                  = distributionLT;

dev.dcs.path.base                       = [dev.path.data 'dcData' b];                           mkdirOS(dev.dcs.path.base,OS,1);
dev.dcs.path.rawData                    = [dev.dcs.path.base 'rawData' b];                      mkdirOS(dev.dcs.path.rawData,OS,1);
dev.dcs.path.rawDataDat                 = [dev.dcs.path.rawData 'rawDataDat' b];                mkdirOS([dev.dcs.path.rawDataDat],OS,1);mkdirOS([dev.dcs.path.rawDataDat 'done' b],OS,1);
dev.dcs.path.rawDataMat                 = [dev.dcs.path.rawData 'rawDataMat' b];                mkdirOS([dev.dcs.path.rawDataMat],OS,1);mkdirOS([dev.dcs.path.rawDataMat 'done' b],OS,1);
dev.dcs.path.data                       = [dev.dcs.path.base 'data' b];                         mkdirOS(dev.dcs.path.data,OS,1);mkdirOS([dev.dcs.path.data 'merge' b],OS,1);                                                   %mkdirOS(dev.dcs.path.data,OS,1);
dev.dcs.path.LT                         = [SYS 'lookUpTables' b];                               mkdirOS(dev.dcs.path.LT,OS,1);


if(devicePos == 1)
    configuration.dev = dev;
else
    configuration.dev(devicePos) = dev;
end

devicePos = devicePos + 1;


return