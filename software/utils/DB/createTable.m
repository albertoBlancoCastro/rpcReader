function createTable(fid, schema, tablename, tabletype)
    schema = escapeSpecialCharacters(schema);
    tablename = escapeSpecialCharacters(tablename);
    fprintf(fid, '\n');
    fprintf(fid, ['CREATE TABLE "' char(schema) '"."' char(tablename) '" (\n']);
    fprintf(fid, ['timestamps TIMESTAMP UNIQUE,\n']);
    fprintf(fid, ['"values" ' char(upper(tabletype)) ' ); \n']); 
end