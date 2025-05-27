function LUT = readLookUpTable(LUTfile)
    if ~exist(LUTfile, 'file')
        error("LUT file '%s' not found.", LUTfile);
    end
    S = loadLUTasStruct(LUTfile);
    if ~isfield(S, 'distributionLookUpTable')
        error("File '%s' does't have the variable 'distributionLookUpTable'.", LUTfile);
    end
    LUT = S.distributionLookUpTable;
end