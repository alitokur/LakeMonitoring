T = readtable('data.txt');
M = readtable('mark.txt');
C = readtable('Labels.txt');
C = table2cell(C);
%%Ensemble
[baggedTreesFit, baggedTreesAC,img_1] = predictionForModel(baggedTrees,M,C);
[boosteedTreesFit, boostedTreesAC,img_2] = predictionForModel(boostedTrees,M,C);
[rusBoostedTreesFit, rusBoostedTreesAC,img_3] = predictionForModel(rusBoostedTrees,M,C);
[subspaceDiscriminantFit, subspaceDiscriminantAC,img_4] = predictionForModel(subspaceDiscriminant,M,C);
[subspaceKnnFit, subspaceKnnAC,img_5] = predictionForModel(subspaceKnn,M,C);
[optimizableEnsembleFit, optimizableEnsembleAC,img_6] = predictionForModel(optimizableEnsemble,M,C);
%%SVM




