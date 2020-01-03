%%final
%%
file_1 = fopen('features.txt','r');
formatSpec = '%d %d %d';
sizeA = [3 600];
A = fscanf(file_1,formatSpec,sizeA);
A=A';
%%
file_2 = fopen('class.txt','r');
formatSpec = '%d %d %d';
sizeB = [1 600];
B = fscanf(file_2,formatSpec,sizeB);
B=B';

file_3 = fopen('mark.txt','r');
formatSpec = '%d %d %d';
sizeC = [3 3348900];
C = fscanf(file_3,formatSpec,sizeC);
C=C';

X = A;
y = B;
%%
%80 : %20
rand_num = randperm(600);
X_train = X(rand_num(1:480),:);
y_train = y(rand_num(1:480),:);

X_test = X(rand_num(481:end),:);
y_test = y(rand_num(481:end),:);

%%
c = cvpartition(y_train,'k',5);

%%
Md1 = fitcsvm(X_train,y_train,'KernelFunction','rbf','OptimizeHyperparameters','auto',...
      'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
      'expected-improvement-plus','ShowPlots',true));
%%  
test_accuracy_for_iter = sum((predict(Md1,X_test) == y_test))/length(y_test)*100; 

%%
% figure;
% hgscatter = gscatter(X_train(:,1),X_train(:,2),y_train);
% hold on;
% h_sv=plot(Md1.SupportVectors(:,1),Md1.SupportVectors(:,2),'ko','markersize',7-4);

%%
% gscatter(X_test,X_test,y_test,'rb','xx')
%%
allPixelValue=predict(Md1,C);
ColumnMatrix = vec2mat(allPixelValue,1830);
for i=1:1830
    for j=1:1830
        if(ColumnMatrix(i,j)==1)
            newTaggedImage(i,j)=1;
        else
            newTaggedImage(i,j)=0;
        end
    end
end

