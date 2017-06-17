function source_main(w,PathToResults)
% main file for source set

%% parameters for patch extraction
    no_source_patches = 500;
    entropy_thresh = 3;

%% extract patches and save in the result folder

    Xs = getSourcePatches(w, no_source_patches, entropy_thresh);
    save(strcat(PathToResults,'Source_Patches.mat'),'Xs','entropy_thresh');

%% perform PCA 

    [s_coeff, ~, ~, ~, s_explained] = pca(Xs');
    save(strcat(PathToResults,'Source_PCA.mat'),'s_coeff','s_explained');
end    