file_1 = fopen('features.txt','r');
formatSpec = '%d %d %d';
sizeA = [3 (size(waterNew,1)+size(landNew,1))];
A = fscanf(file_1,formatSpec,sizeA);
A=A';

file_2 = fopen('allClass.txt','r');
formatSpec = '%d';
sizeB = [1 (size(waterNew,1)+size(landNew,1))];
B = fscanf(file_2,formatSpec,sizeB);
B=B';

C = [A B];

T = array2table(C);

%%
% chiSqrDist = @(x,Z,wt)sqrt((bsxfun(@minus,x,Z).^2)*wt);
k = 5;
% w = [0.3; 0.3; 0.2; 0.2];
Mdl = fitcknn(A,B,'NumNeighbors',5,'Standardize',1);
% KNNMdl = fitcknn(A,B,'Distance',@(x,Z)chiSqrDist(x,Z,w),...
%     'NumNeighbors',k,'Standardize',1);

rng(1)
Mdl = fitcknn(A,B,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'))

%%
% 
% rng(1); % For reproducibility
% CVKNNMdl = crossval(KNNMdl);
% classError = kfoldLoss(CVKNNMdl);

%%

label = predict(Mdl,C);

%%
ColumnMatrix2 = vec2mat(label,1830);
for i=1:1830
    for j=1:1830
        if(ColumnMatrix2(i,j)==2)
           ColumnMatrix2(i,j)=0;
        end
    end
end

