function mCoeffs = read_fcf_file(filename)
fid = fopen(filename);
if (fid == -1)
    error([filename 'could not be opened for reading']);
end

strDataMarker = 'Numerator:';
nDataFound = 0;
mCoeffs= [];
while ~feof(fid)
    strLine = fgetl(fid);
    if nDataFound == 0
        if strncmp(strDataMarker, strLine, length(strDataMarker)) == 1
            nDataFound = 1;
        end
    else
        mCoeff = sscanf(strLine, '%f%f', [2,1]);
        mCoeffs = [mCoeffs mCoeff];
    end
end

if nDataFound == 0
    error (['No filter data found in ' filename]);
fclose (fid);
end



            

            