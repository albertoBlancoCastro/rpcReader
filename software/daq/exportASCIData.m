function exportASCIData(inputvars)



inPath        = inputvars{1};
outPath       = inputvars{2};
zipOutput     = inputvars{3};
lookUpTables  = inputvars{4};
systemName    = inputvars{5};

s = dir([inPath '*.mat']);
load([inPath s(1).name]);


name2Open  = [s(1).name(1:end-4) '.dat'];
file2Open = [outPath name2Open];
openFile;

run([lookUpTables systemName 'export2asic.m']);

fclose(fp);

if zipOutput
    [~, ~] = system(['tar -czvf ' outPath  name2Open '.tar.gz -C ' outPath ' ' name2Open ';']);
    [~, ~] = system(['rm -r ' file2Open]);
end

return


['tar -czvf ' inPath 'done' b fileListRun(hldFile).fileName '.tar.gz -C ' inPath 'done' b ' ' fileListRun(hldFile).fileNameExt]