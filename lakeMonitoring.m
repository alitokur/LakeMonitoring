% Lake Monitoring
% Ali Tokur   
% Computer Engineer - alitokurr@gmail.com 
% Testing the indexes & Preparing the Dataset
TCI = imread("T33PVQ_20191105T092151_TCI_60m.jp2");
B = double(imread("T33PVQ_20191105T092151_B02_60m.jp2"));
G = double(imread("T33PVQ_20191105T092151_B03_60m.jp2"));
R = double(imread("T33PVQ_20191105T092151_B04_60m.jp2"));
NIR = double(imread("T33PVQ_20191105T092151_B8A_60m.jp2"));
SWIR1 = double(imread("T33PVQ_20191105T092151_B11_60m.jp2")); 
SWIR2 = double(imread("T33PVQ_20191105T092151_B12_60m.jp2"));

% first index method
ndvi = (NIR-R)./(NIR+R); 
ndvi_gao = (NIR-SWIR1)./(NIR+SWIR1); %gao 1995
ndwi = (G-NIR)./(G+NIR); %mc feeters 1996
ndwi_2 = (R-SWIR1)./(R+SWIR1); % rogers and kearney 2004
mndwi = (G-SWIR1)./ (G+SWIR1); % hanqiu xu 2006
ndpi = (SWIR1-G)./(SWIR1+G); % lacaux 2007
ewi = (G-NIR-SWIR1)./(G+NIR+SWIR1); %yan 2007
nwi = (B-(NIR+SWIR1+SWIR2))./(B+(NIR+SWIR1+SWIR2)); %ding 2009
new = (B-SWIR2)./(B+SWIR2); %xiao 2010
ndwi_b = (B-NIR)./(B+NIR); %qu 
awei = 4*(G-SWIR1)-((0.25*NIR)+(2.75*SWIR2)); %feyisa 2014
awei_ns = B + (2.5*G) - 1.5*(NIR+SWIR1)-(0.25*SWIR2); %feyisa 2014,

% lets start with awei 
for i=1:1830
    for j=1:1830
        if(awei(i,j)<0)
            taggedImage(i,j)=0;
        else
            taggedImage(i,j)=1;
        end
    end
end

%to write the classes to file.

% f1 = fopen('rgbFeaturesForWater.txt','w+');
% f2 = fopen('rgbFeaturesForLand.txt','w+');
% fprintf(f1,'# x     y   R   G  B');

% counter_1=0;
% counter_2=0;
% for ii = 1:size(TCI,1)
%     for jj=1:size(TCI,1)
%         if (taggedImage(ii,jj)==1)
%         fprintf(f1,'%d %d %d %d %d %d',counter_1,ii,jj,TCI(ii,jj,1),TCI(ii,jj,2),TCI(ii,jj,3));
%         fprintf(f1,'\n');
%         counter_1 = counter_1+1;
%         else
%         fprintf(f2,'%d %d %d %d %d %d',counter_2,ii,jj,TCI(ii,jj,1),TCI(ii,jj,2),TCI(ii,jj,3));
%         fprintf(f2,'\n');
%         counter_2 = counter_2+1;
%         end
%     end
% end
% fclose(f1);
% fclose(f2);

%preparing the train dataset
 data1 = zeros(100,2);
 data2 = zeros(100,2);

file_1 = fopen('trainDataForLand.txt','r');
formatSpec = '%d %d %d %d %d %d';
sizeA = [6 100];
A = fscanf(file_1,formatSpec,sizeA);
A=A';

file_2 = fopen('trainDataForWater.txt','r');
formatSpec = '%d %d %d %d %d %d';
sizeB = [6 100];
B = fscanf(file_2,formatSpec,sizeB);
B=B';

% rng(1); % For reproducibility
% x = randi([1 2799648],100,1); %x
% y = randi([1 549250],100,1); %y
% 

for ii= 1:100
data1(ii,1) = A(ii,5);
data1(ii,2) = A(ii,6);
end

 for ii= 1:100
data2(ii,1) = B(ii,5);
data2(ii,2) = B(ii,6);
end


     





