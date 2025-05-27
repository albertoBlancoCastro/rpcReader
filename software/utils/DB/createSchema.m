function createSchema(fid, schema)
    schema = escapeSpecialCharacters(schema);
    fprintf(fid, '\n');
    fprintf(fid, ['CREATE SCHEMA "' char(schema) '"; \n']);
end