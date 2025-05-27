function grantSelect(fid, schema, grafanaUserName)
    schema = escapeSpecialCharacters(schema);
    grafanaUserName = escapeSpecialCharacters(grafanaUserName);
    fprintf(fid, '\n');
    fprintf(fid, ['GRANT SELECT ON ALL TABLES IN SCHEMA "' char(schema) '" TO ' grafanaUserName ';\n']);
end
