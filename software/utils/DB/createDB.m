function createDB(fid, database, username)
    username = escapeSpecialCharacters(username);
    database = escapeSpecialCharacters(database);
    fprintf(fid, '\n');
    fprintf(fid, ['CREATE DATABASE "' database '" WITH OWNER "' username '";\n']);
    fprintf(fid, ['\\connect "' database '"\n']);
end