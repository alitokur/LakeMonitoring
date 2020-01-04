%%dataset creating
f5 = fopen('mark.txt','w+');
for ii = 1:size(TCI,1)
    for jj=1:size(TCI,1)
        fprintf(f5,'%d %d %d',TCI(ii,jj,1),TCI(ii,jj,2),TCI(ii,jj,1));
        fprintf(f5,'\n');
    end
end
fclose(f5);

%%
f5 = fopen('allResults.txt','w+');


for ii = 1:1:size(TCI,1)
    for jj=1:1:size(TCI,1)
        if (awei(ii,jj)==1)
        fprintf(f5,'Water');
        fprintf(f5,'\n');
        else
        fprintf(f5,'Land');
        fprintf(f5,'\n');
        end
    end
   
 end
fclose(f5);



% f3 = fopen('allClass.txt','w+');
% 
% for foo=1:8000
%     if (foo<=4000)
%         fprintf(f3,'1');
%         fprintf(f3,'\n');
%         
%     else
%         fprintf(f3,'2');
%         fprintf(f3,'\n');
%         
%     end
% end
% 
