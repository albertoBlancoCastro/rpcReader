function installTableFunc(fid)
    fprintf(fid, '\n');
    fprintf(fid, 'CREATE EXTENSION tablefunc WITH SCHEMA public;\n');
end