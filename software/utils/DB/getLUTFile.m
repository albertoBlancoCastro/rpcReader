function LUTfile = getLUTFile(dev)
    LUTfile = fullfile(dev.dcs.path.LT, dev.dcs.distributionLT);
    if length(LUTfile) < 2 || ~strcmp(LUTfile(end-1:end), '.m')
        LUTfile = [LUTfile '.m'];
    end

    if ~exist(LUTfile, 'file')
        LUTfile = '';
    end
end
