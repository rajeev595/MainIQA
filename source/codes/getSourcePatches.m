function Xs = getSourcePatches(w,no_source_patches,entropy_thresh)

% Path to the data directory
    data_path = '../source/data/';

% reading the images
    files = dir('../source/data/img*');
    noFiles = size(files);
    
% Initializing the source data to empty matrix
    Xs = [];

    for i = 1 : noFiles
    % reading ith image from the data
        img = files(i,1).name;
    % Adding the image path
        img = strcat(data_path,img);
        I = imread(img);
    % Converting a color image to grayscale
        if(size(I, 3) ~= 1)
            I = rgb2gray(I);
        end      
        
    % Extracting random patches
        P = getPatchesDict(I, w, entropy_thresh);
        noPatches = size(P, 2);
        
    % Selecting the patches randomly
        if (noPatches < no_source_patches)
            patch_inds = randsample(noPatches, noPatches);
        else
            patch_inds = randsample(noPatches, no_source_patches);
        end
        
    % Converting to double
        P = im2double(P);
        
    % Adding the patches of each image to source data
        Xs = [Xs P(:,patch_inds)];
    end
end           