% main file for the target set    
    mkdir('..', 'results');
    MainPath = '../results/';
    w = 11;
    
    no_target_patches = 4000; % number of target patches
    entropy_thresh = 3;
    
% extract patches and save in the result folder
    data = 3;
    for distortion = 2 : 4
        getTargetPatches(w,no_target_patches,entropy_thresh,distortion,data, MainPath);
%        doTargetPCA(distortion,data, MainPath);
        getScores(w,distortion,data,MainPath,MainPath);
        spearmanScore(distortion,data,MainPath);        
    end