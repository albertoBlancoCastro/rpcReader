function configuration = loadConfiguration(inputVars)

configuration       = inputVars{1};
HOSTNAME            = inputVars{2};
SYSTEMNAME          = inputVars{3};
HOME                = inputVars{4};
SYS                 = inputVars{5};
INTERPRETER         = inputVars{6};
OS                  = inputVars{7};
%%
devicePos = 1;
time2Show   = 2*24;
oneHour     = datenum([0000 00 00 01 00 00])-datenum([0000 00 00 00 00 00]);
time1       = datenum([2023 01 01 00 00 00]);time2       = datenum([2023 01 08 12 00 00]);
time2Show = [time1 now];
%time2Show = [now - oneHour*time2Show now];

%%%% This is obsolete has to be done diferently
name                = SYSTEMNAME;             
[configuration, devicePos] = initNoReadableDevice({name,configuration,devicePos,SYS,OS});
telescopePath = [configuration.dev(1).path.data 'ana' b];

%hours
downScaling = 1;
%% General information
configuration.SYSTEMNAME                             = SYSTEMNAME;
configuration.HOSTNAME                               = HOSTNAME;
configuration.SYSTEM                                 = SYSTEMNAME;
configuration.HOME                                   = HOME;
configuration.SYS                                    = SYS; 
configuration.OS                                     = OS;
configuration.INTERPRETER                            = INTERPRETER;
configuration.bar                                    = getBarOS(OS);b = getBarOS(OS);

%% Some general work with the paths
mkdirOS(SYS,OS,1);
mkdirOS([SYS 'devices' b],OS,1);
mkdirOS([SYS 'logs' b],OS,1);

loadMyDevices.m


%% TRB    
daq = initDAQ(); 

daq.active                              = 1;
daq.name                                = 'TRB';
daq.subName                             = '3';
    daq.path.base                       = [SYS 'devices' b  daq.name  daq.subName b];mkdirOS(daq.path.base,OS,1);    
    daq.path.data                       = [daq.path.base 'data' b];                              mkdirOS(daq.path.data,OS,1);                              mkdirOS(daq.path.data,OS,1);
    daq.readable                        = 1;
    
    daq.rAccess.active                  = 1;
    daq.rAccess.IP                      = '192.168.3.45';
    daq.rAccess.user                    = 'rpcuser';
    daq.rAccess.key                     = '/home/alberto/.ssh/id_rsa';
    daq.rAccess.fileExt                 = '*.hld';
    daq.rAccess.remotePath              = ['/media/externalDrive01/data/'];
    daq.rAccess.port                    = '22';
    daq.rAccess.keepHLDs                = 1;
    daq.rAccess.zipFiles                = 1;
    daq.rAccess.downScale               = 2;
    
    daq.lAccess.active                  = 0;
    daq.lAccess.fileExt                 = '*.hld';
    daq.lAccess.path                    = ['/home/alberto/gate/localDocs/lip/daqSystems/SELADAS1M2/hlds/'];
    daq.lAccess.zip                     = 0;
    
    daq.unpacking.path.base             = [daq.path.data 'daqData' b];                           mkdirOS([daq.unpacking.path.base],OS,1);
    daq.unpacking.path.rawData          = [daq.unpacking.path.base 'rawData' b];                 mkdirOS([daq.unpacking.path.rawData],OS,1);
    daq.unpacking.path.rawDataDat       = [daq.unpacking.path.rawData 'dat' b];                  mkdirOS([daq.unpacking.path.rawDataDat],OS,1);mkdirOS([daq.unpacking.path.rawDataDat 'done' b],OS,1);
    daq.unpacking.path.rawDataMat       = [daq.unpacking.path.rawData 'mat' b];                  mkdirOS([daq.unpacking.path.rawDataMat],OS,1);mkdirOS([daq.unpacking.path.rawDataMat 'done' b],OS,1);
    daq.unpacking.fileExt               = '*.hld';
    daq.unpacking.bufferSize            =  60000000;%Confortable number for Manta III
    daq.unpacking.type                  = 'TRB3';
    daq.unpacking.keepHLDs              = 1;
    daq.unpacking.zipFiles              = 0;                               %keep data on origing and compress
    daq.unpacking.writeTDCCal           = 1;
    daq.unpacking.downScale             = 1;                               %1 is no downScale
    
    daq.raw2var.path.base               = [daq.path.data 'daqData' b];                           mkdirOS([daq.raw2var.path.base],OS,1);
    daq.raw2var.path.varData            = [daq.unpacking.path.base 'varData' b];                 mkdirOS([daq.raw2var.path.varData],OS,1);mkdirOS([daq.raw2var.path.varData 'done' b],OS,1);
    daq.raw2var.path.lookUpTables       = [SYS 'lookUpTables' b];                                         mkdirOS([daq.raw2var.path.lookUpTables],OS,1);
    %daq.raw2var.lookUpTables            = {'lookupTables_R3BCTS.m','lookupTables_RPC.m'};
    daq.raw2var.lookUpTables            = {'lookUpTables_RPC.m'};
    daq.raw2var.keepRawFiles            = 0;
    
    daq.var2cal.path.base               = [daq.path.data 'daqData' b];                           mkdirOS([daq.var2cal.path.base],OS,1);
    daq.var2cal.path.calData            = [daq.unpacking.path.base 'calData' b];                 mkdirOS([daq.var2cal.path.calData],OS,1);mkdirOS([daq.var2cal.path.calData 'done' b],OS,1);
    daq.var2cal.path.lookUpTables       = [SYS 'par' b];                                         mkdirOS([daq.var2cal.path.lookUpTables],OS,1);
    daq.var2cal.lookUpTables            = '';
    daq.var2cal.keepVarFiles            =  0;
    
    
     
    daq(1).active                       = 1;
    daq(1).type                         = 'TRB3';
    daq.TRB3(1).centralFPGA             = 'C001';%This are the FPGA corresponding to a subEvent
    %conf.TRBs(1).lookupTables  = [conf.software.basePath 'wvf2var/lookupTables.m'];
    %The order of he FPGAs is the order on the Network MAP
    %%%%                                       ID          type   active   writeOutput                            timeCalPar                                                             lookupTables
    daq(1).TRB3(1).FPGAs                 = {'A001',            'TDC',   'NONE',   'NONE',        [daq.raw2var.path.lookUpTables 'timeCalibrationParametersDummy'],0;...
                                            'A002',            'TDC',   'NONE',   'NONE',        [daq.raw2var.path.lookUpTables 'timeCalibrationParametersDummy'],0;...
                                            'A003',            'TDC',   'TRUE',   'TRUE',        [daq.raw2var.path.lookUpTables 'timeCalibrationParametersDummy'],0;...
                                            'A004',            'TDC',   'TRUE',   'TRUE',        [daq.raw2var.path.lookUpTables 'timeCalibrationParametersDummy'],0;...
                                            'C001',            'CTS',   'TRUE',   'TRUE',        ['none'],0;...    
                                            };  

%{11} is the offset in the TDC-CTS that jump all the words that are not TDCs 
%it is the number of words in betwwen 0x0010c001 and the first TDC word 0x60b9bd70. I assume that this is constant!!!

%size: 0x00000060  decoding: 0x00020001  id:    0x0000c001  trigNr: 0x0608e3a6 trigTypeTRB3: 0x1

%00000000:  0x0000c002  0x0010c001  0x100403e4  0xe6f5c14a
%00000010:  0x00000000  0xe6f5c14a  0x00000000  0xd3784d9d
%00000020:  0x0006e130  0x872aca87  0x00029994  0x80000000
%00000030:  0x20009500  0x60b9bd70  0x800faa96  0x80522a85
%00000040:  0x804aa30b  0x01a60000  0x00015555  0x00000001                                       
                                        
 
    
configuration.daq = daq;                
     
        %% Ana parametres
ana.active                                  = 1;
ana.path                                    = [HOME 'ana' b];mkdirOS(ana.path,OS,1);
    
    ana.calibration.QPEDParam               = 'Offset_2023_06_05.mat';
    ana.calibration.LonYParam               = 'YOffSet_2023_06_05.mat';

    ana.keepFiles.TriggerType1              = 1;if(ana.keepFiles.TriggerType1);mkdirOS([telescopePath 'TT1' b],OS,1);end
    ana.keepFiles.TriggerType2              = 1;if(ana.keepFiles.TriggerType2);mkdirOS([telescopePath 'TT2' b],OS,1);end
    ana.keepVars.TriggerType1               = 1;if(ana.keepVars.TriggerType1);mkdirOS([telescopePath 'Vars' b],OS,1);mkdirOS([telescopePath 'Vars' b 'TT1' b],OS,1);end
    ana.keepVars.TriggerType2               = 1;if(ana.keepVars.TriggerType1);mkdirOS([telescopePath 'Vars' b],OS,1);mkdirOS([telescopePath 'Vars' b 'TT2' b],OS,1);end

    ana.calibration.QPED.active             = 0;          
    ana.calibration.longitudinalY.active    = 0;                
    ana.calibration.longitudinalY.path      = [daq.raw2var.path.varData 'calYOff' b];mkdirOS(ana.calibration.longitudinalY.path,OS,1);

    ana.scintAna.active                     = 0;
    ana.scintAna.path                       = [ana.path 'ScintEff' b];mkdirOS(ana.scintAna.path,OS,1);

    ana.backgroundAna.active                = 0;
    ana.backgroundAna.path                  = [ana.path 'Background' b];mkdirOS(ana.backgroundAna.path,OS,1);
    
    ana.param.strips.vprop                  = 165.7;%165.7mm/ns
    ana.param.strips.strips                 = 16;
    ana.param.strips.pitch                  = 18;%mm
    ana.param.strips.planes                 = 4; 
    ana.param.strips.planesZPos             = [0 200 400 600]; 
    ana.param.strips.ActivePlanes           = [1 1 1 1];
    
    ana.param.strips.strTh                  = 100;
    ana.param.strips.QRange                 = [-100:0.1:500];%For Q histogram
    ana.param.strips.XRange                 = [-50:10:350];
    ana.param.strips.YRange                 = [-200:10:200];

    ana.report.address4Email                = {'alberto@coimbra.lip.pt','luisalberto@coimbra.lip.pt'};
   
configuration.ana                       = ana;              

     
            
%% Logs
log = initLog(); log.active        = 1; log.type          = 'criticallog'; log.localPath     = [SYS 'logs' b 'criticallog.log'];system(['touch ' log.localPath]);
configuration.logs = log;

log = initLog(); log.active        = 1; log.type          = 'syslog'; log.localPath     = [SYS 'logs' b 'syslog.log'];system(['touch ' log.localPath]);
configuration.logs(2) = log;

log = initLog(); log.active        = 1; log.type          = 'netlog'; log.localPath     = [SYS 'logs' b 'netlog.log'];system(['touch ' log.localPath]);
configuration.logs(3) = log;
        
%% Alarms
alarm = initAlarm(); alarm.system = SYSTEMNAME;alarm.active        = 1; alarm.type          = 'netAccess'; alarm.TO     = {'alberto@coimbra.lip.pt','alberto.blanco.abc@gmail.com'};
configuration.alarms = alarm;        

alarm = initAlarm(); alarm.system = SYSTEMNAME;alarm.active        = 1; alarm.type          = 'unpacking'; alarm.TO     = {'rpc.slow.control@gmail.com'};
configuration.alarms(2) = alarm;  

alarm = initAlarm(); alarm.system = SYSTEMNAME;alarm.active        = 0; alarm.type          = 'unpackDCS'; alarm.TO     = {'alberto@coimbra.lip.pt'};
configuration.alarms(3) = alarm; 

alarm = initAlarm(); alarm.system = SYSTEMNAME;alarm.active        = 0; alarm.type          = 'IDs no active'; alarm.TO     = {'rpc.slow.control@gmail.com'};
configuration.alarms(4) = alarm; 

alarm = initAlarm(); alarm.system = SYSTEMNAME;alarm.active        = 1; alarm.type          = 'Online Monitoring'; alarm.TO     = {'rpc.slow.control@gmail.com'};
configuration.alarms(5) = alarm; 


DB.active               =                           0;

DB.connection.remoteIP  =                 'localhost';
DB.connection.port      =                     '15432';
DB.connection.user      =                      'swgo';
DB.connection.pass      =                  'swgo@lip';
DB.connection.key       = '/home/alberto/.ssh/id_rsa';

DB.tmpFolder            = ['/tmp/' SYSTEMNAME b];                             mkdirOS([DB.tmpFolder],OS,1);
DB.DistributeDCSVars    = 1;
DB.DistributeAnaVars    = 1;

configuration.DB        = DB;




configuration.Versioning = {'distributeAnaVars',1;'sendData2DB',0;'writeCSV4DB',1};

        
%% Write the conf file once per day.
mkdirOS([HOME 'software/conf/data/'],OS,1);
save([HOME 'software/conf/data/configuration-' date '.mat'],'configuration');
return
