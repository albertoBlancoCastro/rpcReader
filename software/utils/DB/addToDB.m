function DB = addToDB(DB, schemaName, tableName, tableType)
    schemaExists = false;
    for s = 1:length(DB.schema)
        if strcmp(DB.schema(s).name, schemaName)
            schemaExists = true;
            tableNames = {DB.schema(s).table.name};
            if ~ismember(tableName, tableNames)
                newTableIndex = length(DB.schema(s).table) + 1;
                DB.schema(s).table(newTableIndex).name = tableName;
                DB.schema(s).table(newTableIndex).type = tableType;
            end
            return;
        end
    end
    newSchemaIndex = length(DB.schema) + 1;
    DB.schema(newSchemaIndex).name = schemaName;
    DB.schema(newSchemaIndex).table(1).name = tableName;
    DB.schema(newSchemaIndex).table(1).type = tableType;
end