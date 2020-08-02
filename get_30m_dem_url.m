%str = 'https://e4ftl01.cr.usgs.gov/MEASURES/SRTMGL1.003/2000.02.11/N32E106.SRTMGL1.hgt.zip'
clear;
str = 'https://e4ftl01.cr.usgs.gov/MEASURES/SRTMGL1.003/2000.02.11/.SRTMGL1.hgt.zip';

%DEM AOI
lonmin = 100;
lonmax = 108;
latmin = 34;
latmax = 41;

%DEM num
num = 1;

for m=latmin:latmax
    for n=lonmin:lonmax
        newText = ['N',num2str(m,'%02d'),'E',num2str(n,'%03d')];
        newStr{num} = insertBefore(str,'.SRTMGL1',newText);
        num = num + 1;
    end    
end

newStr'