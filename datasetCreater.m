% %%dataset creating
% TCI = imread("T33PVQ_20191105T092151_TCI_60m.jp2");
% f1 = fopen('mark.txt','w+');
% for ii = 1:size(TCI,1)
%     for jj=1:size(TCI,1)
%         fprintf(f1,'%d %d %d',TCI(ii,jj,1),TCI(ii,jj,2),TCI(ii,jj,1));
%         fprintf(f1,'\n');
%     end
% end
% fclose(f1);

f3 = fopen('allClass.txt','w+');

for foo=1:8000
    if (foo<=4000)
        fprintf(f3,'1');
        fprintf(f3,'\n');
        
    else
        fprintf(f3,'2');
        fprintf(f3,'\n');
        
    end
end

