function createUser(fid, username, password)
    username = escapeSpecialCharacters(username);
    password = escapeSpecialCharacters(password);
    fprintf(fid, '\n');
    fprintf(fid, ['CREATE USER "' username '" WITH password ''' password ''';\n']);
end