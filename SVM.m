%%final
%%
file_1 = fopen('features.txt','r');
formatSpec = '%d %d %d';
sizeA = [3 (size(waterNew,1)+size(landNew,1))];
A = fscanf(file_1,formatSpec,sizeA);
A=A';
%%
file_2 = fopen('allClass.txt','r');
formatSpec = '%d';
sizeB = [1 (size(waterNew,1)+size(landNew,1))];
B = fscanf(file_2,formatSpec,sizeB);
B=B';


%%
file_3 = fopen('mark.txt','r');
formatSpec = '%d %d %d';
sizeC = [3 3348900];
C = fscanf(file_3,formatSpec,sizeC);
C=C';
%%
file_4 = fopen('allResults.txt','r');
formatSpec = '%d';
sizeD = [1 3348900];
D = fscanf(file_4,formatSpec,sizeD);
D=D';

%%
X = A;
y = B;
%%
%90 : %10
rand_num = randperm(141294);
X_train = X(rand_num(1:131294),:);
y_train = y(rand_num(1:131294),:);

X_test = X(rand_num(131295:end),:);
y_test = y(rand_num(131295:end),:);

%%
c = cvpartition(y_train,'k',5);

%% feature selection
%     classf = @(train_data, train_labels, test_data, test_labels)...
%     sum(predict(fitcsvm(train_data, train_labels,'KernelFunction','rbf'), test_data) ~= test_labels);
%     opts = statset('display','iter');
% 
%     [fs, history] = sequentialfs(classf, X_train, y_train, 'cv', c, 'options', opts,'nfeatures',2);
    
%% Best hyperparameter
%% X_train_w_best_feature = X_train(:,fs);
    
%%
% Md1 = fitcsvm(X_train_w_best_feature,y_train,'KernelFunction','rbf','OptimizeHyperparameters','auto',...
%       'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
%       'expected-improvement-plus','ShowPlots',true));
Md1 = fitcsvm(X_train,y_train,'KernelFunction','rbf','OptimizeHyperparameters','auto',...
      'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
      'expected-improvement-plus','ShowPlots',false));  
  

%% Final test with test set
% X_test_w_best_feature = X_test(:,fs);
% test_accuracy_for_iter = sum((predict(Md1,X_test_w_best_feature) == y_test))/length(y_test)*100
%%
% 
% C = C(:,fs);  

 test_accuracy_for_iter = sum((predict(Md1,X_test) == y_test))/length(y_test)*100;


%
% figure;
% hgscatter = gscatter(X_train(:,1),X_train(:,2),y_train);
% hold on;
% h_sv=plot(Md1.SupportVectors(:,1),Md1.SupportVectors(:,2),'ko','markersize',4);

%%
% gscatter(X_test,X_test,y_test,'rb','xx')
%%
allPixelValue = predict(Md1,C);
new_test_accuracy_for_iter = sum((predict(Md1,C) == D))/length(D)*100;

%%

ColumnMatrix = vec2mat(allPixelValue,1830);


%%
% newTaggedImage = zeros(1830,1830);
for i=1:1830
    for j=1:1830
        if(ColumnMatrix(i,j)==2)
           ColumnMatrix(i,j)=0;
        end
    end
end

