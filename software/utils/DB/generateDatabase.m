function generateDatabase(conf)
    user            = conf.DB.connection.user;     
    password        = conf.DB.connection.pass; 
    remoteIP        = conf.DB.connection.remoteIP;
    DatabaseName    = user;  
    grafanaUserName = 'grafanareader';
    tmpPathOut      = '/tmp/';
    outputFileName  = ['createsDB-' DatabaseName '.sh'];

    DB = struct('schema', []);


    for i = 1:length(conf.dev)
        dev = conf.dev(i);

        if ~isValidDevice(dev)
            continue;
        end

        LUTfile = getLUTFile(dev);

        try
            LUT = readLookUpTable(LUTfile);
            for col = 1:size(LUT, 2)
                try
                    devName = LUT{3, col};
                    devsubName = LUT{4, col};
                    tableName  = LUT{2, col};
                    tableType  = "REAL";

                    if isempty(devName) || isempty(tableName)
                        continue;
                    end
                    schemaName = [devName, devsubName];
                    DB = addToDB(DB, schemaName, tableName, tableType);
                catch
                  
                end
            end
        catch
        
        end
    end

    %% file .sh
    fid = fopen(fullfile(tmpPathOut, outputFileName), 'w');

    fprintf(fid, 'sudo -u postgres psql -f - << EOF\n');
    createUser(fid, user, password);
    createDB(fid, DatabaseName, user);
    fprintf(fid, '\nEOF\n');

    writeHeader(fid, user, password, remoteIP, DatabaseName);

    for i = 1:length(DB.schema)
        createSchema(fid, DB.schema(i).name);
    end

    for i = 1:length(DB.schema)
        schemaName = DB.schema(i).name;
        for j = 1:length(DB.schema(i).table)
            tableName = DB.schema(i).table(j).name;
            tableType = DB.schema(i).table(j).type;
            createTable(fid, schemaName, tableName, tableType);
        end
    end

    for i = 1:length(DB.schema)
        grantSelect(fid, DB.schema(i).name, grafanaUserName);
        grantUsage(fid, DB.schema(i).name, grafanaUserName);
    end

    installTableFunc(fid);
    writeFooter(fid);
    fclose(fid);

    makeFileExecutable(fullfile(tmpPathOut, outputFileName));
    fprintf('\n=== File created in %s\n', fullfile(tmpPathOut, outputFileName));
end
