T = readtable('data.txt');
M = readtable('mark.txt');
C = readtable('Labels.txt');
C = table2cell(C);
[baggedTreesFit, baggedTreesAC,img] = predictionForModel(baggedTrees,M,C);


