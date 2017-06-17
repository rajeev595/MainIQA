% main file for the target set    
    mkdir('..', 'results');
    MainPath = '../results/';
    w = 33;
    
    no_target_patches = 4000; % number of target patches
    entropy_thresh = 3;
    
% extract patches and save in the result folder
    data = 1;
    for distortion = 2 : 4
        getTargetPatches(w,no_target_patches,entropy_thresh,distortion,data, MainPath);
%        doTargetPCA(distortion,data, MainPath);
        getScores(distortion,data,MainPath,MainPath);
        spearmanScore(distortion,data,MainPath);        
    end