function grantUsage(fid, schema, grafanaUserName)
    schema = escapeSpecialCharacters(schema);
    grafanaUserName = escapeSpecialCharacters(grafanaUserName);
    fprintf(fid, '\n');
    fprintf(fid, ['GRANT USAGE ON SCHEMA "' char(schema) '" TO ' grafanaUserName ';\n']);
end