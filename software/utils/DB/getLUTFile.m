function LUTfile = getLUTFile(dev)
    LUTfile = fullfile(dev.dcs.path.LT, dev.dcs.distributionLT);
    if ~endsWith(LUTfile, '.m')
        LUTfile = [LUTfile '.m'];
    end
    if ~exist(LUTfile, 'file')
        LUTfile = '';
    end
end