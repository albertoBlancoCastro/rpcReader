function scpLastAndMove(systemName,device,remoteIP,user,key,pathIn,pathOut,port,fileExt,logs,alarms,OS)
%%

%2024-04-26 on sRPC    - Do the code compatible with no entries on config
if (length(key) > 0);     keyString = ['-i '  key ' '];else;    keyString = '';end
if (length(port) > 0);sshPortString = ['-p ' port ' '];else;sshPortString = '';end
if (length(port) > 0);scpPortString = ['-P ' port ' '];else;scpPortString = '';end
if (length(user) > 0);   userString =       [user '@'];else;   userString = '';end



b = getBarOS(OS);

try %Try the copy
    %%%List the files
    %[status, result] = system(['ssh -i ' key ' -p ' port ' ' user '@' remoteIP ' ls -1 ' pathIn fileExt]);
    [status, result] = system(['ssh ' keyString sshPortString userString remoteIP ' ls -1 ' pathIn fileExt]);
    
    if status == 0
        resultPorc = procLsOut(result);
    else
        message2log = ['Error while copying from remote location                 : ' remoteIP ' ' result];
        disp(message2log);
        write2log(logs,message2log,'Error','syslog',OS);
        write2log(logs,message2log,'Error','netlog',OS);
        write2log(logs,message2log,'Error','criticallog',OS);
       
        alarmType = 'netAccess';processAlarm(systemName,device,alarmType,message2log,alarms);
        return
    end
    
    if(size(resultPorc,1) == 0 )
        disp('Nothing to copy');
    elseif(size(resultPorc,1) == 1)
        file = resultPorc{1};
        I = find(file == b);
        fileName = file(I(end)+1:end);
        %%%    Check if the folder exist
        mkdirOS(pathOut,OS,1);mkdirOS([pathOut 'done' b],OS,1);
        
        
        %%%Copy files
        %[status, result] = system(['scp -i ' key ' -P ' port ' ' user '@' remoteIP ':' file ' ' pathOut]);
        [status, result] = system(['scp ' keyString scpPortString userString remoteIP ':' file ' ' pathOut]);
        
        message2log = ['Copying from remote location                             : ' remoteIP ' ' file];                                          
        disp(message2log);
        write2log(logs,message2log,'   ','syslog',OS);
    else
        for i=1: size(resultPorc,1)-1
            file = resultPorc{i};
            I = find(file == b);
            fileName = file(I(end)+1:end);
            
            %%%    Check if the folder exist
            mkdirOS(pathOut,OS,1);mkdirOS([pathOut 'done' b],OS,1);
            
            %%%Copy files
            [status, result] = system(['scp ' keyString scpPortString userString remoteIP ':' file ' ' pathOut]);
            
            message2log = ['Copying from remote location                             : ' remoteIP ' ' file];
            disp(message2log);
            write2log(logs,message2log,'   ','syslog',OS);
            
            %%%Move to the remote \ done folder
            [status, result] = system(['ssh ' keyString sshPortString userString remoteIP ' mv ' file ' ' pathIn 'done' b]);
            
            message2log = ['Moving to done on remote location                        : ' remoteIP ' ' file];
            disp(message2log);
            write2log(logs,message2log,'   ','syslog',OS);
        end
    end
    
catch exception
        fullMessage = [];
        for j = 1:length(exception.stack)
            message2log = ['Error in: ' exception.stack(j).file ' line ' num2str(exception.stack(j).line)];
            fullMessage = [fullMessage ' ' message2log];
            disp(message2log);
            write2log(logs,message2log,'   ','syslog',OS);
            write2log(logs,message2log,'   ','criticallog',OS);
        end
        alarmType = 'netAccess';
        processAlarm(systemName,device,alarmType,fullMessage,alarms);
end

return