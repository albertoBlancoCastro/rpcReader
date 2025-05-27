function S = loadLUTasStruct(LUTfile)
    tmpFile = [tempname, '.mat'];
    evalin('base', sprintf('clear distributionLookUpTable; run(''%s''); save(''%s'', ''distributionLookUpTable'')', LUTfile, tmpFile));
    S = load(tmpFile);
    delete(tmpFile);
end