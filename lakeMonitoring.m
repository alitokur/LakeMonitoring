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
            newImage(i,j)=0;
        else
            newImage(i,j)=1;
        end
        end
    end
    





