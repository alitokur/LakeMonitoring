% Lake Monitoring
% Ali Tokur   
% Computer Engineer - alitokurr@gmail.com 
%%

% Testing the indexes & Preparing the Dataset
TCI = imread("T33PVQ_20190723T092039_TCI_60m.jp2");
% B = double(imread("T33PVQ_20190728T092031_B02_20m.jp2"));
G = double(imread("T33PVQ_20190723T092039_B03_60m.jp2"));
% R = double(imread("T33PVQ_20190728T092031_B04_20m.jp2"));
NIR = double(imread("T33PVQ_20190723T092039_B8A_60m.jp2"));
SWIR1 = double(imread("T33PVQ_20190723T092039_B11_60m.jp2")); 
SWIR2 = double(imread("T33PVQ_20190723T092039_B12_60m.jp2"));

%% first index method
% ndvi = (NIR-R)./(NIR+R); 
% ndvi_gao = (NIR-SWIR1)./(NIR+SWIR1); %gao 1995
% ndwi = (G-NIR)./(G+NIR); %mc feeters 1996
% ndwi_2 = (R-SWIR1)./(R+SWIR1); % rogers and kearney 2004
% mndwi = (G-SWIR1)./ (G+SWIR1); % hanqiu xu 2006
% ndpi = (SWIR1-G)./(SWIR1+G); % lacaux 2007
% ewi = (G-NIR-SWIR1)./(G+NIR+SWIR1); %yan 2007
% nwi = (B-(NIR+SWIR1+SWIR2))./(B+(NIR+SWIR1+SWIR2)); %ding 2009
% new = (B-SWIR2)./(B+SWIR2); %xiao 2010
% ndwi_b = (B-NIR)./(B+NIR); %qu 
awei = 4*(G-SWIR1)-((0.25*NIR)+(2.75*SWIR2)); %feyisa 2014
% awei_ns = B + (2.5*G) - 1.5*(NIR+SWIR1)-(0.25*SWIR2); %feyisa 2014,
% imgGauss = imgaussfilt(awei,2);
%% lets start with awei 
prompt = 'Pixel araligini belirtin ?';
x = input(prompt);

%%
y= 1830/x;
taggedImage = zeros(y,y);
foo=1;
bar=1;
for i=x:x:1830
    for j=x:x:1830
        if(awei(i,j)<0)
            taggedImage(foo,bar)=0;
        else
            taggedImage(foo,bar)=1;
        end
        bar=bar+1;
    end
    foo=foo+1;
    bar=1;
end

%to write the classes to file.
%not all pixel
%%
f1 = fopen('rgbFeaturesForWater.txt','w+');
f2 = fopen('rgbFeaturesForLand.txt','w+');
foo=1;
bar=1;
counter_1=0;
counter_2=0;

for ii = x:x:size(TCI,1)
    for jj=x:x:size(TCI,1)
        if (taggedImage(foo,bar)==1)
        fprintf(f1,'%d %d %d',TCI(ii,jj,1),TCI(ii,jj,2),TCI(ii,jj,3));
        fprintf(f1,'\n');
        counter_1 = counter_1+1;
        else
        fprintf(f2,'%d %d %d',TCI(ii,jj,1),TCI(ii,jj,2),TCI(ii,jj,3));
        fprintf(f2,'\n');
        counter_2 = counter_2+1;
        end
        bar=bar+1;
    end
    foo=foo+1;
    bar=1;
 end
fclose(f1);
fclose(f2);




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
firstrth=(1:4600);
waterNew = Water(firstrth(1:4600),:);
% Rth = 2:2:37218;
% waterNew = waterNew(Rth(1:18600),:);

%%
firstrth=(1:28880);
landNew = Land(firstrth(1:28880),:);
Rth = 5:5:28880;
landNew = Land(Rth(1:5776),:);
rand_n = randperm(4600);
landNew = landNew(rand_n(1:4600),:);

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

%%

f3 = fopen('allClass.txt','w+');

for i=1:(size(waterNew,1)*2)
    if (i<=size(waterNew,1))
        fprintf(f3,'1');
        fprintf(f3,'\n');
        
    else
        fprintf(f3,'2');
        fprintf(f3,'\n');
        
    end
end
fclose(f3);














%%
%preparing the train dataset
%  data1 = zeros(100,2);
%  data2 = zeros(100,2);
% 
% file_1 = fopen('trainDataForLand.txt','r');
% formatSpec = '%d %d %d %d %d %d';
% sizeA = [6 100];
% A = fscanf(file_1,formatSpec,sizeA);
% A=A';
% 
% file_2 = fopen('trainDataForWater.txt','r');
% formatSpec = '%d %d %d %d %d %d';
% sizeB = [6 100];
% B = fscanf(file_2,formatSpec,sizeB);
% B=B';

% rng(1); % For reproducibility
% x = randi([1 2799648],100,1); %x
% y = randi([1 549250],100,1); %y
% 

% for ii= 1:100
% data1(ii,1) = A(ii,5);
% data1(ii,2) = A(ii,6);
% end
% 
%  for ii= 1:100
% data2(ii,1) = B(ii,5);
% data2(ii,2) = B(ii,6);
% end
% % 
% figure;
% plot(data1(:,1),data1(:,2),'r.','MarkerSize',10)
% hold on
% plot(data2(:,1),data2(:,2),'b.','MarkerSize',10)
% % ezpolar(@(x)1);
% % ezpolar(@(x)2);
% axis equal
% hold off
% 
% data3 = [data1;data2];
% theclass = ones(200,1);
% theclass(1:100) = -1;
% 
% %Train the SVM Classifier
% cl = fitcsvm(data3,theclass,'KernelFunction','rbf',...
%     'BoxConstraint',Inf,'ClassNames',[-1,1]);
% 
% % Predict scores over the grid
% d = 0.02;
% [x1Grid,x2Grid] = meshgrid(min(data3(:,1)):d:max(data3(:,1)),...
%     min(data3(:,2)):d:max(data3(:,2)));
% xGrid = [x1Grid(:),x2Grid(:)];
% [~,scores] = predict(cl,xGrid);
% 
% % Plot the data and the decision boundary
% figure;
% h(1:2) = gscatter(data3(:,1),data3(:,2),theclass,'rb','.');
% hold on
% % ezpolar(@(x)1);
% % h(3) = plot(data3(cl.IsSupportVector,1),data3(cl.IsSupportVector,2),'ko');
% % contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
% % legend(h,{'-1','+1','Support Vectors'});
% % axis equal
% % hold off

%  
%  for i=1:1830
%     for j=1:1830
%         if(allPixelClass(i*j)==1)
%             newTaggedImage(i,j)=1;
%         else
%             newTaggedImage(i,j)=0;
%         end
%     end
% end
% 

