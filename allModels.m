T = readtable('data.txt');
%%
M = readtable('mark.txt');
%%
C = readtable('Labels.txt');
C = table2cell(C);
%% Ensemble
[baggedTreesFit, baggedTreesAC,img_1] = predictionForModel(baggedTrees,M,C);
[boosteedTreesFit, boostedTreesAC,img_2] = predictionForModel(boostedTrees,M,C);
[rusBoostedTreesFit, rusBoostedTreesAC,img_3] = predictionForModel(rusBoostedTrees,M,C);
[subspaceDiscriminantFit, subspaceDiscriminantAC,img_4] = predictionForModel(subspaceDiscriminant,M,C);
[subspaceKnnFit, subspaceKnnAC,img_5] = predictionForModel(subspaceKnn,M,C);
[optimizableEnsembleFit, optimizableEnsembleAC,img_6] = predictionForModel(optimizableEnsemble,M,C);
%% KNN
[fineKNNFit, fineKnnAC,img_7] = predictionForModel(fineKNN,M,C);
[mediumKNNFit, mediumKnnAC,img_8] = predictionForModel(mediumKNN,M,C);
[cosineKNNFit, cosineKnnAC,img_9] = predictionForModel(cosineKNN,M,C); %%not completed
[cubicKNNFit, cubicKnnAC,img_10] = predictionForModel(cubicKNN,M,C);
[weightedKNNFit, weightedKNNAC,img_11] = predictionForModel(weightedKNN,M,C);
%% Trees
[fineTreeFit, fineTreeAC,img_12] = predictionForModel(fineTree,M,C);
[mediumTree, mediumTreeAC,img_13] = predictionForModel(mediumTree,M,C);
[coarseTree, coarseTreeAC,img_14] = predictionForModel(coarseTree,M,C);

%% Discriminant
[linearDiscriminantFit, linearDiscriminantAC,img_15] = predictionForModel(linearDiscriminant,M,C);
[quadraticDiscriminantFit, quadraticDiscriminantAC,img_16] = predictionForModel(quadraticDiscriminant,M,C);

%%




