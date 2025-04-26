function exportMingoData(inputvars)

inPath      = inputvars{1};
outPath     = inputvars{2};

s = dir([inPath '*.mat']);
load([inPath s(1).name]);



 
M = full([datevec(EBtime) triggerType T1_F T1_B Q1_F Q1_B T2_F T2_B Q2_F Q2_B T3_F T3_B Q3_F Q3_B T4_F T4_B Q4_F Q4_B]);% T1_F T1_B Q1_F Q1_B T2_F T2_B Q2_F Q2_B T3_F T3_B Q3_F Q3_B T4_F T4_B Q4_F Q4_B]);
  
file2Open = [outPath s(1).name(1:end-4) '.dat']
 
 
    openFile;
    fprintf(fp,...
    ['%04d %02d %02d %02d %02d %02d  %01d   ' ...
    '%09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f   %09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f   '...
    '%09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f   %09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f   '...
    '%09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f   %09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f   '...
    '%09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f   %09.4f %09.4f %09.4f %09.4f  %09.4f %09.4f %09.4f %09.4f\n'],M');
    fclose(fp);

return