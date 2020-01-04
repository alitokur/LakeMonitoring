%%Linear SVM
N = array2table(C);
label3 = linearSVM.predictFcn(N);

%%


ColumnMatrix3 = vec2mat(label3,1830);
for i=1:1830
    for j=1:1830
        if(ColumnMatrix3(i,j)==2)
           ColumnMatrix3(i,j)=0;
        end
    end
end