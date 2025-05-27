function writeHeader(fid, user, password, remoteIP, DatabaseName)
    fprintf(fid, ['PGPASSWORD=' password ' psql -U ' user ' -h ' remoteIP '  -d ' DatabaseName ' -f - <<EOF\n']);
end