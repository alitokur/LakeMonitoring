function [x,y,img] = predictionForModel(n,M,C)
    x = n.predictFcn(M);
    counter = 0;
    for i = 1:3348900 
    if isequal(C(i), x(i))
    counter=counter+1; 
    end
    baggedTreesAC = counter/3348900*100;
    end
    y = baggedTreesAC;
    
    New=zeros(3348900,1);
    for i= 1:3348900 
    if strcmp(x{i},'Water')
    New(i,1)=1;  
    else
    New(i,1)=0;
    end
    end
    img = vec2mat(New,1830);
    
    
end