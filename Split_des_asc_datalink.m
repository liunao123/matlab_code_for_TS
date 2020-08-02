
clear
txtpath = 'C:\Users\liu\Desktop\4301445796-download.txt';

fid = fopen(txtpath,'r');

num = 1;
%判断是不是读到了文件结尾
while ~feof(fid)
    name{num} = fgetl(fid);    
    abs_orb(num) = str2num(name{num}(89:94));
    num = num + 1;
end
fclose(fid)
orb =  mod(abs_orb - 73 , 175) + 1;
R_O = unique(orb);

newtxtfile = insertBefore(txtpath,'.txt','_new');
fid = fopen(newtxtfile,'w');

for m = 1:length(R_O)
    p = find(R_O(m) == orb);
    strt = ['relative orb :',num2str(R_O(m))];
    disp(strt);
    split_orb{m} = name(p)';
    
    fprintf(fid,'%s\n',strt);
    for n = 1:length(split_orb{m})
        eachline = split_orb{m}{n};
        fprintf(fid,'%s\n',eachline);
    end
    
end
fclose(fid);

clearvars -except R_O split_orb

