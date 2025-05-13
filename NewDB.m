% novo - criação de base de dados a partir das configurações 
%% Configurações da DB
clear all;

user            = 'ms03m2';      
password        = 'ms03m2@lip'; 
remoteIP        = 'localhost';
DatabaseName    = user;  
grafanaUserName = 'grafanareader';

% Caminho e nome do arquivo de saída
tmpPathOut      = '/tmp/';
outputFileName  = ['createsDB-' DatabaseName '.sh'];
%% Importar dados




%% extrair os dados e convertê-los no formato necessário 
function DB = convertLookUpToDB(lookupTables)
    DB.schema = [];
    for i = 1:length(lookupTables.tables)
        DB.schema(i).name = lookupTables.tables(i).name;
        for j = 1:size(lookupTables.tables(i).channels,1)
            DB.schema(i).table(j).name = lookupTables.tables(i).channels{j,1};
            DB.schema(i).table(j).type = lookupTables.tables(i).channels{j,2};
        end
    end
end



%% %% Criar o arquivo .sh
fid = fopen(fullfile(tmpPathOut, outputFileName), 'w');

%fprintf(fid, 'sudo -i -u postgres\n');
fprintf(fid,'sudo -u postgres psql -f - << EOF\n');
createUser(fid,user,password);
createDB(fid,DatabaseName,user);
fprintf(fid, "\nEOF\n");
writeHeader(fid,user,password,remoteIP,DatabaseName);

% % Criar os schemas
for i = 1:length(DB.schema)
    createSchema(fid, DB.schema(i).name);
end

% Criar as tabelas dentro de cada schema
for i = 1:length(DB.schema)
    schemaName = DB.schema(i).name;
    for j = 1:length(DB.schema(i).table)
        tableName = DB.schema(i).table(j).name;
        tableType = DB.schema(i).table(j).type;
        createTable(fid, schemaName, tableName, tableType);
    end
end

% Permissões 
for i = 1:length(DB.schema)
    grantSelect(fid, DB.schema(i).name, grafanaUserName);
    grantUsage(fid, DB.schema(i).name, grafanaUserName);
end

% Instalar extensões
installTableFunc(fid);

% Fechar script
writeFooter(fid);
fclose(fid);

% Tornar o arquivo executável
makeFileExecutable(fullfile(tmpPathOut, outputFileName));
fprintf('\n=== Arquivo gerado em %s\n', fullfile(tmpPathOut, outputFileName));

%% funcoes auxiliares
function createUser(fid, username, password)
    username= escapeSpecialCharacters(username); % future-proof: in case someone wants to create an user with chars like %,\, or '
    password= escapeSpecialCharacters(password); % future-proof: in case someone wants to create a  DB   with chars like %,\, or '

    count = fprintf(fid,'\n');
    count = fprintf(fid,['CREATE USER "' username '" WITH password ''' password ''';\n']);

end

function createDB(fid, database, username)
    username= escapeSpecialCharacters(username); % future-proof: in case someone wants to create an user with chars like %,\, or '
    database= escapeSpecialCharacters(database); % future-proof: in case someone wants to create a  DB   with chars like %,\, or '
    count = fprintf(fid,'\n');
    count = fprintf(fid,['CREATE DATABASE "' database '" WITH OWNER "' username '";\n']);
    count = fprintf(fid,['\\connect "' database '"\n']);
end

function createSchema(fid, schema)
    % this creates a new schema
    schema= escapeSpecialCharacters(schema); % future-proof: in case someone wants to create a schema with chars like %,\, or '
    count = fprintf(fid,['\n']);
    count = fprintf(fid,['CREATE SCHEMA "' char(schema) '"; \n']);
end

function writeFooter(fid)
    fprintf(fid, "\nEOF\n");
end

 function writeHeader(fid,user, password, remoteIP, DatabaseName)
     count = fprintf(fid,['PGPASSWORD=' password ' psql -U ' user ' -h ' remoteIP '  -d ' DatabaseName ' -f - <<EOF\n']);
 end

function createTable(fid,schema,tablename,tabletype)
    % this creates a new table inside a given schema;
    % the table has 2 columns: a timestamp column and a values collumn;
    schema= escapeSpecialCharacters(schema); % future-proof: in case someone wants to create a schema with chars like %,\, or '
    tablename= escapeSpecialCharacters(tablename); % future-proof: in case someone wants to create a table with chars like %,\, or '

    count = fprintf(fid,['\n']);
    count = fprintf(fid,['CREATE TABLE "' char(schema) '"."' char(tablename) '" (\n']);
    count = fprintf(fid,['timestamps TIMESTAMP UNIQUE,\n']);
    count = fprintf(fid,['"values" ' char(upper(tabletype)) ' ); \n']); 
    
end

function grantSelect(fid,schema,grafanaUserName)
    schema= escapeSpecialCharacters(schema); % future-proof: in case someone creates a schema with chars like %,\, or '
    grafanaUserName = escapeSpecialCharacters(grafanaUserName);% future-proof: in case someone creates a user with chars like %,\, or '

    count = fprintf(fid,['\n']);
    count = fprintf(fid,['GRANT SELECT ON ALL TABLES IN SCHEMA "' char(schema) '" TO ' grafanaUserName ';\n']);
end

function grantUsage(fid,schema,grafanaUserName)
    schema= escapeSpecialCharacters(schema);    % future-proof: in case someone creates a schema with chars like %,\, or '
    grafanaUserName = escapeSpecialCharacters(grafanaUserName);% future-proof: in case someone creates a user with chars like %,\, or '

    count = fprintf(fid,['\n']);
    count = fprintf(fid,['GRANT USAGE ON SCHEMA "' char(schema) '" TO ' grafanaUserName ';\n']);
end

function installTableFunc(fid)
    % installs sql commands there are not there by default; just like a
    % MATLAB toolbox or a python library; it is necessary to make 1D and 2D
    % histograms
    count = fprintf(fid,'\n');
    count = fprintf(fid,'CREATE EXTENSION tablefunc WITH SCHEMA public;\n');
end

function makeFileExecutable(filename)
    system(['chmod +x ' filename]);
end

function x = escapeSpecialCharacters(x)
    % As I'm creating a script that outputs text files, I need to be
    % careful with special characters of the fprintf() syntax. This
    % auxiliary funtion solves that.
    x = regexprep(x, '%', '%%');
    x = regexprep(x, '\\', '\\\');
    x = regexprep(x, '''', '''''');
end