mTemplates = read_tpl_file(filename)
fid = fopen(filename);
if (fid == -1)
    errordlg([filename 'could not be opened for reading']);
    return
end

mTemplates = [];
while ~feof(fid)
    strLine = fgetl(fid);
    mTemplate = sscanf(strLine, '%f%f', [2,1]);
    mTemplates = [mTemplates mTemplate];
end


fclose (fid);
end
