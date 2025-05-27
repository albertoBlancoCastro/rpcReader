function valid = isValidDevice(dev)
    valid = isfield(dev, 'dcs') && isfield(dev.dcs, 'active') && ...
            isfield(dev.dcs, 'readable') && dev.dcs.active && dev.dcs.readable && ...
            isfield(dev.dcs, 'path') && isfield(dev.dcs, 'distributionLT') && isfield(dev.dcs.path, 'LT');
end

% getLUTFile.m
function LUTfile = getLUTFile(dev)
    LUTfile = fullfile(dev.dcs.path.LT, dev.dcs.distributionLT);
    if ~endsWith(LUTfile, '.m')
        LUTfile = [LUTfile '.m'];
    end
end