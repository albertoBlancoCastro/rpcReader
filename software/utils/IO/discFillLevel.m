function result = discFillLevel(UUID)


    [status,result] = system(['df --output=pcent $(findmnt -no TARGET -S UUID=' UUID ') | tail -n 1 | tr -d '' %'' ']);
    result = str2num(result);

return
