% Lake Monitoring
% Ali Tokur   
% Computer Engineer - alitokurr@gmail.com 
% Preparing the Dataset

B = double(imread("T33PVQ_20191105T092151_B04_60m.jp2"));
G = double(imread("T33PVQ_20191105T092151_B03_60m.jp2"));
NIR = double(imread("T33PVQ_20191105T092151_B8A_60m.jp2"));
MIR = double(imread("T33PVQ_20191105T092151_B11_60m.jp2")); 

% first index method
NDPI = (MIR-G)./(MIR+G); 