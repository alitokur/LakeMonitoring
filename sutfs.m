% taggedImage = zeros(183,183);
% %%
% foo = 1;
% bar = 1;
% for i=10:10:1830
%     for j=10:10:1830
%         if(awei(i,j)<0)
%             taggedImage(foo,bar)=0;
%         else
%             taggedImage(foo,bar)=1;
%         end
%        bar=bar+1; 
%     end
%     foo=foo+1;
%     bar=1;
% end

% for i=30:30:180
%     disp(i);
% end;
%%

file_1 = fopen('rgbFeaturesForWater.txt','r');
formatSpec = '%d %d %d';
sizeLand = [3 (counter_1)];
Water = fscanf(file_1,formatSpec,sizeLand);
Water=Water';

file_2 = fopen('rgbFeaturesForLand.txt','r');
formatSpec = '%d %d %d';
sizeLand = [3 (counter_2)];
Land = fscanf(file_2,formatSpec,sizeLand);
Land=Land';

%%
first5k = 1:5000;
waterNew = Water(first5k(1:5000),:);
fourRth = 4:4:27976;
landNew = Land(fourRth(1:6994),:);

rand_n = randperm(5000);
landNew = landNew(rand_n(1:5000),:);

%%
fid = fopen('features.txt','wt');
for ii = 1:size(waterNew,1)
    fprintf(fid,'%g\t',waterNew(ii,:));
    fprintf(fid,'\n');
end

for ii = 1:size(landNew,1)
    fprintf(fid,'%g\t',landNew(ii,:));
    fprintf(fid,'\n');
end


fclose(fid);