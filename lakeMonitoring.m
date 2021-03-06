% Lake Monitoring
% Ali Tokur   
% Computer Engineer - alitokurr@gmail.com 
%%

% Testing the indexes & Preparing the Dataset
TCI = imread("T31PFM_20191207T100411_TCI_60m.jp2");
B=imread("T31PFM_20191207T100411_B02_60m.jp2");
G=imread("T31PFM_20191207T100411_B03_60m.jp2");
R=imread("T31PFM_20191207T100411_B04_60m.jp2");
NIR=imread("T31PFM_20191207T100411_B8A_60m.jp2");
SWIR1=imread("T31PFM_20191207T100411_B11_60m.jp2");
SWIR2=imread("T31PFM_20191207T100411_B12_60m.jp2");

B2 = double(B); 
G2 = double(G);
R2 = double(R);
NIR2 = double(NIR);
SWIR12 = double(SWIR1); 
SWIR22 = double(SWIR2);

% figure; imshow(TCI);
% figure; imshow(B);
% figure; imshow(G);
% figure; imshow(R);
% figure; imshow(NIR);
% figure; imshow(SWIR1);
% figure; imshow(SWIR2);

%% first index method
ndvi = (NIR2-R2)./(NIR2+R2);
ndvi_gao = (NIR2-SWIR12)./(NIR2+SWIR12); %gao 1995
ndwi = (G2-NIR2)./(G2+NIR2); %mc feeters 1996
ndwi_2 = (R2-SWIR12)./(R2+SWIR12); % rogers and kearney 2004
mndwi = (G2-SWIR12)./ (G2+SWIR12); % hanqiu xu 2006
ndpi = (SWIR12-G2)./(SWIR12+G2); % lacaux 2007
ewi = (G2-NIR2-SWIR12)./(G2+NIR2+SWIR12); %yan 2007
nwi = (B2-(NIR2+SWIR12+SWIR22))./(B2+(NIR2+SWIR12+SWIR22)); %ding 2009
new = (B2-SWIR22)./(B2+SWIR22); %xiao 2010
ndwi_b = (B2-NIR2)./(B2+NIR2); %qu 
awei = 4*(G2-SWIR12)-((0.25*NIR2)+(2.75*SWIR22)); %feyisa 2014
awei_ns = B2 + (2.5*G2) - 1.5*(NIR2+SWIR12)-(0.25*SWIR22); %feyisa 2014,

% figure('Name','ndvi'); imshow(ndvi);
% figure('Name','ndvi_gao'); imshow(ndvi_gao);
% figure('Name','ndwi'); imshow(ndwi);
% figure('Name','ndvi_2'); imshow(ndwi_2);
% figure('Name','mndwi'); imshow(mndwi);
% figure('Name','ndpi'); imshow(ndpi);
% figure('Name','ewi'); imshow(ewi);
% figure('Name','nwi'); imshow(nwi);
% figure('Name','new'); imshow(new);
% figure('Name','ndvi_b'); imshow(ndwi_b);
% figure('Name','awei'); imshow(awei);
% figure('Name','awei_ns'); imshow(awei_ns);


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
firstrth=(1:80750);
waterNew = Water(firstrth(1:80750),:);
% Rth = 2:2:37218;
% waterNew = waterNew(Rth(1:18600),:);
% rand_n = randperm(75647);
% waterNew = waterNew(rand_n(1:75647),:);

%%
% firstrth=(1:30232);
% landNew = Land(firstrth(1:30232),:);
Rth = 5:5:756470;
landNew = Land(Rth(1:151294),:);
rand_n = randperm(80750);
landNew = landNew(rand_n(1:80750),:);

%%
fid = fopen('features.txt','wt');
fprintf(fid,'R G B \n');
for ii = 1:size(waterNew,1)
    fprintf(fid,'%g ',waterNew(ii,:));
    fprintf(fid,'\n');
end

for ii = 1:size(landNew,1)
    fprintf(fid,'%g ',landNew(ii,:));
    fprintf(fid,'\n');
end


fclose(fid);

%%

f3 = fopen('allClass.txt','w+');
fprintf(f3,'Class\n');
for i=1:(size(waterNew,1)+size(landNew,1))
    if (i<=size(waterNew,1))
        fprintf(f3,'Water');
        fprintf(f3,'\n');
        
    else
        fprintf(f3,'Land');
        fprintf(f3,'\n');
        
    end
end
fclose(f3);
%%
% fid = fopen('allClass.txt');
% data = textscan(fid,'%s');
% fclose(fid);
%%
class = readtable('allClass.txt');
%%
features = readtable('features.txt');
%%
T = [features class];
%%
writetable(T,'data.txt');


% %%
% rgbFeatures = [A data];
% rgbFeatures = array2table(rgbFeatures);
% %%
% writetable(rgbFeatures,'myData.txt','Delimiter',' ');  
% type 'myData.txt';

%%
% f4 = fopen('allClass.txt','r');
% formatSpec = '%d';
% sizeClass = [1 (size(waterNew,1)*2)];
% allClass = fscanf(file_4,formatSpec,sizeClass);
% allClass=allClass';
% fclose(f4);










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

