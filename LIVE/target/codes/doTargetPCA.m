function doTargetPCA(distortion,data, PathToResults)

    if(data == 1)        
        if(distortion == 1)       
            mkdir(strcat(PathToResults,'LIVE/jp2k'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/jp2k/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/jp2k/PCA/');         % Path to PCA
            noImages = 227;
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'LIVE/jpeg'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/jpeg/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/jpeg/PCA/');         % Path to PCA
            noImages = 233;
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'LIVE/wn'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/wn/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/wn/PCA/');         % Path to PCA
            noImages = 174;
        else
            mkdir(strcat(PathToResults,'LIVE/gblur'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/gblur/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/gblur/PCA/');         % Path to PCA
            noImages = 174;
        end
    elseif(data == 2)
        if(distortion == 1)       
            mkdir(strcat(PathToResults,'TID/jp2k'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/jp2k/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/jp2k/PCA/');         % Path to PCA
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'TID/jpeg'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/jpeg/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/jpeg/PCA/');         % Path to PCA
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'TID/wn'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/wn/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/wn/PCA/');         % Path to PCA
        else
            mkdir(strcat(PathToResults,'TID/gblur'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/gblur/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/gblur/PCA/');         % Path to PCA
        end
    elseif(data == 3)
        if(distortion == 1)       
            mkdir(strcat(PathToResults,'CSIQ/jp2k'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/jp2k/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/jp2k/PCA/');         % Path to PCA
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'CSIQ/jpeg'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/jpeg/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/jpeg/PCA/');         % Path to PCA
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'CSIQ/wn'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/wn/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/wn/PCA/');         % Path to PCA
        else
            mkdir(strcat(PathToResults,'CSIQ/gblur'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/gblur/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/gblur/PCA/');         % Path to PCA
        end
    end
   
    for i=1 : noImages;           
        patch = sprintf('Patches_img%d.mat',i);         % Extracting the name of the patch    
        patch = strcat(PathToPatches, patch);           % Adding the path to the patch    
        load(patch);                                    % Loading the patch    
        [t_coeff,~,~,~,t_explained] = pca(Xt');         % Performing PCA
    % Saving the PCA        
        savePCA = sprintf('PCA_img%d.mat',i);       
        savePCA = strcat(PathToPCA,savePCA);
        save(savePCA,'t_coeff','t_explained');
    % Clearing the coefficients for next image
        clear t_coeff
        clear t_explained
    end
end